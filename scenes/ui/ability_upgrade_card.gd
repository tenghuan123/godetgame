extends PanelContainer

# 定义一个鼠标点击后发出的事件
signal selected

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel

func _ready():
	gui_input.connect(on_gui_input)


func on_gui_input(event: InputEvent): 
	if(Input.get_action_strength('mouse_left_click')):
		selected.emit()



func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
