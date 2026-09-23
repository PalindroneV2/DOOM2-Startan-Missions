class JuggernautHealth : MaxHealth
{
    Default
    {
		Tag "Juggernog Health";
        Inventory.Amount 1;
        Inventory.MaxAmount 250;
    }
    States
    {
        Spawn:
            BON1 ABCDCB 6;
            Loop;
        Pickup:
            TNT1 A 0;
            Stop;
    }
}

class Perk_Juggernog : Inventory
{
	Default
	{
		Tag "Juggernog Perk";
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        // Inventory.InterHubAmount 0;
        +INVENTORY.QUIET;
        +INVENTORY.UNDROPPABLE;
        +INVENTORY.UNTOSSABLE;
		+INVENTORY.HUBPOWER;
	}
}

class PerkBottle_Juggernog : CustomInventory
{
    Default
    {
		Tag "Juggernog Bottle";
		+INVENTORY.ALWAYSPICKUP;
        Inventory.PickupMessage "Reach for Juggernog Tonight!";
        Inventory.PickupSound "misc/p_pkup";
    }
    States
    {
        Spawn:
            BON1 ABCDCB 6;
            Loop;
        Pickup:
            TNT1 A 0 GivePerk_Juggernog();
            Stop;
    }
    action void GivePerk_Juggernog()
    {
        A_GiveInventory("JuggernautHealth",150);
        A_GiveInventory("Perk_Juggernog",1);
    }
}