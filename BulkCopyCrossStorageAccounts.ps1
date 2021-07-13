#1. Connect to Azure platform
Connect-AzureRMAccount 

#2. Get the Storage Account created before
$StorageAccountA = Get-AzureRmStorageAccount -Name ebaccountaq7s7yylrkpriu -ResourceGroupName AZ_EyalB001_RG

$AccountCtx = $StorageAccountA.Context

#3. Create new container for StorageAccountA
$ContainerAName = "ebacontainer"
#New-AzureStorageContainer -Name $ContainerAName -Context $AccountCtx -Permission Blob

#4. Upload Blobs to the storage container

#Clean the storage Account Container
Get-AzureStorageBlob -Name $ContainerAName -Context $AccountCtx | Remove-AzureStorageBlob

# Upload file from D:\PERSONNEL\Eyal Photos USA 1\20190715_184013.jpg
$fileUpload = "C:\20190715_184013.jpg"
Set-AzureStorageBlobContent -File $fileUpload -Container $ContainerAName -Blob "test" -Context $AccountCtx

#5. Create and Upload 2 blobs 
for($counter =1; $counter -le 99; $counter++){

    #get a random name for each blob
    $BlobAName = "ebacont" + -join((97..122) | Get-Random -Count 6 | ForEach-Object{[char]$_})

    #create blob into container
    Set-AzureStorageBlobContent -File $fileUpload -Container $ContainerAName -Blob $BlobAName -Context $AccountCtx

}

#6. Bulk Copy the 100 blobs from Storage Account A to B
    #Create container for storage account B
    $ContainerBName = "ebbcontainer"
    #New-AzureStorageContainer -Name $ContainerBName -Context $AccountCtx -Permission Blob

    #tests upload to container B
    $fileUpload = "D:\PERSONNEL\Eyal Photos USA 1\20190715_184013.jpg"
    Set-AzureStorageBlobContent -File $fileUpload -Container $ContainerBName -Blob "test" -Context $AccountCtx



    #Bulk Copy
    Get-AzureStorageBlob -Container $ContainerAName -Context $AccountCtx | Start-AzureStorageBlobCopy -DestContainer $ContainerBName




#7. Retrieve all blobs from container Aget
Get-AzureStorageContainer -Context $AccountCtx | Get-AzureStorageBlob 


