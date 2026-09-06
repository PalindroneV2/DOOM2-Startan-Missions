class Wunderwaffe : DoomWeapon
{
    Default
    {
        //$Category Weapons
        Weapon.SelectionOrder 2000;
        Weapon.SlotNumber 7;
        Weapon.AmmoUse 20;
        Weapon.AmmoGive 60;
        Weapon.AmmoType "Cell";
        Obituary "%k zapped %o with a Wunderwaffe DG-2.";
        -WEAPON.WIMPY_WEAPON;
        Inventory.PickupMessage "You got a Wunderwaffe DG-2.";
        Tag "Wunderwaffe DG-2";
        Scale 1;
        // AttackSound "raygun/fire";
    }
    States
    {
    Ready:
        RLGG A 1 A_WeaponReady;
        Loop;
    Deselect:
        RLGG A 1 A_Lower(9);
        Loop;
    Select:
        RLGG A 1 A_Raise(9);
        Loop;
    // Fire:
    //     RAYG A 4;
    //     RAYG B 6 A_WaffeFire;
    //     RAYG C 4;
    //     RAYG B 5;
    //     RAYG A 15;
    //     RAYG A 5 A_StartSound ("DG2/HAPPY", CHAN_AUTO);
    //     RAYG A 15;
    //     Goto Ready;
	Fire:
		RLGF A 3 A_WaffeFire;
		RLGF B 3;
		RLGG B 12;
		RLGG B 6;
		RLGG CDEFG 6;
		RLGG H 6;
		RLGG I 3 A_StartSound ("DG2/HAPPY", CHAN_AUTO);
		RLGG J 3;
		Goto Ready;
    Flash:
		TNT1 A 3 Bright A_Light1;
		TNT1 A 3 Bright A_Light2;
		TNT1 A 0 Bright A_Light0;
		Goto LightDone;
    Spawn:
        RAIL A -1;
        Stop;
    }
}

extend class Wunderwaffe
{
	action void A_WaffeFire()
    {
		A_StartSound ("DG2/FIRE", CHAN_WEAPON);
		A_StartSound ("DG2/DIST", CHAN_AUTO);
        A_RailAttack(
			0,                     // damage
			0,                       // spawnofs_xy
			true,                    // useammo
			"LightBlue",                // color1
			"White",                // color2
			RGF_SILENT | RGF_FULLBRIGHT | RGF_NOPIERCING,          // flags
			0,                       // maxdiff
			"WaffePuff",             // pufftype
			1,                       // spread_xy
			0,                       // spread_z
			8192,                    // range
			35,                      // duration
			0.5,                     // sparsity
			1,                     // driftspeed
			"None",                  // spawnclass
			0,                       // spawnofs_z
			270,                     // spiraloffset
			1                        // limit
		);
    }
}

class WaffeChainActor : Actor
{
	static Actor FindNearestWaffeTarget(Actor origin, double radius)
	{
		Actor closest = null;
		double closestDistance = 999999999.0;

		BlockThingsIterator itr =
			BlockThingsIterator.Create(origin, radius);

		while (itr.Next())
		{
			Actor thing = itr.thing;

			if (thing == null)
				continue;

			if (thing == origin)
				continue;

			if (!thing.bIsMonster)
				continue;

			if (thing.Health <= 0)
				continue;

			double distance = origin.Distance3D(thing);

			if (distance <= radius && distance < closestDistance)
			{
				closest = thing;
				closestDistance = distance;
			}
		}

		return closest;
	}
}

class WaffePuff : WaffeChainActor
{
	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
		+ZDOOMTRANS
        +ALWAYSPUFF
		RenderStyle "Add";
		Alpha 0.75;
		DamageType "BFGSplash";
		Translation "112:127=%[0.0,0.2,0.8]:[0.4,0.9,1.0]";
	}

	States
	{
	Spawn:
		BFE2 AB 4 Bright;
		BFE2 A 0 A_WaffeChainStart2;
		BFE2 CD 4 Bright;
		Stop;
	Crash:
		BFE2 AB 4 Bright;
		BFE2 A 0 A_WaffeChainStart2;
		BFE2 CD 4 Bright;
		Stop;
	}
}
extend class WaffePuff
{
	void FireChainRailStart(Actor target)
	{
		Vector3 targetPos =
			target.Pos + (0, 0, target.Height / 2);

		Vector3 direction =
			targetPos - Pos;

		double distanceXY =
			sqrt(
				direction.X * direction.X +
				direction.Y * direction.Y
			);

		// Point the puff directly at the target.
		Angle = AngleTo(target);

		Pitch =
			-atan2(direction.Z, distanceXY);

		FRailParams p;

		p.damage = 0;
		p.offset_xy = 0;
		p.offset_z = 0;

		p.color1 = Color("LightBlue");
		p.color2 = Color("White");

		p.maxdiff = 0;
		p.flags = RGF_SILENT | RGF_FULLBRIGHT | RGF_NOPIERCING;

		p.puff = null;

		// No offset. Rail fires along the puff's orientation.
		p.angleoffset = 0;
		p.pitchoffset = 0;

		p.distance = direction.Length();

		p.duration = 35;
		p.sparsity = 0.5;
		p.drift = 1;

		p.spawnclass = null;
		p.SpiralOffset = 270;
		p.limit = 1;

		RailAttack(p);
	}
	void A_WaffeChainStart2()
	{
		Actor target =
			FindNearestWaffeTarget(self, 128);

		if (target == null)
			return;

		Vector3 targetPos = target.Pos + (0, 0, target.Height / 2);

		A_StartSound ("DG2/BOUNCE1", CHAN_AUTO);
		FireChainRailStart(target);

		WaffeExtra extra =
			WaffeExtra(
				Spawn(
					'WaffeExtra',
					targetPos
				)
			);

		if (extra != null)
		{
			extra.ChainCount = 1;
			extra.ChainOrigin = target;
		}

		int victimsHealth = target.GetMaxHealth();
		string bossmonsers[] = {"Cyberdemon", "SpiderMastermind", "Harbinger"};
		for (int i = 0; i < bossmonsers.Size(); i++)
		{
			if (target.GetClass() == bossmonsers[i])
			{
				victimsHealth = victimsHealth / 20;
			}
		}
        target.DamageMobj(
            self,
            self,
            victimsHealth,
            'BFGSplash'
        );
	}
}

class WaffeExtra : WaffeChainActor
{
	int ChainCount;
	Actor ChainOrigin;
	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		DamageType "BFGSplash";
		Translation "112:127=%[0.0,0.2,0.8]:[0.4,0.9,1.0]";
	}

	States
	{
	Spawn:
		BFE2 ABCD 4 Bright;
		BFE2 A 0 A_WaffeChainContinue;
		BFE2 ABCD 4 Bright;
		Stop;
	}
}

extend class WaffeExtra
{
    void FireChainRail(Actor target)
    {
        Vector3 targetPos =
            target.Pos + (0, 0, target.Height / 2);

        Vector3 direction =
            targetPos - Pos;

        double distanceXY =
            sqrt(
                direction.X * direction.X +
                direction.Y * direction.Y
            );

        // Point this WaffeExtra directly at the next target.
        Angle = AngleTo(target);

        Pitch =
            -atan2(direction.Z, distanceXY);

        FRailParams p;

        p.damage = 0;
        p.offset_xy = 0;
        p.offset_z = 0;

        p.color1 = Color("LightBlue");
        p.color2 = Color("White");

        p.maxdiff = 0;
        p.flags = RGF_SILENT | RGF_FULLBRIGHT | RGF_NOPIERCING;

        // No puff: this rail is purely visual.
        p.puff = null;

        // Fire along our newly-set orientation.
        p.angleoffset = 0;
        p.pitchoffset = 0;

        p.distance = direction.Length();

        p.duration = 35;
        p.sparsity = 0.5;
        p.drift = 1;

        p.spawnclass = null;
        p.SpiralOffset = 270;
        p.limit = 1;

        RailAttack(p);
    }

    void A_WaffeChainContinue()
    {
        if (ChainCount >= 8)
            return;

        if (ChainOrigin == null)
            return;

        Actor target =
            FindNearestWaffeTarget(ChainOrigin, 256);

        if (target == null)
            return;

        // Rail starts HERE — at this WaffeExtra.
		A_StartSound ("DG2/BOUNCE1", CHAN_AUTO);
        FireChainRail(target);

        Vector3 targetPos =
            target.Pos + (0, 0, target.Height / 2);

        WaffeExtra extra = WaffeExtra(
			Spawn(
				'WaffeExtra',
				targetPos
			)
		);

        if (extra != null)
        {
            extra.ChainCount = ChainCount + 1;
            extra.ChainOrigin = target;
        }

		int victimsHealth = target.GetMaxHealth();
		string bossmonsers[] = {"Cyberdemon", "SpiderMastermind", "Harbinger"};
		for (int i = 0; i < bossmonsers.Size(); i++)
		{
			if (target.GetClass() == bossmonsers[i])
			{
				victimsHealth = victimsHealth / 20;
			}
		}
        target.DamageMobj(
            self,
            self,
            victimsHealth,
            'BFGSplash'
        );
    }
}

// OLD
// class WaffeProjectile : WaffeChainActor
// {
// 	Default
// 	{
// 		Radius 8;
// 		Height 8;
// 		Speed 128;
// 		DamageFunction (500);
// 		Projectile;
// 		+RANDOMIZE
// 		+ZDOOMTRANS
// 		RenderStyle "Add";
// 		Alpha 0.75;
// 		DeathSound "weapons/bfgx";
// 		Obituary "$OB_MPBFG_BOOM";
// 		DamageType "BFGSplash";
// 	}

// 	States
// 	{
// 	Spawn:
// 		BFS1 AB 4 Bright;
// 		Loop;

// 	Death:
// 		BFE1 AB 8 Bright;
// 		BFE1 C 0 A_WaffeChainStart;
// 		BFE1 C 8 Bright;
// 		BFE1 DEF 8 Bright;
// 		Stop;
// 	}
// }


// extend class WaffeProjectile
// {
// 	void A_WaffeChainStart()
// 	{
// 		Actor target =
// 			FindNearestWaffeTarget(self, 128);

// 		if (target == null) return;

// 		WaffeExtra extra = WaffeExtra(Spawn('WaffeExtra', target.Pos + (0, 0, target.Height/2)));

// 		target.DamageMobj(
// 			self,
// 			self,
// 			10000,
// 			'BFGSplash'
// 		);

// 		if (extra != null)
// 		{
// 			extra.ChainCount = 1;
// 			extra.ChainOrigin = target;
// 		}
// 	}
// }