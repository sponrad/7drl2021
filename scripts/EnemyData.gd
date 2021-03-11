extends Node

enum types {
    DEMON,
    MAGE,
    BLOB,
    SKELETON,
    KRAKEN,
}

class Enemy:
    var attack
    var health
    var attack_range

    func _init(attack, health, attack_range):
        self.attack = attack
        self.health = health
        self.attack_range = attack_range

var defs = {
    types.DEMON: Enemy.new(5, 10, 0),
    types.MAGE: Enemy.new(3, 5, 3),
    types.BLOB: Enemy.new(2, 10, 0),
    types.SKELETON: Enemy.new(1, 2, 0),
    types.KRAKEN: Enemy.new(10, 125, 2),
}
