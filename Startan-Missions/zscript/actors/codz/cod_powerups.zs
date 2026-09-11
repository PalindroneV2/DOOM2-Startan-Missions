class Default_CODPowerup : CustomInventory
{
    int powerupLifeTime;
    Default
    {
        Tag "Power Up";
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
        Inventory.Icon "PUPGA0";
        Inventory.AltHUDIcon "PUPGA0";
        Inventory.PickupMessage "Fucking Nothing!";
		Inventory.PickupSound "misc/p_pkup";
       //$Category Powerups
    }
    States
    {
        Spawn:
            PUPG AB 2 BRIGHT;
            Loop;
        Pickup:
            TNT1 A 0;
            Stop;
    }
    override void PostBeginPlay()
    {
        Super.PostBeginPlay();

        powerupLifeTime = 30 * 35;
    }
    override void Tick()
    {
        Super.Tick();

        if (powerupLifeTime > 0)
        {
            powerupLifeTime--;

            if (powerupLifeTime <= 0)
            {
                Destroy();
                return;
            }
        }
    }
}

class MaxAmmo_Powerup : Default_CODPowerup
{
    Default
    {
        Tag "Max Ammo Power Up";
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
        Inventory.Icon "MXAMA0";
        Inventory.AltHUDIcon "MXAMA0";
        Inventory.PickupMessage "MAX AMMO!";
		Inventory.PickupSound "misc/p_pkup";
       //$Category Powerups
    }
    States
    {
        Spawn:
            MXAM CD 2 BRIGHT;
            Loop;
        Pickup:
            TNT1 A 0 A_MaxAmmoPickup;
            Stop;
    }

    action void A_MaxAmmoPickup()
    {
        A_GiveInventory("Clip", 400);
        A_GiveInventory("Shell", 100);
        A_GiveInventory("RocketAmmo", 100);
        A_GiveInventory("Cell", 600);
        A_GiveInventory("RifleBullets", 80);
    }
}

class Armor_CODPowerUp : Default_CODPowerup
{
    Default
    {
        Tag "Max Armor Power Up";
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
        Inventory.Icon "ARMPA0";
        Inventory.AltHUDIcon "ARMPA0";
        Inventory.PickupMessage "MAX ARMOR!";
		Inventory.PickupSound "misc/p_pkup";
       //$Category Powerups
    }
    States
    {
        Spawn:
            ARMP AB 2 BRIGHT;
            Loop;
        Pickup:
            TNT1 A 0 A_ArmorCODPickup;
            Stop;
    }

    action void A_ArmorCODPickup()
    {
        A_GiveInventory("EnchantedArmor", 1);
    }
}

class Berserk_CODPowerUp : Default_CODPowerup
{
    Default
    {
        Tag "Berserk Power Up";
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
        Inventory.Icon "BSKPA0";
        Inventory.AltHUDIcon "BSKPA0";
        Inventory.PickupMessage "BERSERK!";
		Inventory.PickupSound "misc/p_pkup";
       //$Category Powerups
    }
    States
    {
        Spawn:
            BSKP ABAB 2 BRIGHT;
            Loop;
        Pickup:
            TNT1 A 0 A_ArmorCODPickup;
            Stop;
    }

    action void A_ArmorCODPickup()
    {
        A_GiveInventory("NewBerserk", 1);
    }
}

class Nuke_CODPowerUp : Default_CODPowerup
{
    Default
    {
        Tag "Nuke Power Up";
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
        Inventory.Icon "FATMAN00";
        Inventory.AltHUDIcon "FATMAN00";
        Inventory.PickupMessage "NUKE!";
        Inventory.PickupSound "weapons/rocklx";
    }
    States
    {
        Spawn:
            NUKP ABAB 2 BRIGHT;
            Loop;
        Pickup:
            TNT1 A 0 A_CODNukeKaboom();
            MISL B 8 Bright;
            MISL C 6 Bright;
            MISL D 4 Bright;
            Stop;
    }
    action void A_CODNukeKaboom()
    {
        let iterator = ThinkerIterator.Create("Actor");

        Actor actor;

        while (actor = Actor(iterator.Next()))
        {
            if (actor == null)
                continue;

            if (actor.bIsMonster && actor.bShootable)
            {
                actor.DamageMobj(self, self, 1000000, 'Nuke');
            }
        }
    }
}

class KillingTime_CODPowerup : Default_CODPowerup
{
    Default
    {
        Tag "Killing Time Power Up";
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
        Inventory.PickupMessage "Killing Time! Time Stops!";
		Inventory.PickupSound "misc/p_pkup";
       //$Category Powerups
    }
    States
    {
        Spawn:
            KILT ABAB 2 BRIGHT;
            Loop;
        Pickup:
            TNT1 A 0 A_KillingTimeStopTime;
            Stop;
    }
    action void A_KillingTimeStopTime()
    {
        A_GiveInventory("KillTimeStopTime",1);
    }
}

class KillTimeStopTime : TimeStopPower
{
    Default
    {
        Inventory.PickupMessage "Time stopped!";
        Inventory.Icon "KILLTIME";      // optional (make a graphic or remove this line)
        Powerup.Duration -10;            // seconds (negative value => seconds)
        // You can tweak these for audiovisual flair:
        Powerup.Color "GoldMap",0.25; // subtle blue tint (remove if undesired)
        // Powerup.Mode "TimeFreezer";       // not strictly needed; class already does it
    }
}