Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction']='Stop'

#Warning you should not have duplicate!! Only for experts
$skipduplicates  = $false
#-------------------------------------------------------
$production = "https://pkgs.dev.azure.com/darkmatter2bd/NuGet/_packaging/Production/nuget/v3/index.json"
$testing = "https://pkgs.dev.azure.com/darkmatter2bd/NuGet/_packaging/TestNuget/nuget/v3/index.json"

$nugetsource = $production;
Set-Location $PSScriptRoot;
$nugetoutput = "$PSScriptRoot\nuget"
$nugets = Get-ChildItem -LiteralPath $nugetoutput -Filter *.nupkg | Where-Object BaseName -Like "*.symbols";
$nugets | Select BaseName | Format-Table

function ThrowOnNativeFailure {
    if (-not $?)
    {
        throw 'Native Failure'
    }
}

$skipdups = "";
if($skipduplicates) {
$skipdups += "--skip-duplicate";
}

foreach ($p in $nugets){
   dotnet nuget push --source `"$nugetsource`" --interactive $skipdups --api-key az `"$($p.FullName)`" ;
   ThrowOnNativeFailure;
}


