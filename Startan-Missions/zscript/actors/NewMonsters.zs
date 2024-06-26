class Harbinger : CyberDemon
{
	Default
	{
		Tag "Harbinger of Doom";
       //$Category Monsters
		Obituary "%o was crushed by the Harbinger of Doom.";
		Health 3500;
		Radius 40;
		Height 110;
		Mass 1000;
		Speed 15;
		PainChance 20;
		SeeSound "cyber/sight";
		PainSound "cyber/pain";
		DeathSound "superdemon/death";
		ActiveSound "cyber/active";
		MONSTER;
		+BOSS;
		+FLOORCLIP;
		+NORADIUSDMG;
		+DONTMORPH;
		+MISSILEMORE;
	}
	States
	{
		Spawn:
			SUPR AB 10 A_Look;
			Loop;
		See:
			SUPR A 3 A_Hoof;
			SUPR ABBCC 3 A_Chase;
			SUPR D 3 A_Hoof;
			SUPR D 3;
			Loop;
		Missile:
			SUPR Q 0 A_Jump(128,"Missile2");
			SUPR QR 4 A_FaceTarget;
			SUPR S 8 A_SpawnProjectile ("SuperDemonBall", 54);
			SUPR QR 4 A_FaceTarget;
			SUPR S 8 A_SpawnProjectile ("SuperDemonBall", 54);
			SUPR QR 4 A_FaceTarget;
			SUPR S 9 A_SpawnProjectile ("SuperDemonBall", 54);
			Goto See;
		Missile2:
			SUPR EF 6 A_FaceTarget;
			SUPR GG 0 A_SpawnProjectile ("SuperDemonBall", 54, 0, -10);
			SUPR GG 0 A_SpawnProjectile ("SuperDemonBall", 54, 0, -5);
			SUPR GG 0 A_SpawnProjectile ("SuperDemonBall", 54, 0, 5);
			SUPR GG 0 A_SpawnProjectile ("SuperDemonBall", 54, 0, 10);
			SUPR G 10 A_SpawnProjectile ("SuperDemonBall", 54, 0);
			Goto See	;		
		Pain:
			SUPR H 10 A_Pain;
			Goto See;
		Death:
			SUPR I 4 A_StartSound ("superdemon/snarl", chan_5);
			SUPR J 4 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			SUPR J 4 A_Scream;
			SUPR KKKK 1 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			SUPR L 3 A_SpawnProjectile ("SuperDemonArm", 54, -50, -50);
			SUPR MN 5 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			SUPR O 7 A_StartSound ("superdemon/crash");
			SUPR PPPPPPP 1 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			SUPR P 7 A_NoBlocking;
			SUPR P -1 A_BossDeath ;
			Stop;
	}
}

class SuperDemonBall : Actor
{
	Default
	{
		Radius 6;
		Height 16;
		Speed 16;
		Damage 15;
		Scale 1.5;
		// RenderStyle Add;
		PROJECTILE;
		+RANDOMIZE;
		SeeSound "baron/attack";
		DeathSound "baron/shotx";
		Decal "BigScorch";
	}
	States
	{
		Spawn:
			BAL9 AB 1 bright;
			Loop;
		Death:
			BAL9 CDE 6 bright;
			Stop;
	}
}

class  SuperDemonArm : Actor
{
	Default
	{
		Radius 10;
		Height 8;
		Speed 1;
		Damage 1;
		Scale 1;
		PROJECTILE;
		-NOGRAVITY;
		+LOWGRAVITY;
	}
	States
	{
		Spawn:
			SUPH A 5 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			SUPH B 5 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			SUPH C 5 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			Goto Death;
		Death:
			SUPH D 5 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			SUPH E -1 A_SpawnProjectile("Blood",0,0,random(-80,-100),2,random(45,80));
			Stop;
	}
}

class DeadHarbinger : Actor
{
	Default
	{
		Tag "Dead Harbinger";
		Radius 40;
       //$Category Decoration
	}
	States
	{
		Spawn:
			SUPR P -1 ;
	}
}

class FormerRanger : Actor
{
	Default
	{
		//$Category Monsters
		Tag "Former Ranger";
		Health 50;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 170;
		Monster;
		+FLOORCLIP
		SeeSound "grunt/sight";
		AttackSound "grunt/attack";
		PainSound "grunt/pain";
		DeathSound "grunt/death";
		ActiveSound "grunt/active";
		Obituary "%o was cut down by a Ranger.";
		DropItem "M16";
	}
  States
	{
		Spawn:
			FRNG AB 10 A_Look;
			Loop;
		See:
			FRNG AABBCCDD 3 A_Chase;
			Loop;
		Missile:
			FRNG E 10 A_FaceTarget;
			Goto WhichMissileType;
		WhichMissileType:
			FRNG E 0 A_JumpIfCloser(768, "BurstFire");
			FRNG E 0 A_Jump(64, "SnipeFire2");
			Goto SnipeFire;
		SnipeFire:
			FRNG F 4 bright A_CustomBulletAttack(10, 1, 1, random(1,5) * 3, "BulletPuff", 0, CBAF_NORANDOM);
			FRNG E 10 A_CPosRefire;
			Goto WhichMissileType;
		SnipeFire2:
			FRNG EE 10 A_FaceTarget;
			FRNG F 4 bright A_CustomBulletAttack(8, 1, 1, random(1,5) * 3, "BulletPuff", 0, CBAF_NORANDOM);
			FRNG E 10 A_CPosRefire;
			Goto WhichMissileType;
		BurstFire:
			FRNG E 3 A_FaceTarget;
			// FRNG F 4 Bright A_CustomBulletAttack(13, 2, 1, random(1,5) * 3, "BulletPuff", 0, CBAF_NORANDOM);//A_CPosAttack
			FRNG EFE 3 Bright A_CustomBulletAttack(13, 2, 1, random(1,5) * 3, "BulletPuff", 0, CBAF_NORANDOM);//A_CPosAttack
			FRNG E 3 A_FaceTarget;
			FRNG E 10 A_CPosRefire;
			Goto WhichMissileType;
		Pain:
			FRNG G 3;
			FRNG G 3 A_Pain;
			Goto See;
		Death:
			FRNG H 5;
			FRNG I 5 A_Scream;
			FRNG J 5 A_NoBlocking;
			FRNG K 5;
			FRNG L -1;
			Stop;
		XDeath:
			FRNG M 5;
			FRNG N 5 A_XScream;
			FRNG O 5 A_NoBlocking;
			FRNG PQRST 5;
			FRNG U -1;
			Stop;
		Raise:
			FRNG LKJIH 5;
			Goto See;
	}
}

class RangerCorpse : Actor
{
	Default{
		Tag "Dead Former Ranger";
		Radius 20;
		//$Category Decoration
	}
	States
	{
		Spawn:
			FRNG L -1;
			Stop;
	}
}

Class Hellion : Actor
{
	Default
	{
		Obituary "A Hellion burned %o to a crisp.";
		Health 70;
		Radius 20;
		Height 56;
		Mass 120;
		Speed 10;
		PainChance 24;
		SeeSound "monster/hlnsit";
		PainSound "monster/hlnpai";
		DeathSound "monster/hlndth";
		ActiveSound "monster/hlnact";
		Monster;
		+FloorClip
	}
	States
	{
		Spawn:
			HELN AB 10 A_Look();
			Loop;
		See:
			HELN AABBCCDDEEFF 2 A_Chase();
			Loop;
		Missile:
			HELN G 0 A_VileStart();
			HELN GHIJK 6 Bright A_FaceTarget();
			HELN L 6 Bright A_SpawnProjectile("HellionBall",32,0,0,0,0);
			HELN L 2;
			Goto See;
		Pain:
			HELN M 2;
			HELN M 2 A_Pain();
			Goto See;
		Death:
			HELN N 6;
			HELN O 6 A_Scream();
			HELN PQR 6;
			HELN S 6 A_NoBlocking();
			HELN T -1;
			Stop;
		XDeath:
			HELN U 5;
			HELN V 5 A_XScream();
			HELN W 5;
			HELN X 5 A_NoBlocking();
			HELN YZ 5;
			HEL2 AB 5;
			HEL2 C -1;
			Stop;
		Raise:
			HELN TSRQPON 6;
			Goto See;
	}
}

Class HellionBall : CacodemonBall
{
  Default
  {
    Damage 8;
    Speed 48 ;
    Alpha 0.80;
    DamageType "Fire";
    SeeSound "Monster/hlnatk";
    DeathSound "Monster/hlnexp";
    Decal "DoomImpScorch";
    +ThruGhost
    +ForceXYBillboard
  }

  states
  {
  Spawn:
    HLBL AB 3 Bright A_SpawnItemEx("HellionPuff", 0,0,0, 0,0,0, 0, SXF_CLIENTSIDE);
    Loop;
  Death:
    HLBL JKLMN 3 Bright;
    Stop;
  }
}

Class HellionPuff : Actor
{
  Default
  {
    Radius 3;
    Height 3;
    RenderStyle "Add";
    Alpha 0.67;
    +NoGravity
    +NoBlockMap
    +DontSplash
    +ForceXYBillboard
  }

  States
  {
  Spawn:
    TNT1 A 3 Bright;
    HLBL CDEFGHI 3 Bright;
    Stop;
  }
}

class DeadHellion : Actor
{
	Default
	{
		Tag "Dead Hellion";
		Radius 20;
       //$Category Decoration
	}
	States
	{
		Spawn:
			HELN T -1 ;
	}
}

//End of Hellion

