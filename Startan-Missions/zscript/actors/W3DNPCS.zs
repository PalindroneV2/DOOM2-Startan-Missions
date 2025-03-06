#include "./w3d/W3DGuard.zs"
#include "./w3d/W3DNCO.zs"
#include "./w3d/W3DOfficer.zs"
#include "./w3d/W3DRifleman.zs"
#include "./w3d/W3DZombies.zs"

class EnemyDog : MBFHelperDog
{
	Default
	{
		Health 30;
		Tag "Nazi Hound";
       //$Category Monsters
		Species "Nazi";
		Speed 16;
		Obituary "You were mauled to death by a Nazi Hound";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
}
class PlasmaSS : WolfensteinSS
{
	Default
	{
	   Health 75;
		Radius 16;
		Height 56;
		Speed 10;
		PainChance 75;
		SeeSound "plasmass/sight";
		PainSound "wolfss/pain";
		DeathSound "plasmass/death";
		ActiveSound "wolfss/active";
		AttackSound "baby/attack";
		Obituary "You were melted by a Plasmawaffen SS.";
		Tag "Plasmawaffen SS";
       //$Category Monsters
		Dropitem "PlasmaRifle";
		Species "Nazi";
		+DONTHARMSPECIES
		+NOINFIGHTSPECIES
	}
	States
	{
		Spawn:
			SSPL AB 10 A_Look;
			Loop;
		See:
			"####" E 5 A_FaceTarget;
			Goto Chase;
		Chase:
			"####" AABBCCDD 3 A_Chase("Aim","Aim");
			Loop;
		Aim:
			"####" EF 3 A_FaceTarget;
			Goto Missile;
		Missile:
			"####" E 5 A_FaceTarget;
			"####" G 4 BRIGHT A_PlasmaSSAttack;
			"####" F 4 BRIGHT;
			"####" F 5 A_CPosRefire;
			Goto Missile+1;
		Pain:
			"####" H 3;
			"####" H 3 A_Pain;
			Goto See;
		Death:
			"####" I 5;
			"####" J 5 A_Scream;
			"####" K 5 A_NoBlocking;
			"####" L 5;
			"####" M -1;
			Stop;
		XDeath:
			"####" N 5 ;
			"####" O 5 A_XScream;
			"####" P 5 A_NoBlocking;
			"####" QRSTU 5;
			"####" V -1;
			Stop;
		Raise:
			"####" M 5;
			"####" LKJI 5;
			Goto See ;
	}
}

extend class PlasmaSS
{
	void A_PlasmaSSAttack()
	{
		if (target)
		{
			A_FaceTarget();
			SpawnMissile(target, "ArachnotronPlasma");
		}
	}
}