<#
  Symbios 8x8 SYSTEM prompts (Auto Attendant + Call Queue) — Q5.
  Same locked recipe as generate.ps1 (Sarah + multilingual_v2 + seed 222 + "Sim Bios").
  Scripts sourced from the Confluence export (Symbios-Call-Scripts.md).
  Usage:  .\generate-system.ps1                 (auto-rotates keys, #4 first)
          .\generate-system.ps1 -Only Billing
#>
[CmdletBinding()]
param(
  [string[]]$KeyNames = @('ELEVEN_LABS_API_KEY_4','ELEVEN_LABS_API_KEY','ELEVEN_LABS_API_KEY_2','ELEVEN_LABS_API_KEY_3'),
  [string]$Only = ''
)
$ErrorActionPreference = 'Stop'

# --- keys from Bitwarden (values never printed); rotate on quota/401/429 ---
$env:BWS_ACCESS_TOKEN = & C:\dev\.secrets\Get-Secret.ps1 -Name bitwarden-work
$secrets = [array](ConvertFrom-Json ((bws secret list) -join "`n"))
$keyList = @()
foreach ($kn in $KeyNames) {
  $mm = [array]($secrets | Where-Object { $_.key -eq $kn })
  if ($mm.Count -eq 1) { $keyList += [pscustomobject]@{ Name=$kn; Value=[string]$mm[0].Value } }
  else { Write-Host "  (warn) $kn not found in Bitwarden, skipping" }
}
$secrets=$null; $mm=$null
if ($keyList.Count -eq 0) { throw "No usable ElevenLabs keys found" }
$script:kIdx = 0
$script:hdr = @{ 'xi-api-key' = $keyList[0].Value }
Write-Host ("keys in rotation: {0}" -f (($keyList | ForEach-Object { $_.Name }) -join ' -> '))

# --- LOCKED recipe ---
$voice = 'EXAVITQu4vr4xnSDxMaL'
$model = 'eleven_multilingual_v2'
$seed  = 222
$vs    = @{ stability=0.50; similarity_boost=0.85; style=0.28; use_speaker_boost=$true }
$B = 'Sim Bios'
$outDir = 'C:\dev\Clients\Symbios\8x8-audio\user-greetings'
New-Item -ItemType Directory -Force $outDir | Out-Null

function Gen($text,$path,$sd){
  if (-not $sd) { $sd = $seed }
  $tts = @{ text=$text; model_id=$model; voice_settings=$vs; seed=$sd }
  $tb = [Text.Encoding]::UTF8.GetBytes(($tts | ConvertTo-Json -Depth 6))
  while ($true) {
    try {
      Invoke-WebRequest -Uri "https://api.elevenlabs.io/v1/text-to-speech/$voice`?output_format=mp3_44100_128" -Method Post -Headers $script:hdr -ContentType 'application/json' -Body $tb -OutFile $path | Out-Null
      return
    } catch {
      $r = $_.Exception.Response; $body = ''; $status = 0
      if ($r) { try { $status=[int]$r.StatusCode } catch {}; try { $sr=New-Object IO.StreamReader($r.GetResponseStream()); $body=$sr.ReadToEnd() } catch {} }
      $rotatable = ($body -match 'quota_exceeded') -or ($status -eq 401) -or ($status -eq 429)
      if ($rotatable -and $script:kIdx -lt ($keyList.Count - 1)) {
        Write-Host ("  ...key {0} failed (status {1}); rotating" -f $keyList[$script:kIdx].Name, $status)
        $script:kIdx++; $script:hdr = @{ 'xi-api-key' = $keyList[$script:kIdx].Value }; continue
      }
      if ($body) { throw $body } else { throw $_.Exception.Message }
    }
  }
}

# --- The 7 system prompts (brand -> "Sim Bios", Dr. -> Doctor, 911 -> "9 1 1") ---
$prompts = @(
  [pscustomobject]@{ File='AutoAttendant.mp3'; Seed=101; Text="Thank you for calling $B Medical Services, and the practice of Doctor Stephen Luther. If this is a medical emergency, please hang up and call 9 1 1. Otherwise, please listen closely because our menu options have changed. Don't forget about your patient portal as a great way to communicate with our clinical staff and providers for medical questions and prescription refills. For our business hours, location, and fax number, please press 1. For prescription refills, medical questions, or to schedule an appointment, press 2. And for billing, please press 3." }
  [pscustomobject]@{ File='AutoAttendant-GeneralInfo.mp3'; Text="Our regular business hours are Monday through Friday, 8 AM to 5 PM. We are located at 460 William Hilton Parkway, Hilton Head Island, South Carolina, 2 9 9 2 6. Our fax number is 8 4 3, 7 3 8, 4 8 0 1. Please press 1 to replay this message, press 2 to go back to the main menu, or simply hang up." }
  [pscustomobject]@{ File='AutoAttendant-PrescriptionsAndAppointments.mp3'; Text="You have just reached prescription refills, medical questions, and appointment scheduling. If you have reached this area in error, please press 1 to go back to the previous menu, press 2 to repeat this message, or just hold for the next available medical receptionist." }
  [pscustomobject]@{ File='AutoAttendant-Billing.mp3'; Text="You have just reached our billing department. If you have reached this area in error, please press 1 to go back to the previous menu, press 2 to repeat this message, or hold for the billing receptionist." }
  [pscustomobject]@{ File='Initial_Call_Queue_Greeting-Std.mp3'; Text="Thank you for calling $B Medical Services and the practice of Doctor Stephen Luther. If this is a medical emergency, please hang up and call 9 1 1. Kindly be advised that a cancellation fee of `$25 will apply to missed appointments and appointments canceled within 24 hours of the scheduled time. All our receptionists are currently assisting other callers, but your call is very important to us, so please stay on the line, and your call will be answered in the order it was received. Thank you for your patience." }
  [pscustomobject]@{ File='Initial_Call_Queue_Greeting-XMAS.mp3'; Text="Merry Christmas, and thank you for calling $B Medical Services and the practice of Doctor Stephen Luther. If this is a medical emergency, please hang up and call 9 1 1. Please take note of our adjusted holiday hours. The office will close at 12 PM on Christmas Eve, December 24th, and remain closed through Christmas Day, December 25th. We will resume regular business hours on December 26th. Kindly be advised that a cancellation fee of `$25 will apply to missed appointments and appointments canceled within 24 hours of the scheduled time. All our receptionists are currently assisting other callers, but your call is very important to us, so please stay on the line, and your call will be answered in the order it was received. Thank you for your patience." }
  [pscustomobject]@{ File='Repeating_Call_Queue_Greeting.mp3'; Text="Thank you for holding. All our representatives are still assisting other callers, and your call will be answered as soon as possible, and in the order it was received. We appreciate your patience and understanding. Don't forget about your patient portal. It's an easy way to request appointments, prescription refills, or get answers to routine health questions. You can find the link on our website at, my $B dot com. Additionally, you can press 2 at any time to leave a message, and one of our caring receptionists will get back to you as soon as possible." }
)

$rows = @(); $total = 0
Write-Host "=== Q5 system prompts ==="
foreach ($p in $prompts) {
  if ($Only -ne '' -and $p.File -notlike "*$Only*") { continue }
  $sd = $null
  if ($p.PSObject.Properties.Name -contains 'Seed') { $sd = $p.Seed }
  Gen $p.Text (Join-Path $outDir $p.File) $sd
  $total += $p.Text.Length
  Write-Host ("  OK  {0}" -f $p.File)
  $rows += [pscustomobject]@{ File=$p.File; Script=($p.Text -replace 'Sim Bios','Symbios') }
}
if ($Only -eq '') {
  $rows | Export-Csv -Path (Join-Path $outDir '_manifest_Q5_system.csv') -NoTypeInformation -Encoding UTF8
}
Write-Host ("Done. ~{0} chars." -f $total)
