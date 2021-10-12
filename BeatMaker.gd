extends Node2D

export var icon: Texture
export (int, 1, 16) var delay_beats: int = 1
export var beatmap_frog : String
export var beatmap_whale : String
export var beatmap_bird : String
export var beatmap_lion : String
export var beatmap_bat : String
export var multiplier: int = 1
var offbeat = 0;
var map: String = "."

func _ready():
	var beatmaps = [beatmap_frog, beatmap_whale, beatmap_bird, beatmap_lion, beatmap_bat]
	for beatmap in beatmaps:
		if beatmap:
			var file = File.new()
			file.open(beatmap,File.READ)
			map = file.get_as_text().replace("\n","")
			file.close()

func _process(delta):
	if not visible:
		return

	transport = float(OS.get_ticks_usec() - us_since_level_started)/1e6 - delay
	if visible and not song_has_started and transport >= 0.0:
		song_has_started = true
		othersong.play(transport)
		calopsitasong.play(transport)

	if level_has_started:
		var beat = int(floor(((transport + delay) / beat_length + offset)))
		if beat != last_beat:
			if offbeat == 0:
				for spawner in [spawnerleft,spawnerright]:
					print(beat)
					spawner.on_beat(beat_length)
				for c in [leftcharacter, rightcharacter]:
					var character : Character = c as Character 
					if character.is_dancing:
						character.dance()

			offbeat = (offbeat + 1) % multiplier
		last_beat = beat
		
var index: int = 0

func on_beat(beat_length: float):
	match map[index % map.length()]:
		"-":
			power_sing(index * beat_length)
	index = index+1 % map.length()

func power_sing():
	
