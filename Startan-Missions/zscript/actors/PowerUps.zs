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
        if (FindInventory("DIOfists"))
        {
            A_SelectWeapon("DIOfists");
        }
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

class ZaWarudo : ZaWarudoTimeStop
{
    Default
    {
        Inventory.PickupMessage "Time stopped!";
        Inventory.Icon "KUNGA0";      // optional (make a graphic or remove this line)
        Powerup.Duration -10;            // seconds (negative value => seconds)
        // You can tweak these for audiovisual flair:
        Powerup.Color "GoldMap",0.25; // subtle blue tint (remove if undesired)
        // Powerup.Mode "TimeFreezer";       // not strictly needed; class already does it
    }
}

class ZaWarudoTimeStop : Powerup
{
	Default
	{
		Powerup.Duration -5;
	}
	
	//===========================================================================//
	// InitEffect
	//===========================================================================//
	override void InitEffect()
	{
		int freezemask;

		Super.InitEffect();

		if (Owner == null || Owner.player == null)
			return;

		// When this powerup is in effect, pause the music.
		S_PauseSound(false, true);
        S_StartSound("dio/timestopsfx", CHAN_AUTO);
        S_StartSound("dio/timestop", CHAN_AUTO);

		// Give the player and his teammates the power to move when time is frozen.
		freezemask = 1 << Owner.PlayerNumber();
		Owner.player.timefreezer |= freezemask;
		for (int i = 0; i < MAXPLAYERS; i++)
		{
			if (playeringame[i] &&
				players[i].mo != null &&
				players[i].mo.IsTeammate(Owner)
			   )
			{
				players[i].timefreezer |= freezemask;
			}
		}

		// Ensure the effect ends one tic after the counter hits zero.
		EffectTics += !(EffectTics & 1);
		if ((EffectTics & 1) == 0)
		{
			EffectTics++;
		}

		// Make sure the effect starts and ends on an even tic.
		if ((Level.maptime & 1) == 0)
		{
			Level.SetFrozen(true);
		}
		else
		{
			if(EffectTics < 0x7fffffff)
				EffectTics++;
		}
	}

	//===========================================================================//
	// DoEffect
	//===========================================================================//

	override void DoEffect()
    {
        Super.DoEffect();

        // Keep time frozen for the entire duration of the effect
        if (Owner == null || Owner.player == null || (Owner.player.cheats & CF_PREDICTING))
        {
            return;
        }
        if (EffectTics == 75) // 35 tics = 1 second
        {
            S_StartSound("dio/timeresume", CHAN_AUTO); // Replace with your sound path
        }

        // Freeze the level unconditionally while the powerup is active
        Level.SetFrozen(true);
    }

	//===========================================================================//
	// EndEffect
	//===========================================================================//

	override void EndEffect()
	{
		Super.EndEffect();

		if (Owner != null && Owner.player != null)
		{
			int freezemask = ~(1 << Owner.PlayerNumber());
			for (int i = 0; i < MAXPLAYERS; ++i)
			{
				players[i].timefreezer &= freezemask;
			}
		}

		for (int i = 0; i < MAXPLAYERS; ++i)
		{
			if (playeringame[i] && players[i].timefreezer != 0)
			{
				return;
			}
		}

		Level.SetFrozen(false);
		S_ResumeSound(false);
	}
    override bool isBlinking()
    {
        return false;
    }
}
