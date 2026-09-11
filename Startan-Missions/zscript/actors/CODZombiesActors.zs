#include "zscript/actors/codz/cod_powerups.zs"

class PackaPunchMachine : Actor
{
    Default
    {
        Tag "Pack-a-Punch Machine";
		Radius 32;
		Height 64;
        Scale 0.75;
		+SOLID
        +USESPECIAL
       //$Category Decoration
    }
    States{
        Spawn:
            PAPU A -1;
            Stop;
    }
}

class PAP_PowerUp : CustomInventory
{
    Default
    {
        Tag "Pack-a-Punch Power Up";
		Radius 20;
		Height 20;
        Scale 1;
        +PICKUP;
        +NOGRAVITY;
        +COUNTITEM;
        +FLOATBOB;
		+INVENTORY.ALWAYSPICKUP;
        FloatBobStrength 0.25;
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        Inventory.InterHubAmount 0;
        Inventory.Icon "PAPPA0";
        Inventory.AltHUDIcon "PAPPA0";
        Inventory.PickupMessage "Got Pack A Punch!";
		Inventory.PickupSound "misc/p_pkup";
       //$Category Powerups
    }
    States
    {
        Spawn:
            PAPP A -1;
            Stop;
        Pickup:
            TNT1 A 0 A_PAPUpgrade;
            Stop;
    }
}

extend class PAP_PowerUp
{
    // {"M1911A1", "MP40", "Minigun", "M16", "Trenchgun", "NewSuperShotgun", "NewRocketLauncher", "FastPlasmaRifle", "BFG9000", "RayGun", "KAR98K"};
    action void A_PAPUpgrade()
    {
        string weaponbox[] = {
            "M1911A1", "MP40", "Minigun", "M16", "Trenchgun",
            "NewSuperShotgun", "NewRocketLauncher", "FastPlasmaRifle",
            "BFG9000", "RayGun", "Kar98k"
        };
        Weapon currentWeapon = player.ReadyWeapon;
        string guntoupgrade = currentWeapon.GetClassName() .. "";
        string upgradedgun = guntoupgrade .. "_PAP";
        bool weaponupgradable = false;

        for (int fuck = 0; fuck < 11; fuck++)
        {
            // console.printf((weaponbox[fuck]   .. "_PAP"));
            if((weaponbox[fuck] != guntoupgrade) || guntoupgrade == guntoupgrade.."_PAP")
            {
                weaponupgradable = false;
                continue;
            }
            if ((weaponbox[fuck] == guntoupgrade) && guntoupgrade != upgradedgun)
            {
                weaponupgradable = true;
                break;
            }
        }
        if (weaponupgradable == true){
            A_TakeInventory(guntoupgrade);
            A_GiveInventory(upgradedgun);
            A_SelectWeapon(upgradedgun);
            A_TakeInventory("PAP_PowerUp");
            A_Log("Your weapon was upgraded!");
        }else if(weaponupgradable == false){
            A_Log("This weapon cannot be upgraded.");
        }
        // A_GiveInventory(currentWeapon.AmmoType1.GetClassName(), 600);
        if (currentWeapon.AmmoType1 != null){
            A_GiveInventory(currentWeapon.AmmoType1.GetClassName(), 600);
            A_Log("Primary Ammo Topped Off!.");
        }
        if (currentWeapon.AmmoType2 != null){
            A_GiveInventory(currentWeapon.AmmoType2.GetClassName(), 600);
            A_Log("Secondary Ammo Topped Off!.");
        }
    }
}

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

class CODPowerupShuffler : Object play
{
    array<string> dropList;

    void Init()
    {
        dropList.Clear();
        dropList.Push("MaxAmmo_Powerup");
        dropList.Push("Armor_CODPowerUp");
        dropList.Push("Berserk_CODPowerUp");
        dropList.Push("Nuke_CODPowerUp");
        dropList.Push("KillingTime_CODPowerUp");
        ShuffleQueue();
        // "MaxAmmo_Powerup", "Armor_CODPowerUp", "Berserk_CODPowerUp"
    }

    array<int> dropQueue;
    int dropIndex;

    void ShuffleQueue()
    {
        dropQueue.Clear();

        while (dropQueue.Size() < dropList.Size())
        {
            int index = Random(0, dropList.Size() - 1);

            if (dropQueue.Find(index) == dropQueue.Size())
            {
                dropQueue.Push(index);
            }
        }

        dropIndex = 0;
    }

    void SpawnPowerup(Vector3 pos)
    {
        // console.printf(
        //     "DropList: %d | DropQueue: %d | DropIndex: %d",
        //     dropList.Size(),
        //     dropQueue.Size(),
        //     dropIndex
        // );
        if (dropQueue.Size() == 0)
            ShuffleQueue();

        Actor.Spawn(
            dropList[dropQueue[dropIndex]],
            pos
        );

        dropIndex++;

        if (dropIndex >= dropQueue.Size())
        {
            ShuffleQueue();
        }
    }
}

class CODPowerupDropper : EventHandler
{
    CODPowerupShuffler ReadyPowerUpShuffler;
    override void OnRegister()
    {
        ReadyPowerUpShuffler = new("CODPowerupShuffler");
        ReadyPowerUpShuffler.Init();
    }
    override void WorldThingDied(WorldEvent dead)
    {
        
        if (!dead.Thing || !dead.Thing.bIsMonster || dead.Thing.GetSpecies() == "Teddy" || dead.Thing is "PlayerPawn")
        {
            // console.printf("Is this even zombiekill?");
            return;
        }
        if (ACS_NamedExecuteWithResult("IsZombieMap") == 0)
        {
            // console.printf("Is this even zombiemap?");
            return;
        }
        if(Random(1,100) <= 2)
        {
            ReadyPowerUpShuffler.SpawnPowerup(dead.Thing.pos);
        }
    }
}

class CODZombieHealthRegen : EventHandler
{
    override void WorldThingDamaged(WorldEvent hurtDude)
    {
        if (ACS_NamedExecuteWithResult("IsZombieMap") == 0)
        {
            // console.printf("Is this even zombiemap?");
            return;
        }
        //if not a thing dont do anything
        if (hurtDude.Thing == null)return;
        //if not player dont do anything
        if (hurtDude.Thing.player == null) return;
        //if not zombie map dont do anything
        //do stuff
        let iterator = ThinkerIterator.Create('CODZombieRegenTimer');
        Thinker thinker;
        while ((thinker = iterator.Next()) != null)
        {
            CODZombieRegenTimer oldTimer = CODZombieRegenTimer(thinker);
            if (oldTimer.Player == hurtDude.Thing)
            {
                oldTimer.Destroy();
            }
        }
        PlayerPawn gamer = PlayerPawn(hurtDude.Thing);
        int topHP=100;
        // if (hurtDude.Thing.FindInventory("CODJuggernog") != null)
        // {
        //     topHP = 250;
        // }else{
        //     topHP = 100;
        // }
        int hurtPlayerHealth = hurtDude.Thing.player.health;
        // Console.Printf("Gamer topHP: " .. topHP);
        // Console.Printf("Gamer's current health: " .. hurtPlayerHealth);
        if (hurtPlayerHealth > 0 && hurtPlayerHealth < topHP)
        {
            // Console.Printf("Gamer will regenerate");
            CODZombieRegenTimer timer = new("CODZombieRegenTimer");
            timer.TicsLeft = 5 * 35;
            timer.Player = hurtDude.Thing;
            timer.maxHealth = topHP;
        }
    }
}

class CODZombieRegenTimer : Thinker
{
	int TicsLeft;
	Actor Player;
    int maxHealth;

	override void Tick()
	{
		TicsLeft--;
		if ((TicsLeft <= 2 * 35) && (Level.maptime % 5 == 0) && (Player.health < maxHealth))
		{
            Player.A_GiveInventory("Health",10);
		}
		if (TicsLeft <= 0)
		{
			// Console.Printf("feeling better :)");
			Destroy();
		}
	}
}