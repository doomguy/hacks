param (
    [int]$duration = 60,
    [int]$sleepDuration = 300
)
$hostname = (Get-WmiObject -Class Win32_ComputerSystem).Name
$previousOutput = @()
$endTime = (Get-Date).AddSeconds($duration)

while ((Get-Date) -lt $endTime) {
    $output = wmic process get Name,CommandLine,ProcessId /FORMAT:csv
    if ($output -match '\S') {
        $newLines = Compare-Object -ReferenceObject $previousOutput -DifferenceObject $output | Where-Object { $_.SideIndicator -eq "=>"} | ForEach-Object {
            $_.InputObject
        }
        
        # Filter out noise
        $newLines = $newLines | Where-Object { $_ -notlike "*process get Name,CommandLine,ProcessId*" -and $_ -match '\S' }
        
        # Remove the computer name and leading comma from lines
        $newLines = $newLines | ForEach-Object {
            $_ -replace "^$hostname,+", ''
        }
        
        if ($newLines.Count -gt 0) {
            $timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
            $newLines | ForEach-Object {
                Write-Host ("{0}|`t{1}" -f $timestamp, $_)
            }
        }
        $previousOutput = $output
    }
    Start-Sleep -Milliseconds $sleepDuration
}
