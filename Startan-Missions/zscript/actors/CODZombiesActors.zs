#include "zscript/actors/codz/cod_powerups.zs"
#include "zscript/actors/codz/cod_perks.zs"
#include "zscript/actors/codz/packapunch.zs"
#include "zscript/actors/codz/teddy.zs"

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
        int topHP = 100;
        if (hurtDude.Thing.FindInventory("Perk_Juggernog",false) != null)
        {
            // Console.Printf("Found");
            topHP = 250;
        }else{
            // Console.Printf("NOT FOUND");
            topHP = 100;
        }
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
            if (maxHealth == 250)
            {
                Player.A_GiveInventory("Health",25);
            }else{
                Player.A_GiveInventory("Health",10);
            }
		}
		if (TicsLeft <= 0)
		{
			// Console.Printf("feeling better :)");
			Destroy();
		}
	}
}