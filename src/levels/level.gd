extends Node2D

export var ambience := "ambience"
export var song := ""


func _ready():
	Music.play_music(song)
	Music.play_ambience(ambience)
