extends Control

# line 4 is used to access a different scene from this one.
const InputResponse = preload("res://scenes/input_response.tscn")
const Response = preload("res://scenes/response.tscn")

@export  var max_lines_remembered  = 30

@onready var history_row : VBoxContainer = %HistoryRow 
@onready var scroll : ScrollContainer = %ScrollContainer 
@onready var scrollbar = scroll.get_v_scroll_bar()
@onready var command_processor : Node = $CommandProcessor
@onready var room_manager : Node = $RoomManager

#This function calls this as the game is being created. Placement matters for some of these things
func _ready() -> void:
	scrollbar.changed.connect(handle_scrollbar_changed)
	create_response("Thank you for booting up Nova, please enjoy.")
	var starting_room_response = command_processor.initialize(room_manager.get_child(0))
	create_response(starting_room_response)


# this function both calls the history limiter function (explained below) and creates an array but creating childing nodes of historical player commands.
func add_game_response(response: Control):
	history_row.add_child(response)
	history_limiter()


#this is so ridiculous This is used to allow us to constantly stay at the bottom of the scroll bar 
func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value


#this one is a little complicated for me
func create_response(response_text):
	var response = Response.instantiate()
	add_game_response(response)
	response.text = response_text


#this function is used to limit the amount of history that the game stores and feeds back to the player
func history_limiter():
#this is what deletes the first few lines that are stored. it uses for loop to do so.
	if history_row.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_row.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_row.get_child(i).queue_free()


#this blew my mind(bertter figure out what this does)
func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return 
	var response = command_processor.process_command(new_text)
	var input_response = InputResponse.instantiate()
	add_game_response(input_response)
	input_response.set_text(new_text, response)

