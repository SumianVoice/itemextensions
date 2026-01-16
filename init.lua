local mod_name = core.get_current_modname()
local mod_path = core.get_modpath(mod_name)

itemextensions = {}

itemextensions._playerdata = {}
function itemextensions.pi(player)
	if not core.is_player(player) then return nil end
	local pi = itemextensions._playerdata[player]
	if not pi then pi = {}; itemextensions._playerdata[player] = pi end
	return pi
end

dofile(mod_path .. "/scripts/equipment.lua")
dofile(mod_path .. "/scripts/move_item.lua")
dofile(mod_path .. "/scripts/wieldevents.lua")
dofile(mod_path .. "/scripts/node_drops.lua")
