@tool
extends PanelContainer
class_name GameRoom

@export  var room_name : String = "" : set = _set_room_name
@export_multiline  var room_desc : String = "" : set = _set_room_desc


var exits_dic: Dictionary = {}
var room_items_arr: Array = []

# function created for internal tool 
func _set_room_name(new_name : String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name

# function created for internal tool 
func _set_room_desc(new_desc : String):
	$MarginContainer/Rows/RoomDescription.text = new_desc
	room_desc = new_desc


func add_item(item: Item):
	room_items_arr.append(item)



func get_full_description() -> String:
		
	print_items()
	print_exits()
	return get_room_description()

#these are for the different types of room descriptions.
func get_room_description():
	return "You are in: " + room_name + "\nIt is " + room_desc


func print_items():
	if room_items_arr.size() == 0:
		print("no items")
	else:
		var item_string = ""
		for item in room_items_arr:
			item_string += item.item_name + ", "
		print("items: " , item_string)


func print_exits():
	print("\n".join(PackedStringArray(exits_dic.keys())))


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
