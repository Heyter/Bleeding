stock bool StartBleeding(int client)
{
    int health = GetClientHealth(client);
    if(health > GetConVarInt(g_hBleedingBorder)) b_bleeding[client] = false;

    else if (i_bleeding[client] > 0)
    {
        i_bleeding[client]--;
        //PrintHintText(client, "<font color='#ff0000'>Кровотечение через %d</font>", i_bleeding[client]);
    }
   
    else if (i_bleeding[client] == 0)
    {
        if ((health -= GetConVarInt(g_hBleedingHealth)) > 0)
        {
            SetEntityHealth(client, health);
            i_bleeding[client] = GetConVarInt(g_hBleedingTime);
        }
        else KillPlayer(client);
    }
}

stock bool IsValid(int client)
{
	if (0 < client && client <= MaxClients && IsClientInGame(client) && IsPlayerAlive(client))
	{
		return true;
	}
	else return false;
}

stock bool Reset_Var(int client)
{
	b_bleeding[client] = false;
	i_bleeding[client] = GetConVarInt(g_hBleedingTime);
}

stock bool KillPlayer(int client)
{
	ForcePlayerSuicide(client);
	Reset_Var(client);
}
