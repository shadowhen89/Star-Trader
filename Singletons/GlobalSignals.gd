extends Node

signal annouce_state(message)
signal annouce(message)
signal toggle_music(playing)
signal toggle_sound(playing)

func annouce_state_message(message: String):
	emit_signal("annouce_state", message)

func annouce_message(message: String):
	emit_signal("annouce", message)
