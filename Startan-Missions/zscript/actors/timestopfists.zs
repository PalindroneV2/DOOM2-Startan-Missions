class THEWORLD : Weapon
{
    int AltFireRegenTimer;
    bool FirstSelect;
    bool CanThrow;
    Default
    {
		Weapon.AmmoUse2 1;
		Weapon.AmmoGive2 1;
		Weapon.AmmoType2 "ZaWarudoCharge";
        Weapon.SlotNumber 1;
        Weapon.KickBack 50;
        Weapon.SelectionOrder 3700;
        Scale 1;
        Inventory.PickupMessage "You have obtained STAND POWER! THE WORLD!";
        Obituary "%k obliterated %o with his STAND, THE WORLD.";
        Tag "THE WORLD";
		Radius 20;
		Height 20;
        +PICKUP;
        +NOGRAVITY;
        +COUNTITEM;
        +FLOATBOB;
		+INVENTORY.ALWAYSPICKUP;
        FloatBobStrength 0.25;
        +INVENTORY.UNTOSSABLE;
        +Inventory.AUTOACTIVATE; // optional: auto-equip on pickup
        +Inventory.PickupFlash; // optional visual
        +Weapon.MeleeWeapon; // ZScript uses Inventory-style flags
        +WEAPON.ALT_AMMO_OPTIONAL;        // Prevent weapon blocking if ammo is missing
    }

    States
    {
        Spawn:
            KUNG A -1;
            Stop;
        Select:
            TNT1 A 0 A_JumpIf(!invoker.FirstSelect,"FirstSelect");
            TNT1 A 0 A_JumpIf(invoker.FirstSelect,"RealSelect");
        FirstSelect:
            KNGF A 1 A_Raise(18);
            TNT1 A 0 {
                A_StartSound("dio/wry", CHAN_VOICE);
                invoker.FirstSelect = true;
            }
            Loop;
        RealSelect:
            KNGF A 1 A_Raise(18);
            Loop;
        Deselect:
            KNGF A 1 A_Lower(18);
            Loop;
        Ready:
            TNT1 A 0 A_JumpIf(invoker.CanThrow,"StandReady");
            KNGF A 1 A_WeaponReady;
		    Loop;
        StandReady:
            KNGF A 1 A_WeaponReady(WRF_ALLOWRELOAD);
		    Loop;
        Fire:
            KNGF A 0 A_StartSound("dio/mudaloop", CHAN_VOICE);
            // First punch: right-hand jab
            KNGF C 1;
            KNGF C 1 A_WeaponOffset(-12, 0);
            KNGF C 1 { A_WeaponOffset(-35, -14); A_DIOPunch(); }
            KNGF C 1 A_WeaponOffset(-41, 30);
            // Transition to second punch (left-hand)
            KNGF D 1;
            KNGF D 1 A_WeaponOffset(12, 0);
            KNGF D 1 { A_WeaponOffset(35, -14); A_DIOPunch(); }
            KNGF D 1 A_WeaponOffset(41, 30);
            //START RIGHT HAND JAB AGAIN
            KNGF C 1;
            KNGF C 1 A_WeaponOffset(-12, 0);
            KNGF C 1 { A_WeaponOffset(-35, -14); A_DIOPunch(); }
            KNGF C 1 A_WeaponOffset(-41, 30);
            // Transition to second punch (left-hand)
            KNGF D 1;
            KNGF D 1 A_WeaponOffset(12, 0);
            KNGF D 1 { A_WeaponOffset(35, -14); A_DIOPunch(); }
            KNGF D 1 A_WeaponOffset(41, 30);
            // Retract and ready for next action
            TNT1 A 1 { A_WeaponOffset(0, 32); A_Refire(); }
            TNT1 A 0 A_StopSound(CHAN_VOICE);
            KNGF A 1 A_WeaponOffset(0, 62);
            KNGF A 1 A_WeaponOffset(0, 52);
            KNGF A 1 A_WeaponOffset(0, 42);
            KNGF A 1 A_WeaponOffset(0, 32);
            Goto Ready;
        Reload:
            TNT1 A 0 A_JumpIf(!invoker.CanThrow,"Ready");
            PUNG A 1 A_WeaponOffset(0, 64);
            PUNG A 1 A_WeaponOffset(0, 60);
            PUNG A 1 A_WeaponOffset(0, 56);
            PUNG A 1 A_WeaponOffset(0, 52);
            PUNG A 1 A_WeaponOffset(0, 48);
            PUNG A 1 A_WeaponOffset(0, 40);
            PUNG A 1 A_WeaponOffset(0, 32);
            PUNG A 1 A_DIOKnifeThrowTall();
            PUNG A 12;
            Goto StandReady;
        AltFire:
            TNT1 A 0 A_JumpIf(invoker.ZaWarudoCharge,"ZaWarudo");
            KNGF A 35 A_StartSound("dio/mudada", CHAN_AUTO);
            Goto Ready;
        ZaWarudo:
            KNGF A 54 A_StartSound("dio/ZAWARUDO", CHAN_AUTO);
            KNGF A 1 A_ZaWarudo();
            TNT1 A 0 {
                invoker.CanThrow = true;
            }
            Goto StandReady;
    }
}

extend class THEWORLD
{
    bool ZaWarudoCharge;
    action void A_DIOPunch()
    {
        int dmg = 5 * Random(5,6);
		if (FindInventory("PowerStrength"))
		{
			dmg  = 5 * Random(10,12);
		}
        A_CustomPunch(dmg, norandom:true, CPF_NOTURN, "FuryPuff", 64, 0, 0, "ArmorBonus", "Puff/HitThing", "Puff/HitMiss");
    }
    action void A_DIOKnifeThrow()
    {
        A_StartSound("dio/knifethrow", CHAN_AUTO);
        A_FireProjectile("DIOKnife",
                        angle: 0,
                        useammo: true,
                        spawnofs_xy: 0,
                        spawnheight: 0,
                        flags: 0,
                        pitch: 0);
    }
    action void A_DIOKnifeThrowTall()
    {
		for (int i = 0; i < 5; i++)
        {
            int offset = -2 + (i * 8); // Calculate the offset: -32, -24, ..., 24
            A_StartSound("dio/knifethrow", CHAN_AUTO);
            A_FireProjectile("DIOKnife",
                            angle: 0,
                            useammo: true,
                            spawnofs_xy: 0,
                            spawnheight: offset,
                            flags: 0,
                            pitch: 0);
        }
    }
    action void A_DIOKnifeThrowWide()
    {
		for (int i = 0; i < 5; i++)
        {
            int offset = -2 + (i * 8); // Calculate the offset: -32, -24, ..., 24
            A_StartSound("dio/knifethrow", CHAN_AUTO);
            A_FireProjectile("DIOKnife",
                            angle: 0,
                            useammo: true,
                            spawnofs_xy: offset,
                            spawnheight: 0,
                            flags: 0,
                            pitch: 0);
        }
    }
    action void A_ZaWarudo()
    {
        A_TakeInventory("ZaWarudoCharge", 1);
        A_GiveInventory("ZaWarudo",1);
        // if (invoker.ZaWarudoCharge)
        // {
        //     A_TakeInventory("ZaWarudoCharge", 1);
        //     A_GiveInventory("ZaWarudo",1);
        // }
        // S_StartSound("dio/timestopsfx", CHAN_AUTO);
        // S_StartSound("dio/timestop", CHAN_AUTO);
    }
    override void BeginPlay()
    {
        Super.BeginPlay();
        AltFireRegenTimer = 0;
    }
    override void Tick()
    {
        Super.Tick();
        // If we lack alt ammo, start/reduce the regen timer.
        if (owner == null || owner.PlayerNumber() < 0)
        {
            return; // no player to check ammo for
        }
        ZaWarudoCharge = CheckAmmo(AltFire, false, true);
       if (!ZaWarudoCharge)
        {
            if (AltFireRegenTimer <= 350 && AltFireRegenTimer > 0)
            {
                CanThrow = false;
            }
            if (AltFireRegenTimer <= 0)
            {
                AltFireRegenTimer = 700; // e.g., 20-second countdown
            }
            else
            {
                AltFireRegenTimer--;
                
                // A_Log("Time till Time Stop = " .. AltFireRegenTimer / 35);
                if (AltFireRegenTimer <= 0)
                {
                    owner.GiveInventory("ZaWarudoCharge", 1); // replenish ammo
                    S_StartSound("dio/laugh", CHAN_AUTO);
                }
            }
        }
        else
        {
            // If ammo exists, reset the cooldown timer
            // A_Log("You have Ammo!");
            AltFireRegenTimer = 0;
        }

    }

}

class ZaWarudoCharge : Ammo
{
    Default
    {
        Inventory.PickupMessage "The World is ready to stop time!";
        Inventory.PickupSound "dio/charge"; // Optional feedback\
        Inventory.Amount 1;
		Ammo.BackpackAmount 1;
		Ammo.BackpackMaxAmount 1;
		Inventory.Icon "KUNGA0";
        // Inventory.HideFromHUD true;
    }
}

class FuryPuff : Actor
{
    Default
    {
        VSpeed 1;
        RenderStyle "Translucent"; // see ZScript default renderstyles
        Alpha 0.5;
        +NOBLOCKMAP;
        +NOGRAVITY;
        +ALLOWPARTICLES;
        +NOEXTREMEDEATH;
    }

    States
    {
        Spawn:
            PUFF CD 4;
            Stop;
    }
}

class FuryPowerPuff : FuryPuff
{
    Default
    {
        VSpeed 0;
        Scale 0.7;
        +PUFFONACTORS;
        -ALLOWPARTICLES;
        -NOEXTREMEDEATH;
    }

    States
    {
        Spawn:
            BAL1 DE 4;
            Stop;
    }
}

class DIOKnife : FastProjectile
{
    Default
    {
        Speed 60;                // How fast the knife flies
        Radius 4;
        Height 4;
        DamageFunction 25;               // Damage it does on hit
        +NOBLOCKMAP;
        Projectile;
        +MISSILE;
        RenderStyle "Normal";
        Translation "None";
        Obituary "%o was skewered by a knife!";
        Scale 0.15;
    }

    States
    {
    Spawn:
        KNIF A 1 Bright;
        Loop;
    Death:
        KNIF A 1 Bright A_StartSound("dio/knifehit", CHAN_AUTO);
        KNIF A 5 Bright;
        Stop;
    }
}

class ZaWarudo : TimeStopPower
{
    Default
    {
        Inventory.PickupMessage "Time stopped!";
        Inventory.Icon "KUNGA0";      // optional (make a graphic or remove this line)
        Powerup.Duration -10;            // seconds (negative value => seconds)
        // You can tweak these for audiovisual flair:
        Powerup.Color "GoldMap",0.25; // subtle blue tint (remove if undesired)
        // Powerup.Mode "TimeFreezer";       // not strictly needed; class already does it
		TimeStopPower.TimeStopSFX "dio/timestopsfx";
		TimeStopPower.TimeStopBark "dio/timestop";
		TimeStopPower.TimeResumeBark "dio/timeresume";
    }
}

class TimeStopPower : Powerup
{
	string TimeStopSFX;
	string TimeStopBark;
	string TimeResumeBark;
	property TimeStopSFX : TimeStopSFX;
	property TimeStopBark : TimeStopBark;
	property TimeResumeBark : TimeResumeBark;
	Default
	{
		Powerup.Duration -5;
		TimeStopPower.TimeStopSFX "dio/timestopsfx";
		TimeStopPower.TimeStopBark "";
		TimeStopPower.TimeResumeBark "";
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
        S_StartSound(TimeStopSFX, CHAN_AUTO);
        S_StartSound(TimeStopBark, CHAN_AUTO);

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
            S_StartSound(TimeResumeBark, CHAN_AUTO); // Replace with your sound path
        }
		if (!paused)
		{
			S_ResumeSound(false);
			S_PauseSound(false, true);
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