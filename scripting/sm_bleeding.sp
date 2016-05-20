#pragma semicolon 1
#include <sdktools_functions>
#include <autoexecconfig>
#pragma newdecls required

#define PL_VERSION "0.03"

bool b_bleeding[MAXPLAYERS + 1];
int i_bleeding[MAXPLAYERS + 1];

Handle 	g_hBleedingBorder = null,
		g_hBleedingTime = null,
		g_hBleedingHealth = null;

#include "bleeding/stock.sp"
#include "bleeding/events.sp"

public Plugin myinfo =
{
	author = "Hejter",
	name = "[CSS/CSGO] Bleeding",
	version = PL_VERSION,
	url = "https://github.com/Heyter/Bleeding",
};

public void OnPluginStart()
{
	CreateConVar("Bleeding_Version", PL_VERSION, "Bleeding", FCVAR_NOTIFY|FCVAR_DONTRECORD);
	
	AutoExecConfig_SetFile("plugin.bleeding");
	AutoExecConfig_SetCreateFile(true);
	
	g_hBleedingBorder = AutoExecConfig_CreateConVar("Bleeding_Border", "75", "Start bleeding if player got less health", _, true, 0.0, true, 100.0);
	g_hBleedingTime = AutoExecConfig_CreateConVar("Bleeding_Timer", "5", "Delay between taking damage while bleeding (in seconds)", _);
	g_hBleedingHealth = AutoExecConfig_CreateConVar("Bleeding_Health", "5", "Minus health 1-100 every X seconds", _);
	
	AutoExecConfig_CleanFile();
	AutoExecConfig_ExecuteFile();
	
	HookEvent("player_hurt", Event_PlayerHurt);
	HookEvent("player_spawn", Event_PlayerSpawn);
	
	CreateTimer(1.0, OnEverySecond, _, TIMER_REPEAT);
}

public Action OnEverySecond(Handle timer)
{
	for (int i = 1; i <= MaxClients; i++) 
	{
		if (IsValid(i) && GetClientTeam(i) > 1 && b_bleeding[i])
		{
			StartBleeding(i);
		}
	}
}

public void OnClientPutInServer(int client)
{	
	Reset_Var(client);
}
