class GreenArmor35 : GreenArmor replaces GreenArmor
{
    Default
    {
		Tag "Security Armor";
        Inventory.PickupMessage "Picked up the Security Armor. (35% DT)" ;
        Armor.SavePercent 35;
    }
}

class BlueArmor50 : BlueArmor
{
    Default
    {
		Tag "Combat Armor";
       //$Category Health and Armor
        Inventory.PickupMessage "Picked up the Combat Armor" ;
    }
}

class GreenArmorSmall : BasicArmorPickup
{
    Default
    {
		Tag "Light Security Armor";
       //$Category Health and Armor
        Radius 20;
        Height 16;
        Inventory.PickupMessage "Picked up the Light Security Armor. (35% DT)" ;
        Inventory.Icon "ARM3A0";
        Armor.SavePercent 35;
        Armor.SaveAmount 50;
    }
    States
    {
        Spawn:
            ARM3 A 6;
            ARM3 B 7 Bright;
            Loop;
    }
}

class BlueArmorSmall : BasicArmorPickup
{
    Default
    {
		Tag "Light Combat Armor";
       //$Category Health and Armor
        Radius 20;
        Height 16;
        Inventory.PickupMessage "Picked up the Light Combat Armor. (50% DT)" ;
        Inventory.Icon "ARM4A0";
        Armor.SavePercent 50;
        Armor.SaveAmount 50;
    }
    States
    {
        Spawn:
            ARM4 A 6;
            ARM4 B 7 Bright;
            Loop;
    }
}

class RedArmor : BasicArmorPickup
{
    Default
    {
		Tag "Advanced Armor";
        //$Category Health and Armor
        Radius 20;
        Height 16;
        Inventory.PickupMessage "Picked up the Advanced Armor. (75% DT)" ;
        Inventory.Icon "ARM5A0";
        Armor.SavePercent 75;
        Armor.SaveAmount 200;
    }
    States
    {
        Spawn:
            ARM5 A 6;
            ARM5 B 7 Bright;
            Loop;
    }
}

class RedArmorSmall : BasicArmorPickup
{
    Default
    {
		Tag "Light Advanced Armor";
        //$Category Health and Armor
        Radius 20;
        Height 16;
        Inventory.PickupMessage "Picked up the Light Advanced Armor.(75% DT)" ;
        Inventory.Icon "ARM6A0";
        Armor.SavePercent 75;
        Armor.SaveAmount 100;
    }
    States
    {
        Spawn:
            ARM6 A 6;
            ARM6 B 7 Bright;
            Loop;
    }
}

class EnchantedArmor : BasicArmorPickup
{
    Default
    {
		Tag "Enchanted Armor";
       //$Category Health and Armor
        Radius 20;
        Height 16;
        Inventory.PickupMessage "Behold! You picked up the Enchanted Armor! (100% DT)" ;
        Inventory.Icon "ARM7A0";
        Armor.SavePercent 100;
        Armor.SaveAmount 200;
    }
    States
    {
        Spawn:
            ARM7 A 6;
            ARM7 B 7 Bright;
            Loop;
    }
}

class  HalfHeal : Health
{
    Default
    {
		Tag "Surgery Kit";
       //$Category Health and Armor
        Inventory.Amount 50;
        Inventory.PickupMessage "Picked up a Surgery Kit. (50% HP)";
        Health.LowMessage 25, "Picked up an Surgery Kit that you REALLY need! (50% HP)";
    }
    States
    {
        Spawn:
            HHEL A -1;
            Stop;
    }
}

class  FullHeal : Health
{
    Default
    {
		Tag "Full Recovery Kit";
       //$Category Health and Armor
        Inventory.Amount 100;
        Inventory.PickupMessage "Picked up a Full Recovery Kit.(100% HP)";
        Health.LowMessage 25, "Picked up an Full Recovery Kit that you REALLY need! (100% HP)";
    }
    States
    {
        Spawn:
            FHEL A -1;
            Stop;
    }
}

class  W3DFood : Health
{
    Default
    {
		Tag "Hot Meal";
       //$Category Health and Armor
        Inventory.Amount 10;
        Inventory.PickupMessage "You ate a Hot Meal.";
        Health.LowMessage 25, "You ate some nutritious food that will keep you alive!";
    }
    States
    {
        Spawn:
            W3FD A -1;
            Stop;
    }
}

class W3DDogFood: Health
{
    Default
    {
        Tag "Dog Food";
        //$Category Health and Armor
        Inventory.Amount 5;
        Inventory.PickupMessage "Ate some dog food." ;
    }
    States
    {
        Spawn:
            W3DF A -11;
            Loop;
    }
}