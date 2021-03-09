extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.CRAB
var health = SpellData.defs[spell].health
var attack = SpellData.defs[spell].attack

func _ready():
    if game_manager.current_summon:
        game_manager.current_summon.take_damage(10000)
    game_manager.current_summon = self

func move_to(target_tile):
    # if movable, then move there
    if target_tile.has_enemy():
        var enemy = target_tile.has_enemy()
        enemy.take_damage(attack)
        if not target_tile.has_enemy():
            position = target_tile.position
    elif target_tile.is_moveable():
        position = target_tile.position
    game_manager.end_turn()

func take_damage(amount):
    health -= amount
    if health <= 0:
        # do an animation or something
        queue_free()
