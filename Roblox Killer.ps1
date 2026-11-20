# Roblox Killer - closes Roblox only when it is running in the background
# (no visible window, i.e. only under "Background processes" in Task Manager).
# If Roblox has a window open (shows under "Apps"), nothing is closed.
#
# Must run as the logged-in user (not SYSTEM), otherwise it can't see windows.

$CheckIntervalSeconds = 1
$GraceSeconds = 5    # time allowed for Roblox to open its window while launching

$noWindowSince = $null

while ($true) {
    try {
        $roblox = @(Get-Process -ErrorAction SilentlyContinue |
            Where-Object { $_.ProcessName -like 'Roblox*' -or $_.ProcessName -eq 'Windows10Universal' })

        if ($roblox.Count -eq 0) {
            $noWindowSince = $null
        }
        elseif ($roblox | Where-Object { $_.MainWindowHandle -ne 0 }) {
            # Roblox is open as an app - leave everything alone
            $noWindowSince = $null
        }
        else {
            if (-not $noWindowSince) { $noWindowSince = Get-Date }
            if (((Get-Date) - $noWindowSince).TotalSeconds -ge $GraceSeconds) {
                $roblox | Stop-Process -Force -ErrorAction SilentlyContinue
                $noWindowSince = $null
            }
        }
    } catch { }
    Start-Sleep -Seconds $CheckIntervalSeconds
}
