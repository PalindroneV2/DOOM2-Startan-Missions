class W3DWaffenSS : WolfensteinSS
{
	Default
	{
		Health 50;
		Radius 16;
		Height 56;
		Speed 8;
		PainChance 150;
		Monster;
		+FLOORCLIP
		SeeSound "wolfss/sight";
		PainSound "wolfss/pain";
		DeathSound "wolfss/death";
		ActiveSound "wolfss/active";
		AttackSound "MP40/Fire";
		Obituary "You were riddled by holes by a Waffen SS.";
		Tag "Waffen SS (W3D)";
		Dropitem "MP40";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		// SSBL - Lost Missions Waffen SS
		// SSWV - Original Waffen SS
		// SSWV - Replaced Waffen SS
		// AMNC - Afrikakorps Machinegun NCO
		// APNC - Afrikakorps Pistol NCO
		// HMNC - Heer Machinegun NCO
		// HPNC - Heer Pistol NCO
		// SMNC - Waffen SS Machinegun NCO
		// SPNC - Waffen SS Pistol NCO
		Spawn:
			SS3D AB 10 A_Look;
			Loop;
		See:
			#### E 8 A_FaceTarget;
			Goto Chase;
		Chase:
			#### AABBCCDD 3 A_Chase("Aim","Aim");
			Loop;
		Aim:
			#### EF 3 A_FaceTarget;
			Goto Missile;
		Missile:
			#### F 5 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 3 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 2 A_CPosRefire;
			Goto Missile+1;
		Pain:
			#### H 3;
			#### H 3 A_Pain;
			Goto See;
		Death:
			#### I 5;
			#### J 5 A_Scream;
			#### K 5 A_NoBlocking;
			#### L 5;
			#### M -1;
			Stop;
		XDeath:
			SSWV N 5 ;
			SSWV O 5 A_XScream;
			SSWV P 5 A_NoBlocking;
			SSWV Q -1;
			Stop;
		Raise:
			#### M 5;
			#### LKJI 5;
			Goto See ;
	}
}

class W3DMissionsWaffenSS : W3DWaffenSS
{
	Default
	{
		Obituary "You were riddled by holes by a Waffen SS.";
		Tag "Waffen SS (W3D Missions)";
		Dropitem "MP40";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SSBL AB 10 A_Look;
			Loop;
	}
}
class W3DHeerNCO : W3DWaffenSS
{
	Default
	{
		Obituary "You were riddled by holes by a German Unteroffizier.";
		Tag "German Unteroffizier (Heer)";
		Dropitem "MP40";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			HMNC AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DAfrikaNCO : W3DWaffenSS
{
	Default
	{
		Obituary "You were riddled by holes by a German Unteroffizier.";
		Tag "German Unteroffizier (Afrika)";
		Dropitem "MP40";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			AMNC AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSNCO : W3DWaffenSS
{
	Default
	{
		Obituary "You were riddled by holes by a Nazi  Unteroffizier.";
		Tag "Nazi Unteroffizier (SS)";
		Dropitem "MP40";
		Species "Nazi";
		Speed 12;
		PainChance 100;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SMNC AB 10 A_Look;
			Loop;
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_SpawnProjectile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}

class W3DHeerNCOPistol : W3DWaffenSS
{
	Default
	{
		Obituary "You were shot down by a German Unteroffizier.";
		Tag "German Unteroffizier (Heer) (Pistol)";
		Dropitem "Clip";
		AttackSound "WaltherPPK/Fire";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			HPNC AB 10 A_Look;
			Loop;
		Aim:
			#### EF 5 A_FaceTarget;
			Goto PistolFire;
		PistolFire:
			#### F 7 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 5 A_FaceTarget;
			#### F 2 A_CPosRefire;
			Goto PistolFire+1;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DAfrikaNCOPistol : W3DWaffenSS
{
	Default
	{
		Obituary "You were shot down by a German Unteroffizier.";
		Tag "German Unteroffizier (Afrika) (Pistol)";
		Dropitem "Clip";
		AttackSound "WaltherPPK/Fire";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			APNC AB 10 A_Look;
			Loop;
		Aim:
			#### EF 5 A_FaceTarget;
			Goto PistolFire;
		PistolFire:
			#### F 7 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 5 A_FaceTarget;
			#### F 2 A_CPosRefire;
			Goto PistolFire+1;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSNCOPistol : W3DWaffenSS
{
	Default
	{
		Obituary "You were shot down by a Nazi  Unteroffizier.";
		Tag "Nazi Unteroffizier (SS) (Pistol)";
		Dropitem "Clip";
		AttackSound "WaltherPPK/Fire";
		Species "Nazi";
		Speed 12;
		PainChance 100;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SPNC AB 10 A_Look;
			Loop;
		Aim:
			#### EF 5 A_FaceTarget;
			Goto PistolFire;
		PistolFire:
			#### F 7 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 5 A_FaceTarget;
			#### F 2 A_CPosRefire;
			Goto PistolFire+1;
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_SpawnProjectile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}