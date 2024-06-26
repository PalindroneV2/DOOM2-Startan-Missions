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
		MP40 B 2 Bright A_MP40Fire;
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
		A_FireBullets(4, 3, 1, 12, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_GunFlash();
		// Name NewAmmoClassName = 'TangoBulletClip';
		// Class<Ammo> NewAmmoClass = NewAmmoClassName;
		// if(NewAmmoClass)
		// {
		// 	A_FireBullets(5, 4, 1, 12, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		// }else{
		// 	A_FireBullets(5, 4, 1, 5, "BulletPuff");
		// }
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
	}
	States
	{
		Ready:
			COLT A 1 A_WeaponReady;
			Loop;
		Deselect:
			COLT A 1 A_Lower(6);
			Loop;
		Select:
			COLT A 1 A_Raise(6);
			Loop;
		Fire:
			COLT A 0;
			COLF A 1 A_WaltherPPKShot;
			COLF A 1 A_Light2;
			COLF A 1 A_Light1;
			COLT B 1 A_Light0;
			COLT CDE 2;
			COLT B 1 A_ReFire;
			Goto Ready;
		Flash:
			COLF A 1 Bright A_Light1;
			COLF A 1 Bright A_Light0;
			Goto LightDone;
		Spawn:
			COLP A -1;
			Stop;
	}
}

extend class WaltherPPK
{
    action void A_WaltherPPKShot()
    {
		A_StartSound ("WaltherPPK/Fire", CHAN_WEAPON);
		A_FireBullets(2, 2, -1, 12, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_GunFlash();
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
		A_FireBullets (1.5,1.5,-1,18,"BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		// Name NewAmmoClassName = 'TangoBulletClip';
		// Class<Ammo> NewAmmoClass = NewAmmoClassName;
		// if(NewAmmoClass)
		// {
		// 	A_FireBullets (1.6,1.6,1,17,"BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		// }else{
		// 	A_FireBullets (1.6,1.6,1,8,"BulletPuff");
		// }
	}
	action void A_M16SemiFire()
	{
		A_FireBullets (0.5,0.5,1,18,"BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		// Name NewAmmoClassName = 'TangoBulletClip';
		// Class<Ammo> NewAmmoClass = NewAmmoClassName;
		// if(NewAmmoClass)
		// {
		// 	A_FireBullets (1.6,1.6,1,17,"BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		// }else{
		// 	A_FireBullets (1.6,1.6,1,8,"BulletPuff");
		// }
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
		A_StartSound ("TRNCFIR", CHAN_WEAPON);
		A_FireBullets(7.5,0, 8, 12, "BulletPuff",FBF_USEAMMO|FBF_NORANDOM);
		A_GunFlash();
    }
}

extend class RayGun
{
	action void A_RayGun_Fire()
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
		SpawnPlayerMissile ("RayGunBall");
	}
}

class RayGunBall : Actor
{
	Default
	{
		Radius 13;
		Height 8;
		Speed 50;
		DamageFunction (200);
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "baby/attack";
		DeathSound "baby/shotx";
	}
	States
	{
	Spawn:
		APLS AB 5 BRIGHT;
		Loop;
	Death:
		APBX ABCDE 5 BRIGHT;
		Stop;
	}
}

class Kar98k : DoomWeapon
{
	Default
	{
		Weapon.Slotnumber 3;
		Obituary "%o was sniped by %k.";
		Weapon.Ammotype "RifleBullets";
		Weapon.Ammogive 5;
		Weapon.ammouse 1;
		Decal "Bulletchip";
		Inventory.Pickupmessage "You got the Kar98k!";
		Attacksound "K98K/FIRE";
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
			K98K B 1 BRIGHT A_Firebullets(3,0,1,75,"RiflePuff",FBF_USEAMMO|FBF_NORANDOM);
			// TNT1 A 0 A_Quake(2,3,0,3);
			K98K CDEFEDCA 1;
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