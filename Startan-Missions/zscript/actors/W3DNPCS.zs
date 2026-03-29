#include "./w3d/W3DGuard.zs"
#include "./w3d/W3DNCO.zs"
#include "./w3d/W3DOfficer.zs"
#include "./w3d/W3DRifleman.zs"
#include "./w3d/W3DZombies.zs"

class W3DNPC_Template : WolfensteinSS
{
	int W3D_PistolClip;
	int W3D_RifleClip;
	int W3D_SMGClip;
	int W3D_PlasmaClip;
	property W3D_PistolClip : W3D_PistolClip;
	property W3D_RifleClip : W3D_RifleClip;
	property W3D_SMGClip : W3D_SMGClip;
	property W3D_PlasmaClip : W3D_PlasmaClip;
	Default{
		W3DNPC_Template.W3D_PistolClip 8;
		W3DNPC_Template.W3D_RifleClip 5;
		W3DNPC_Template.W3D_SMGClip 32;
		W3DNPC_Template.W3D_PlasmaClip 20;
	}
}
extend class W3DNPC_Template
{
	void A_W3DSightorFlight()
	{
		if (Target && (Target.health > 0) && CheckSight(Target))
		{
			// Enter Aim state to face & shoot
			SetStateLabel("Aim");
		}
		else
		{
			// Player not visible → chase blindly
			SetStateLabel("Chase");
		}
	}
	void A_W3DPistolAttack()
	{
		A_StartSound("WaltherPPK/Fire", CHAN_WEAPON, CHANF_OVERLAP, 1.0, ATTN_NORM);
		A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
		W3D_PistolClip--;
	}
	void A_W3DSMGAttack()
	{
		A_StartSound("MP40/Fire", CHAN_WEAPON, CHANF_OVERLAP, 1.0, ATTN_NORM);
		A_CustomBulletAttack(20, 1, 1, random(8,12), "BulletPuff", 0, CBAF_NORANDOM);
		W3D_SMGClip--;
	}
	void A_W3DCheckAmmo()
	{
		if (W3D_PistolClip <= 0 || W3D_RifleClip <= 0 || W3D_SMGClip <= 0 || W3D_PlasmaClip <= 0)
		{
			A_StartSound("K98K/BOLT",CHAN_AUTO,1);
			SetStateLabel("Reloading");
		}else{
			SetStateLabel("Missile");
		}
		A_CPosRefire();
		// A_MonsterRefire(0, "Chase");
	}
	void A_W3DReload()
	{
		W3D_PistolClip = 8;
		W3D_RifleClip = 5;
		W3D_SMGClip = 32;
		W3D_PlasmaClip = 20;
	}
}

class PlasmaSS : W3DNPC_Template
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
		W3DNPC_Template.W3D_PistolClip 8;
		W3DNPC_Template.W3D_RifleClip 5;
		W3DNPC_Template.W3D_SMGClip 32;
		W3DNPC_Template.W3D_PlasmaClip 20;
	}
	States
	{
		Spawn:
			SSPL AB 10 A_Look;
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
			#### EEE 20 A_W3DReload();
			Goto Aim;
		Missile:
			#### F 3 A_FaceTarget;
			#### G 2 BRIGHT A_PlasmaSSAttack;
			#### F 2 BRIGHT;
			#### F 3 A_W3DCheckAmmo();
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
			#### N 5 ;
			#### O 5 A_XScream;
			#### P 5 A_NoBlocking;
			#### QRSTU 5;
			#### V -1;
			Stop;
		Raise:
			#### M 5;
			#### LKJI 5;
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
			SpawnMissile(target, "PlasmaSS_PlasmaBolt");
			W3D_PlasmaClip--;
		}
	}
}

class PlasmaSS_PlasmaBolt : ArachnotronPlasma
{
	Default
	{
		Radius 13;
		Height 8;
		Speed 25;
		DamageFunction (10 + Random(5,10));
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "baby/attack";
		DeathSound "baby/shotx";
	}
}

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