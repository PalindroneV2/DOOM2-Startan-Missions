class TeddyBear : Actor
{
	Default
	{
		Health 1;
		Radius 8;
		Height 16;
        Scale 0.4;
		+SOLID
		+SHOOTABLE
		+NOBLOOD
		+ACTIVATEMCROSS
		+DONTGIB
		+NOICEDEATH
		+OLDRADIUSDMG
        +NEVERTARGET
        Tag "Teddy Bear";
		Species "Teddy";
        //$Category Decoration
	}
	States
	{
	Spawn:
		TEDD A -1;
		Loop;
	Death:
        TFOG ABABCDEFGHIJ 6 Bright;
        // TNT1 A 0; // Instantly vanish upon death
        Stop;
	}
}

class TeddyBearPerkaholic : Actor
{
	Default
	{
		Health 1;
		Radius 8;
		Height 16;
        Scale 0.4;
		+SOLID
		+SHOOTABLE
		+NOBLOOD
		+ACTIVATEMCROSS
		+DONTGIB
		+NOICEDEATH
		+OLDRADIUSDMG
        +NEVERTARGET
        Tag "Teddy Bear (Perkaholic)";
		Species "Teddy";
        //$Category Decoration
	}
	States
	{
	Spawn:
		TEDP A -1;
		Loop;
	Death:
        TFOG ABABCDEFGHIJ 6 Bright;
        // TNT1 A 0; // Instantly vanish upon death
        Stop;
	}
}

class TeddyBearKnife : Actor
{
	Default
	{
		Health 1;
		Radius 8;
		Height 16;
        Scale 0.4;
        //$Category Decoration
		+SOLID
		+SHOOTABLE
		+NOBLOOD
		+ACTIVATEMCROSS
		+DONTGIB
		+NOICEDEATH
		+OLDRADIUSDMG
        +NEVERTARGET
        Tag "Teddy Bear (Knife)";
		Species "Teddy";
	}
	States
	{
	Spawn:
		TEDK A -1;
		Loop;
	Death:
        TFOG ABABCDEFGHIJ 6 Bright;
        // TNT1 A 0; // Instantly vanish upon death
        Stop;
	}
}

class TeddyBearDeco : Actor
{
	Default
	{
		Radius 8;
		Height 16;
        Scale 0.4;
		+SOLID
        +USESPECIAL
        Tag "Teddy BearDeco";
		Species "Teddy";
        //$Category Decoration
	}
	States
	{
	Spawn:
		TEDD A -1;
		Stop;
	}
}