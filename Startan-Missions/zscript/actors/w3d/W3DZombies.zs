class W3DZombie : Actor
{
	default
	{
		Health 95;
		Speed 15;
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
		+JUMPDOWN
		+DROPOFF
		// +ALWAYSFAST
       //$Category Monsters
		//$Sprite NZGDI
	}
	States
	{
	Spawn:
		//SS3D is placeholder
		//SSZM is SS Zombie
		//HRZM is Heer Zombie
		SS3D AB 10 A_Look;
		Loop;
	See:
		#### E 2 A_FaceTarget;
		#### E 3;
		#### F 30 A_StartSound("w3dzombie/scream",CHAN_AUTO);
		Goto Chase;
	Chase:
		#### A 0 A_JumpIf(CheckForObstacle(),"Jump"); 
		#### AA 2 A_Chase("Melee",null);
		#### B 0 A_JumpIf(CheckForObstacle(),"Jump");
		#### BB 2 A_Chase("Melee",null);
		#### C 0 A_JumpIf(CheckForObstacle(),"Jump");
		#### CC 2 A_Chase("Melee",null);
		#### D 0 A_JumpIf(CheckForObstacle(),"Jump");
		#### DD 2 A_Chase("Melee",null);
		Loop;
	Melee:
		#### EG 6 A_FaceTarget;
		#### H 1 A_W3DZombieSwipe;
		#### H 3;
		Goto Chase;
	Pain:
		#### I 2;
		#### I 2 A_Pain;
		Goto Chase;
	Death:
		#### I 8;
		#### J 8 A_Scream;
		#### K 4;
		#### L 4 A_Fall;
		#### M 4;
		#### N -1;
		Stop;
	XDeath:
		SS3D N 5 ;
		SS3D O 5 A_XScream;
		SS3D P 5 A_NoBlocking;
		SS3D Q -1;
		Stop;
	Raise:
		#### N 5;
		#### MLKJI 5;
		Goto See;
	Jump:
		#### A 1;
        #### A  1 A_Recoil(6); // Adjust the Z velocity for the jump
        #### A  2;
        #### AB  1 A_W3DZombieJump;
        #### AB  6;
        Goto Chase ;
	}
}

extend class W3DZombie
{
	void A_W3DZombieSwipe()
	{
		int zmbdmg = 5 * Random(3,4);
		if (target)
		{
			A_FaceTarget();
			A_CustomMeleeAttack(zmbdmg);
		}
	}
	void A_W3DZombieJump()
	{
		// A_ChangeVelocity(9, 0, 9, CVF_REPLACE);
		A_ChangeVelocity(6, 0, 5, CVF_RELATIVE);
		// A_Recoil(-9);
		Thrust(1,1e37);
	}
	bool CheckForObstacle()
    {
		double zombieangle = self.Angle;
		// console.printf("ACTOR RELATIVE ANGLE: " .. self.Angle);
 
        // Perform the line trace
        FLineTraceData trace;
        FLineTraceData trace2;
		bool hit = LineTrace(zombieangle ,  32 , 0, TRF_NOSKY | TRF_THRUACTORS | TRF_BLOCKSELF,  31, 0, 0, trace);
		bool hit2 = LineTrace(zombieangle,  32 , 0, TRF_NOSKY | TRF_THRUACTORS | TRF_BLOCKSELF,  33, 0, 0, trace2);
		double hitHeight = trace.HitLocation.z - floorz;

        // Check if the trace hit something within the desired height
		if(hit2)
		{
			// console.printf("Dont jump at this wall!");
			// console.printf("LineTrace2 has hit at height: " .. trace2.HitLocation.z - floorz .. " Where floorz is: " .. floorz);
			// console.printf("LineTrace2 has hit a " .. trace.HitType);
			return false;
		}
        if (hit)
        {
			// console.printf("Jump!");
			// console.printf("LineTrace has hit at height: " .. trace.HitLocation.z - floorz .. " Where floorz is: " .. floorz);
			// console.printf("LineTrace has hit a " .. trace.HitType);
			return true;
        }
		return false;
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
		//$Sprite SSZMH0 
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
		//$Sprite HRZMH0
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