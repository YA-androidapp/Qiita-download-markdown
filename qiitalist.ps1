$i = 1
foreach ($l in Get-Content qiitalist.txt) {
    Write-Host $i

    $uri = New-Object System.Uri($l)
    $file = Split-Path $uri.AbsolutePath -Leaf
    Invoke-WebRequest -Uri "${l}.md" -OutFile "${file}"

    $title = Select-String "title\: " "${file}" | Select-Object -First 1 Line
    $title = [string]($title | Out-String -Stream)
    $title = $title.Replace('title: ', '')
    $title = $title.Replace(' Line ---- ', '')

    Write-Host "    l= " $l

    if ([String]::IsNullOrEmpty($title)) {
        Write-Host "    title= EMPTY"
    }
    else {
        Write-Host "    title= " $title
        Move-Item "${file}" "${title}.md"
    }

    $i++
}
