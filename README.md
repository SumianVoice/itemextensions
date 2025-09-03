# Item Extensions
This API aims to provide easy high and medium level features to maximise the control developers have over itemstacks, and make it easier to use them overall. Ideally, this covers all item functionality that is standard to games in general.

## Feature Rundown
- Items can run any code on step on a wielded item
- Items know when they are selected and deselected (wielded) and selected items are deselected when dropped or on player logout
- Items can run code on any item in the inventory whether wielded or not
- Items can decide if they should be allowed to be moved from one slot to another
- Items know when they are moved
- Items know when dropped and can prevent being dropped
- Items can modify the dropped item object after it is created
- Equipment system:
    - Game can define equipment lists, where items are "active"
    - Items know when they are equipped and unequipped
    - Items can run on_step while equipped
- Control over item movement
    - Game can decide that some lists will only allow some item groups to be placed in them, e.g. for armor or backpacks
    - Same as above but for individual inventory slots

## API list
```lua
itemdef = {
    -- just started wielding
    _on_select = function(itemstack, player) end, --> return ItemStack to modify or nil
    -- just stopped wielding
    _on_deselect = function(itemstack, player) end, --> return ItemStack to modify or nil
    -- every step while wielded
    _on_step = function(itemstack, player, dtime) end, --> return ItemStack to modify or nil
    -- every step whether wielded or not
    _on_inventory_step = function(itemstack, player, dtime, list_name, list_index) end,
    -- on this item moved to another index and/or list
    _on_inventory_move_allow = function(itemstack, player, info) end, --> return 0 to cancel or num of items to allow
    -- on this item moved to another index and/or list
    --[[
        info = {
            stack = ItemStack, [to,from]_[index] = number|nil,  [to,from]_[list] = string|nil
        }
    --]]
    _on_inventory_moved = function(itemstack, player, info) end,
    -- before creating an item entity
    _on_drop = function(itemstack, player) end, --> return ==false to cancel
    -- after creating an item entity
    _on_dropped = function(itemstack, player, object) end,
    -- when in an inventory list that is registered as an equipment list (e.g. armor, accessories)
    _on_equipment_step = function(itemstack, player, dtime, list_name, list_index) end,
    -- when first moved to equipment list
    _on_equipped = function(itemstack, player, info) end, --> void
    -- when moved from equipment list
    _on_unequipped = function(itemstack, player, info) end, --> void
}

itemextensions.bind_group_to_inventory_list(item_group_name, inventory_list_name)
itemextensions.bind_group_to_inventory_slot(item_group_name, inventory_list_name, list_index)

-- Note that it is possible the stack is not in its original form by the time your callback runs on it.
-- This is the case for all of the below.
-- Callbacks are run regardless of whether the name has changed.
itemextensions.register_on_move_item("my_mod:my_item", function(itemstack, player, info) end)
itemextensions.register_on_select(function(itemstack, player) end) --> return ItemStack to modify or nil
itemextensions.register_on_deselect(function(itemstack, player) end) --> return ItemStack to modify or nil
itemextensions.register_on_wield_step(function(itemstack, player, dtime) end) --> return ItemStack to modify or nil
```
