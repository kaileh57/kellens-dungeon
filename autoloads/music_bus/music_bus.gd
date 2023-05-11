extends Node

###This script manages the music bus, play music to it with the $"/root/MusicBus".play(preload("PATH/TO/MUSIC")) function

@onready var mplayer = $AudioStreamPlayer

func _ready():
	$"/root/Debug".debug_print("audio bus ready")
	
	#test sound (cringe)
	#play(preload("res://sounds/music/Test sound.mp3"))

func play(audio_stream: AudioStream):#plays the requested sound on the music bus
	mplayer.stream = audio_stream
	mplayer.play()
