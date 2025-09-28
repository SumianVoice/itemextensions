---@diagnostic disable: undefined-global

local has_playerphysics = core.get_modpath("playerphysics")
core.register_tool("itemextensions:test", {
	description = "itemextensions:test",
	groups = { combat = 2, not_in_creative_inventory = 1 },

	_on_select = function(stack, player)
		if has_playerphysics then
			playerphysics.add_physics_factor(player, "gravity", "itemextensions:test", 0.5)
			playerphysics.add_physics_factor(player, "speed", "itemextensions:test", 1.5)
		end
	end,
	_on_deselect = function(stack, player)
		if has_playerphysics then
			playerphysics.remove_physics_factor(player, "gravity", "itemextensions:test")
			playerphysics.remove_physics_factor(player, "speed", "itemextensions:test")
		end
		return ItemStack("itemextensions:test 1 "..math.random(20, 50000))
	end,
	_on_step = function(stack, player, dtime)
		local vel_y = player:get_velocity().y
		player:add_velocity(vector.new(0, math.max(vel_y * -0.05, 0), 0))
		core.log("tick")
		return ItemStack("itemextensions:test 1 "..math.random(59000, 60000))
	end,
	-- every step whether wielded or not
	_on_inventory_step = function(itemstack, player, dtime, list_name, list_index) end,
	-- on this item moved to another index and/or list
	_on_inventory_move = function(itemstack, player, from_list, to_list, from_index, to_index) end, --> return ==false to cancel
	-- before creating an item entity
	_on_drop = function(itemstack, player)
		--
	end, --> return ==false to cancel
	-- after creating an item entity
	_on_dropped = function(itemstack, player, object) end,
})
