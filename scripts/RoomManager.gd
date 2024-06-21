extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var key = Item.new()
	key.initialize("house key", Types.ItemTypes.KEY)
	
	$HouseRoom.connect_exit("east",$OutsideRoom )
	$HouseRoom.connect_exit("west",$SomeOtherRoom )
	$HouseRoom.connect_exit("north",$KitchenRoom )
	$HouseRoom.connect_exit("south",$BedRoom )
	$HouseRoom.add_item(key)
