extends AudioStreamPlayer

## Controls the sound that will be played when user 
## chooses the correct answer

func _ready():
	var audioStream: AudioStreamMP3 = load("res://Piano WAVs/correctSound.mp3")
	self.set_stream(audioStream)

func playSound() -> void:
	self.play()
