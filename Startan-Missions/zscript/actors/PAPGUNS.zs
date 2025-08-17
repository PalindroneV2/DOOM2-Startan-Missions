class MP40_PAP : MP40
{
	Default
	{
		Tag "The Afterburner";
		Obituary "%o was riddled by %k's Afterburner.";
		Inventory.PickupMessage "Your MP40 was transformed into the Afterburner!";
		// Weapon.SisterWeapon "MP40";
		// +WEAPON.POWERED_UP;
	}
	States
	{
		Fire:
			MP40 B 1 Bright A_MP40Fire_PAP;
			MP40 D 1;
			MP40 CA 1; 
			MP40 A 1 A_ReFire;
			Goto Ready;
	}
}

class M1911A1_PAP : M1911A1
{
	bool M1911Akimbo;
	Default
	{
		Weapon.AmmoUse1 1;
		Weapon.AmmoGive1 8;
		Weapon.AmmoType1 "Clip";
		Weapon.AmmoUse2 1;
		Weapon.AmmoGive2 8;
		Weapon.AmmoType2 "Clip";
		Tag "Mustang/Sally";
		Obituary "%o was blasted into pieces by %k's Mustang/Sally.";
		Inventory.Pickupmessage "Your Colt M1911A1 became Mustang/Sally!.";
	}
	States
	{
		Ready:
			191A A 1 A_WeaponReady;
			Loop;
		Deselect:
			191A A 1 A_Lower(6);
			Loop;
		Select:
			191A A 1 A_Raise(6);
			Loop;
		Flash:
			GNFL C 1 BRIGHT A_Light2;
			GNFL D 1 BRIGHT;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		AltFlash:
			GNFL E 1 BRIGHT A_Light2;
			GNFL F 1 BRIGHT;
			TNT1 A 2 A_Light1;
			Goto LightDone;
		// Fire:
		// 	TNT1 A 0 {
		// 		M1911Akimbo = ! M1911Akimbo;
		// 	}
		// 	Goto Fire1;
		AltFire:
			// TNT1 A 0 A_JumpIf(M1911Akimbo,"Fire2");
			191A B 2 A_MustangSallyShotRight;
			191A C 1;
			191A DEED 1;
			191A B 2 Offset(0,34);
			191A B 2 Offset(0,33);
			Goto Ready;
		Fire:
			191B B 2 A_MustangSallyShotLeft;
			191B C 1;
			191B DEED 1;
			191B B 2 Offset(0,34);
			191B B 2 Offset(0,33);
			Goto Ready;
	}
}
class MustangSallyRocket : NoRandRocket
{
	Default
	{
		DamageFunction (128);
		Speed 256;
	}
}

class M16_PAP : M16
{
	Default
	{
		// Weapon.SisterWeapon "M16";
		Weapon.AmmoType "Clip";
		Weapon.AmmoType1 "Clip";
		Weapon.AmmoType2 "RocketAmmo";
		Weapon.AmmoGive2 2;
		Weapon.AmmoUse 1;
		Weapon.AmmoUse1 1;
		Weapon.AmmoUse2 1;
		Obituary "%o's skull was crushed by %k's Skullcrusher.";
		Inventory.PickupMessage "Your M16A1 evolved into the Skullcrusher!";
		Tag "Skullcrusher";
		// +WEAPON.POWERED_UP;
		//$Category Weapons
	}
	States
	{
		Fire:
			M16A A 1;
			M16A B 1 BRIGHT;
			M16A C 1 BRIGHT A_M16PAPFire;
			M16A D 1 BRIGHT A_ReFire;
			M16A E 1;
			Goto Ready;
		AltFire:
			M16A A 1;
			M16A B 1 BRIGHT;
			M16A C 1 BRIGHT A_M16PAPAltFire;
			M16A D 1 BRIGHT;
			M16A E 1;
			M16A A 1 A_Lower(15);
			M16A A 30;
			M16A A 1 A_Raise(15);
			Goto Ready;
	}
}

class RayGun_PAP : RayGun
{
	default
	{
		Inventory.PickupMessage "Your Ray Gun was enhanced by Dr. Porter himself!";
		Obituary "%k vaporized %o with a Porter's X2 Ray Gun.";
		Tag "Porter's X2 Ray Gun";
	}
	States
	{
		Fire:
			RAYG A 4;
			RAYG B 6 A_RayGun_Fire_PAP;
			RAYG C 4;
			RAYG B 5 A_ReFire;
			Goto Ready;
	}
}
class RayGunBall_PAP : RayGunBall
{
	default
	{
		DamageFunction (500);
		Translation 2;
	}
}

class Trenchgun_PAP : Trenchgun
{
	default
	{
		Obituary "%o was warcrimed by %k's Gut Shot.";
		Inventory.PickupMessage "The Trenchgun has been transformed into the Gut Shot!";
		Decal "BulletChip";
	}
	States
	{
		Fire:
			TREN B 1 BRIGHT A_TrenchgunShot_PAP;
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

class Kar98k_PAP : Kar98k
{
	default
	{
		Weapon.SlotPriority 3;
		Inventory.Pickupmessage "Your Kar98k became the Armaggedon!";
		Obituary "%o was 360-noscoped by %k with the Armaggedon.";
		Tag "Armaggedon";
	}
    States
    {
        Fire:
			K98K B 1 BRIGHT A_KAR98K_Shot_PAP;
			K98K CDEFEDCA 1;
			Goto Bolt;
    }
}

class BFG9000_PAP : BFG9000
{
	Default
	{
		Height 20;
		Weapon.SelectionOrder 2799;
        Weapon.SlotNumber 7;
		Weapon.AmmoUse 40;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Cell";
		+WEAPON.NOAUTOFIRE;
		Inventory.PickupMessage "BFG90K";
		Tag "Big Fucking Gun 90k";
        Translation 2;
	}
	States
	{
	Fire:
		BFGG A 20 A_BFGsound;
		BFGG B 10 A_GunFlash;
		BFGG B 10 A_FireBFG_PAP;
		BFGG B 20 A_ReFire;
		Goto Ready;
	}
}

extend class BFG9000_PAP
{
    action void A_FireBFG_PAP()
	{
		A_FireProjectile("BFGBall_PAP");
	}
}

class BFGBall_PAP : BFGBallNoRand
{
    Default
    {
        DamageFunction (1000);
        Translation 2;
    }
	States
	{
        Spawn:
            BFS1 AB 14 Bright;
            Loop;
        Death:
            BFE1 AB 8 Bright;
            BFE1 C 8 Bright A_BFGBlast_PAP;
            BFE1 DEF 8 Bright;
            Stop;
	}
}

class RocketLauncher_PAP : NewRocketLauncher
{
	Default
	{
		Weapon.SelectionOrder 2555;
		Weapon.AmmoGive 5;
        Weapon.SlotNumber 5;
		Weapon.SlotPriority 4;
		Inventory.PickupMessage "Rocket Launcher has become the Unclean Launcher";
		Tag "Unclean Launcher";
	}
	States
	{
	Fire:
		MISG B 8 A_GunFlash;
		MISG B 12 A_FireProjectile ("PAP_Rocket");
		MISG B 0 A_ReFire;
		Goto Ready;
    }
}

class PAP_Rocket : NoRandRocket
{
	Default
	{
        Translation 2;
		DamageFunction (256);
	}
	States
	{
	Death:
		MISL B 8 Bright A_RocketExplode_PAP;
		MISL C 6 Bright;
		MISL D 4 Bright;
		Stop;
	BrainExplode:
		MISL BC 10 Bright;
		MISL D 10 A_BrainExplode;
		Stop;
	}
}

class FastPlasmaRifle_PAP : FastPlasmaRifle
{
	Default
	{
		Tag "Fusion Repeater";
		Inventory.PickupMessage "Your ";
	}
	States
	{
		Fire:
			PLSG A 3 A_FireProjectile ("PlasmaBall_PAP");
			PLSG B 0 A_Quake(2,2,0,2);
			PLSG B 10 A_ReFire;
			Goto Ready;
	}
}

class PlasmaBall_PAP : NoRandPlasmaBall
{
	Default
	{
		DamageFunction (50);
        Translation 2;
		Obituary "%k liquified %o with a Fusion Repeater.";
	}
}

class NewSuperShotgun_PAP : NewSuperShotgun
{
	Default
	{
		Weapon.SelectionOrder 399;
		Inventory.PickupMessage "The Super Shotgun has evolved!";
		Obituary "%o was blown away by %k's Super Shotgun Evolved";
		Tag "Super Shotgun Evolved";
	}
	States
	{
	Fire:
		SHT2 A 3;
		SHT2 A 7 A_FireSSG_PAP;
		SHT2 B 7;
		SHT2 C 7 A_CheckReload;
		SHT2 D 7 A_OpenShotgun2;
		SHT2 E 7;
		SHT2 F 7 A_LoadShotgun2;
		SHT2 G 6;
		SHT2 H 6 A_CloseShotgun2;
		SHT2 A 5 A_ReFire;
		Goto Ready;
	}
}

class Minigun_PAP : Minigun
{
	Default
	{
		Weapon.SelectionOrder 689;
		Weapon.SlotNumber 4;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Clip";
		Inventory.PickupMessage "The minigun transformed into the Death Machine!";
		Obituary "%o was shredded by %k with a Death Machine";
		Tag "Death Machine";
	}
	States
	{
	Fire:
		CHGG A 1 ;
		CHGG B 2 A_MinigunFire_PAP;
		CHGG B 1 A_ReFire;
		Goto Ready;
    }
}