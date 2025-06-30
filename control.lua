-- always day
local daytime_setting=1
local function apply_always_day_setting()
	local enabled=settings.global['always-day'].value
	game.surfaces[1].always_day=enabled
	game.print('Daylight cycle '..(enabled and'frozen at noon.'or'resumed.'))
end
-- disable pollution
local function apply_disable_pollution_setting()
	local enabled=settings.global['disable-pollution'].value
	if enabled then game.surfaces[1].clear_pollution()end
	game.map_settings.pollution.enabled=not enabled
	game.print('Pollution '..(enabled and'cleared and disabled.'or're-enabled.'))
end
--disable biters
local function clear_all_biters()
	for _,enemy in pairs(game.surfaces[1].find_entities_filtered{force='enemy'})do
		enemy.destroy()
	end
	game.players[1].force.chart_all()
end
local function apply_disable_biters_setting()
	local enabled=settings.global['disable-biters'].value
	game.print('Biters '..(enabled and'cleared and disabled.'or're-enabled.'))
	if enabled then
		clear_all_biters()
	end
end
--
script.on_event(defines.events.on_chunk_generated,function(event)
	if not settings.global['disable-biters'].value then return end
	for _,entity in pairs(event.surface.find_entities_filtered{area=event.area,force='enemy',type={'unit-spawner','turret'}})do
		entity.destroy()
	end
end)
local function apply_all_settings()
	apply_always_day_setting()
	apply_disable_pollution_setting()
	apply_disable_biters_setting()
end
script.on_init(apply_all_settings)
script.on_configuration_changed(apply_all_settings)
-- live update when the player toggles a setting
script.on_event(defines.events.on_runtime_mod_setting_changed,function(event)
	if event.setting=='always-day'then
		apply_always_day_setting()
	elseif event.setting=='disable-pollution'then
		apply_disable_pollution_setting()
	elseif event.setting=='disable-biters'then
		apply_disable_biters_setting()
	end
end)