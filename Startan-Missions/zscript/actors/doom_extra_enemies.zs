//Trap Archvile
class TrapVile : Actor
{
    int VileLife;
    property VileLife : VileLife;
	Default
	{
       //$Category Monsters
		//$Sprite VILEI1
		Tag "Self-Resurrecting Archvile";
		SeeSound "vile/sight";
		PainSound "vile/pain";
		DeathSound "vile/death";
		ActiveSound "vile/active";
		MeleeSound "vile/stop";
		Obituary "$OB_VILE";
        TrapVile.VileLife 1;
		Health 600;
		Radius 20;
		Height 16;
		Mass 500;
		Speed 15;
		PainChance 15;
		Monster;
		MaxTargetRange 640;
		+QUICKTORETALIATE 
		+FLOORCLIP 
		+NOTARGET
	}

    state VileRaiseSelf(int ChancetoRaise = 0, statelabel endstate = "See")
    {
        if(VileLife == 1)
        {
            return  ResolveState("RaiseSelf");
        }
        else if(ChancetoRaise > random(0,100))
        {
            return ResolveState(endstate);
        }
        return null;
    }
	States
	{
	Spawn:
		VILE Z 1;
        VILE Z 0
        {
            A_UnsetSolid();
			A_UnSetShootable();
        }
		Goto Possum;
	Possum:
		VILE Z 1 A_LookEx(0,0,64,0,180,"RaiseSelf");
		Loop;
    RaiseSelf:
        VILE Z 1;
		VILE YXWVUT 4;
		VILE S 4;
		VILE R 4;
		VILE Q 4;
		VILE Q 0
        {
            A_SetSolid();
            VileLife = 0;
			A_SetSize(-1,56);
			A_SetShootable();
        }
        Goto See;
	See:
		VILE AABBCCDDEEFF 2 A_Chase;
		Loop;
	Missile:
		VILE G 0 BRIGHT A_VileStart;
		VILE G 10 BRIGHT A_FaceTarget;
		VILE H 8 BRIGHT A_VileTarget;
		VILE IJKLMN 8 BRIGHT A_FaceTarget;
		VILE O 8 BRIGHT A_VileAttack;
		VILE P 20 BRIGHT;
		Goto See;
	Pain:
		VILE Q 5;
		VILE Q 5 A_Pain;
		Goto See;
	Death:
		VILE Q 0
        {
            A_SetSolid();
            VileLife = 0;
        }
		VILE Q 7;
		VILE R 7 A_Scream;
		VILE S 7 A_NoBlocking;
		VILE TUVWXY 7;
        VILE Z -1;
		Stop;
	}
}

//CyberDemon NoRandom
class CyberdemonNoRand : Actor replaces Cyberdemon
{
	Default
	{
		Health 4000;
		Radius 40;
		Height 110;
		Mass 1000;
		Speed 16;
		PainChance 20;
		Monster;
		MinMissileChance 160;
		+BOSS 
		+MISSILEMORE
		+FLOORCLIP
		+NORADIUSDMG
		+DONTMORPH
		+BOSSDEATH
		SeeSound "cyber/sight";
		PainSound "cyber/pain";
		DeathSound "cyber/death";
		ActiveSound "cyber/active";
		Obituary "$OB_CYBORG";
		Tag "Cyberdemon";
	}
	States
	{
	Spawn:
		CYBR AB 10 A_Look;
		Loop;
	See:
		CYBR A 3 A_Hoof;
		CYBR ABBCC 3 A_Chase;
		CYBR D 3 A_Metal;
		CYBR D 3 A_Chase;
		Loop;
	Missile:
		CYBR E 6 A_FaceTarget;
		CYBR F 12 A_CyberAttackNoRand;
		CYBR E 12 A_FaceTarget;
		CYBR F 12 A_CyberAttackNoRand;
		CYBR E 12 A_FaceTarget;
		CYBR F 12 A_CyberAttackNoRand;
		Goto See;
	Pain:
		CYBR G 10 A_Pain;
		Goto See;
	Death:
		CYBR H 10;
		CYBR I 10 A_Scream;
		CYBR JKL 10;
		CYBR M 10 A_NoBlocking;
		CYBR NO 10;
		CYBR P 30;
		CYBR P -1 A_BossDeath;
		Stop;
	}
}
extend class CyberDemonNoRand
{
	action void A_CyberAttackNoRand()
	{
		if (target)
		{
			A_FaceTarget();
			SpawnMissile(target, "EnemyRocket");
		}
	}
}

//ENEMY ROCKET
class EnemyRocket : Rocket replaces Rocket
{
	Default
	{
		DamageFunction (50);
	}
	States
	{
	Death:
		MISL B 8 Bright A_Explode;
		MISL C 6 Bright;
		MISL D 4 Bright;
		Stop;
	BrainExplode:
		MISL BC 10 Bright;
		MISL D 10 A_BrainExplode;
		Stop;
	}
}

extend class EnemyRocket
{
	action void A_RocketExplodeEnemy()
	{
		A_Explode(50, 96, XF_HURTSOURCE, false, 40);
	}
}