#$versionsuffix = "v20220908"
#in project file

Set-Location $PSScriptRoot;
$nugetoutput = "$PSScriptRoot\nuget"
Remove-Item -LiteralPath $nugetoutput -Recurse -ErrorAction SilentlyContinue

$projecttargets = @("Ljbc1994.Blazor.IntersectionObserver");
$projects = Get-ChildItem -Filter *.csproj -Recurse `
    | Where-Object { $projecttargets -Contains $_.BaseName};

$projects | Select BaseName | Format-Table

$p = $projects;


foreach ($p in $projects){
    dotnet pack "$($p.FullName)" --force --include-source --include-symbols --interactive --output nuget --verbosity  m   #--version-suffix "$versionsuffix"
}

#dotnet nuget push --source "TestNuget" --api-key az <package-path>
return

