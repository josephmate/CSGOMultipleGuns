# CSGOMultipleGuns
Plugin that allows multiple guns


# Hooks Interactions with Pickup and Drop
To figure what options I have to work with in sourcemod when dropping and picking up items, I added all item related hooks and printed all information available to those hooks.

## Result Summary
Unfortunately, when the client picks up a primary weapon, but the client already has a primary item, CS_OnCSWeaponDrop is the first hook called.
This will make it really chanllenging to replace the pickup logic because it would require this plugin to to track all the weapons picked up and re-implement picking up and dropping.

## How to Setup Tests

Server Side
```
sv_cheats 1
bot_quota 0
mp_roundtime_defuse 60
mp_roundtime_hostage 60
mp_roundtime 60
mp_restartgame 1
```

Client Side
```
give weapon_m4a1
give weapon_ak47
# drop the guns to begin the experiment
```

## No Primary Logs
Make sure you're not holding any guns. Pick up the M4 with e from a distance
```
SDKHook OnWeaponCanUse clientId 1 weaponEntityId 910
SDKHook OnWeaponCanUsePost clientId 1 weaponEntityId 910
SDKHook OnWeaponEquip clientId 1 weaponEntityId 910
SDKHook OnWeaponCanSwitchTo clientId 1 weaponEntityId 910
SDKHook OnWeaponCanSwitchToPost clientId 1 weaponEntityId 910
SDKHook OnWeaponSwitch clientId 1 weaponEntityId 910
SDKHook OnWeaponCanSwitchTo clientId 1 weaponEntityId 910
SDKHook OnWeaponCanSwitchToPost clientId 1 weaponEntityId 910
HookEvent OnItemEquip userid 2 item_name_buffer m4a1 defindex 16 canzoom 0 hassilencer 0 issilenced 0 hastracers 1 weptype 3 ispainted 0
SDKHook OnWeaponSwitchPost clientId 1 weaponEntityId 910
SDKHook OnWeaponEquipPost clientId 1 weaponEntityId 910
HookEvent OnItemPickUpSlerp userid 2 index 910 behavior 1
HookEvent OnItemPickUp userid 2 item_name_buffer m4a1 silent 1 defindex 16
```

## Already Have Primary Logs
While still holding the M4, try to pick up the AK
```
CS_OnCSWeaponDrop client 1 weaponIndex 910
SDKHook OnWeaponDrop clientId 1 weaponEntityId 910
HookEvent OnItemRemove userid 2 item_name_buffer m4a1 defindex 16
SDKHook OnWeaponSwitch clientId 1 weaponEntityId 933
SDKHook OnWeaponCanSwitchTo clientId 1 weaponEntityId 933
SDKHook OnWeaponCanSwitchToPost clientId 1 weaponEntityId 933
HookEvent OnItemEquip userid 2 item_name_buffer glock defindex 4 canzoom 0 hassilencer 0 issilenced 0 hastracers 1 weptype 1 ispainted 0
SDKHook OnWeaponSwitchPost clientId 1 weaponEntityId 933
SDKHook OnWeaponDropPost clientId 1 weaponEntityId 910
SDKHook OnWeaponCanUse clientId 1 weaponEntityId 914
SDKHook OnWeaponCanUsePost clientId 1 weaponEntityId 914
SDKHook OnWeaponEquip clientId 1 weaponEntityId 914
SDKHook OnWeaponCanSwitchTo clientId 1 weaponEntityId 914
SDKHook OnWeaponCanSwitchToPost clientId 1 weaponEntityId 914
SDKHook OnWeaponSwitch clientId 1 weaponEntityId 914
SDKHook OnWeaponCanSwitchTo clientId 1 weaponEntityId 914
SDKHook OnWeaponCanSwitchToPost clientId 1 weaponEntityId 914
HookEvent OnItemEquip userid 2 item_name_buffer ak47 defindex 7 canzoom 0 hassilencer 0 issilenced 0 hastracers 1 weptype 3 ispainted 0
SDKHook OnWeaponSwitchPost clientId 1 weaponEntityId 914
SDKHook OnWeaponEquipPost clientId 1 weaponEntityId 914
HookEvent OnItemPickUpSlerp userid 2 index 914 behavior 1
HookEvent OnItemPickUp userid 2 item_name_buffer ak47 silent 1 defindex 7
```
