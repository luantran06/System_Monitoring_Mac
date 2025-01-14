# System_Monitoring_Mac
System Monitoring on Mac
top -l 1: Runs the top command in macOS for a single snapshot of system performance.
awk '/CPU usage/ {print "CPU Load: " 100 - $7 "%"}': Finds the line containing CPU usage, extracts the idle percentage (column 7), and calculates the active CPU load as 100 - idle%.
vm_stat: Provides memory statistics in terms of pages.
The awk script calculates memory in GB:
Converts pages to bytes (1 page = 4096 bytes).
Separates memory into free, active, inactive, and wired.
Calculates total memory and percentage of memory used.
df -h /: Displays disk usage for the root filesystem in human-readable format.
awk: Extracts used space, total space, and percentage used.
ps -e -o pid,ppid,comm,%mem,%cpu: Lists all processes along with their PID, PPID, command, memory usage, and CPU usage.
sort -k5 -nr: Sorts the output by the 5th column (%CPU) in descending order.
head -6: Displays the top 5 processes (plus the header row).
OS Version:
sw_vers -productVersion: Displays macOS version.
Uptime:
uptime: Shows system uptime.
awk: Formats the uptime output for readability.
Logged-in Users:
who | wc -l: Counts the number of users currently logged in.
