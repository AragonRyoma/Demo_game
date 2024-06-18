@tool
extends PanelContainer
class_name GameRoom

@export  var room_name : String = "" : set = _set_room_name
@export_multiline  var room_desc : String = "" : set = _set_room_desc


var exits_dic: Dictionary = {
}
# function created for internal tool 
func _set_room_name(new_name : String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name

# function created for internal tool 
func _set_room_desc(new_desc : String):
	$MarginContainer/Rows/RoomDescription.text = new_desc
	room_desc = new_desc


func connect_exit(direction, room):
	var exit = Exit.new()
	exit.room_1 = self
	exit.room_2 = room
	exits_dic[direction] = exit
	match direction:
		"west","w":
			room.exits_dic["east"] = exit
		"east","e":
			room.exits_dic["west"] = exit
		"north","n":
			room.exits_dic["south"] = exit
		"south","s":
			room.exits_dic["north"] = exit
		_:
			printerr("This direction leads nowhere.")
