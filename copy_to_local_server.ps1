.\compile.ps1
if (Test-Path .\csgo\addons\sourcemod\plugins\CSGOMultipleGuns.smx -PathType leaf)
{
  cp .\csgo\addons\sourcemod\plugins\CSGOMultipleGuns.smx C:\Users\Joseph\Desktop\steamcmd\cs_go\csgo\addons\sourcemod\plugins
}