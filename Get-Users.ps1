# Fetches users from JSONPlaceholder and writes name, email, company name to a CSV.

$ErrorActionPreference = 'Stop'

$url        = 'https://jsonplaceholder.typicode.com/users'
$outputFile = Join-Path $PSScriptRoot 'users.csv'

$users = Invoke-RestMethod -Uri $url -Method Get

$rows = $users | ForEach-Object {
    [pscustomobject]@{
        name    = $_.name
        email   = $_.email
        company = $_.company.name    # pulled out of the nested company object
        city    = $_.address.city    # pulled out of the nested address object
    }
}

$rows | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Wrote $($rows.Count) users to $outputFile"
