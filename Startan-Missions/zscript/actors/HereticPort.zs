
// Mummy --------------------------------------------------------------------

class CustomMummy : Actor
{
	Default
	{
		Health 450;
		Radius 22;
		Height 62;
		Mass 75;
		Speed 20;
		Painchance 64;
		Monster;
		+FLOORCLIP
		SeeSound "mummy/sight";
		AttackSound "mummy/attack1";
		PainSound "mummy/pain";
		DeathSound "mummy/death";
		ActiveSound "mummy/active";
		Species "Mummy";
		Obituary "%o was blazed by a Mummy";
		Tag "Mummy";
	}
	States
	{
	Spawn:
		MUMM AB 10 A_Look;
		Loop;
	See:
		MUMM ABCD 4 A_Chase;
		Loop;
	Melee:
		MUMM E 6 A_FaceTarget;
		MUMM F 6 A_CustomMeleeAttack(random[MummyAttack](1,8)*2, "mummy/attack2", "mummy/attack");
		MUMM G 6;
		Goto See;
    Missile:
		MUMM X 3 A_FaceTarget;
		MUMM Y 3 Bright A_FaceTarget;
		MUMM X 3 A_FaceTarget;
		MUMM Y 3 Bright A_FaceTarget;
		MUMM X 3 A_FaceTarget;
		MUMM Y 3 Bright A_CustomComboAttack("MummyProjectile", 32, random[MummyAttack2](1,8)*2, "mummy/attack2");
		Goto See;
	Pain:
		MUMM H 4;
		MUMM H 4 A_Pain;
		Goto See;
	Death:
		MUMM I 5;
		MUMM J 5 A_Scream;
		MUMM K 5 A_SpawnItemEx("CustomMummySoul", 0,0,10, 0,0,1);
		MUMM L 5;
		MUMM M 5 A_NoBlocking;
		MUMM NO 5;
		MUMM P -1;
		Stop;
	}
}

// Mummy ghost --------------------------------------------------------------

class CustomMummyGhost : CustomMummy
{
	Default
	{
		+SHADOW
		+GHOST
		RenderStyle "Translucent";
		Alpha 0.4;
	}
}

// Mummy soul ---------------------------------------------------------------
class CustomMummySoul : Actor
{
	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
	}
	States
	{
	Spawn:
		MUMM QRS 5;
		MUMM TUVW 9;
		Stop;
	}
}

// Mummy FX 1 (flying head) -------------------------------------------------
class MummyProjectile : Actor
{
	Default
	{
		Radius 8;
		Height 14;
		Speed 16;
		FastSpeed 32;
		DamageFunction (20);
		RenderStyle "Add";
		Projectile;
		-ACTIVATEPCROSS
		-ACTIVATEIMPACT
		+SEEKERMISSILE
		+ZDOOMTRANS
	}
	States
	{
	Spawn:
		FX15 A 5 Bright A_StartSound("mummy/head");
		FX15 B 5 Bright A_SeekerMissile(10,20);
		FX15 C 5 Bright;
		FX15 B 5 Bright A_SeekerMissile(10,20);
		Loop;
	Death:
		FX15 DEFG 5 Bright;
		Stop;
	}
}
