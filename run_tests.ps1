# run_tests.ps1
# Compiles and runs every testbench in tb\ with Icarus Verilog.
# A test FAILS if it does not compile, vvp returns an error, or its output contains "FAIL".
# A test PASSES if its output contains "PASS". Tests with neither are listed as "no self-check".

$root     = $PSScriptRoot
$iverilog = "C:\iverilog\bin\iverilog.exe"
$vvp      = "C:\iverilog\bin\vvp.exe"

$rtlFiles = @(Get-ChildItem (Join-Path $root "rtl") -Filter "*.sv" -File |
    Sort-Object Name | ForEach-Object { $_.FullName })

$tbFiles = @(Get-ChildItem (Join-Path $root "tb") -Filter "*.sv" -File |
    Sort-Object Name)

$simDir = Join-Path $root "simulation"
New-Item -ItemType Directory -Force $simDir | Out-Null

$passed  = @()
$failed  = @()
$noCheck = @()

foreach ($tb in $tbFiles) {
    $top    = [IO.Path]::GetFileNameWithoutExtension($tb.Name)
    $output = Join-Path $simDir "$top.vvp"

    Write-Host "`n===== Testing: $top =====" -ForegroundColor Cyan

    & $iverilog -g2012 -s $top -o $output @rtlFiles $tb.FullName
    if ($LASTEXITCODE -ne 0) {
        Write-Host "FAIL: Compilation failed" -ForegroundColor Red
        $failed += $top
        continue
    }

    $log = & $vvp $output 2>&1 | ForEach-Object { "$_" }
    $exit = $LASTEXITCODE
    $log | ForEach-Object { Write-Host $_ }
    $text = $log -join "`n"

    if ($exit -ne 0 -or $text -match "FAIL") {
        Write-Host "RESULT: FAIL" -ForegroundColor Red
        $failed += $top
    }
    elseif ($text -match "PASS") {
        Write-Host "RESULT: PASS" -ForegroundColor Green
        $passed += $top
    }
    else {
        Write-Host "RESULT: ran, but no self-check (add PASS/FAIL to this testbench)" -ForegroundColor Yellow
        $noCheck += $top
    }
}

Write-Host "`n========== FINAL SUMMARY =========="
Write-Host "Total testbenches : $($tbFiles.Count)"
Write-Host "Passed            : $($passed.Count)" -ForegroundColor Green
Write-Host "Failed            : $($failed.Count)" -ForegroundColor Red
Write-Host "No self-check     : $($noCheck.Count)" -ForegroundColor Yellow
if ($failed.Count -gt 0)  { Write-Host "Failed tests: $($failed -join ', ')" -ForegroundColor Red }
if ($noCheck.Count -gt 0) { Write-Host "Not self-checking: $($noCheck -join ', ')" -ForegroundColor Yellow }

if ($failed.Count -gt 0) { exit 1 } else { exit 0 }