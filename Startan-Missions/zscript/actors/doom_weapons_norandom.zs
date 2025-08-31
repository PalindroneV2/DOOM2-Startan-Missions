class DoomFist : Weapon replaces Fist
{
	Default
	{
		Weapon.SelectionOrder 3700;
		Weapon.SlotNumber 1;
		Weapon.Kickback 100;
		Obituary "%k beat %o to death.";
		Tag "Fist";
		+WEAPON.WIMPY_WEAPON
		+WEAPON.MELEEWEAPON
		+WEAPON.NOAUTOSWITCHTO
	}
	States
	{
	Ready:
		PUNG A 1 A_WeaponReady;
		Loop;
	Deselect:
		PUNG A 1 A_Lower(18);
		Loop;
	Select:
		PUNG A 1 A_Raise(18);
		Loop;
	Fire:
		PUNG B 4;
		PUNG C 4 A_NewPunch;
		PUNG D 5;
		PUNG C 4;
		PUNG B 5 A_ReFire;
		Goto Ready;
	FireFast:
		PUNG B 1;
		PUNG C 1 A_NewPunch;
		PUNG D 2;
		PUNG C 1;
		PUNG B 2 A_ReFire;
		Goto Ready;
	}
}
extend class DoomFist
{	
	action void A_NewPunch()
	{
		int dmg = 5 * Random(1,5);
		if (FindInventory("PowerStrength"))
		{
			dmg  = 50* Random(4,5);
		}
		A_CustomPunch(dmg, norandom:true, range: meleeRange + 20, meleesound: "*fist");
	}
	override bool HandlePickup(Inventory item)
	{
		if (item.GetClass() == "THEWORLD")
		{
			//Take away the base DOOMFist
			owner.TakeInventory("DoomFist", 1);
			item.bPickupgood = true;
			return Super.HandlePickup(item); // Pickup was handled
		}
		return Super.HandlePickup(item);
	}
}

class ChainsawNoRand : Weapon replaces Chainsaw
{
	Default
	{
		Weapon.Kickback 0;
		Weapon.SlotNumber 1;
		Weapon.SelectionOrder 3701;
		Weapon.UpSound "weapons/sawup";
		Weapon.ReadySound "weapons/sawidle";
		Inventory.PickupMessage "$GOTCHAINSAW";
		Obituary "$OB_MPCHAINSAW";
		Tag "Chainsaw";
		+WEAPON.MELEEWEAPON		
		+WEAPON.NOAUTOSWITCHTO
	}
	States
	{
	Ready:
		SAWG CD 4 A_WeaponReady;
		Loop;
	Deselect:
		SAWG C 1 A_Lower;
		Loop;
	Select:
		SAWG C 1 A_Raise;
		Loop;
	Fire:
		SAWG AB 4 A_ChainSaw();
		SAWG B 0 A_ReFire;
		Goto Ready;
	Spawn:
		CSAW A -1;
		Stop;
	}
}

extend class ChainsawNoRand
{
	action void A_ChainSaw()
	{
		A_Saw("weapons/sawfull", "weapons/sawhit", 10, "BulletPuff", SF_NORANDOM, 64, 2.8125, 0, 0, 0, "ArmorBonus");
	}
}

class Handgun : Pistol replaces Pistol
{
 	Default
	{
		Weapon.SelectionOrder 1900;
		Weapon.SlotNumber 2;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Clip";
		Obituary "%k somehow killed %o with a Handgun.";
		-WEAPON.WIMPY_WEAPON;
		Inventory.PickupMessage "You picked up a Handgun.";
		Tag "Handgun";
	}
	States
	{
	Ready:
		PISG A 1 A_WeaponReady;
		Loop;
	Deselect:
		PISG A 1 A_Lower(12);
		Loop;
	Select:
		PISG A 1 A_Raise(12);
		Loop;
	Fire:
		PISG A 3;
		PISG B 3 A_HandgunFire;
		PISG C 3;
		PISG B 3 A_ReFire;
		Goto Ready;
	Flash:
		PISF A 3 Bright A_Light1;
		Goto LightDone;
		PISF A 3 Bright A_Light1;
		Goto LightDone;
 	Spawn:
		PIST A -1;
		Stop;
	}
}

extend class Handgun
{
    action void A_HandgunFire()
    {
		int dmg = 10;
		if (Random(1, 100) <= 5)
		{
			dmg *= 2.5;
		}else{
			dmg = 10;
		}
		A_StartSound ("weapons/pistol", CHAN_WEAPON);
		A_FireBullets(5, 4, 1, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		(1,3,0,1);
		A_GunFlash();
    }
	override bool HandlePickup(Inventory item)
	{
		if (item.GetClass() == "WaltherPPK" || item.GetClass() == "M1911A1")
		{
			// Deduct some ammo to compensate for the weapon pickup
			owner.TakeInventory("Clip", 4);
			//Take away the base Handgun
			owner.TakeInventory("Handgun", 1);
			item.bPickupgood = true;
			return Super.HandlePickup(item); // Pickup was handled
		}
		return Super.HandlePickup(item);
	}
}

class Minigun : DoomWeapon replaces Chaingun
{
	Default
	{
		Weapon.SelectionOrder 699;
		Weapon.SlotNumber 4;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Clip";
		Inventory.PickupMessage "You got a minigun!";
		Obituary "%o was shredded by %k with a Minigun";
		Tag "Minigun";
	}
	States
	{
	Ready:
		CHGG A 1 A_WeaponReady;
		Loop;
	Deselect:
		CHGG A 1 A_Lower(6);
		Loop;
	Select:
		CHGG A 1 A_Raise(6);
		Loop;
	Fire:
		CHGG A 1 ;
		CHGG B 2 A_MinigunFire;
		CHGG B 1 A_ReFire;
		Goto Ready;
	Flash:
		CHGF A 3 Bright A_Light1;
		Goto LightDone;
	Flash2:
		CHGF B 3 Bright A_Light2;
		Goto LightDone;
	Spawn:
		MGUN A -1;
		Stop;
	}
}

extend class Minigun
{
    action void A_MinigunFire()
    {
		int dmg = 10;
		if (Random(1, 100) <= 5)
		{
			dmg *= 2;
		} else {
			dmg = 10;
		}
		A_StartSound ("weapons/chngun", CHAN_WEAPON);
		A_FireBullets(5, 0, 1, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		(2,2,0,2);
		A_GunFlash();
    }
    action void A_MinigunFire_PAP()
    {
		int dmg = 20;
		if (Random(1, 100) <= 5)
		{
			dmg *= 2;
		} else {
			dmg = 20;
		}
		A_StartSound ("PAP/Fire", CHAN_WEAPON);
		A_FireBullets(5, 0, 1, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		(2,2,0,2);
		A_GunFlash();
    }
}

class NewShotgun : DoomWeapon replaces Shotgun
{
	Default
	{
		Weapon.SelectionOrder 1300;
		Weapon.SlotPriority 1;
        Weapon.SlotNumber 3;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 8;
		Weapon.AmmoType "Shell";
		Inventory.PickupMessage "You got the Shotgun!";
		Obituary "%o was blasted by %k with a Shotgun";
		Tag "Shotgun";
	}
	States
	{
	Ready:
		SHTG A 1 A_WeaponReady;
		Loop;
	Deselect:
		SHTG A 1 A_Lower(10);
		Loop;
	Select:
		SHTG A 1 A_Raise(10);
		Loop;
	Fire:
		SHTG A 3;
		SHTG A 7 A_ShotgunShot;
		SHTG BC 5;
		SHTG D 4;
		SHTG CB 5;
		SHTG A 3;
		SHTG A 7 A_ReFire;
		Goto Ready;
	Flash:
		SHTF A 4 Bright A_Light1;
		SHTF B 3 Bright A_Light2;
		Goto LightDone;
	Spawn:
		SHOT A -1;
		Stop;
	}
}
extend class NewShotgun
{
    action void A_ShotgunShot()
    {
		int dmg = 12;
		if (Random(1, 100) <= 10)
		{
			dmg *= 1.25;
		}else{
			dmg = 12;
		}
		A_StartSound ("weapons/shotgf", CHAN_WEAPON);
		A_FireBullets(7.5,0, 8, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		(2,3,0,3);
		A_GunFlash();
    }
	action void A_SecretShotgunPickup()
	{
		TakeInventory("NewShotgun", 1);
		TakeInventory("Shotgun", 1);
		TakeInventory("Shell", 12);
		GiveInventory("Trenchgun", 1);
	}
	override bool HandlePickup(Inventory item)
	{
		if (item.GetClass() == "Trenchgun")
		{
			if (owner.FindInventory("NewShotgun"))
			{
				// Give only ammo
				owner.TakeInventory("Shell", 4);
				owner.TakeInventory("NewShotgun", 1);
			}
			item.bPickupgood = true;
			return Super.HandlePickup(item); // Pickup was handled
		}
		return Super.HandlePickup(item);
	}
}

class NewSuperShotgun : DoomWeapon replaces SuperShotgun
{
	Default
	{
		Weapon.SelectionOrder 400;
		Weapon.SlotPriority 3;
		Weapon.SlotNumber 3;
		Weapon.AmmoUse 2;
		Weapon.AmmoGive 8;
		Weapon.AmmoType "Shell";
		Inventory.PickupMessage "You got the Super Shotgun!";
		Obituary "%o was blown away by %k's Super Shotgun";
		Tag "Super Shotgun";
	}
	States
	{
	Ready:
		SHT2 A 1 A_WeaponReady;
		Loop;
	Deselect:
		SHT2 A 1 A_Lower(10);
		Loop;
	Select:
		SHT2 A 1 A_Raise(10);
		Loop;
	Fire:
		SHT2 A 3;
		SHT2 A 7 A_FireSSG;
		SHT2 B 7;
		SHT2 C 7 A_CheckReload;
		SHT2 D 7 A_OpenShotgun2;
		SHT2 E 7;
		SHT2 F 7 A_LoadShotgun2;
		SHT2 G 6;
		SHT2 H 6 A_CloseShotgun2;
		SHT2 A 5 A_ReFire;
		Goto Ready;
	// unused states
		SHT2 B 7;
		SHT2 A 3;
		Goto Deselect;
	Flash:
		SHT2 I 4 Bright A_Light1;
		SHT2 J 3 Bright A_Light2;
		Goto LightDone;
	Spawn:
		SGN2 A -1;
		Stop;
	}
}
extend class NewSuperShotgun
{
    action void A_FireSSG()
    {
		int dmg = 12;
		//SSG SuperCrit
		if (Random(1, 200) == 1)
		{
			dmg = 125;
		}else{
			dmg = 12;
		}
		A_StartSound ("weapons/sshotf", CHAN_WEAPON);
		A_FireBullets(15,7.5, 25, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		(3,5,0,5);
		A_GunFlash();
    }
	action void A_FireSSG_PAP()
    {
		int dmg = 25;
		//SSG SuperCrit
		if (Random(1, 200) == 1)
		{
			dmg = 150;
		}else{
			dmg = 25;
		}
		A_StartSound ("weapons/sshotf", CHAN_WEAPON);
		A_StartSound ("PAP/Fire", CHAN_AUTO);
		A_FireBullets(15,7.5, 25, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		(3,5,0,5);
		A_GunFlash();
    }
}

class NewRocketLauncher : RocketLauncher replaces RocketLauncher
{
	Default
	{
		Tag "Rocket Launcher";
		Weapon.SlotNumber 5;
		Weapon.SlotPriority 2;
	}
	States
	{
	Fire:
		MISG B 8 A_GunFlash;
		MISG B 12 A_NewRocketLauncherFire();
		MISG B 0 A_ReFire;
		Goto Ready;
    }

	action void A_NewRocketLauncherFire()
	{
		A_FireProjectile("NoRandRocket",
                 angle: 0,
                 useammo: true,
                 spawnofs_xy: 0,
                 spawnheight: 1,
                 flags: 0,
                 pitch: 0);
	}
}

class FastPlasmaRifle : PlasmaRifle replaces PlasmaRifle
{
	Default
	{
		Tag "Plasma Rifle";
		Weapon.SlotNumber 6;
	}
	States
	{
		Ready:
			PLSG A 1 A_WeaponReady;
			Loop;
		Fire:
			PLSG A 3 A_NewFirePlasma();
			// PLSG B 0 A_Quake(2,2,0,2);
			PLSG B 10 A_ReFire;
			Goto Ready;
		Ready:
			PLSG A 1 A_WeaponReady;
			Loop;
		Deselect:
			PLSG A 1 A_Lower(9);
			Loop;
		Select:
			PLSG A 1 A_Raise(9);
			Loop;
		Flash:
			PLSF A 4 Bright A_Light1;
			Goto LightDone;
			PLSF B 4 Bright A_Light1;
			Goto LightDone;
		Spawn:
			PLAS A -1;
			Stop;
	}

	action void A_NewFirePlasma()
	{
		A_FireProjectile("NoRandPlasmaBall",
                 angle: 0,
                 useammo: true,
                 spawnofs_xy: 0,
                 spawnheight: 1,
                 flags: 0,
                 pitch: 0);
	}
}

class NoRandPlasmaBall : Actor replaces PlasmaBall
{
	Default
	{
		DamageFunction (25);
		Radius 12;
		Height 8;
		Speed 25;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "weapons/plasmaf";
		DeathSound "weapons/plasmax";
		Obituary "$OB_MPPLASMARIFLE";
	}
	States
	{
	Spawn:
		PLSS AB 6 Bright;
		Loop;
	Death:
		PLSE ABCDE 4 Bright;
		Stop;
	}
}

class Rocket_Dud : Rocket
{
	Default
	{
		DamageFunction (0);
		SeeSound "weapons/rocklf";
		DeathSound "weapons/rocklx";
	}
	States
	{
	Death:
		MISL B 8 Bright;
		MISL C 6 Bright;
		MISL D 4 Bright;
		Stop;
	}
}

class NoRandRocket : Rocket replaces Rocket
{
	Default
	{
		DamageFunction (128);
		SeeSound "weapons/rocklf";
		DeathSound "weapons/rocklx";
	}
	States
	{
	Death:
		MISL B 8 Bright A_ExplodeNoRand;
		MISL C 6 Bright;
		MISL D 4 Bright;
		Stop;
	BrainExplode:
		MISL BC 10 Bright;
		MISL D 10 A_BrainExplode;
		Stop;
	}
}
extend class NoRandRocket
{
	action void A_ExplodeNoRand()
	{
		(4,12,0,400);
		(2,12,0,800);
		A_Explode(128, 96, XF_HURTSOURCE, false, 40);
	}
	action void A_RocketExplode_PAP()
	{
		(4,12,0,400);
		(2,12,0,800);
		A_Explode(256, 96, XF_HURTSOURCE, false, 40);
	}
}

class BFGBallNoRand : Actor replaces BFGBall
{
	Default
	{
		Radius 13;
		Height 8;
		Speed 25;
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
		// BFE1 AB 0 Bright A_Quake(4,12,0,400);
		// BFE1 AB 0 Bright A_Quake(2,12,0,800);
		BFE1 AB 8 Bright;
		BFE1 C 8 Bright A_BFGBlast;
		BFE1 DEF 8 Bright;
		Stop;
	}
}
extend class BFGBallNoRand
{
	action void A_BFGBlast()
	{
		A_Explode(100, 256, XF_THRUSTLESS, false, 64,0,10,"BFGExtra","BFGSplash"); //Extra explosion damage
		A_BFGSpray("BFGExtra",45, 0, 90, 1024, 90, 50, 0); //Vanilla adjacent BFG
		(4,12,0,400);
		(2,12,0,800);
		// A_BFGSpray("BFGExtra",45, 0, 360, 1024, 90, 50, BFGF_MISSILEORIGIN); //BFG SHOOTS RAYS FROM BALL
	}
	action void A_BFGBlast_PAP()
	{
		A_Explode(100, 512, XF_THRUSTLESS, false, 64,0,10,"BFGExtra","BFGSplash"); //Extra explosion damage
		A_BFGSpray("BFGExtra",90, 0, 90, 1024, 90, 100, 0); //Vanilla adjacent BFG
		(4,12,0,400);
		(2,12,0,800);
		// A_BFGSpray("BFGExtra",45, 0, 360, 1024, 90, 50, BFGF_MISSILEORIGIN); //BFG SHOOTS RAYS FROM BALL
	}
	action void A_BFGRails()
	{
		A_BFGSpray("BFGExtra",45, 0, 360, 1024, 90, 50, BFGF_MISSILEORIGIN); //BFG SHOOTS RAYS FROM BALL
	}
}