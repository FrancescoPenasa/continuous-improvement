# open alias file

# check history of cmds
function check_history {
  Get-Content (Get-PSReadlineOption).HistorySavePath | Select-String -Pattern $args
}

