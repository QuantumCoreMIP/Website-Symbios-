<#
  Symbios 8x8 voicemail greeting generator.
  Locked recipe: Sarah + eleven_multilingual_v2 + seed 222 + CA settings + brand spelled "Sim Bios".
  Usage:  .\generate.ps1 -Quarter 2          (auto-rotates across the 3 free keys)
          .\generate.ps1 -Quarter 1 -Only Luther
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][int]$Quarter,
  [string[]]$KeyNames = @('ELEVEN_LABS_API_KEY_4','ELEVEN_LABS_API_KEY','ELEVEN_LABS_API_KEY_2','ELEVEN_LABS_API_KEY_3'),
  [string]$Only = ''
)
$ErrorActionPreference = 'Stop'

# --- ElevenLabs keys from Bitwarden (values never printed); rotate on quota ---
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
$voice = 'EXAVITQu4vr4xnSDxMaL'      # Sarah
$model = 'eleven_multilingual_v2'
$seed  = 222
$vs    = @{ stability=0.50; similarity_boost=0.85; style=0.28; use_speaker_boost=$true }   # "CA"
$B = 'Sim Bios'   # multilingual ignores phoneme tags; this plain spelling reads as SIM-BY-ohs

# Spoken-name pronunciation overrides (filename + manifest keep the REAL spelling)
$pronOverride = @{
  'Shemika Chisolm' = @{ First='Sha-meeka'; Last='Chizzum' }
  'Vika Blintser'   = @{ First='Vee-ka';    Last='Blintser' }
  'Jean Magarelli'  = @{ First='Gene';      Last='Magarelli' }
}

# Per-file seed overrides: a few names rendered inconsistently on the default seed;
# these specific seeds are the approved clean takes (both names correct).
$seedOverride = @{
  'Shemika_Chisolm-External.mp3' = 22
  'Shemika_Chisolm-Internal.mp3' = 55
}

$outDir = 'C:\dev\Clients\Symbios\8x8-audio\user-greetings'
New-Item -ItemType Directory -Force $outDir | Out-Null

# --- Roster (First, Last, Type, Quarter) ---
$roster = @(
  @{First='Alison';     Last='Haynes';          Type='person';         Q=1}
  @{First='Darla';      Last='Kirchner';        Type='person';         Q=1}
  @{First='Alison';     Last='Cohen';           Type='person';         Q=1}
  @{First='Michelle';   Last='Giddens';         Type='person';         Q=1}
  @{First='Dwan';       Last='Brown';           Type='person';         Q=1}
  @{First='Melanie';    Last='Fracassa';        Type='person';         Q=1}
  @{First='Emily';      Last='Gill';            Type='person';         Q=1}
  @{First='Stephen';    Last='Luther';          Type='doctor';         Q=1}
  @{First='Diane';      Last='Baisey';          Type='person';         Q=1}

  @{First='Bryce';      Last='White';           Type='person';         Q=2}
  @{First='Christopher';Last='Madison';         Type='doctor';         Q=2}
  @{First='Jennifer';   Last='Krueger';         Type='person';         Q=2}
  @{First='Brenna';     Last='Taylor';          Type='person';         Q=2}
  @{First='Celeste';    Last='Welsh';           Type='person';         Q=2}
  @{First='Scott';      Last='Hoffman';         Type='person';         Q=2}
  @{First='Allison';    Last='Burcham';         Type='person';         Q=2}
  @{First='Lymphedema'; Last='Clinic';          Type='resource-lymph'; Q=2}
  @{First='Debreca';    Last='Harris';          Type='person';         Q=2}

  @{First='McHaley';    Last='Kirchner';        Type='person';         Q=3}
  @{First='Shemika';    Last='Chisolm';         Type='person';         Q=3}
  @{First='Cheyenne';   Last='McLoud';          Type='person';         Q=3}
  @{First='Vika';       Last='Blintser';        Type='person';         Q=3}
  @{First='Lindsey';    Last='Cavanaugh';       Type='person';         Q=3}
  @{First='Lisa';       Last='Lacy';            Type='person';         Q=3}
  @{First='Jean';       Last='Magarelli';       Type='person';         Q=3}
  @{First='Marilyn';    Last='Tassone-Landry';  Type='person';         Q=3}
  @{First='Rhonda';     Last='Bentley';         Type='person';         Q=3}

  @{First='PT Provider Station'; Last=''; Type='resource-pt'; Q=4}
  @{First='Nicole';     Last='Toti';            Type='person';         Q=4}
  @{First='Adrienne';   Last='Roser';           Type='person';         Q=4}
  @{First='Debbie';     Last='Luther';          Type='person';         Q=4}
  @{First='Mystica';    Last='Green';           Type='person';         Q=4}
  @{First='Lisa';       Last='Mazeika';         Type='person';         Q=4}
  @{First='Linda';      Last='Goss';            Type='person';         Q=4}
  @{First='Kelly';      Last='Ruckno';          Type='person';         Q=4}
)

function Fn($first,$last){
  $f = ($first.Trim() -replace '\s+','_')
  $l = ($last.Trim()  -replace '\s+','_')
  if ($l -ne '') { '{0}_{1}' -f $f,$l } else { $f }
}
function ExtText($type,$first,$last){
  switch ($type) {
    'person'         { "Thank you for calling $B. You have just reached the voicemail of $first $last. $first is unavailable at the moment, but please leave your name, number, and the reason you're calling, and you will get a call back as soon as possible." }
    'doctor'         { "Thank you for calling $B. You have just reached the voicemail of Doctor $first $last. Doctor $last is unavailable at the moment, but please leave your name, number, and the reason you're calling, and you will get a call back as soon as possible." }
    'resource-lymph' { "Thank you for calling $B. You have reached the voicemail of the $B Lymphedema Clinic. We are unavailable at the moment, but please leave your name, number, and the reason you're calling, and you will get a call back as soon as possible." }
    'resource-pt'    { "Thank you for calling $B Medical Services, and the practice of Doctor Stephen Luther. If this is a medical emergency, please hang up and call 9 1 1. You have reached the voicemail of $B Physical Rehab. We are unable to take your call at the moment as we are on the phone, or have stepped away for a moment. Please leave a detailed message including your name, date of birth, call back number, and the reason for your call, and our receptionist will call you back as soon as possible." }
  }
}
function IntText($type,$first,$last){
  switch ($type) {
    'person'         { "You have just reached the voicemail of $first $last. Please leave your name, number, and the reason you're calling, and $first will call you back as soon as possible." }
    'doctor'         { "You have just reached the voicemail of Doctor $first $last. Please leave your name, number, and the reason you're calling, and Doctor $last will call you back as soon as possible." }
    'resource-lymph' { "You have reached the voicemail of the Lymphedema Clinic. Please leave your name, number, and the reason you're calling, and someone will call you back as soon as possible." }
    'resource-pt'    { "You have reached the voicemail of $B Physical Rehab. We are unable to take your call at the moment as we are on the phone, or have stepped away for a moment. Please leave a detailed message including your name, date of birth, call back number, and the reason for your call, and our receptionist will call you back as soon as possible." }
  }
}
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
      if ($r) {
        try { $status = [int]$r.StatusCode } catch {}
        try { $sr = New-Object IO.StreamReader($r.GetResponseStream()); $body = $sr.ReadToEnd() } catch {}
      }
      $rotatable = ($body -match 'quota_exceeded') -or ($status -eq 401) -or ($status -eq 429)
      if ($rotatable -and $script:kIdx -lt ($keyList.Count - 1)) {
        Write-Host ("  ...key {0} failed (status {1}); rotating" -f $keyList[$script:kIdx].Name, $status)
        $script:kIdx++
        $script:hdr = @{ 'xi-api-key' = $keyList[$script:kIdx].Value }
        continue
      }
      if ($body) { throw $body } else { throw $_.Exception.Message }
    }
  }
}

$sel = [array]($roster | Where-Object { $_.Q -eq $Quarter })
if ($Only -ne '') { $sel = [array]($sel | Where-Object { (Fn $_.First.Trim() $_.Last.Trim()) -like "*$Only*" }) }
if ($sel.Count -eq 0) { throw "No roster entries for quarter $Quarter (Only='$Only')" }
$rows = @(); $total = 0
Write-Host ("=== Quarter {0} ({1} mailboxes) ===" -f $Quarter, $sel.Count)
foreach ($p in $sel) {
  $first=$p.First.Trim(); $last=$p.Last.Trim(); $type=$p.Type
  $base = Fn $first $last
  $sfirst=$first; $slast=$last
  $ovKey = ("{0} {1}" -f $first,$last).Trim()
  if ($pronOverride.ContainsKey($ovKey)) { $sfirst=$pronOverride[$ovKey].First; $slast=$pronOverride[$ovKey].Last }
  $extText = ExtText $type $sfirst $slast
  $intText = IntText $type $sfirst $slast
  $extFile = "$base-External.mp3"; $intFile = "$base-Internal.mp3"
  $extSd = $null; if ($seedOverride.ContainsKey($extFile)) { $extSd = $seedOverride[$extFile] }
  $intSd = $null; if ($seedOverride.ContainsKey($intFile)) { $intSd = $seedOverride[$intFile] }
  Gen $extText (Join-Path $outDir $extFile) $extSd
  Gen $intText (Join-Path $outDir $intFile) $intSd
  $total += $extText.Length + $intText.Length
  $mb = ("{0} {1}" -f $first,$last).Trim()
  Write-Host ("  OK  {0}-External.mp3 / -Internal.mp3   [{1}]" -f $base, $type)
  $rows += [pscustomobject]@{ File="$base-External.mp3"; Mailbox=$mb; Type=$type; Kind='External'; Script=($extText -replace 'Sim Bios','Symbios') }
  $rows += [pscustomobject]@{ File="$base-Internal.mp3"; Mailbox=$mb; Type=$type; Kind='Internal'; Script=($intText -replace 'Sim Bios','Symbios') }
}
if ($Only -eq '') {
  $manifest = Join-Path $outDir ("_manifest_Q{0}.csv" -f $Quarter)
  $rows | Export-Csv -Path $manifest -NoTypeInformation -Encoding UTF8
  Write-Host ("Manifest -> {0}" -f $manifest)
}
Write-Host ("Done. {0} files, ~{1} chars." -f ($sel.Count*2), $total)
$key=$null; $hdr=$null
