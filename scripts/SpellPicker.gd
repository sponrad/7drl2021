extends WindowDialog


func _ready():
    pass # Replace with function body.


func _on_CastButton_pressed():
    print('Casting %s' % $CastSpellList.selected_spell)
    # close the window
    # enter spell select mode on the game manager
