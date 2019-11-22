
Connect-MicrosoftTeams
Get-Team -Visibility Public | Export-Csv C:\Users\Public\Desktop\PublicTeams.csv

$Result=""  
$Results=@() 
$Path="./AllPrivateChannels_$((Get-Date -format yyyy-MMM-dd-ddd` hh-mm` tt).ToString()).csv"
Write-Host Exporting Private Channels report...
$Count=0
Get-Team | foreach {
$TeamName=$_.DisplayName
Write-Progress -Activity "`n     Processed Teams count: $Count "`n"  Currently Processing: $TeamName"
$Count++
$GroupId=$_.GroupId
$PrivateChannels=(Get-TeamChannel -GroupId $GroupId -MembershipType Private).DisplayName
foreach($PrivateChannel in $PrivateChannels)
{
 $Result=@{'Teams Name'=$TeamName;'Private Channel'=$PrivateChannel}
 $Results= New-Object psobject -Property $Result
 $Results | select 'Teams Name','Private Channel' | Export-Csv $Path -NoTypeInformation -Append
 }
}
Write-Progress -Activity "`n     Processed Teams count: $Count "`n"  Currently Processing: $TeamName" -Completed
if((Test-Path -Path $Path) -eq "True") 
{
 Write-Host `nReport available in $Path -ForegroundColor Green
}
  