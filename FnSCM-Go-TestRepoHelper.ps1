function Test-Property {
    Param(
        [HashTable] $json,
        [string] $key,
        [switch] $must,
        [switch] $should,
        [switch] $maynot,
        [switch] $shouldnot
    )

    $exists = $json.ContainsKey($key)
    if ($exists) {
        if ($maynot) {
            Write-Host "::Error::Property '$key' may not exist in $settingsFile"
        }
        elseif ($shouldnot) {
            Write-Host "::Warning::Property '$key' should not exist in $settingsFile"
        }
    }
    else {
        if ($must) {
            Write-Host "::Error::Property '$key' must exist in $settingsFile"
        }
        elseif ($should) {
            Write-Host "::Warning::Property '$key' should exist in $settingsFile"
        }
    }
}

function Test-Json {
    Param(
        [string] $jsonFile,
        [string] $baseFolder,
        [switch] $repo
    )

    $settingsFile = $jsonFile.Substring($baseFolder.Length)
    if ($repo) {
        Write-Host "Checking FnSCM-Go Repo Settings file $settingsFile"
    }
    else {
        Write-Host "Checking FnSCM-Go Settings file $settingsFile"
    }

    try {
        $json = Get-Content -Path $jsonFile -Raw -Encoding UTF8 | ConvertFrom-Json | ConvertTo-HashTable
        if ($repo) {
            Test-Property -settingsFile $settingsFile -json $json -key 'templateUrl' -should
        }
        else {
            Test-Property -settingsFile $settingsFile -json $json -key 'templateUrl' -maynot
            'nextMajorSchedule','nextMinorSchedule','currentSchedule','githubRunner','runs-on' | ForEach-Object {
                Test-Property -settingsFile $settingsFile -json $json -key $_ -shouldnot
            }
        }
    }
    catch {
        Write-Host "::Error::$($_.Exception.Message)"
    }
}

function Test-FnSCMRepository {
    Param(
        [string] $baseFolder
    )
    
    # Test .json files are formatted correctly
    Get-ChildItem -Path $baseFolder -Filter '*.json' -Recurse | ForEach-Object {
        if ($_.FullName -like '*\.FnSCM-Go\Settings.json') {
            Test-Json -jsonFile $_.FullName -baseFolder $baseFolder
        }
        elseif ($_.FullName -like '*\.github\*Settings.json') {
            Test-Json -jsonFile $_.FullName -baseFolder $baseFolder -repo:($_.BaseName -eq "FnSCM-Go-Settings")
        }
    }
}

function Write-Big {
Param(
    [string] $str
)
$chars = @{
"0" = @'
   ___  
  / _ \ 
 | | | |
 | | | |
 | |_| |
  \___/ 
'@.Split("`n")
"1" = @'
  __
 /_ |
  | |
  | |
  | |
  |_|
'@.Split("`n")
"2" = @'
  ___  
 |__ \ 
    ) |
   / / 
  / /_ 
 |____|
'@.Split("`n")
"3" = @'
  ____  
 |___ \ 
   __) |
  |__ < 
  ___) |
 |____/ 
'@.Split("`n")
"4" = @'
  _  _   
 | || |  
 | || |_ 
 |__   _|
    | |  
    |_|  
'@.Split("`n")
"5" = @'
  _____ 
 | ____|
 | |__  
 |___ \ 
  ___) |
 |____/ 
'@.Split("`n")
"6" = @'
    __  
   / /  
  / /_  
 | '_ \ 
 | (_) |
  \___/ 
'@.Split("`n")
"7" = @'
  ______ 
 |____  |
     / / 
    / /  
   / /   
  /_/    
'@.Split("`n")
"8" = @'
   ___  
  / _ \ 
 | (_) |
  > _ < 
 | (_) |
  \___/ 
'@.Split("`n")
"9" = @'
   ___  
  / _ \ 
 | (_) |
  \__, |
    / / 
   /_/  
'@.Split("`n")
"." = @'
    
    
    
    
  _ 
 (_)
'@.Split("`n")
"v" = @'
        
        
 __   __
 \ \ / /
  \ V / 
   \_(_)
'@.Split("`n")
"p" = @'
  _____                _               
 |  __ \              (_)              
 | |__) | __ _____   ___  _____      __
 |  ___/ '__/ _ \ \ / / |/ _ \ \ /\ / /
 | |   | | |  __/\ V /| |  __/\ V  V / 
 |_|   |_|  \___| \_/ |_|\___| \_/\_/  
'@.Split("`n")
"d" = @'
  _____             
 |  __ \            
 | |  | | _____   __
 | |  | |/ _ \ \ / /
 | |__| |  __/\ V / 
 |_____/ \___| \_(_)
'@.Split("`n")
"a" = @'
 ______                  _____          __              _____ _ _   _    _       _       
|   ___|                / ____|        / _|            / ____(_) | | |  | |     | |      
|  |__  _  ___   ______| |  __  ___   | |_ ___  _ __  | |  __ _| |_| |__| |_   _| |__    
|   __|| |/_  \ |______| | |_ |/ _ \  |  _/ _ \| '__| | | |_ | | __|  __  | | | | '_ \   
|  |   | |  | |        | |__| | (_) | | || (_) | |    | |__| | | |_| |  | | |_| | |_) |  
|__|   | |  | |         \_____|\___/  |_| \___/|_|     \_____|_|\__|_|  |_|\__,_|_.__/   
'@.Split("`n")
}


0..5 | ForEach-Object {
    $line = $_
    $str.ToCharArray() | ForEach-Object {
        $ch = $chars."$_"
        if ($ch) {
            Write-Host -noNewline $ch[$line]
        }
    }
    Write-Host
}
}