extends Node

const GAME_SCENE_PATH = "res://src/main.tscn"

var master_volume:float = 100
var music_volume:float = 100
var sfx_volume:float = 100

const GameDataPath = "user://conf.cfg"
var config:ConfigFile

var debug_build := false
var in_game:=false

var music_on:=true:
	set(v):
		music_on=v
		Logger.info("music %s" % [music_on])
		var sfx_index= AudioServer.get_bus_index("Music")
		AudioServer.set_bus_volume_db(sfx_index, -9 if music_on else -100)
	

var sound_on:=true:
	set(v):
		sound_on = v
		Logger.info("sound %s" % [sound_on])
		var sfx_index= AudioServer.get_bus_index("Sound")
		AudioServer.set_bus_volume_db(sfx_index, 0 if sound_on else -100)
	

@onready var menu_music: AudioStreamPlayer = $menu_music
@onready var game_music: AudioStreamPlayer = $game_music

func _ready():
	_init_logger()
	Logger.info("Starting menu music")
	fade_in_music(menu_music)
	

func start_game():
	in_game=true
	
	fade_music(menu_music,1)
	await get_tree().create_timer(1).timeout
	
	get_tree().change_scene_to_file(GAME_SCENE_PATH)
	fade_in_music(game_music)
	

func _init_logger():
	Logger.set_logger_level(Logger.LOG_LEVEL_INFO)
	Logger.set_logger_format(Logger.LOG_FORMAT_MORE)
	var console_appender:Appender = Logger.add_appender(ConsoleAppender.new())
	console_appender.logger_format=Logger.LOG_FORMAT_FULL
	console_appender.logger_level = Logger.LOG_LEVEL_INFO
	var file_appender:Appender = Logger.add_appender(FileAppender.new("res://debug.log"))
	file_appender.logger_format=Logger.LOG_FORMAT_FULL
	file_appender.logger_level = Logger.LOG_LEVEL_DEBUG
	Logger.info("Logger initialized.")


func play_music(node:AudioStreamPlayer):
	if not node.playing:
		node.volume_db = -9
		node.play()
	

func fade_in_music(node:AudioStreamPlayer, duration := 1):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	node.volume_db=-20
	node.play()
	tween.tween_property(node,"volume_db",0 , duration)
	

func fade_music(node:AudioStreamPlayer, duration := 1):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(node,"volume_db",-20 , duration)
	await tween.finished
	node.stop()
	
