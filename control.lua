-- always day
local daytime_setting=1
local function apply_daytime_setting()
	local freeze=settings.global['always-day'].value
	game.surfaces[1].always_day=freeze
	game.print('Daylight cycle '..(freeze and'frozen at noon.'or'resumed.'))
end
-- setting handlers
local function apply_all_settings()
	apply_daytime_setting()
end
script.on_init(apply_all_settings)
script.on_configuration_changed(apply_all_settings)
-- live update when the player toggles a setting
script.on_event(defines.events.on_runtime_mod_setting_changed,function(event)
	if event.setting=='always-day'then
		apply_daytime_setting()
	end
end)