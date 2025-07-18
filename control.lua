-- always day
local function apply_always_day_setting(enabled)
	game.surfaces[1].always_day=enabled
end
-- disable pollution
local function apply_disable_pollution_setting(enabled)
	if enabled then game.surfaces[1].clear_pollution()end
	game.map_settings.pollution.enabled=not enabled
end
-- disable biters
local function clear_all_biters()
	for _,enemy in pairs(game.surfaces[1].find_entities_filtered{force='enemy'})do enemy.destroy()end
	for _,player in pairs(game.connected_players)do player.force.chart_all()end
end
local function apply_disable_biters_setting(enabled)
	if enabled then clear_all_biters()end
end
-- destroy decoratives
local function destroy_all_decoratives_on_surface(surface)
	for chunk in surface.get_chunks()do
		if surface.is_chunk_generated(chunk)then
			local area={
				{chunk.x*32,chunk.y*32},
				{(chunk.x+1)*32,(chunk.y+1)*32}
			}
			surface.destroy_decoratives{area=area}
		end
	end
end
--
script.on_event(defines.events.on_chunk_generated,function(event)
	if not settings.global['disable-biters'].value then return end
	for _,enemy in pairs(event.surface.find_entities_filtered{area=event.area,force='enemy',type={'unit-spawner','turret'}})do enemy.destroy()end
	event.surface.destroy_decoratives({area=event.area})
end)
local function apply_all_settings()
	apply_always_day_setting(settings.global['always-day'].value)
	apply_disable_pollution_setting(settings.global['disable-pollution'].value)
	apply_disable_biters_setting(settings.global['disable-biters'].value)
end
local function apply_static_optimisations()
	for _,surface in pairs(game.surfaces)do destroy_all_decoratives_on_surface(surface)end
end
script.on_init(function()
	apply_all_settings()
	apply_static_optimisations()
end)
script.on_configuration_changed(function()
	apply_all_settings()
	apply_static_optimisations()
end)
-- live update when the player toggles a setting
script.on_event(defines.events.on_runtime_mod_setting_changed,function(event)
	if event.setting=='always-day'then
		apply_always_day_setting(settings.global['always-day'].value)
		game.print('Daylight cycle '..(settings.global['always-day'].value and'frozen at noon.'or'resumed.'))
	elseif event.setting=='disable-pollution'then
		apply_disable_pollution_setting(settings.global['disable-pollution'].value)
		game.print('Pollution '..(settings.global['disable-pollution'].value and'cleared and disabled.'or're-enabled.'))
	elseif event.setting=='disable-biters'then
		apply_disable_biters_setting(settings.global['disable-biters'].value)
		game.print('Biters '..(settings.global['disable-biters'].value and'cleared and disabled.'or're-enabled.'))
	end
end)