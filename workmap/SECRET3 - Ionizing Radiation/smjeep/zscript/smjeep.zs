Class smjeep : Actor {
	Default {
		Radius 80;
		Height 256;
		
		
		+SOLID
		+INVULNERABLE
		+NODAMAGE
		+SHOOTABLE
		+NOTAUTOAIMED
		+NEVERTARGET
		+DONTTHRUST
	}

	States {
		Spawn:
			PLAY A -1;
			Stop;
	}
}