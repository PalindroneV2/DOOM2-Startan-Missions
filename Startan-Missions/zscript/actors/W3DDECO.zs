class W3DPotTree : TorchTree
{
    Default
    {
        Tag "Potted Tree (Wolf3D)";
       //$Category Decoration
    }
    States{
        Spawn:
            W3PG A -1;
            Stop;
    }
}
class W3DPotPlant : TorchTree
{
    Default
    {
        Tag "Potted Plant (Wolf3D)";
       //$Category Decoration
    }
    States{
        Spawn:
            W3PB A -1;
            Stop;
    }
}
class W3DPotAlone: TorchTree
{
    Default
    {
        Tag "Blue Pot (Wolf3D)";
       //$Category Decoration
    }
    States{
        Spawn:
            W3PS A -1;
            Stop;
    }
}
class W3DWoodBarrel : TorchTree
{
    Default
    {
        Tag "Wooden Barrel (Wolf3D)";
       //$Category Decoration
    }
    States{
        Spawn:
            W3WB A -1;
            Stop;
    }
}
class W3DArmorDeco : TorchTree
{
    Default
    {
        Tag "Decorative Armor (Wolf3D)";
       //$Category Decoration
    }
    States{
        Spawn:
            W3AR A -1;
            Stop;
    }
}
class W3DNaziFlag : TorchTree
{
    Default
    {
        Tag "Nazi Flag (Wolf3D)";
       //$Category Decoration
    }
    States{
        Spawn:
            W3FL A -1;
            Stop;
    }
}

class W3DHangingSkelton :   Meat2
{    
    Default
    {
        Tag "Hanging Skeleton (Wolf3D)";
       //$Category Decoration
        Height 64;
    }
    States
    {
        Spawn:
            SKLC A -1;
            Stop;
    }
}
class W3DCage :   Meat2
{
    Default
    {
        Tag "Hanging Cage (Wolf3D)";
       //$Category Decoration
        Height 64;
    }
    States
    {
        Spawn:
            W3CG A -1;
            Stop;
    }
}
class W3DCage2 :   Meat2
{
    Default
    {
        Tag "Hanging Cage with Skeleton (Wolf3D)";
       //$Category Decoration
        Height 64;
    }
    States
    {
        Spawn:
            W3CS A -1;
            Stop;
    }
}

class W3DChandelier :   Actor
{    
    Default
    {
        Tag "Chandelier (Wolf3D)";
        //$Category Light sources
        Radius 26;
        Height 19;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
    }
    States
    {
        Spawn:
            W3CH A -1;
            Stop;
    }
}

class W3DSkeletonFloor  :   DeadMarine
{
    Default
    {
        Tag "Skeleton (Wolf3D)";
       //$Category Decoration
    }
    States
    {
        Spawn:
            SKLF A -1;
            Stop;
    }
}

class W3DBonePile  :   DeadMarine
{
    Default
    {
        Tag "Bone Pile (Wolf3D)";
       //$Category Decoration
    }
    States
    {
        Spawn:
            SKLP A -1;
            Stop;
    }
}


//DEAD BAD GUYS
class W3DDeadDog :  Actor
{
    Default
    {
        Tag "Dead Nazi Hound";
       //$Category Decoration
    }
	States
	{
        Spawn:
            DOGS N -1;
	}
}

class W3DDeadGuard : Actor
{
	Default
	{
		Tag "Dead Nazi Guard (W3D)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            NZGD M -1;
	}
}
class W3DDeadMissionsGuard : Actor
{
	Default
	{
		Tag "Dead Nazi Guard (W3D Missions)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            NZGL M -1;
	}
}
class W3DDeadHeerGuard : Actor
{
	Default
	{
		Tag "Dead German Guard (Heer)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            HPGD M -1;
	}
}
class W3DDeadAfrikaGuard : Actor
{
	Default
	{
		Tag "Dead German Guard (Afrika)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            APGD M -1;
	}
}
class W3DDeadSSGuard : Actor
{
	Default
	{
		Tag "Dead Nazi Guard (SS)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            SPGD M -1;
	}
}

class W3DDeadWaffenSS : Actor
{
	Default
	{
		Tag "Dead Waffen SS (W3D)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            SS3D M -1;
	}
}
class W3DDeadMissionsWaffenSS : Actor
{
	Default
	{
		Tag "Dead Waffen SS (W3D Missions)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            SSBL M -1;
	}
}
class W3DDeadHeerNCO : Actor
{
	Default
	{
		Tag "Dead German Unteroffizier (Heer)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            HMNC M -1;
	}
}
class W3DDeadAfrikaNCO : Actor
{
	Default
	{
		Tag "Dead German Unteroffizier (Afrika)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            AMNC M -1;
	}
}
class W3DDeadSSNCO : Actor
{
	Default
	{
		Tag "Dead Nazi Unteroffizier (SS)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            SMNC M -1;
	}
}

class W3DDeadPlasmaSS : Actor
{
	Default
	{
		Tag "Dead Plasmawaffen SS";
       //$Category Decoration
    }
	States
	{
        Spawn:
            SSPL M -1;
	}
}

class W3DDeadOfficer : Actor
{
	Default
	{
		Tag "Dead Nazi Officer (W3D)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            NAZO M -1;
	}
}
class W3DDeadMissionsOfficer : Actor
{
	Default
	{
		Tag "Dead Nazi Officer (W3D Missions)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            NZWL M -1;
	}
}
class W3DDeadHeerOfficer : Actor
{
	Default
	{
		Tag "Dead German Officer (Heer)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            HPOF M -1;
	}
}
class W3DDeadAfrikaOfficer : Actor
{
	Default
	{
		Tag "Dead German Officer (Afrika)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            APOF M -1;
	}
}
class W3DDeadSSOfficer : Actor
{
	Default
	{
		Tag "Dead Nazi Officer (SS)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            SPOF M -1;
	}
}
class W3DDeadSSZombie : Actor
{
	Default
	{
		Tag "Dead Nazi Zombie  (SS)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            SSZM N -1;
	}
}
class W3DDeadHeerZombie : Actor
{
	Default
	{
		Tag "Dead German Zombie (Heer)";
       //$Category Decoration
    }
	States
	{
        Spawn:
            HRZM N -1;
	}
}