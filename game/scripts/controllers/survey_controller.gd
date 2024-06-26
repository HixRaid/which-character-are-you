extends Node

onready var progress_bar = $"../Panel/ProgressBar"
onready var question_label = $"../Panel/QuestionLabel"
onready var do_not_know_counter_label = $"../Panel/AnswersPanel/DoNotKnowPanel/CounterLabel"
onready var do_not_know_button = $"../Panel/AnswersPanel/DoNotKnowPanel/DoNotKnowButton"
onready var restart_button = $"../Panel/RestartButton"
onready var interface_switch = $"%InterfaceSwitch"
onready var result_controller = $"%ResultController"
onready var tween = $Tween


func _ready():
	var _error = Survey.connect("finished", self, "_on_finished")
	_error = Survey.connect("updated", self, "_on_updated")
	Survey.start()
	progress_bar.max_value = len(Survey.data.QUESTIONS)


func _on_updated(fast):
	var question = Survey.get_next_question()
	question_label.text = question.key
	
	if fast:
		progress_bar.value = Survey.current_survey.passed
	else:
		tween.interpolate_property(progress_bar, "value",
				progress_bar.value, Survey.current_survey.passed, 0.25,
				Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	
	progress_bar.value = Survey.current_survey.passed
	
	restart_button.set_disabled(Survey.current_survey.passed == 0)
	
	do_not_know_button.disabled =  Survey.current_survey.do_not_know == Survey.current_survey.max_do_not_know
	do_not_know_counter_label.text = str(Survey.current_survey.do_not_know) + "/" + str(Survey.current_survey.max_do_not_know)


func _on_restart():
	Survey.start()


func _on_yes():
	Survey.vote(Survey.YES)


func _on_no():
	Survey.vote(Survey.NO)


func _on_more_likely_yes():
	Survey.vote(Survey.MORE_LIKELY_YES)


func _on_more_likely_no():
	Survey.vote(Survey.MORE_LIKELY_NO)


func _on_do_not_know():
	Survey.vote(Survey.DO_NOT_KNOW)


func _on_finished(result):
	result_controller.set_character(result)
	interface_switch.set_visible_interface("Result")


func _on_interface_set_visible(value):
	if !value:
		return
	
	if Survey.is_finished:
		Survey.start()
