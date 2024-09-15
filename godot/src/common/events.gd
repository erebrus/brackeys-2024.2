extends Node


@warning_ignore("unused_signal")
signal character_name_unset(character: Character)
@warning_ignore("unused_signal")
signal character_name_set(character: Character)

@warning_ignore("unused_signal")
signal character_portrait_unset(character: Character)
@warning_ignore("unused_signal")
signal character_portrait_set(character: Character)

@warning_ignore("unused_signal")
signal time_changed(day: int, time: int)
@warning_ignore("unused_signal")
signal day_changed(day:int)
@warning_ignore("unused_signal")
signal day_ended

@warning_ignore("unused_signal")
signal request_location_change(target: Types.Locations)

@warning_ignore("unused_signal")
signal dialogue_started()
@warning_ignore("unused_signal")
signal dialogue_finished()

@warning_ignore("unused_signal")
signal family_tree_complete
@warning_ignore("unused_signal")
signal family_tree_requested()

@warning_ignore("unused_signal")
signal show_tootip(locaation: Types.Locations)
@warning_ignore("unused_signal")
signal hide_tooltip
