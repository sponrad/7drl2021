extends Node

enum types {
    SKELETON,
    BLOB,
    MAGE,
    DEMON,
    KRAKEN,
}

class Enemy:
    var name
    var attack
    var health
    var attack_range

    func _init(name, attack, health, attack_range):
        self.attack = attack
        self.health = health
        self.attack_range = attack_range
        self.name = name

var defs = {
    types.DEMON: Enemy.new('Demon', 5, 10, 0),
    types.MAGE: Enemy.new('Mage', 3, 4, 3),
    types.BLOB: Enemy.new('Blob', 1, 8, 0),
    types.SKELETON: Enemy.new('Skeleton', 1, 2, 0),
    types.KRAKEN: Enemy.new('Kraken', 10, 50, 2),
}
