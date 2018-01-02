function writeLog
{
    Param ($log_path,[string]$logstring)
    Add-content $log_path -value $logstring
}

function writeLogMovement ($X,$Y,$x_disposition,$y_disposition)
{
    $tmp_log = "FRANTICRAT mouse jiggler v0.1 function=moveCursor x-origin=$X y-origin=$Y x-transform=$x_disposition y-transform=$y_disposition"
    eventcreate /t information /id 100 /d $tmp_log
    writeLog $log_path -Format g $($(Get-Date).ToString("u")+" "+$tmp_log)
}

function moveCursor ($x_disposition,$y_disposition)
{
    Add-Type -AssemblyName System.Windows.Forms
    $X = [System.Windows.Forms.Cursor]::Position.X
    $Y = [System.Windows.Forms.Cursor]::Position.Y
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(($X+$x_disposition),($Y+$y_disposition))
    writeLogMovement $X $Y $x_disposition $y_disposition
}

function vibrate($gap)
{
    # CONFIGURE HERE FOR MOVEMENT DISTANCE
    moveCursor 200 -200
    Start-Sleep -s $gap
    moveCursor 200 -200
    Start-Sleep -s $gap
}

function vibration($gap)
{
    while ($true)
    {
        vibrate $gap
    }
}

function main
{
    #CONFIGURE HERE TO CHANGE LOG WRITE PATH LOCATION
    $log_path = "C:\Logs\fr\fr.log"

    If(!(test-path $log_path))
    {
        New-Item -ItemType File -Force -Path $log_path
    }

    # CONFIGURE HERE FOR REST TIME BETWEEN MOVEMENTS
    vibration 60
}

main
