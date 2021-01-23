#include <sourcemod>
#include <cstrike>
#include <sdkhooks>
#include <sdktools_functions>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_NAME "CSGO Multiple Guns"
#define PLUGIN_NAME_ID "csgo_multiple_guns"
#define PLUGIN_VERSION "0.0.1"
public Plugin myinfo = 
{
  name = PLUGIN_NAME, 
  author = "CupOfJoe", 
  description = "Allows you to pick up multiple guns", 
  version = PLUGIN_VERSION, 
  url = "https://github.com/josephmate/CSGOMultipleGuns"
};

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
  // No need for the old GetGameFolderName setup.
  EngineVersion g_engineversion = GetEngineVersion();
  if (g_engineversion != Engine_CSGO)
  {
    SetFailState("This plugin was made for use with Counter-Strike: Global Offensive only.");
  }
}

public void OnPluginStart()
{
  CreateConVar("sm_"...PLUGIN_NAME_ID..."_version", 
    PLUGIN_VERSION, 
    "Standard plugin version ConVar. Please don't change me!", 
    FCVAR_REPLICATED | FCVAR_NOTIFY | FCVAR_DONTRECORD);

  HookEvent("item_pickup", OnItemPickUp, EventHookMode_Pre);
  HookEvent("item_pickup_slerp", OnItemPickUpSlerp, EventHookMode_Pre);
  HookEvent("item_pickup_failed", OnItemPickUpFailed, EventHookMode_Pre);
  HookEvent("item_remove", OnItemRemove, EventHookMode_Pre);
  HookEvent("ammo_pickup", OnAmmoPickUp, EventHookMode_Pre);
  HookEvent("item_equip", OnItemEquip, EventHookMode_Pre);
  HookEvent("dz_item_interaction", OnDZItemInteraction, EventHookMode_Pre);

  PrintToServer(PLUGIN_NAME..." loaded "...PLUGIN_VERSION);
}

public void OnPluginEnd()
{
  PrintToServer(PLUGIN_NAME..." unloaded "...PLUGIN_VERSION);
}

public Action CS_OnCSWeaponDrop(int client, int weaponIndex)
{
  PrintToServer("CS_OnCSWeaponDrop client %d weaponIndex %d", client, weaponIndex);
  //return Plugin_Handled;
  return Plugin_Continue;
}

// item_pickup          short userid    string item   bool silent       long defindex
public Action OnItemPickUp(Event event, const char[] name, bool dontBroadcast)
{
  int userid = event.GetInt("userid");
  char item_name_buffer[128];
  event.GetString("item", item_name_buffer, sizeof(item_name_buffer));
  int silent = event.GetBool("silent");
  int defindex = event.GetInt("defindex");
  PrintToServer("HookEvent OnItemPickUp userid %d item_name_buffer %s silent %d defindex %d", userid, item_name_buffer, silent, defindex);
  return Plugin_Continue;
}

// item_pickup_slerp    short userid    short index    short behavior	
public Action OnItemPickUpSlerp(Event event, const char[] name, bool dontBroadcast)
{
  int userid = event.GetInt("userid");
  int index = event.GetInt("index");
  int behavior = event.GetInt("behavior");
  PrintToServer("HookEvent OnItemPickUpSlerp userid %d index %d behavior %d", userid, index, behavior);
  return Plugin_Continue;
}

// item_pickup_failed   short userid    string item   short reason     short limit
public Action OnItemPickUpFailed(Event event, const char[] name, bool dontBroadcast)
{
  int userid = event.GetInt("userid");
  char item_name_buffer[128];
  event.GetString("item", item_name_buffer, sizeof(item_name_buffer));
  int reason = event.GetInt("reason");
  int limit = event.GetInt("limit");
  PrintToServer("HookEvent OnItemPickUpFailed userid %d item_name_buffer %s reason %d limit %d", userid, item_name_buffer, reason, limit);
  return Plugin_Continue;
}

// item_remove          short userid    string item   long defindex	
public Action OnItemRemove(Event event, const char[] name, bool dontBroadcast)
{
  int userid = event.GetInt("userid");
  char item_name_buffer[128];
  event.GetString("item", item_name_buffer, sizeof(item_name_buffer));
  int defindex = event.GetInt("defindex");
  PrintToServer("HookEvent OnItemRemove userid %d item_name_buffer %s defindex %d", userid, item_name_buffer, defindex);
  return Plugin_Continue;
}

// ammo_pickup          short userid    string item  long index
public Action OnAmmoPickUp(Event event, const char[] name, bool dontBroadcast)
{
  int userid = event.GetInt("userid");
  char item_name_buffer[128];
  event.GetString("item", item_name_buffer, sizeof(item_name_buffer));
  int index = event.GetInt("index");
  PrintToServer("HookEvent OnAmmoPickUp userid %d item_name_buffer %s index %d", userid, item_name_buffer, index);
  return Plugin_Continue;
}

// item_equip           short	userid   string	item  long	defindex bool	canzoom	bool	hassilencer	bool	issilenced	bool	hastracers	short	weptype  bool	ispainted
// weptypes:
// WEAPONTYPE_UNKNOWN = -1
// WEAPONTYPE_KNIFE = 0
// WEAPONTYPE_PISTOL = 1
// WEAPONTYPE_SUBMACHINEGUN = 2
// WEAPONTYPE_RIFLE = 3
// WEAPONTYPE_SHOTGUN = 4
// WEAPONTYPE_SNIPER_RIFLE = 5
// WEAPONTYPE_MACHINEGUN = 6
// WEAPONTYPE_C4 = 7
// WEAPONTYPE_TASER = 8
// WEAPONTYPE_GRENADE = 9
// WEAPONTYPE_HEALTHSHOT = 11
public Action OnItemEquip(Event event, const char[] name, bool dontBroadcast)
{
  int userid = event.GetInt("userid");
  char item_name_buffer[128];
  event.GetString("item", item_name_buffer, sizeof(item_name_buffer));
  int defindex = event.GetInt("defindex");
  bool canzoom = event.GetBool("canzoom");
  bool hassilencer = event.GetBool("hassilencer");
  bool issilenced = event.GetBool("issilenced");
  bool hastracers = event.GetBool("hastracers");
  int weptype = event.GetInt("weptype");
  bool ispainted = event.GetBool("ispainted");

  PrintToServer("HookEvent OnItemEquip userid %d item_name_buffer %s defindex %d canzoom %d hassilencer %d issilenced %d hastracers %d weptype %d ispainted %d",
    userid,
    item_name_buffer,
    defindex,
    canzoom,
    hassilencer,
    issilenced,
    hastracers,
    weptype,
    ispainted
  );
  return Plugin_Continue;
}

// dz_item_interaction  short	userid  short	subject  string	type
public Action OnDZItemInteraction(Event event, const char[] name, bool dontBroadcast)
{
  int userid = event.GetInt("userid");
  int subject = event.GetInt("subject");
  char type_name_buffer[128];
  event.GetString("type", type_name_buffer, sizeof(type_name_buffer));
  int index = event.GetInt("index");
  PrintToServer("HookEvent OnDZItemInteraction userid %d subject %d type_name_buffer %s index %d", userid, subject, type_name_buffer, index);
  return Plugin_Continue;
}

public void OnClientPutInServer(int client)
{
  PrintToServer("OnClientPutInServer %d", client);

  SDKHook(client, SDKHook_WeaponCanSwitchTo, OnWeaponCanSwitchTo);
  SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
  SDKHook(client, SDKHook_WeaponDrop, OnWeaponDrop);
  SDKHook(client, SDKHook_WeaponSwitch, OnWeaponSwitch);
  SDKHook(client, SDKHook_WeaponEquip, OnWeaponEquip);
  SDKHook(client, SDKHook_WeaponCanSwitchToPost, OnWeaponCanSwitchToPost);
  SDKHook(client, SDKHook_WeaponCanUsePost, OnWeaponCanUsePost);
  SDKHook(client, SDKHook_WeaponDropPost, OnWeaponDropPost);
  SDKHook(client, SDKHook_WeaponEquipPost, OnWeaponEquipPost);
  SDKHook(client, SDKHook_WeaponSwitchPost, OnWeaponSwitchPost);
}

public Action OnWeaponCanSwitchTo(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponCanSwitchTo clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponCanUse(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponCanUse clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponDrop(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponDrop clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponSwitch(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponSwitch clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponEquip(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponEquip clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponCanSwitchToPost(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponCanSwitchToPost clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponCanUsePost(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponCanUsePost clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponDropPost(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponDropPost clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponEquipPost(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponEquipPost clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}

public Action OnWeaponSwitchPost(int clientId, int weaponEntityId)
{
  PrintToServer("SDKHook OnWeaponSwitchPost clientId %d weaponEntityId %d", clientId, weaponEntityId);
  return Plugin_Continue;
}