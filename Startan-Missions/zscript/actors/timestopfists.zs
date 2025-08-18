class THEWORLD : Weapon
{
    int AltFireRegenTimer;
    int FirstSelect;
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
            KNGF A 1 A_WeaponReady;
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
            // Retract and ready for next action
            TNT1 A 1 { A_WeaponOffset(0, 32); A_Refire(); }
            TNT1 A 0 A_StopSound(CHAN_VOICE);
            KNGF A 1 A_WeaponOffset(0, 62);
            KNGF A 1 A_WeaponOffset(0, 52);
            KNGF A 1 A_WeaponOffset(0, 42);
            KNGF A 1 A_WeaponOffset(0, 32);
            Goto Ready;
        AltFire:
            TNT1 A 0 A_JumpIf(invoker.ZaWarudoCharge,"ZaWarudo");
            KNGF A 35 A_StartSound("dio/mudada", CHAN_AUTO);
            Goto Ready;
        ZaWarudo:
            KNGF A 54 A_StartSound("dio/ZAWARUDO", CHAN_AUTO);
            KNGF A 1 A_ZaWarudo();
            Goto Ready;
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
