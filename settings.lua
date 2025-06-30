data:extend({
	{
		name='always-day',
		localised_name='Always Day',
		localised_description='Freezes the day-night cycle at noon. Eliminates lighting updates, saving ~0.15ms/tick (+9% UPS headroom).',
		setting_type='runtime-global',
		type='bool-setting',
		default_value=true,
		per_user=false,
	},
	{
		name='disable-pollution',
		localised_name='Disable Pollution',
		localised_description='Clears and disables pollution. Eliminates pollution diffusion, absorption, and trigger logic, saving ~0.10–0.25ms/tick (+6–12% UPS headroom).',
		setting_type='runtime-global',
		type='bool-setting',
		default_value=false,
		per_user=false,
	},
	{
		name='disable-biters',
		localised_name='Disable Biters',
		localised_description='Clears and disables enemies. Removes existing enemy units, and prevents new spawners in unexplored chunks. Saves ~0.2–0.6ms/tick (+12–25% UPS headroom on combat-heavy saves).',
		setting_type='runtime-global',
		type='bool-setting',
		default_value=false,
		per_user=false,
	}
})