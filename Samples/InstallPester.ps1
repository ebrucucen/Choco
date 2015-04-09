Configuration Main
{
    Import-DscResource -ModuleName Choco
    ChocoExe choco
    {
        Ensure = 'Present'
    }

    ChocoPackage pester
    {
        Name = 'pester'
        #Ensure = 'Present'
    }
}