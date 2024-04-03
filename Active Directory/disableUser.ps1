$ou="OU=disabled,DC=domain,DC=local"


$user = read-host "User to disable: "

get-aduser $user -properties * | select enabled,cn
$user_x = get-aduser $user
$start = read-host "Type 1 to disable "
if($start -eq 1)
{
    $data = Get-Date -DisplayHint Date
    $opis = $user.description + " ---" +$user.canonicalname + " ---" + $data
    set-aduser $user -Manager $null
    Set-ADUser $user -Description $opis  
    $users = (Get-ADUser $user -properties memberof).memberof
    if($users) { set-aduser $user -Replace @{Info="$users"} }
    $users | Remove-ADGroupMember -Members $user -Confirm:$false
    Move-ADObject $user_x -TargetPath $ou
    Disable-ADAccount $user
}
