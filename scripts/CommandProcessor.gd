extends Node



var current_room = null

# this starts the game in the starting room using a function that allows you to change rooms	
func initialize(starting_room) -> String:
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
		var change_response = change_room(exit.get_other_room(current_room)) 
		return "\n".join(PackedStringArray(["You go %s." % second_word, change_response]))
		
	else:
		return "That direction leads nowhere."



# this function is what allows you to change the room you are in. It tells the players data based off the room they switched to.
func change_room(new_room : GameRoom) -> String:
	current_room = new_room
	return new_room.get_full_description()
	
	



func help():
	return "You can use these commands: go [location], help"
