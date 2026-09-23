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