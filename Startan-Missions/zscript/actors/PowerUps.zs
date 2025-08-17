class BerserkProtect : Powerup
{
    Default
    {
        Powerup.Duration -60;
		Powerup.Color "ff 00 00", 0.25;
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

class NewMegasphere : Megasphere replaces Megasphere
{
    Default
    {
        +COUNTITEM
        +INVENTORY.ALWAYSPICKUP
        +INVENTORY.ISHEALTH
        Tag "Megasphere";
        Inventory.PickupMessage "You got a Megasphere!";
        Inventory.PickupSound "misc/p_pkup";
    }
    States
    {
	Spawn:
		MEGA ABCD 6 BRIGHT;
		Loop;
    Pickup:
        TNT1 A 0 A_MegaSpherePickup;
        Stop;
    }
}

extend class NewMegasphere
{
    action void A_MegaSpherePickup()
    {
        bool ArmorisRed = CheckArmorType("EnchantedArmor", 1);
        bool ArmorisRedSmall = CheckArmorType("RedArmorSmall", 1);
        bool ArmorisEnchanted = CheckArmorType("EnchantedArmor", 1);
        GiveInventory("MegasphereHealth", 200);
       if (ArmorisRed || ArmorisRedSmall)
        {
            // Player has RedArmor equipped
            GiveInventory("RedArmor", 1);
        }
        else if (ArmorisEnchanted)
        {
            // Player has EnchantedArmor equipped
            GiveInventory("EnchantedArmor", 1);
        }
        else
        {
            // Player has no special armor equipped
            GiveInventory("BlueArmor50", 1);
        }
    }
}