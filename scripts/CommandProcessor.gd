extends Node



var current_room = null
var hero = null

# this starts the game in the starting room using a function that allows you to change rooms	
func initialize(starting_room, hero) -> String:
	self.hero = hero
	return change_room(starting_room)

# this function processes the user commands. It takes in a string and converts it to an array and then processes each element
func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: No words were parsed."

	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()

	match first_word:
		"go","g":
			return go(second_word)
		"take","grab":
			return pick_up(second_word)
		"inventory","i","list":
			return hero.inventory_name()
		"drop","d":
			return drop_item(second_word)
		"use","u":
			return use_key(second_word)
		"help","h":
			return help()
		_:
			return "Unrecognized command - Please try again."

# this function is used to tell the player where they decided to go based off of the string they entered. This function is called in the process function
func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
		
	if current_room.exits_dic.keys().has(second_word):
		var exit = current_room.exits_dic[second_word]# ###### ASK AMADO ######
		if exit.is_locked:
			return "No good, its locked."
		var change_response = change_room(exit.get_other_room(current_room)) 
		return "\n".join(PackedStringArray(["You go %s." % second_word, change_response]))
		
	else:
		return "That direction leads nowhere."


func use_key(second_word: String) -> String:
	if second_word == "":
		return "Use what?"
	for item in hero.inventory:
		if second_word.to_lower() == item.item_name:
			for exit in current_room.exits_dic.values():
				if item.item_use == exit.room_2:
					exit.is_locked = false
					hero.remove_inventory(item)
					return "Door unlocked"
			
	return "that didnt work"


func pick_up(second_word : String) -> String:
	if second_word == "":
		return "What would you like to take?"

	for item in current_room.room_items_arr:
		if second_word.to_lower() == item.item_name:
			current_room.remove_item(item)
			hero.pickup_item(item)
			return "You took the %s" % second_word

	for dup_item in hero.inventory:
		if second_word.to_lower() == dup_item.item_name:
			return "you've already picked up the %s" % second_word
			
	return "I do not see the %s" % second_word + " you are looking for."


func drop_item(second_word : String) -> String:
	if hero.inventory.size() == 0:
		return "You can't drop what you don't have. You currently do not have anything in your pocket."

	for item in hero.inventory:
		if second_word.to_lower() == item.item_name:
			hero.remove_inventory(item)
			current_room.add_item(item)
			return "You've dropped %s" % second_word
	return "words"

# this function is what allows you to change the room you are in. It tells the players data based off the room they switched to.
func change_room(new_room : GameRoom) -> String:
	current_room = new_room
	return new_room.get_full_description()


func help():
	return "You can use these commands: go [location], help, take [item], inventory, drop [item]"
