$lista = 'RDP_Host1','RDP_Host2','RDP_Host3','RDP_Host4','RDP_Host5'
foreach($rdp in $lista) {
    $sesja = New-PSSession $rdp
"--------------------------------"
    $rdp
    Invoke-Command -Session $sesja -ScriptBlock {
        $a = query user
        $b =$a | ForEach-Object -Process { $_ -replace '\s{2,}',',' }
        $c=$b | ConvertFrom-Csv
        $a

        #$current = whoami 
        #$current = $current.Replace("domain\","")

        foreach($user in $c) {
            if(!($user.username -like ">*")) {
        
                $u= $user.username 
                $id= $user.id
                write-output "Logout: $u, ID:$id"
                logoff $id    
            }
        }
    }
}
