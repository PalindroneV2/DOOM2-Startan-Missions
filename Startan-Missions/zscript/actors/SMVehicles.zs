Class SMJEEP : Actor {
	Default {
		Radius 80;
		Height 64;
		
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