extends Node

signal finished(result)

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
		emit_signal("finished", summarize())
		start()


func summarize():
	var traits = []
	for i in current_survey.traits:
		traits.append(0.5 + i.value / i.count * 0.5)
	
	var min_score = 0xffffff
	var min_score_character
	
	for i in data.CHARACTERS:
		var score = 0
		for j in range(len(i.traits)):
			score += abs(traits[j] - i.traits[j])
		
		if score < min_score:
			min_score = score
			min_score_character = i
	
	return min_score_character


func add_vote(value, question):
	if question.positive:
		current_survey.traits[question.trait].value += value
	else:
		current_survey.traits[question.trait].value -= value
	
	current_survey.traits[question.trait].count += 1


func get_next_question():
	return data.QUESTIONS[current_survey.passed]
