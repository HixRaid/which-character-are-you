extends Control

const BACK = "Back"

export var open_interface = ""

var story = []
var interfaces = {}


func _ready():
	var children = get_children()
	for i in children:
		i.set_visibility(i.name ==  open_interface)
		interfaces.merge({i.name: i})
	
	story.append(open_interface)


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		set_visible_interface(BACK)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		set_visible_interface(BACK)


func set_visible_interface(name):
	if name == open_interface:
		return
	
	if story.has(name) and interfaces.has(name):
		story = story.slice(0, story.find(name))
	elif name == BACK and len(story) > 1:
		story = story.slice(0, len(story) - 2)
	elif interfaces.has(name):
		story.append(name)
	else:
		return
	
	interfaces[open_interface].set_visibility(false)
	open_interface = story[len(story) - 1]
	interfaces[open_interface].set_visibility(true)
