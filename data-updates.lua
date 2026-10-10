local sprite_scale = 0.75
local scaled_sprite_definitions = {}

local function shrink_sprites(value)
	if type(value) ~= "table" or scaled_sprite_definitions[value] then
		return
	end

	scaled_sprite_definitions[value] = true

	if value.layers == nil and (value.filename or value.filenames or value.stripes) then
		value.scale = (value.scale or 1) * sprite_scale
	end

	for _, child in pairs(value) do
		if type(child) == "table" then
			shrink_sprites(child)
		end
	end
end

local visual_fields = {
	"graphics_set",
	"folded_animation",
	"preparing_animation",
	"prepared_animation",
	"prepared_alternative_animation",
	"starting_attack_animation",
	"attacking_animation",
	"energy_glow_animation",
	"resource_indicator_animation",
	"ending_attack_animation",
	"folding_animation",
	"integration",
	"integration_patch",
	"pictures"
}

local turret_prototypes = {
	{"electric-turret", "w93-beam-turret"},
	{"ammo-turret", "w93-dcannon-turret"},
	{"ammo-turret", "w93-gatling-turret"},
	{"ammo-turret", "w93-hcannon-turret"},
	{"ammo-turret", "w93-hmg-turret"},
	{"ammo-turret", "w93-lcannon-turret"},
	{"electric-turret", "w93-plaser-turret"},
	{"radar", "w93-radar-turret"},
	{"ammo-turret", "w93-rocket-turret"},
	{"electric-turret", "w93-tlaser-turret"}
}

for _, turret in ipairs(turret_prototypes) do
	for _, suffix in ipairs({"", "2"}) do
		local prototype = data.raw[turret[1]][turret[2] .. suffix]
		prototype.collision_box = {{-0.6, -0.6}, {0.6, 0.6}}
		prototype.selection_box = {{-0.9, -0.9}, {0.9, 0.9}}
		prototype.corpse = "small-remnants"
		for _, field in ipairs(visual_fields) do
			shrink_sprites(prototype[field])
		end
	end
end