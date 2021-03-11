extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.SPIDER
var health = SpellData.defs[spell].health
var attack = SpellData.defs[spell].attack

func _ready():
    game_manager.map.clear_fov_at_position(position, 2)
    if game_manager.current_summon:
        game_manager.current_summon.take_damage(10000)
    game_manager.current_summon = self
    SpellData.summon_check_for_items(self)

func move_to(target_tile):
    SpellData.summon_move_to(self, target_tile)

func take_damage(amount):
    SpellData.summon_take_damage(self, amount)
