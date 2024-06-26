class DeadCyberdemon : Actor
{
	Default
	{
		Tag "Dead Cyberdemon";
		Radius 40;
       //$Category Decoration
	}
	States
	{
		Spawn:
			CYBR P -1;
	}
}

class DeadSpiderMastermind : Actor
{
	Default
	{
		Tag "Dead Spider Mastermind";
		Radius 128;
       //$Category Decoration
	}
	States
	{
		Spawn:
			SPID S -1;
	}
}

class DeadArachnotron : Actor
{
	Default
	{
		Tag "Dead Arachnotron";
		Radius 64;
       //$Category Decoration
	}
	States
	{
		Spawn:
			BSPI P -1;
	}
}

class DeadHellKnight : Actor
{
	Default
	{
		Tag "Dead Hell Knight";
		Radius 24;
       //$Category Decoration
	}
	States
	{
		Spawn:
			BOS2 O -1;
	}
}

class DeadBaronOfHell : Actor
{
	Default
	{
		Tag "Dead Baron of Hell";
		Radius 24;
       //$Category Decoration
	}
	States
	{
		Spawn:
			BOSS O -1;
	}
}

class DeadFatso : Actor
{
	Default
	{
		Tag "Dead Mancubus";
		Radius 48;
       //$Category Decoration
	}
	States
	{
		Spawn:
			FATT P -1;
	}
}

class DeadArchvile : Actor
{
	Default
	{
		Tag "Dead Archvile";
		Radius 20;
       //$Category Decoration
	}
	States
	{
		Spawn:
			VILE Z -1;
	}
}

class DeadRevenant : Actor
{
	Default
	{
		Tag "Dead Revenant";
		Radius 20;
       //$Category Decoration
	}
	States
	{
		Spawn:
			SKEL Q -1;
	}
}

class DeadChaingunner : Actor
{
	Default
	{
		Tag "Dead ChaingunGuy";
		Radius 20;
       //$Category Decoration
	}
	States
	{
		Spawn:
			CPOS N -1;
	}
}