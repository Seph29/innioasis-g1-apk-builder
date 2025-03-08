# innioasis-g1-apk-builder
Creates custom installable Apks for the Innioasis G1 by alloing the user to select from a lit of whiteliested apps on the G1, then the program does the rest, decompiling, renaming, recompiling, aligning and signing. When the custom apk is installed, it will overwrite the existing data for that app(if you have the original installed).

if you have any questions, email me at thaidakar21@gmail.com
powershell -Command "(New-Object -com shell.application).Windows() | Where-Object {$_.Name -eq 'File Explorer'} | ForEach-Object {$_.Quit()}"
