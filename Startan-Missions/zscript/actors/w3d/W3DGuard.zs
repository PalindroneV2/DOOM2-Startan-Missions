class W3DGuard : WolfensteinSS
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
			#### EF 5 A_FaceTarget;
			Goto Missile;
		Missile:
			#### F 5 A_FaceTarget;
			#### G 4 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 6 A_FaceTarget;
			#### F 4 A_CPosRefire;
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
			#### EF 5 A_FaceTarget;
			Goto SMGFire;
		SMGFire:
			#### F 5 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 3 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 2 A_CPosRefire;
			Goto SMGFire+1;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
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
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_SpawnProjectile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}