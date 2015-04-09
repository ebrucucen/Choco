enum Ensure
{
    Absent
    Present
}

[DscResource()]
class ChocoExe
{
    [DscProperty(Key)][Ensure] $Ensure
    
    [void] Set()
    {
        if($this.ensure -eq [Ensure]::Present)
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
        if($this.ensure -eq [Ensure]::Present)        
        {
            return [bool](Get-Command -Name choco.exe*)
        }
        else
        {
            throw "Not supported" 
        }        
    }

    [ChocoExe] Get()
    {
        return [ChocoExe]@{ 
            Ensure = [bool](Get-Command -Name choco.exe*) 
        }
    }
}


[DscResource()]
class ChocoPackage
{
    [Ensure] $Ensure
    [DscProperty(Key)] [string] $Name
    [string] $version

    [void] Set()
    {
        if($this.ensure -eq [Ensure]::Present)
        {
            if ($this.version) 
            {
                choco install $this.Name -version $this.version
            }
            else
            {
                choco install $this.Name
            }
        }
        else
        {
            throw "Not supported"     
        }
    }

    [bool] Test() 
    {
        if($this.ensure -eq [Ensure]::Present)        
        {
            $out = choco list -localonly $this.Name
            return ($out -eq "No packages found.")
        }
        else
        {
            throw "Not supported" 
        }        
    }

    [ChocoPackage] Get()
    {
        return [ChocoPackage] @{
            Ensure = [bool](choco list -localonly $this.Name)
            Name = $this.Name
            # todo version
        }
    }
}
