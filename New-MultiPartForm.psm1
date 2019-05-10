function New-MultipartForm {
    [CmdletBinding(DefaultParameterSetName='Ordered')]
    param(
        # Hashtable containing field names and values for your multipart field body type.
        [Parameter(Mandatory = $true,
        ParameterSetName='Ordered')]
        [System.Collections.IDictionary]$FieldData
    )

    #Generate GUID to use as boundary string.
    $boundary = [System.Guid]::NewGuid().ToString()
    #Set variable with newline character for easier access later.
    $LF = "`r`n";

    #Get list of hashtable keys and values and store in seperate variables.
    [string[]]$KeyList = $FieldData.Keys
    [string[]]$ValueList = $FieldData.Values

    #Get total number of items.
    $DataLength = $KeyList.Count

    #Initialize empty array.
    $bodyLines = @()

    #Loop through values and build multipart form in an array.
    for ($i=0; $i -lt $DataLength; $i++) {
        $bodyLines += "--$boundary",
        "Content-Disposition: form-data; name=`"$($KeyList[$i])`"",
        '',
        $($ValueList[$i])
    }

    #Insert end boundary.
    $bodyLines += "--$boundary--$LF"

    #Convert array to single string.
    $bodyText = $bodyLines -join $LF

    #Return both string and boundary.
    $returnValue = @{
        'Boundary' = $boundary
        'bodyText' = $bodyText
    }

    return $returnValue
}
