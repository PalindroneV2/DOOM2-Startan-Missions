class W3DZombie : Actor
{
	default
	{
		Health 100;
		Speed 20;
		PainChance 50;
		Radius 16;
		Height 56;
		Mass 100;
		ActiveSound "w3dzombie/chase";
		AttackSound "w3dzombie/attack";
		DeathSound "w3dzombie/death";
		PainSound "";
		SeeSound "w3dzombie/see";
		Obituary "You were torn to shreds by a Nazi Zombie";
		Tag "Zombie (W3D)";
		Species "Nazi Zombie";
		MONSTER;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
	Spawn:
		NZGD AB 10 A_Look;
		Loop;
	See:
		"####" E 2 A_FaceTarget;
		"####" F 30 A_StartSound("w3dzombie/scream",CHAN_AUTO);
		Goto Chase;
	Chase:
		"####" AABBCCDD 3 A_Chase("Melee",null);
		Loop;
	Melee:
		"####" EG 4 A_FaceTarget;
		"####" H 4 A_W3DZombieSwipe;
		Goto Chase;
	Pain:
		"####" I 2;
		"####" I 2 A_Pain;
		Goto Chase;
	Death:
		"####" I 8;
		"####" J 8 A_Scream;
		"####" K 4;
		"####" L 4 A_Fall;
		"####" M 4;
		"####" N -1;
		Stop;
	Raise:
		"####" N 5;
		"####" MLKJI 5;
		Goto See;
	}
}

extend class W3DZombie
{
	void A_W3DZombieSwipe()
	{
		int zmbdmg = 5 * Random(5,10);
		if (target)
		{
			A_FaceTarget();
			A_CustomMeleeAttack(zmbdmg);
		}
	}
}

class SSSoldiertoZombie : Actor
{
    Default
    {
        +NOINTERACTION;
        +NOBLOCKMAP;
        +NOCLIP;
    }
    States
    {
    Spawn:
        TNT1 A 0 NoDelay;
        TNT1 A 0 A_SpawnItemEx("W3DSSZombie", 0, 0, 0, 0, 0, 0, 0, SXF_TRANSFERPOINTERS | SXF_NOCHECKPOSITION);
        Stop;
    }
}
class HeerSoldiertoZombie : Actor
{
    Default
    {
        +NOINTERACTION;
        +NOBLOCKMAP;
        +NOCLIP;
    }
    States
    {
    Spawn:
        TNT1 A 0 NoDelay;
        TNT1 A 0 A_SpawnItemEx("W3DHeerZombie", 0, 0, 0, 0, 0, 0, 0, SXF_TRANSFERPOINTERS | SXF_NOCHECKPOSITION);
        Stop;
    }
}

class W3DSSZombie : W3DZombie
{
	Default
	{
		Obituary "You were torn to shreds by a Nazi Zombie";
		Tag "Nazi Zombie (SS)";
		Species "Nazi Zombie";
		Radius 16;
		Height 56;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			SSZM AB 10 A_Look;
			Loop;
	}
}
class W3DHeerZombie : W3DZombie
{
	Default
	{
		Obituary "You were torn to shreds by a German Zombie";
		Tag "German Zombie (Heer)";
		Species "Nazi Zombie";
		Radius 16;
		Height 56;
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
       //$Category Monsters
	}
	States
	{
		Spawn:
			HRZM AB 10 A_Look;
			Loop;
	}
}