extends Panel

var file_path = "res://csvjson.json"

var dictionary : Dictionary = {}

func _ready():
	convert_to_dic()
	AM.play_main_theme()
	update_text()


func update_text():
	#check if has current key
	if !dictionary.has(GM.current_key):
		get_tree().change_scene("res://MainMenu.tscn")
	
	$MarginContainer/HBoxContainer/RichTextLabel.bbcode_text = dictionary[GM.current_key].text
	$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/OptionA.text = dictionary[GM.current_key].choice_a
	$MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/OptionB.text = dictionary[GM.current_key].choice_b
	pass

func _on_OptionA_pressed():
	#no key -> go to menu
	if !dictionary.has(dictionary[GM.current_key].choice_a) or !dictionary.has(dictionary[GM.current_key].choice_b):
		get_tree().change_scene("res://MainMenu.tscn")
	else:
		GM.current_key = dictionary[GM.current_key].choice_a
		GM.change_scene(dictionary[GM.current_key].level_index)

func _on_OptionB_pressed():
	#no key -> go to menu
	if !dictionary.has(dictionary[GM.current_key].choice_a) or !dictionary.has(dictionary[GM.current_key].choice_b):
		get_tree().change_scene("res://MainMenu.tscn")
	else:
		GM.current_key = dictionary[GM.current_key].choice_b
		GM.change_scene(dictionary[GM.current_key].level_index)

func convert_to_dic():
	var file = File.new()
	
	if not file.file_exists(file_path):
		return
		
	file.open(file_path, File.READ)

	var content = parse_json(file.get_as_text())
	dictionary = content
	file.close()
	
	print(dictionary)
	pass
