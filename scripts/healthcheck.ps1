param([Parameter(Mandatory=$true)][string]$Url)
try {
  $resp = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 5
  if ($resp.StatusCode -eq 200) { "HEALTHCHECK: OK"; exit 0 }
  else { "HEALTHCHECK: BAD STATUS $($resp.StatusCode)"; exit 1 }
} catch {
  "HEALTHCHECK: ERROR $($_.Exception.Message)"; exit 1
}
