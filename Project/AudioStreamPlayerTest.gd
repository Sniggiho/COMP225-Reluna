extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var audioStream: AudioStreamMP3 = load_mp3("res://Piano Key WAV/a3.mp3")
	self.set_stream(audioStream)
	self.set_volume_db(3.0)
	self.play()


func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound
	
func play_detuned():
	# Note that raising/lowering the pitch of a note one semitone would correspond to a 
	# detuneAmount value of 1 +- 0.0625. Thus, to keep within the realm of the note
	# we're working with, we want detuneSeverity <= ~0.03
	var detuneAmount = 1 + randf_range(-0.03,0.03) # this is a scaling factor on the original pitch
	self.set_pitch_scale(detuneAmount)
	self.play()
	
func play_in_tune():
	self.set_pitch_scale(1)
	self.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	self.play_detuned() 


func _on_button_for_in_tune_pressed():
	self.play_in_tune()
