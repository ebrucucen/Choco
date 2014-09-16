enum Ensure
{
    Absent
    Present
}

[DscResource()]
class ChocoExe
{
    [DscResourceKey()][Ensure] $Ensure
    
    [void] Set()
    {
        if($ensure -eq [Ensure]::Present)
        {
            iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
        }
        else
        {
            throw "Not supported"     
        }
    }

    [bool] Test() 
    {
        if($ensure -eq [Ensure]::Present)        
        {
            return [bool](Get-Command -Name choco.exe*)
        }
        else
        {
            throw "Not supported" 
        }        
    }

    [System.Management.Automation.ApplicationInfo] Get()
    {
        return Get-Command -Name choco.exe*
    }
}


[DscResource()]
class ChocoPackage
{
    [Ensure] $Ensure
    [DscResourceKey()] [string] $Name
    [string] $version

    [void] Set()
    {
        if($ensure -eq [Ensure]::Present)
        {
            if ($version) 
            {
                choco install $Name -version $version
            }
            else
            {
                choco install $Name
            }
        }
        else
        {
            throw "Not supported"     
        }
    }

    [bool] Test() 
    {
        if($ensure -eq [Ensure]::Present)        
        {
            $out = choco list -localonly $Name
            return ($out -eq "No packages found.")
        }
        else
        {
            throw "Not supported" 
        }        
    }

    [string] Get()
    {
        return choco list -localonly $Name
    }
}
