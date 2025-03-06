
class W3DRifleman : W3DGuard
{
	Default
	{
		Tag "German Rifleman (Template)";
		Obituary "You were sniped by a German Rifleman.";
		Dropitem "Kar98k";
		Attacksound "K98K/FIRE";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
		+MISSILEEVENMORE
	}
	States
	{
		// ARGD - AfrikaKorps Rifle Guard
		// HRGD - Heer Rifle Guard
		// SRGD - Waffen SS Rifle Guard
		Spawn:
			UNKN AB 10 A_Look;
			Loop;
		See:
			"####" E 10 A_FaceTarget;
			"####" E 0 A_GiveInventory("Clip",5);
			"####" E 0 A_JumpIfInventory("Clip",0, "Reload");
			Goto Chase;
		Chase:
			"####" AABBCCDD 3 A_Chase("QuickAttack","Aim");
			Loop;
		Aim:
			"####" EF 15 A_FaceTarget;
			"####" F 0 A_TakeInventory("Clip",1);
			Goto Missile;
		QuickAttack:
			"####" F 10 A_FaceTarget;
			"####" G 4 BRIGHT A_W3D8mmMauserQuickAttack;
			"####" F 5 A_FaceTarget;
			"####" E 35 A_W3DRiflemanRefire ;
			Goto QuickAttack+1;
		Missile:
			"####" F 10 A_FaceTarget;
			"####" G 4 BRIGHT A_W3D8mmMauserAimedAttack;
			"####" F 5 A_FaceTarget;
			"####" E 35 A_W3DRiflemanRefire ;
			Goto Missile+1;
		Pain:
			"####" H 3;
			"####" H 3 A_Pain;
			Goto See;
		Reload:
			"####" FE 35 A_GiveInventory("Clip",5);
			Goto Missile;
		Death:
			"####" I 5;
			"####" J 5 A_Scream;
			"####" K 5 A_NoBlocking;
			"####" L 5;
			"####" M -1;
			Stop;
		Raise:
			"####" M 5;
			"####" LKJI 5;
			Goto See ;
	}
}
extend class W3DRifleman
{
	void A_W3DRiflemanRefire()
	{
		if (target)
		{
			A_CPosRefire();
			A_StartSound("K98K/BOLT",CHAN_AUTO,0.65);
		}
	}
	void A_W3D8mmMauserAimedAttack()
	{
		if (target)
		{
			A_FaceTarget();
			A_CustomBulletAttack(3, 1, 1, random(1,4) * 10, "RiflePuff", 0, CBAF_NORANDOM);
		}
	}
	void A_W3D8mmMauserQuickAttack()
	{
		if (target)
		{
			A_FaceTarget();
			A_CustomBulletAttack(22, 5, 1, random(3,4) * 5, "RiflePuff", 0, CBAF_NORANDOM);
		}
	}
}

class W3DHeerRifleman : W3DRifleman
{
	Default
	{
		Tag "German Rifleman (Heer)";
		Obituary "You were sniped by a German Rifleman.";
		Dropitem "Kar98k";
		Attacksound "K98K/FIRE";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			HRGD AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_CustomMissile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DAfrikaRifleman : W3DRifleman
{
	Default
	{
		Tag "German Rifleman (Afrika)";
		Obituary "You were sniped by a German Rifleman.";
		Dropitem "Kar98k";
		Attacksound "K98K/FIRE";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			ARGD AB 10 A_Look;
			Loop;
		Raise:
			HRZM N 5;
			HRZM MLKJI 5;
			HRZM I 0 A_CustomMissile("HeerSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}
class W3DSSRifleman : W3DRifleman
{
	Default
	{
		Tag "Nazi Rifleman (SS)";
		Obituary "You were sniped by a Nazi Rifleman.";
		Dropitem "Kar98k";
		Attacksound "K98K/FIRE";
		Speed 12;
		PainChance 125;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SRGD AB 10 A_Look;
			Loop;
		Raise:
			SSZM N 5;
			SSZM MLKJI 5;
			SSZM I 0 A_CustomMissile("SSSoldiertoZombie", 0, 0, 0, CMF_AIMDIRECTION);
			Stop;
	}
}