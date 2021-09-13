Function Initialize-NamingConventionFull {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $ResourceGroupName
    )

    # Based on the resource group name, with '<servicename>-<environment><incrementor>-rg' naming convention, we are able to substitute the service name and environment
    if ($ResourceGroupName -match '(?<ServiceName>.+)-(?<Environment>[a-z,A-Z]+)(?<Incrementor>[0-9]+)-rg') {
        $ServiceName = $Matches.ServiceName
        $Environment = $Matches.Environment
        $Incrementor = $Matches.Incrementor
    }
    else {
        Throw 'Invalid ResourceGroupName value supplied'
    }

    [PSCustomObject]@{
        Storage = @{
            StorageAccountName = "$ServiceName$Environment$Incrementor<suffix>sa"
        }
    }
}