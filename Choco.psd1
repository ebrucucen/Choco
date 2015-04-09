@{

# Script module or binary module file associated with this manifest.
RootModule = 'Choco.psm1'

#NestedModules = @('Chocolatey.psm1')

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '3f615d6a-4922-4b1f-8f3d-b33f49889b5c'

# Author of this module
Author = 'Sergei Vorobev'

# Copyright statement for this module
Copyright = '(c) 2014 Sergei Vorobev. All rights reserved.'

# Description of the functionality provided by this module
# Description = 'DSC resource provider for FileResource.'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

DscResourcesToExport = @('ChocoExe', 'ChocoPackage')

}
