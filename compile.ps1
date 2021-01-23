
if (Test-Path .\csgo\addons\sourcemod\plugins\CSGOMultipleGuns.smx -PathType leaf)
{
  Remove-Item .\csgo\addons\sourcemod\plugins\CSGOMultipleGuns.smx
}

C:\Users\Joseph\Desktop\sourcemod-1.10.0\addons\sourcemod\scripting\spcomp.exe .\csgo\addons\sourcemod\plugins\CSGOMultipleGuns.sp

if (Test-Path CSGOMultipleGuns.smx -PathType leaf)
{
  Move-Item CSGOMultipleGuns.smx .\csgo\addons\sourcemod\plugins\CSGOMultipleGuns.smx
}
