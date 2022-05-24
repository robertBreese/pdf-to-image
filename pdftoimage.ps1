#get current parth that script file is in
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

$GSInstalledLocation=$scriptPath+"\ghost\gswin64c.exe"

$rootLocation="\test\General - Documents"




function Move-Item-AutoRename {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [String]$Source,
        [Parameter(Mandatory = $true)]
        [String]$Destination,
        [Parameter(Mandatory = $true)]
        [String]$Name
    )
    PROCESS {
        $count = 1
        [System.IO.FileInfo]$nextName = Join-Path -Path $Destination -ChildPath $Name

        while (Test-Path -Path $nextName) {
            $nextName = Join-Path -Path $Destination ($Name.Split(".")[0] + "_$($count)" + $nextName.Extension)
            $count += 1
        }

        Move-Item -Path $Source -Destination $nextName
    }
}

 

#$Button.Add_Click(

#{
    $rootLocation = ""
    #$ABCrootLocation =$HOME+$rootLocation +"\Communities"
    #$ABCrootLocation = "F:\Communities"
    #####
    New-Item -ItemType Directory -Force -Path $scriptPath"\ghost"

    if (!(Test-Path $scriptPath"\ghost\config.txt"))
    {
       New-Item -path $scriptPath"\ghost" -name config.txt -type "file" -value "\jinx-it.com\General - Documents" -Force
    }
    
    $rootLocation = Get-Content $scriptPath"\ghost\config.txt" -First 1

    #cls
    $rootLocationtmp = Read-Host "PDF TO IMAGE | Edit Default Location. Press the Enter key if path is correct (Current: "$($rootLocation)") "
    if($rootLocationtmp.Length -gt 3){
        New-Item -path $scriptPath"\ghost" -name config.txt -type "file" -value $rootLocationtmp -Force
        $rootLocation =$rootLocationtmp
    }
    $ABCrootLocation =$HOME+$rootLocation +"\Communities"
    #$ABCrootLocation = "F:\Communities"

    while(!(Test-Path -Path $ABCrootLocation))
     {
        cls
        Write-Host "ECS PDF TO IMAGE | Path does not exist, please check"

        $rootLocationtmp = Read-Host "PDF TO IMAGE | Edit Default Location. Press the Enter key if path is correct (Current: "$($rootLocation)") "
        if($rootLocationtmp.Length -gt 3){
            New-Item -path $scriptPath"\ghost" -name config.txt -type "file" -value $rootLocationtmp -Force
            $rootLocation =$rootLocationtmp
        }
        $ABCrootLocation =$HOME+$rootLocation +"\Communities"
     }



        $x=0
        $totalDir=0
        $ProcessedDir=0
        Get-ChildItem  -Directory  $ABCrootLocation| ForEach-Object {
            $totalDir=$totalDir+1
            $isProcessed=$false
            $MapParth=$_.FullName+"\Maps"
            $ArchiveParth=$MapParth+"\Archive"


            #create Archive folder is not exists
            New-Item -ItemType Directory -Force -Path $ArchiveParth

            #move old jpeg file to archive folder if new pdf is exists
            Get-ChildItem $MapParth -Filter "*.pdf" | foreach {
                #move jpeg to archive folder
                Get-ChildItem $MapParth -Filter "*.jpg" | foreach {
                    Move-Item-AutoRename  -Source $_.FullName -Destination $ArchiveParth  -Name $_.Name
                    #Move-Item -Path $_.FullName -Destination $ArchiveParth
                }
            }
            #create jpg file from pdf file
            Get-ChildItem $MapParth -Filter "*.pdf" | foreach {
                $pdfInFile =$_.FullName
                $jpegOutFile = $MapParth +"/" +$_.BaseName +".jpg"
        
                #create jpg file from pdf file
                $cmdline="'"+$GSInstalledLocation+"' -dNOPAUSE -r300x300  -dQUIET -dBATCH -sDEVICE=jpeg -sOutputFile='"+$jpegOutFile+"' '"+$pdfInFile+"'"
                $ret = invoke-expression -command "& $cmdline"
                
                #move pdf to archive folder
                Move-Item-AutoRename  -Source $_.FullName -Destination $ArchiveParth  -Name $_.Name
                #Move-Item -Path $_.FullName -Destination $ArchiveParth
                #break
                $isProcessed =$true
                $x=$x+1

            }
            Write-Host $_.name "Complete"
            if($isProcessed){
                $ProcessedDir=$ProcessedDir+1
            }
            #New-Item -ItemType file -Path "$($_.FullName)" -Name "$($_.Name).txt" 
        }
            cls
            Write-Host "PDF TO IMAGE | COMPLETE"
            

            Write-Host "Number of PDFs converted to image: $($x)"
            Write-Host "Number of folders that did not have PDFs: $($totalDir -$ProcessedDir)"

            $response = read-host




