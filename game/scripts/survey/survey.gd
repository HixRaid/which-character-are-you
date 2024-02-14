extends Node

signal finished()

enum {
	YES = 1,
	NO = 2,
	MORE_LIKELY_YES = 3,
	MORE_LIKELY_NO = 4,
	DO_NOT_KNOW = 5
}

var current_survey = {
	"traits": [],
	"passed": 0
}

onready var data = $Data


func start():
	current_survey.traits.clear()
	current_survey.passed = 0
	
	for i in data.TRAITS:
		current_survey.traits.append({
			"name": i,
			"value": 0,
			"count": 0,
		})


func vote(vote):
	var question = data.QUESTIONS[current_survey.passed]
	current_survey.passed += 1
	
	match vote:
		1:
			add_vote(1, question)
		2:
			add_vote(-1, question)
		3:
			add_vote(0.5, question)
		4:
			add_vote(-0.5, question)
	
	if current_survey.passed == len(data.QUESTIONS):
		emit_signal("finished")
		start()


func add_vote(value, question):
	if question.positive:
		current_survey.traits[question.trait].value += value
	else:
		current_survey.traits[question.trait].value -= value
	
	current_survey.traits[question.trait].count += 1


func get_next_question():
	return data.QUESTIONS[current_survey.passed]
