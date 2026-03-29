class W3DWaffenSS : W3DNPC_Template
{
	Default
	{
		Health 50;
		Radius 16;
		Height 56;
		Speed 9;
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
		W3DNPC_Template.W3D_PistolClip 8;
		W3DNPC_Template.W3D_RifleClip 5;
		W3DNPC_Template.W3D_SMGClip 32;
		W3DNPC_Template.W3D_PlasmaClip 20;
       //$Category Monsters
	}
	States
	{
		// SSBL - Lost Missions Waffen SS
		// SSWV - Original Waffen SS
		// SS3D - Replaced Waffen SS
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
			#### E 0 A_CPosRefire;
			#### EF 3 A_FaceTarget;
			Goto Missile;
		Reloading:
			#### EEE 20 A_W3DReload();
			Goto Aim;
		Missile:
			#### F 3 A_FaceTarget;
			#### G 3 BRIGHT A_W3DSMGAttack();
			#### F 2 A_W3DCheckAmmo();
			Loop;
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
			SS3D N 5 ;
			SS3D O 5 A_XScream;
			SS3D P 5 A_NoBlocking;
			SS3D Q -1;
			Stop;
		Raise:
			#### M 5;
			#### LKJI 5;
			Goto See ;
	}
}

class W3DTestSS : W3DWaffenSS
{
	Default
	{
		Obituary "You were riddled by holes by a Waffen SS test unit.";
		Tag "Waffen SS Test Unit";
		Dropitem "MP40";
	}
	States
	{
		Spawn:
			SS3D AB 10 A_Look;
			Loop;
		Missile:
			#### F 2 A_FaceTarget;
			#### G 2 BRIGHT A_W3DSMGAttack();
			#### F 2 A_MonsterRefire(0, "See");
			Loop;
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
		Health 60;
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
		Health 60;
		Speed 11;
		PainChance 100;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SMNC AB 10 A_Look;
			Loop;
		See:
			#### E 5 A_FaceTarget;
			#### E 0 A_W3DSightorFlight;
			Goto Chase;
		Aim:
			#### E 0 A_CPosRefire;
			#### EF 3 A_FaceTarget;
			Goto Missile;
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
			#### E 0 A_CPosRefire;
			#### EF 5 A_FaceTarget;
			Goto PistolFire;
		Reloading:
			#### EEE 15 A_W3DReload();
			Goto Aim;
		Missile:
			#### F 0 A_FaceTarget;
			goto PistolFire;
		PistolFire:
			#### F 7 A_FaceTarget;
			#### G 3 BRIGHT A_W3DPistolAttack();
			#### F 5 A_FaceTarget;
			#### F 2 A_W3DCheckAmmo();
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DAfrikaNCOPistol : W3DHeerNCOPistol
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
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSNCOPistol : W3DHeerNCOPistol
{
	Default
	{
		Obituary "You were shot down by a Nazi  Unteroffizier.";
		Tag "Nazi Unteroffizier (SS) (Pistol)";
		Dropitem "Clip";
		AttackSound "WaltherPPK/Fire";
		Species "Nazi";
		Health 60;
		Speed 11;
		PainChance 100;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SPNC AB 10 A_Look;
			Loop;
		See:
			#### E 5 A_FaceTarget;
			#### E 0 A_W3DSightorFlight;
			Goto Chase;
		Aim:
			#### EF 3 A_FaceTarget;
			Goto PistolFire;
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_SpawnProjectile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}