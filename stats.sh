#!/bin/bash

# Get total CPU usage
get_cpu_usage() {
    echo "CPU Usage:"
    top -l 1 | awk '/CPU usage/ {print "CPU Load: " 100 - $7 "%"}'
}

# Get total memory usage
get_memory_usage() {
    echo "Memory Usage:"
    vm_stat | awk '
        /free/ {free=$3}
        /active/ {active=$3}
        /inactive/ {inactive=$3}
        /wired/ {wired=$3}
        END {
            free_gb = free * 4096 / 1024 / 1024 / 1024
            used_gb = (active + inactive + wired) * 4096 / 1024 / 1024 / 1024
            total_gb = free_gb + used_gb
            printf "Used: %.2f GB / Total: %.2f GB (%.2f%%)\n", used_gb, total_gb, (used_gb / total_gb * 100)
        }'
}

# Get total disk usage
get_disk_usage() {
    echo "Disk Usage:"
    df -h / | awk '/\// {printf "Used: %s / Total: %s (%s)\n", $3, $2, $5}'
}

# Get top 5 processes by CPU usage
get_top_cpu_processes() {
    echo "Top 5 Processes by CPU Usage:"
    ps -e -o pid,ppid,comm,%mem,%cpu | sort -k5 -nr | head -6
}

# Get top 5 processes by memory usage
get_top_memory_processes() {
    echo "Top 5 Processes by Memory Usage:"
    ps -e -o pid,ppid,comm,%mem,%cpu | sort -k4 -nr | head -6
}

# Additional stats
get_additional_stats() {
    echo "OS Version: $(sw_vers -productVersion)"
    echo "Uptime: $(uptime | awk -F'( |,|:)+' '{print $6,$7", "$8" hours, "$9" minutes"}')"
    echo "Logged in Users: $(who | wc -l)"
}

# Main function
main() {
    echo "Server Performance Stats"
    echo "========================"
    
    get_cpu_usage
    echo ""
    
    get_memory_usage
    echo ""
    
    get_disk_usage
    echo ""
    
    get_top_cpu_processes
    echo ""
    
    get_top_memory_processes
    echo ""
    
    get_additional_stats
}

main
