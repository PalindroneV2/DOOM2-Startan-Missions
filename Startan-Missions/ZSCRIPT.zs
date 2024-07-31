version "4.8.2"

#include "zscript/actors/doom_extra_dead.zs"
#include "zscript/actors/doom_extra_enemies.zs"
#include "zscript/actors/doom_weapons_norandom.zs"
#include "zscript/actors/W3DNPCS.zs"
#include "zscript/actors/W3DDECO.zs"
#include "zscript/actors/NewMonsters.zs"
#include "zscript/actors/SecretWeapons.zs"
#include "zscript/actors/HealthArmor.zs"
#include "zscript/actors/PowerUps.zs"
#include "zscript/actors/HereticPort.zs"
#include "zscript/actors/SMVehicles.zs"

class DoomPlayerNew : DoomPlayer replaces DoomPlayer
{
    Default
    {
        Player.StartItem    "Handgun";
        Player.StartItem    "DoomFist";
        Player.StartItem    "Clip", 50;
    }
}