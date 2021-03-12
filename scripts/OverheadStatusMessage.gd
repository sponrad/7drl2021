extends Node2D

var textLines = PoolStringArray([])
var maxLines = 6

func _ready():
    z_index = 1

func add_message(text: String):
    textLines.insert(0, text)
    if textLines.size() > maxLines:
        textLines.remove(maxLines)
    $TextOne.text = textLines[0]
    var temp = textLines
    temp.remove(0)
    $TextRest.text = temp.join("\n")

func _on_NewLineTimer_timeout():
    add_message("")
    $NewLineTimer.start()
