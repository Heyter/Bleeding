public void Event_PlayerHurt(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	int attacker = GetClientOfUserId(event.GetInt("attacker"));
    
	if (IsPlayerAlive(client) && !b_bleeding[client] && client != attacker)
	{
		int health = event.GetInt("health");
		if (health <= GetConVarInt(g_hBleedingBorder))
		{
			b_bleeding[client] = true;
		}
	}
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	Reset_Var(client);
}