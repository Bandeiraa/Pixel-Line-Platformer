extends Control

func play():
	var _change_scene = get_tree().change_scene("res://scenes/management/level.tscn")


func quit():
	get_tree().quit()
