# New-MultipartForm
Create Multipart form from data for use with Invoke-RestMethod with older versions of Powershell

### Example Usage
```powershell
$MultiPartFormData = New-MultiPartForm -FieldData @{"SomeField"="Value1";"SomeOtherField"="Value2"}

Invoke-RestMethod -URI "https://example.com/someAPI" -Method "POST" -ContentType "multipart/form-data; boundary=$($MultiPartFormData.boundary)" -Body $MultiPartFormData.bodyText
```