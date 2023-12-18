extends AudioStreamPlayer

## Controls the sound that will be played when user 
## chooses the correct answer

func _ready():
	var audioStream: AudioStream = load("res://Piano WAVs/correctSound3.wav")
	self.set_stream(audioStream)

func playSound() -> void:
	self.play()
