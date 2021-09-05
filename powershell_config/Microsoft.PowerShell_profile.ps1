Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme slimfat
$ENV:VIRTUAL_ENV_DISABLE_PROMPT = 1
Start-Service ssh-agent
