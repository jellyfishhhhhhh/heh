# Roblox Killer - closes Roblox repeatedly (screen-time limit).
# Runs forever, checking every few seconds.
# Closes every process whose name starts with "Roblox" (game client,
# background processes, crash handler, launcher, Studio) plus the
# Microsoft Store version (Windows10Universal).

$CheckIntervalSeconds = 5

while ($true) {
    try {
        Get-Process -ErrorAction SilentlyContinue |
            Where-Object { $_.ProcessName -like 'Roblox*' -or $_.ProcessName -eq 'Windows10Universal' } |
            Stop-Process -Force -ErrorAction SilentlyContinue
    } catch {
        # Ignore errors and keep looping
    }
    Start-Sleep -Seconds $CheckIntervalSeconds
}
