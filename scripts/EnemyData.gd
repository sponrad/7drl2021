extends Node

enum types {
    DEMON,
    MAGE,
    BLOB,
    SKELETON,
}

class Enemy:
    var attack
    var health

    func _init(attack, health):
        self.attack = attack
        self.health = health

var defs = {
    types.DEMON: Enemy.new(2, 2),
    types.MAGE: Enemy.new(3, 3),
    types.BLOB: Enemy.new(1, 2),
    types.SKELETON: Enemy.new(1, 1),
}
