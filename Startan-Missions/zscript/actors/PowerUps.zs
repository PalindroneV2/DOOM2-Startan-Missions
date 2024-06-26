class BerserkProtect : Powerup
{
    Default
    {
        DamageFactor  0.75;
        Powerup.Duration -60;
		Powerup.Color "ff 00 00", 0.25;
    }
}

class BerserkStrength : Powerup
{
    Default
    {
        Powerup.Duration 0x7FFFFF;
        +INVENTORY.HUBPOWER;
    }
}

class NewBerserk : CustomInventory replaces Berserk
{
    	Default
	{
		+COUNTITEM
		+INVENTORY.ALWAYSPICKUP
		+INVENTORY.ISHEALTH
        Tag "Berserker Pack";
		Inventory.PickupMessage "Berserk! Rip and Tear! (100% HP)(Fist Improved)";
		Inventory.PickupSound "misc/p_pkup";
	}
	States
	{
	Spawn:
		PSTR A -1 Bright;
		Stop;
	Pickup:
		TNT1 A 0 A_Steroids;
		Stop;
	}
}

extend class NewBerserk
{
    action void A_Steroids()
    {
        A_GiveInventory("BerserkProtect");
        A_GiveInventory("PowerStrength");
        HealThing(100);
        A_SelectWeapon("DoomFist");
    }
}