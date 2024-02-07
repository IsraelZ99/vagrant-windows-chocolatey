# SSH Config
$ssh_key = Get-Content C:\Users\vagrant\windows-deployment-key.pub -Raw
$SEL = Select-String C:\Users\vagrant\.ssh\authorized_keys -Pattern $ssh_key -CaseSensitive -SimpleMatch
if(-Not ($SEL -ne $null)) {
          Add-Content C:\Users\vagrant\.ssh\authorized_keys "`n$ssh_key"  
}

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install 7-zip
if(-Not (Test-Path -Path 'C:/Program Files/7-Zip')) {
          echo 'Instalando 7-Zip'
          choco install 7zip --yes
}

# Unrar files
# if(-Not (Test-Path -Path $folder)){
#           echo 'Descomprimiendo'
#           7z x "$($folder).rar" -y -oc:/
# }

# Install JDK-8
$jdk_location = 'C:/Program Files/Java/jre-1.8'
if(-Not (Test-Path -Path $jdk_location)) {
          echo 'Instalando jdk8'
          choco install jre8 --yes     
}

# Set Environment variables
# TODO: Check if the variable does not exist
if(-Not ([Environment]::GetEnvironmentVariable("JAVA_HOME","Machine"))) {
          echo 'Asignando variable de entorno para Java'
          [Environment]::SetEnvironmentVariable("JAVA_HOME", $jdk_location, "Machine")
}
$content_path = [Environment]::GetEnvironmentVariable("Path","Machine")
if(-Not ($content_path | %{$_ -match $jdk_location})) {
          echo 'Modificando Variable Path'
          [Environment]::SetEnvironmentVariable("Path",[Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:/Program Files/Java/jre-1.8/bin",[EnvironmentVariableTarget]::Machine)
}

# Set address JBoss´
# echo 'Asignando ip address para el servidor JBoss'
# $ipAddress = (Get-NetIPAddress *10*).IPAddress # Get ip from the guest
# (Get-Content 'C:\JBoss_6.3_CoreBancario\standalone\configuration\standalone.xml').Replace('127.0.0.1',$ipAddress) | Set-Content $folder_JBOSS
