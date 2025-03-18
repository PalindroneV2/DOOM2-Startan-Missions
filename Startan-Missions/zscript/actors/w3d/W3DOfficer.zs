
class W3DOfficer : WolfensteinSS
{
	Default
	{
		Health 50;
		Radius 16;
		Height 56;
		Speed 10;
		PainChance 150;
		Monster;
		+FLOORCLIP
		SeeSound "naziofficer/sight";
		PainSound "wolfss/pain";
		DeathSound "naziofficer/death";
		ActiveSound "wolfss/active";
		AttackSound "WaltherPPK/Fire";
		Obituary "You were executed  by a Nazi Officer.";
		Tag "Nazi Officer (W3D)";
		Dropitem "Clip";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		//APOF - Afrikakorps Pistol Officer
		// HPOF - Heer Pistol Officer
		// SPOF - Waffen SS Pistol Officer
		//AMOF - Afrikakorps Machinegun Officer
		// HMOF - Heer Machinegun Officer
		// SMOF - Waffen SS Machinegun Officer
		// NZWL - Lost Episodes Officer
		// NAZO - Original Officer
		Spawn:
			NAZO AB 10 A_Look;
			Loop;
		See:
			#### E 5 A_FaceTarget;
			Goto Chase;
		Chase:
			#### AABBCCDD 3 A_Chase("Aim","Aim");
			Loop;
		Aim:
			#### EF 3 A_FaceTarget;
			Goto Missile;
		Missile:
			#### F 6 A_FaceTarget;
			#### G 3 BRIGHT A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
			#### F 5 A_FaceTarget;
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

class W3DMissionsOfficer : W3DOfficer
{
	Default
	{
		Obituary "You were executed  by a Nazi Officer.";
		Tag "Nazi Officer (W3D Missions)";
		Dropitem "Clip";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			NZWL AB 10 A_Look;
			Loop;
		Death:
			#### I 4;
			#### J 4 A_Scream;
			#### K 4 A_NoBlocking;
			#### L 4;
			#### M 4;
			#### N -1;
			Stop;
	}
}
class W3DHeerOfficer : W3DOfficer
{
	Default
	{
		Obituary "You were executed  by a German Officer.";
		Tag "German Officer (Heer)";
		Dropitem "Clip";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			HPOF AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DAfrikaOfficer : W3DOfficer
{
	Default
	{
		Obituary "You were executed  by a German Officer.";
		Tag "German Officer (Afrika)";
		Dropitem "Clip";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			APOF AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSOfficer : W3DOfficer
{
	Default
	{
		Obituary "You were executed  by a Nazi Officer.";
		Tag "Nazi Officer (SS)";
		Dropitem "Clip";
		Species "Nazi";
		Speed 12;
		PainChance 100;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SPOF AB 10 A_Look;
			Loop;
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_SpawnProjectile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}

class W3DHeerOfficerSMG : W3DOfficer
{
	Default
	{
		Obituary "You were executed  by a German Officer.";
		Tag "German Officer (Heer) (SMG)";
		Dropitem "MP40";
		AttackSound "MP40/Fire";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			HMOF AB 10 A_Look;
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
	}
}
class W3DAfrikaOfficerSMG : W3DHeerOfficerSMG
{
	Default
	{
		Obituary "You were executed  by a German Officer.";
		Tag "German Officer (Afrika) (SMG)";
		Dropitem "MP40";
		AttackSound "MP40/Fire";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			AMOF AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_SpawnProjectile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSOfficerSMG : W3DHeerOfficerSMG
{
	Default
	{
		Obituary "You were executed  by a Nazi Officer.";
		Tag "Nazi Officer (SS) (SMG)";
		Dropitem "MP40";
		AttackSound "MP40/Fire";
		Species "Nazi";
		Speed 12;
		PainChance 100;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SMOF AB 10 A_Look;
			Loop;
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_SpawnProjectile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}