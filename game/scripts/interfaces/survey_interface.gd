extends "res://game/scripts/interfaces/interface.gd"

onready var progress_bar = $Panel/ProgressBar
onready var question_label = $Panel/QuestionLabel
onready var do_not_know_label = $Panel/Answers/DoNotKnowPanel/Label
onready var do_not_know_button = $Panel/Answers/DoNotKnowPanel/Button
onready var interface_switch = $"%InterfaceSwitch"
onready var result_interface = $"%Result"
onready var tween = $Tween


func _ready():
	var _error = Survey.connect("finished", self, "_on_finished")
	Survey.start()
	progress_bar.max_value = len(Survey.data.QUESTIONS)
	update_data()


func update_data():
	var question = Survey.get_next_question()
	question_label.text = question.question
	tween.interpolate_property(progress_bar, "value",
			progress_bar.value, Survey.current_survey.passed, 0.25,
			Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()

	progress_bar.value = Survey.current_survey.passed


func _on_restart():
	Survey.start()
	update_data()


func _on_yes():
	Survey.vote(Survey.YES)
	update_data()


func _on_no():
	Survey.vote(Survey.NO)
	update_data()


func _on_more_likely_yes():
	Survey.vote(Survey.MORE_LIKELY_YES)
	update_data()


func _on_more_likely_no():
	Survey.vote(Survey.MORE_LIKELY_NO)
	update_data()


func _on_do_not_know():
	Survey.vote(Survey.DO_NOT_KNOW)
	update_data()


func _on_finished(result):
	result_interface.set_character(result)
	interface_switch.set_visible_interface("Result")
