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
signal request_location_change(target: Types.Locations)

@warning_ignore("unused_signal")
signal family_tree_complete
