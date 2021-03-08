extends Node

enum tile_types {
    SAND,
    GRASS_ROAD,
    SNOW_ROAD,
    DIRT,
    STONE,
    WATER,
    SNOW,
    GRASS_TREE,
    GRASS_OTHER,
    GRASS,
}

var defs = {
    tile_types.SAND: {
        'power': 0,
    },
    tile_types.GRASS_ROAD: {},
    tile_types.SNOW_ROAD: {},
    tile_types.DIRT: {
        'power': 0,
    },
    tile_types.STONE: {},
    tile_types.WATER: {
        'power': 1,
    },
    tile_types.SNOW: {},
    tile_types.GRASS_TREE: {
        'power': 2,
    },
    tile_types.GRASS_OTHER: {},
    tile_types.GRASS: {
        'power': 1,
    },
}

var tile_type_sprites = {
    tile_types.SAND: [
        preload("res://sprites/Kenney/Tile/medievalTile_01.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_02.png"),
    ],
    tile_types.GRASS_ROAD: [
        preload("res://sprites/Kenney/Tile/medievalTile_03.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_04.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_05.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_06.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_07.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_17.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_18.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_19.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_20.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_21.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_31.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_32.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_33.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_34.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_35.png"),
    ],
    tile_types.SNOW_ROAD: [
        preload("res://sprites/Kenney/Tile/medievalTile_08.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_09.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_10.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_11.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_12.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_22.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_23.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_24.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_25.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_26.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_36.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_37.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_38.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_39.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_40.png"),
    ],
    tile_types.DIRT: [
        preload("res://sprites/Kenney/Tile/medievalTile_13.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_14.png"),
    ],
    tile_types.STONE: [
        preload("res://sprites/Kenney/Tile/medievalTile_15.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_16.png"),
    ],
    tile_types.WATER: [
        preload("res://sprites/Kenney/Tile/medievalTile_27.png"),
        #preload("res://sprites/Kenney/Tile/medievalTile_28.png"),
    ],
    tile_types.SNOW: [
        preload("res://sprites/Kenney/Tile/medievalTile_29.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_30.png"),
    ],
    tile_types.GRASS_TREE: [
        preload("res://sprites/Kenney/Tile/medievalTile_41.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_42.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_43.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_44.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_45.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_46.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_47.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_48.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_49.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_50.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_51.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_52.png"),
    ],
    tile_types.GRASS_OTHER: [
        preload("res://sprites/Kenney/Tile/medievalTile_53.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_54.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_55.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_56.png"),
    ],
    tile_types.GRASS: [
        preload("res://sprites/Kenney/Tile/medievalTile_57.png"),
        preload("res://sprites/Kenney/Tile/medievalTile_58.png"),
    ],
}

enum feature_types {
    ROCK_GRAY,
    LOG,
    ROCK_BROWN,
    SHRUB,
    TREE,
    FIRE,
}

var feature_type_defs = {
    null: {
        'power': 0,
    },
    feature_types.TREE: {
        'power': 1,
    },
    feature_types.LOG: {
        'power': 1,
    },
    feature_types.ROCK_GRAY: {
        'power': 0,
    },
    feature_types.SHRUB: {
        'power': 0,
    },
    feature_types.ROCK_BROWN: {
        'power': 0,
    },
    feature_types.FIRE: {
        'power': 2,
    },
}


var feature_type_sprites = {
    feature_types.TREE: [
        preload("res://sprites/Kenney/Environment/medievalEnvironment_01.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_02.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_03.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_04.png"),
    ],
    feature_types.LOG: [
        preload("res://sprites/Kenney/Environment/medievalEnvironment_05.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_06.png"),
    ],
    feature_types.ROCK_GRAY: [
        preload("res://sprites/Kenney/Environment/medievalEnvironment_07.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_08.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_09.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_10.png"),
        #preload("res://sprites/Kenney/Environment/medievalEnvironment_11.png"),
        #preload("res://sprites/Kenney/Environment/medievalEnvironment_12.png"),
    ],
    feature_types.SHRUB: [
        preload("res://sprites/Kenney/Environment/medievalEnvironment_13.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_20.png"),
    ],
    feature_types.ROCK_BROWN: [
        preload("res://sprites/Kenney/Environment/medievalEnvironment_14.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_15.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_16.png"),
        preload("res://sprites/Kenney/Environment/medievalEnvironment_17.png"),
        #preload("res://sprites/Kenney/Environment/medievalEnvironment_18.png"),
        #preload("res://sprites/Kenney/Environment/medievalEnvironment_19.png"),
    ],
    feature_types.FIRE: [
        preload("res://sprites/Kenney/Environment/medievalEnvironment_21.png"),
    ],
}
