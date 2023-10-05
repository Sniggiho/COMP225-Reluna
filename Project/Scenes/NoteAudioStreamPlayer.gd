extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var audioStream: AudioStreamMP3 = loadMp3("res://Piano Key WAV/a4.mp3")
	self.set_stream(audioStream)
	self.set_volume_db(3.0)
	self.play()


func loadMp3(path) -> AudioStreamMP3:
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound
	
func playDetuned() -> void:
	# Note that raising/lowering the pitch of a note one semitone would correspond to a 
	# detuneAmount value of 1 +- 0.0625. Thus, to keep within the realm of the note
	# we're working with, we want detuneSeverity <= ~0.03
	var detuneAmount = 1 + 0.00625*5 # this is a scaling factor on the original pitch
	self.set_pitch_scale(detuneAmount)
	self.play()
	
func playInTune() -> void:
	self.set_pitch_scale(1)
	self.play()
	
func _onButtonPressed() -> void:
	self.playDetuned() 

