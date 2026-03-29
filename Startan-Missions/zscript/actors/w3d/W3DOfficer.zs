
class W3DOfficer : W3DNPC_Template
{
	Default
	{
		Health 60;
		Radius 16;
		Height 56;
		Speed 10;
		PainChance 125;
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
		W3DNPC_Template.W3D_PistolClip 8;
		W3DNPC_Template.W3D_RifleClip 5;
		W3DNPC_Template.W3D_SMGClip 32;
		W3DNPC_Template.W3D_PlasmaClip 20;
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
			#### E 0 A_W3DSightorFlight;
			Goto Chase;
		Chase:
			#### AABBCCDD 3 A_Chase("Aim","Aim");
			Loop;
		Aim:
			#### E 0 A_CPosRefire;
			#### EF 3 A_FaceTarget;
			Goto Missile;
		Reloading:
			#### EEE 15 A_W3DReload();
			Goto Aim;
		Missile:
			#### F 6 A_FaceTarget;
			#### G 3 BRIGHT A_W3DPistolAttack();
			#### F 5 A_FaceTarget;
			// #### F 2 A_CPosRefire;
			#### F 2 A_W3DCheckAmmo; 
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
		Health 50;
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
		Health 45;
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
		Health 45;
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
		Health 60;
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
		See:
			#### E 3 A_FaceTarget;
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

class W3DHeerOfficerSMG : W3DOfficer
{
	Default
	{
		Obituary "You were executed  by a German Officer.";
		Tag "German Officer (Heer) (SMG)";
		Dropitem "MP40";
		AttackSound "MP40/Fire";
		Species "Nazi";
		Health 45;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			HMOF AB 10 A_Look;
			Loop;
		Aim:
			#### E 0 A_CPosRefire;
			#### EF 5 A_FaceTarget;
			Goto SMGFire;
		Missile:
			#### F 0 A_FaceTarget;
			goto SMGFire;
		Reloading:
			#### EEE 20 A_W3DReload();
			Goto Aim;
		SMGFire:
			#### F 3 A_FaceTarget;
			#### G 3 BRIGHT A_W3DSMGAttack();
			// #### F 2 A_CPosRefire;
			#### F 2 A_W3DCheckAmmo;
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
		Health 45;
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
		Health 60;
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
		See:
			#### E 3 A_FaceTarget;
			#### E 0 A_W3DSightorFlight;
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