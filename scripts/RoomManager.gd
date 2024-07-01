extends Node

var room_data: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HouseRoom.connect_exit_locked("east",$OutsideRoom )
	$HouseRoom.connect_exit_unlocked("west",$SomeOtherRoom )
	$HouseRoom.connect_exit_unlocked("north",$KitchenRoom )
	$HouseRoom.connect_exit_unlocked("south",$BedRoom )
	$HouseRoom.connect_exit_unlocked("window", $Forest, "house")

	self.room_data = {
		"house": {
			"room": $HouseRoom,
			"items": [
				{"name": "key", "type": Types.ItemTypes.KEY, "use": $OutsideRoom}
			]
		},
		"outside": {
			"room": $OutsideRoom, 
			"items": [
				{"name": "sword", "type": Types.ItemTypes.EQUIP, "use": null}
			]
		},
		"kitchen": {
			"room": $KitchenRoom, 
			"items": [
				{"name": "sword", "type": Types.ItemTypes.EQUIP, "use": null},
				{"name": "knife", "type": Types.ItemTypes.EQUIP, "use": null},
			]
		},
	}

	# note: when looping through a dictionary the for value will be the key.
	# loop through the room_data dict and save each key into room_data_key for each loop iteration
	for room_data_key in self.room_data:
		# pass the room_data_key (house/outside/kitchen) into the
		# room_data dict, and save the value to current_room
		var current_room = self.room_data[room_data_key]
		
		# pass in the key "room" to the current_room dict and 
		# save the value to room_instance
		var room_instance = current_room["room"]
		
		
		# pass in the key "items" to the current_room dict and 
		# save the value to items
		var items = current_room["items"]
		
		# note: when looping through an array the for value is the actual
		# element itself (in this case, its the actual dict).
		# loop through the items, and save each dict into item_dict for each loop iteration
		for item_dict in items:
			
			# create a new item
			var item = Item.new()
			
			# go into the item_dict and pass in the "name" key
			# to get the value and save it to item_name
			var item_name = item_dict["name"]
			
			# go into the item_dict and pass in the "type" key
			# to get the value and save it to item_type
			var item_type = item_dict["type"]
			
			var item_use = item_dict["use"]
			
			# initalize the item by passing in item_name & item_type
			item.initialize(item_name, item_type, item_use)
			
			# get the room_instance and add the item we just created
			room_instance.add_item(item)
