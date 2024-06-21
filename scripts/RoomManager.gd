extends Node

var room_items: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HouseRoom.connect_exit("east",$OutsideRoom )
	$HouseRoom.connect_exit("west",$SomeOtherRoom )
	$HouseRoom.connect_exit("north",$KitchenRoom )
	$HouseRoom.connect_exit("south",$BedRoom )

	self.room_items = {
		"house": {
			"room": $HouseRoom, 
			"items": [
				{"name": "vase", "type": Types.ItemTypes.KEY}
			]
		},
		"outside": {
			"room": $OutsideRoom, 
			"items": [
				{ "name": "key", "type": Types.ItemTypes.KEY}
			]
		},
		"kitchen": {
			"room": $KitchenRoom, 
			"items": [
				{"name": "sword", "type": Types.ItemTypes.EQUIP}
			]
		},
	}

	for room in self.room_items:
		var room_data = self.room_items[room]

		for item_data in room_data["items"]:
			var item = Item.new()
			item.initialize(item_data["name"], item_data["type"])
			room_data["room"].add_item(item)
