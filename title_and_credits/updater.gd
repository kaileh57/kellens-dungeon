extends Node2D

@export var exe_link := ""
@export var ver_link := ""

var exe_path
var ver_path := "user://DungeonGame/Version.txt"

var state = "starting"

var http = HTTPRequest

func _ready():
	exe_path = OS.get_executable_path()
	$Label.text = exe_path


func file_exists(path: String) -> bool:
	var file = FileAccess
	return file.file_exists(path)

func download_file(link: String, path: String):
	http = HTTPRequest.new()
	add_child(http)
	
	var error = http.request_raw(link)
	if error != OK:
		update_state("failed")

func update_state(_state: String):
	if state != "failed":
		state = _state
		$Sprite2D.play(_state)

func check_version():
	update_state("checking")
	
