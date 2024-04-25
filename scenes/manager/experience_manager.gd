extends Node

class_name ExperienceManager
signal experience_updated(current_experience: float, targert_experience: float)

var current_experience = 0
var target_experience = 5
var level = 1

const TARGET_EXPERIENCE_GROWTH = 5

func _ready():
    GameEvents.experience_vial_collected.connect(on_experience_vial_collected)

func increment_experience(number: float):
    current_experience = min(current_experience + number, target_experience)
    experience_updated.emit(current_experience, target_experience)
    if current_experience == target_experience:
        level += 1
        target_experience += TARGET_EXPERIENCE_GROWTH
        current_experience = 0
        experience_updated.emit(current_experience, target_experience)

func on_experience_vial_collected(number: float):
    increment_experience(number)
