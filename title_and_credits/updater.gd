extends Label

@export var exe_link := ""
@export var version_link := ""

var exe_path
var version_path := "user://DungeonGame/Version.txt"

var state = "starting"

## Not my code because i'm not a network guy

var http_request: HTTPRequest

func _ready():
	exe_path = OS.get_executable_path()
	$Label.text = exe_path
	_verify_gamefiles()
	self.text = "        Checking for updates"

func file_exists(path: String) -> bool:
	var dir = DirAccess.open(path)
	return dir.file_exists(path)


func _verify_gamefiles():
	if file_exists(exe_path) && file_exists(version_path):
		_download_file(version_link, version_path, true)
	else:
		_check_integrity()


func _download_file(link: String, path: String, just_version: bool):
	http_request = HTTPRequest.new()
	add_child(http_request)
	
	self.text = "Downloading " + str(path.get_file())
	http_request.request_completed.connect(self._install_file(http_request.body ,path, just_version))
	
	
	var error = http_request.request_raw(link)
	if error != OK:
		self.text = "Download Error: " + str(error)


func _install_file(body, path, just_version:bool):
	print(just_version)
	if just_version:
		var new_version = str(body.get_string_from_utf8())
		_compare_version(new_version)
		return
		
	var dir = DirAccess.open(path)
	dir.remove((path))
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_buffer(body)
	file.close()
	_check_integrity()


func _check_integrity():
	if !file_exists(version_path):
		_download_file(version_link, version_path, false)
		self.text = "           Updating launcher"
		print("downloading version")
		return
	
	if !file_exists(exe_path):
		_download_file(exe_link, exe_path, false)
		self.text = "           Updating launcher"
		print("downloading exe")
		return
		
	OS.shell_open(OS.get_user_data_dir() + "/Roguelite launcher.exe")
	get_tree().quit()

	


func _compare_version(new_version):
	var file = FileAccess.open(version_path, FileAccess.READ)
	var cur_version = file.get_as_text();
	file.close()
	if int(new_version) > int(cur_version):
		var dir = DirAccess.open(version_path)
		dir.remove(version_path)
		var dir1 = DirAccess.open(exe_path)
		dir.remove(exe_path)
	_check_integrity()
