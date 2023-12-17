extends AudioStreamPlayer


func _ready():
	var audioStream: AudioStreamMP3 = load("res://Piano WAVs/correctSound.mp3")
	self.set_stream(audioStream)

func playSound() -> void:
	self.play()
