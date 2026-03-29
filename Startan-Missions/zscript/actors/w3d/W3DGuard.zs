class W3DGuard : W3DNPC_Template
{
	Default
	{
		Health 30;
		Radius 16;
		Height 56;
		Speed 10;
		PainChance 200;
		Monster;
		+FLOORCLIP
		SeeSound "naziguard/sight";
		PainSound "wolfss/pain";
		DeathSound "naziguard/death";
		ActiveSound "wolfss/active";
		AttackSound "WaltherPPK/Fire";
		Obituary "You were killed by a Nazi Guard.";
		Tag "Nazi Guard (W3D)";
		Dropitem "Clip";
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
		// NZGD - Oirignal Guard
		// NZGL - Missions Guard
		// AMGD - Afrikakorps Machinegun Guard
		// APGD - Afrikakorps Pistol Guard
		// HMGD - Heer Machinegun Guard
		// HPGD - Heer Pistol Guard
		// SMGD - Waffen SS Machinegun Guard
		// MPGD - Heer Pistol Guard
		Spawn:
			NZGD AB 10 A_Look;
			Loop;
		See:
			#### E 10 A_FaceTarget;
			Goto Chase;
		Chase:
			#### AABBCCDD 3 A_Chase("Aim","Aim");
			Loop;
		Aim:
			#### E 0 A_CPosRefire;
			#### EF 5 A_FaceTarget;
			Goto Missile;
		Reloading:
			#### EEE 15 A_W3DReload();
			Goto Aim;
		Missile:
			#### F 5 A_FaceTarget;
			#### G 4 BRIGHT A_W3DPistolAttack();
			#### F 6 A_FaceTarget;
			#### F 4 A_W3DCheckAmmo;
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
class W3DMissionsGuard : W3DGuard
{
	Default
	{
		Obituary "You were killed by a Nazi Guard.";
		Tag "Nazi Guard (W3D Missions)";
		Dropitem "Clip";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			NZGL AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}

class W3DHeerGuard : W3DGuard
{
	Default
	{
		Obituary "You were killed by a German Guard.";
		Tag "German Guard (Heer)";
		Dropitem "Clip";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			HPGD AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DAfrikaGuard : W3DGuard
{
	Default
	{
		Obituary "You were killed by a German Guard.";
		Tag "German Guard (Afrika)";
		Dropitem "Clip";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			APGD AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSGuard : W3DGuard
{
	Default
	{
		Obituary "You were killed by a Nazi Guard.";
		Tag "Nazi Guard (SS)";
		Dropitem "Clip";
		Species "Nazi";
		Health 45;
		Speed 12;
		PainChance 150;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			SPGD AB 10 A_Look;
			Loop;
		See:
			#### E 7 A_FaceTarget;
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

class W3DHeerGuardSMG : W3DGuard
{
	Default
	{
		Obituary "You were killed by a German Guard.";
		Tag "German Guard (Heer) (SMG)";
		Dropitem "MP40";
		AttackSound "MP40/Fire";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			HMGD AB 10 A_Look;
			Loop;
		Aim:
			#### E 0 A_CPosRefire;
			#### EF 5 A_FaceTarget;
			Goto SMGFire;
		Missile:
			goto SMGFire;
		Reloading:
			#### EEE 20 A_W3DReload();
			Goto Aim;
		SMGFire:
			#### F 3 A_FaceTarget;
			#### G 3 BRIGHT A_W3DSMGAttack();
			#### F 2 A_W3DCheckAmmo;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DAfrikaGuardSMG : W3DHeerGuardSMG
{
	Default
	{
		Obituary "You were killed by a German Guard.";
		Tag "German Guard (Afrika) (SMG)";
		Dropitem "MP40";
		AttackSound "MP40/Fire";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			AMGD AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSGuardSMG : W3DHeerGuardSMG
{
	Default
	{
		Obituary "You were killed by a Nazi Guard.";
		Tag "Nazi Guard (SS) (SMG)";
		Dropitem "MP40";
		AttackSound "MP40/Fire";
		Species "Nazi";
		Health 45;
		Speed 12;
		PainChance 150;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			SMGD AB 10 A_Look;
			Loop;
		See:
			#### E 7 A_FaceTarget;
			// #### E 0 A_W3DSightorFlight;
			Goto Chase;
		Aim:
			#### E 0 A_CPosRefire;
			#### EF 3 A_FaceTarget;
			Goto SMGFire;
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_SpawnProjectile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}