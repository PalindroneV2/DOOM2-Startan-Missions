class Wunderwaffe : DoomWeapon
{
    Default
    {
        //$Category Weapons
        Weapon.SelectionOrder 2000;
        Weapon.SlotNumber 7;
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 3;
        Weapon.AmmoType "Cell";
        Obituary "%k zapped %o with a Wunderwaffe DG-2.";
        -WEAPON.WIMPY_WEAPON;
        Inventory.PickupMessage "You got a Wunderwaffe DG-2.";
        Tag "Wunderwaffe DG-2";
        Scale 0.2;
        // AttackSound "raygun/fire";
    }
    States
    {
    Ready:
        RAYG A 1 A_WeaponReady;
        Loop;
    Deselect:
        RAYG A 1 A_Lower(9);
        Loop;
    Select:
        RAYG A 1 A_Raise(9);
        Loop;
    Fire:
        RAYG A 4;
        RAYG B 6 A_Wunderwaffe_Fire;
        RAYG C 4;
        RAYG B 5 A_ReFire;
        Goto Ready;
    Flash:
        RAYF A 7 Bright A_Light1;
        Goto LightDone;
        RAYF A 7 Bright A_Light1;
        Goto LightDone;
    Spawn:
        RAYT A -1;
        Stop;
    }
}

extend class Wunderwaffe
{
    action void A_Wunderwaffe_Fire()
	{
		if (player == null)
		{
			return;
		}
		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (!weap.DepleteAmmo (weap.bAltFire, true, 1))
				return;
			
			State flash = weap.FindState('Flash');
			if (flash != null)
			{
				player.SetSafeFlash(weap, flash, random[FirePlasma](0, 1));
			}
			
		}
		SpawnPlayerMissile ("WaffeProjectile");
	}
}

class WaffeProjectile : Actor
{
	Default
	{
		Radius 8;
		Height 8;
		Speed 128;
		DamageFunction (500);
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		DeathSound "weapons/bfgx";
		Obituary "$OB_MPBFG_BOOM";
		DamageType "BFGSplash";
	}
	States
	{
	Spawn:
		BFS1 AB 4 Bright;
		Loop;
	Death:
		BFE1 AB 8 Bright;
		BFE1 C 8 Bright A_WaffeChain;
		BFE1 DEF 8 Bright;
		Stop;
	}
}
extend class WaffeProjectile
{
	action void A_WaffeChain()
	{
		A_Explode(100, 128, XF_THRUSTLESS, false, 128 ,0,10,"BFGExtra","BFGSplash"); //Extra explosion damage
		// A_BFGSpray("BFGExtra",45, 0, 90, 1024, 90, 50, 0); //Vanilla adjacent BFG
		A_BFGSpray("BFGExtra",1, 0, 360, 128, 90,  , BFGF_MISSILEORIGIN); //BFG SHOOTS RAYS FROM BALL
	}
}