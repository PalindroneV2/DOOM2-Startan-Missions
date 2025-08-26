// #include "./wunderwaffe.zs"
#include "zscript/actors/PAPGUNS.zs"

class MP40 : DoomWeapon
{
	Default
	{
		Weapon.SelectionOrder 700;
       //$Category Weapons
		Weapon.SlotNumber 4;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Clip";
		Inventory.PickupMessage "You got the MP40!";
		attacksound "MP40/Fire";
		Obituary "%o was riddled by %k's MP40.";
		Tag "MP40";
		Scale 0.5;
		// Weapon.SisterWeapon "MP40_PAP";
	}
	States
	{
	Ready:
		MP40 A 1 A_WeaponReady;
		Loop;
	Deselect:
		MP40 A 1 A_Lower(10);
		Loop;
	Select:
		MP40 A 1 A_Raise(10);
		Loop;
	Fire:
		MP40 B 1 Bright A_MP40Fire;
		MP40 D 1;
		MP40 CA 1; 
		MP40 A 1 A_ReFire;
		Goto Ready;
	Flash:
		TNT1 A 5 Bright A_Light1;
		Goto LightDone;
		TNT1 A 5 Bright A_Light1;
		Goto LightDone;
	Spawn:
		MP40 E -1;
		Stop;
	}
}

extend class MP40
{
	action void A_MP40Fire()
	{
		int dmg = 12;
		if (Random(1, 100) <= 10)
		{
			dmg *= 1.25;
		}else{
			dmg = 12;
		}
		A_FireBullets(4, 3, 1, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
		A_GunFlash();
	}
	action void A_MP40Fire_PAP()
	{
		int dmg = 25;
		if (Random(1, 100) <= 10)
		{
			dmg *= 1.25;
		}else{
			dmg = 25;
		}
		A_FireBullets(4, 3, 1, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
		A_StartSound ("PAP/Fire", CHAN_WEAPON);
	}
	override void PostBeginPlay()
	{
		Name NewAmmoClassName = 'TangoBulletClip';
		Class<Ammo> NewAmmoClass = NewAmmoClassName;
		if(NewAmmoClass)
		{
			AmmoType1 = NewAmmoClass;
			if(Owner)
			{
            	Ammo1 = Ammo(Owner.FindInventory(NewAmmoClass));
			}
		}
	}
}

class WaltherPPK : DoomWeapon
{
	Default
	{
		Weapon.SelectionOrder 700;
		Weapon.SlotNumber 2;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 8;
		Weapon.AmmoType "Clip";
		Obituary "%o was Killed by %k's Walther PPK.";
		+WEAPON.WIMPY_WEAPON;
		Inventory.Pickupmessage "Picked up a Walther PPK.";
       //$Category Weapons
	}
	States
	{
		Ready:
			WPPK A 1 A_WeaponReady;
			Loop;
		Deselect:
			WPPK A 1 A_Lower(12);
			Loop;
		Select:
			WPPK A 1 A_Raise(12);
			Loop;
		Fire:
			WPPK A 0;
			WPPK F 1 A_WaltherPPKShot;
			WPPK F 1 A_Light2;
			WPPK F 1 A_Light1;
			WPPK B 1 A_Light0;
			WPPK CDE 2;
			WPPK B 1 A_ReFire;
			Goto Ready;
		Flash:
			WPPK F 1 Bright A_Light1;
			WPPK F 1 Bright A_Light0;
			Goto LightDone;
		Spawn:
			WPPK Z -1;
			Stop;
	}
}

extend class WaltherPPK
{
    action void A_WaltherPPKShot()
    {
		int dmg = 12;
		if (Random(1, 100) <= 10)
		{
			dmg *= 3;
		}else{
			dmg = 12;
		}
		A_StartSound ("WaltherPPK/Fire", CHAN_WEAPON);
		A_FireBullets(2, 2, -1, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
		A_GunFlash();
    }
	override bool HandlePickup(Inventory item)
	{
		// The WaltherPPK is an upgrade to the Handgun
		//This makes it so a handgun pickup gives ammo for the WaltherPPK
		if (item.GetClass() == "Handgun")
		{
			// If player already has WaltherPPK token
			if (owner.FindInventory("WaltherPPK"))
			{
				// Give only ammo
				owner.GiveInventory("Clip", 5);
			}
			item.bPickupgood = true;
			return true; // Pickup was handled
		}
		// The M1911A1  is an upgrade to the WaltherPPK
		//This makes it so a M1911A1  replaces the WaltherPPK
		if (item.GetClass() == "M1911A1")
		{
			// If player already has WaltherPPK token
			if (owner.FindInventory("WaltherPPK"))
			{
				// Give only ammo
				owner.GiveInventory("Clip", 4);
				owner.TakeInventory("WaltherPPK", 1);
			}
			item.bPickupgood = true;
			return Super.HandlePickup(item); // Pickup was handled
		}
		return Super.HandlePickup(item);
	}
}

class M1911A1 : Weapon
{
	Default
	{
		Weapon.SelectionOrder 700;
		Weapon.SlotNumber 2;
		Weapon.AmmoUse1 1;
		Weapon.AmmoGive1 8;
		Weapon.AmmoType1 "Clip";
		Weapon.AmmoUse2 1;
		Weapon.AmmoGive2 8;
		Weapon.AmmoType2 "Clip";
		Obituary "%o was Killed by %k's Colt M1911A1.";
		+WEAPON.WIMPY_WEAPON;
		Inventory.Pickupmessage "Picked up a Colt M1911A1.";
       //$Category Weapons
	}
    States
    {
    Ready:
        1911 A 1 A_WeaponReady;
        Loop;
    Deselect:
        1911 A 1 A_Lower(12);
        Loop;
    Select:
        1911 A 1 A_Raise(12);
        Loop;
    Fire:
        1911 B 2 A_M1911Shot;
        1911 C 1;
        1911 DEED 1;
        1911 B 2 Offset(0,34);
        1911 B 2 Offset(0,33);
        Goto Ready;
    Flash:
        GNFL A 1 BRIGHT A_Light2;
        GNFL B 1 BRIGHT;
        TNT1 A 2 A_Light1;
        Goto LightDone;
    Spawn:
        1911 Z -1;
        Stop;
    }
}

extend class M1911A1
{
    action void A_M1911Shot()
    {
		int dmg = 15;
		if (Random(1, 100) <= 20)
		{
			dmg *= 4;
		}else{
			dmg = 15;
		}
		A_StartSound ("M1911/Fire", CHAN_WEAPON);
		A_FireBullets(2, 2, -1, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
		A_GunFlash();
    }
	action void A_MustangSallyShotLeft()
    {
		A_StartSound ("PAP/Fire", CHAN_WEAPON);
		// A_FireBullets(2, 2, -1, 15, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
		A_GunFlash();
		// A_FireProjectile("MustangSallyRocket");
		// A_FireCustomMissile ("MustangSallyRocket", 0, 1, -8, 0, 0, 0);
		A_FireProjectile("MustangSallyRocket",
                 angle: 0,
                 useammo: true,
                 spawnofs_xy: -8,
                 spawnheight: 1,
                 flags: 0,
                 pitch: 0);
    }
	action void A_MustangSallyShotRight()
    {
		A_StartSound ("PAP/Fire", CHAN_WEAPON);
		// A_FireBullets(2, 2, -1, 15, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
		A_GunFlash();
		// A_FireProjectile("MustangSallyRocket");
		A_FireProjectile("MustangSallyRocket",
                 angle: 0,
                 useammo: true,
                 spawnofs_xy: 8,
                 spawnheight: 1,
                 flags: 0,
                 pitch: 0);
    }
	override bool HandlePickup(Inventory item)
	{
		if (item.GetClass() == "Handgun" || item.GetClass() == "WaltherPPK")
		{
			// If player already has M1911A1 token
			if (owner.FindInventory("M1911A1"))
			{
				// Give only ammo
				owner.GiveInventory("Clip", 5);
			}
			// Prevent NewShotgun from actually being picked up
			item.bPickupgood = true;
			return true; // Pickup was handled
		}
		return Super.HandlePickup(item);
	}
}

class M16 : DoomWeapon
{
	Default
	{
		Weapon.SelectionOrder 701;
       //$Category Weapons
		Weapon.SlotNumber 4;
		Weapon.AmmoUse1 1;
		Weapon.AmmoUse2 1;
		Weapon.AmmoGive 30;
		Weapon.AmmoType1 "Clip";
		Weapon.AmmoType2 "Clip";
		Inventory.PickupMessage "You got the M16A1!";
		attacksound "M16/Fire";
		Obituary "%o was cut down by %k's M16A1.";
		Tag "M16A1";
		Scale 0.8;
		// Weapon.SisterWeapon "M16_PAP";
	}
	States
	{
		Ready:
			M16A A 1 A_WeaponReady;
			Loop;
		Deselect: 
			M16A A 1 A_Lower(9);
			Loop;
		Select:
			M16A A 1 A_Raise(9);
			Loop;
		Fire:
			M16A A 1;
			M16A B 1 BRIGHT;
			M16A C 1 BRIGHT A_M16Fire;
			M16A D 1 BRIGHT;
			M16A B 1 BRIGHT;
			M16A C 1 BRIGHT A_M16Fire;
			M16A D 1 BRIGHT;
			M16A B 1 BRIGHT;
			M16A C 1 BRIGHT A_M16Fire;
			M16A D 1 BRIGHT;
			M16A E 5;
			M16A E 1 A_ReFire;
			Goto Ready;
		AltFire:
			M16A A 1;
			M16A B 1 BRIGHT;
			M16A C 1 BRIGHT A_M16SemiFire;
			M16A D 1 BRIGHT;
			M16A E 5;
			M16A E 1 A_ReFire;
			Goto Ready;
		Flash:
			TNT1 A 2 bright;
			Stop;
		Spawn:
			M16G A -1;
			Stop;
	}
}

extend class M16
{
	action void A_M16Fire()
	{
		int dmg = 18;
		if (Random(1, 100) <= 8)
		{
			dmg *= 1.5;
		}else{
			dmg = 18;
		}
		A_FireBullets (1.5,1.5,-1, dmg,"BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
	}
	action void A_M16PAPFire()
	{
		int dmg = 36;
		if (Random(1, 100) <= 8)
		{
			dmg *= 1.5;
		}else{
			dmg = 36;
		}
		A_FireBullets (1.5,1.5,-1, dmg,"BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
		A_StartSound ("PAP/Fire", CHAN_WEAPON);
	}
	action void A_M16PAPALTFire()
	{
		A_FireProjectile("Rocket",
                 angle: 0,
                 useammo: true,
                 spawnofs_xy: 0,
                 spawnheight: 1,
                 flags: 0,
                 pitch: 0);
		A_Quake(1,2,0,1);
		A_StartSound ("M203/Fire", CHAN_WEAPON);
	}
	action void A_M16SemiFire()
	{
		int dmg = 18;
		if (Random(1, 100) <= 15)
		{
			dmg *= 2;
		}else{
			dmg = 18;
		}
		A_FireBullets (0.5,0.5,1,dmg,"BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(1,2,0,1);
	}
	override void PostBeginPlay()
	{
		Name NewAmmoClassName = 'TangoBulletClip';
		Class<Ammo> NewAmmoClass = NewAmmoClassName;
		if(NewAmmoClass)
		{
			AmmoType1 = NewAmmoClass;
			if(Owner)
			{
            	Ammo1 = Ammo(Owner.FindInventory(NewAmmoClass));
			}
		}
	}
}

class RayGun : DoomWeapon
{
 	Default
	{
       //$Category Weapons
		Weapon.SelectionOrder 2000;
		Weapon.SlotNumber 2;
		Weapon.AmmoUse 4;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Cell";
		Obituary "%k vaporized %o with a Ray Gun.";
		-WEAPON.WIMPY_WEAPON;
		+WEAPON.BFG;
		Inventory.PickupMessage "You got a Ray Gun.";
		Tag "Ray Gun";
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
		RAYG B 6 A_RayGun_Fire;
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

extend class RayGun
{
	action void A_RayGun_Fire()
	{
		A_FireProjectile("RayGunBall",
                 angle: 0,
                 useammo: true,
                 spawnofs_xy: 0,
                 spawnheight: 1,
                 flags: 0,
                 pitch: 0);
		A_Quake(1,2,0,1);
		A_StartSound ("raygun/fire", CHAN_AUTO);
	}
	action void A_RayGun_Fire_PAP()
	{
		A_FireProjectile("RayGunBall_PAP",
                 angle: 0,
                 useammo: true,
                 spawnofs_xy: 0,
                 spawnheight: 1,
                 flags: 0,
                 pitch: 0);
		A_Quake(1,2,0,1);
		A_StartSound ("raygun/fire", CHAN_AUTO);
	}
}

class RayGunBall : FastProjectile
{
	Default
	{
		Radius 13;
		Height 13;
		Speed 96;
		DamageFunction (100);
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		// SeeSound "baby/attack";
		DeathSound "raygun/splash";
	}
	States
	{
	Spawn:
		APLS AB 1 BRIGHT A_SpawnItemEx("RayGunRing");
		Loop;
	Death:
		RGBA C 1 BRIGHT A_RaygunBallExplodes();
		RGBA CDE 5 BRIGHT;
		Stop;
	}

	action void A_RaygunBallExplodes()
	{
		A_Quake(4,12,0,400);
		A_Quake(2,12,0,800);
		A_Explode(100, 64, XF_HURTSOURCE | XF_THRUSTLESS  | XF_CIRCULAR , false, 40);
	}
}

class RayGunRing : RocketSmokeTrail
{
    Default
    {
        // Customize appearance and behavior
        RenderStyle "Translucent";
        Alpha 0.9;
    }

    States
    {
    Spawn:
        RAYR ABCD 2 Bright;
        Stop;
    }
}

class Trenchgun : DoomWeapon
{
    Default
	{
		Tag "M1897 Trenchgun";
       //$Category Weapons
		Weapon.SlotNumber 3;
		Weapon.SelectionOrder 1000;
		Weapon.SlotPriority 2;
		Weapon.AmmoType "Shell";
		Weapon.AmmoGive 8;
		Weapon.AmmoUse 1;
		Weapon.KickBack 100;
		Inventory.PickupSound "Misc/w_pkup" ;
		Obituary "%o was sent back by %k's Trenchgun.";
		Inventory.PickupMessage "Got the Trenchgun!";
		Decal "BulletChip";
	}
    States
    {
    Spawn:
        TREP A -1;
        Loop;
    Ready:
        TREN A 1 A_WeaponReady;
        Loop;
    Deselect:
        TREN A 1 A_Lower(10);
        Loop;
    Select:
        TREN A 1 A_Raise(10);
        Loop;
    Fire:
		TREN B 1 BRIGHT A_TrenchgunShot;
        TREN C 1 BRIGHT;
		TREN D 2;
		TREN D 1;
		TREN E 2;
		TREN F 6;
		TREN GH 1;
		TREN IJ 2;
		TREN K 0 A_StartSound ("TRNCREL", CHAN_WEAPON);
		TREN KM 2;
		TREN NMLK 1;
		TREN JIHG 2;
		TREN A 2 A_Refire;
		Goto Ready;
  }
}

extend class Trenchgun
{
    action void A_TrenchgunShot()
    {
		int dmg = 12;
		if (Random(1, 100) <= 10)
		{
			dmg *= 1.25;
		}else{
			dmg = 12;
		}
		A_StartSound ("TRNCFIR", CHAN_WEAPON);
		A_FireBullets(7.5,0, 8, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(2,3,0,3);
		A_GunFlash();
    }
	action void A_TrenchgunShot_PAP()
    {
		int dmg = 24;
		if (Random(1, 100) <= 10)
		{
			dmg *= 1.25;
		}else{
			dmg = 24;
		}
		A_StartSound ("PAP/Fire", CHAN_WEAPON);
		A_FireBullets(7.5,0, 8, dmg, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_Quake(2,3,0,3);
		A_GunFlash();
    }
	override bool HandlePickup(Inventory item)
	{
		if (item.GetClass() == "NewShotgun")
		{
			// If player already has Trenchgun token
			if (owner.FindInventory("Trenchgun"))
			{
				// Give only ammo
				owner.GiveInventory("Shell", 4);
			}
			// Prevent NewShotgun from actually being picked up
			item.bPickupgood = true;
			return true; // Pickup was handled
		}
		return Super.HandlePickup(item);
	}
}

class Kar98k : DoomWeapon
{
	Default
	{
		Weapon.SlotNumber 5;
		Weapon.SlotPriority 1;
		Weapon.Ammotype "RifleBullets";
		Weapon.Ammogive 5;
		Weapon.ammouse 1;
		Decal "Bulletchip";
		Inventory.Pickupmessage "You got the Kar98k!";
		Obituary "%o was sniped by %k.";
		Tag "Kar98k";
		Scale 0.75;
       //$Category Weapons
	}
	States
	{
		Ready:
			K98K A 1 A_Weaponready;
			Loop;
			
		Select:
			K98K A 1 A_Raise(10);
			Loop;
			
		Deselect:
			K98K A 1 A_Lower(10);
			Loop;
			
		Fire:
			K98K B 1 BRIGHT A_KAR98K_Shot;
			K98K CDEFEDCA 1;
			Goto Bolt;
		Bolt:
			K98K A 2;
			TNT1 A 0 A_StartSound("K98K/BOLT",CHAN_AUTO);
			K98R A 2;
			K98R B 2;
			K98R C 2;
			K98R D 2;
			K98R E 5;
			K98R D 2;
			K98R C 2;
			K98R B 2;
			K98R A 2;
			K98K A 2;
			TNT1 A 0 A_ReFire;
			Goto Ready;
		Spawn:
			K98J A -1;
			Stop;
	}
}

extend class Kar98k
{
    action void A_KAR98K_Shot()
    {
		int dmg = 75;
		if (Random(1, 100) <= 15)
		{
			dmg *= 2;
		}else{
			dmg = 75;
		}
		A_StartSound ("K98K/FIRE", CHAN_WEAPON);
		A_Firebullets(3, 0, 1, dmg, "RiflePuff", FBF_USEAMMO | FBF_NORANDOM);
		A_Quake(2,3,0,3);
		A_GunFlash();
    }
	action void A_KAR98K_Shot_PAP()
    {
		int dmg = 150;
		if (Random(1, 100) <= 10)
		{
			dmg *= 2;
		}else{
			dmg = 150;
		}
		A_StartSound ("PAP/Fire", CHAN_AUTO);
		// A_RailAttack(int damage, int spawnofs_xy = 0, bool useammo = true, color color1 = 0, color color2 = 0, int flags = 0, double maxdiff = 0, class<Actor> pufftype = "BulletPuff", double spread_xy = 0, double spread_z = 0, double range = 0, int duration = 0, double sparsity = 1.0, double driftspeed = 1.0, class<Actor> spawnclass = "none", double spawnofs_z = 0, int spiraloffset = 270, int limit = 0)
		A_RailAttack(
			dmg,                     // damage
			0,                       // spawnofs_xy
			true,                    // useammo
			"FF00FF",                // color1
			"ffb9fc",                // color2
			RGF_FULLBRIGHT,          // flags
			0,                       // maxdiff
			"RiflePuff",             // pufftype
			1,                       // spread_xy
			0,                       // spread_z
			8192,                    // range
			35,                      // duration
			0.5,                     // sparsity
			1,                     // driftspeed
			"None",                  // spawnclass
			0,                       // spawnofs_z
			270,                     // spiraloffset
			5                        // limit
		);
		// A_Firebullets(3, 0, 1, 150, "RiflePuff", FBF_USEAMMO | FBF_NORANDOM);
		A_Quake(2,3,0,3);
		A_GunFlash();
    }
}

class RifleBullets : Ammo
{
	Default
	{
		Inventory.Amount 5;
		Inventory.MaxAmount 40;
		Inventory.Icon "MAUSB0";
		Ammo.BackpackAmount 5;
		Ammo.BackpackMaxAmount 80;
		Tag "Rifle Clip";
		Inventory.PickupMessage "Picked up a clip of Rifle Ammo!";
       //$Category Ammunition
	}
	States
	{
		Spawn:
			MAUS B -1;
			Stop;
	}
}

class RifleBulletbox : RifleBullets
{
	Default
	{
		Inventory.Amount 20;
		Tag "Rifle Ammo Box";
		Inventory.PickupMessage "Picked up a Box of Rifle Ammo!";
	}
	States
	{
		Spawn:
			MAUS A -1;
			Stop;
	}
}

class RiflePuff: Bulletpuff
{
	Default
	{
		+NOEXTREMEDEATH
	}
}