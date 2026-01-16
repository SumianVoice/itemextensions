
local core_get_node_drops = core.get_node_drops
rawset(core, "get_node_drops", function(node, toolname, ...)
	local ndef = core.registered_nodes[node.name]
	if ndef and (ndef._get_node_drops) then
		return ndef._get_node_drops(node, toolname, ...)
	else
		return core_get_node_drops(node, toolname, ...)
	end
end)
