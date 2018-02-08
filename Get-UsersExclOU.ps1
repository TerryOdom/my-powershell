#This script will filter through and list all AD users with certain OUs excluded.
Get-ADUser -Filter * -SearchBase 'DC=<REPLACE WITH DOMAIN>,DC=local' | 
    Where-Object { $_.DistinguishedName -notlike '*OU=<OU NAME>,*'`
    -and  $_.DistinguishedName -notlike '*OU=<OU NAME>,*'`
    -and  $_.DistinguishedName -notlike '*OU=<OU NAME>,*'} | ogv
