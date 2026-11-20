# Roblox Killer - closes Roblox repeatedly (screen-time limit).
# Runs forever, checking every few seconds.

$CheckIntervalSeconds = 5
$ProcessNames = @('RobloxPlayerBeta', 'RobloxPlayerLauncher', 'RobloxStudioBeta', 'Windows10Universal')

while ($true) {
    try {
        Get-Process -Name $ProcessNames -ErrorAction SilentlyContinue |
            Stop-Process -Force -ErrorAction SilentlyContinue
    } catch {
        # Ignore errors and keep looping
    }
    Start-Sleep -Seconds $CheckIntervalSeconds
}
