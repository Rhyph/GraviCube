extends Node


var files = File.new()

func save_data(content):
	files.open("user://save_game.dat", File.WRITE)
	files.store_string(to_json(content))
	files.close()

func load_data():
	files.open("user://save_game.dat", File.READ)
	var content = files.get_as_text()
	files.close()
	return parse_json(content)
