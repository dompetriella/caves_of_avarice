extends Node

@onready var player_sfx: AudioStreamPlayer = %PlayerSFX
@onready var enemy_sfx: AudioStreamPlayer = %EnemySFX
@onready var music: AudioStreamPlayer = %Music
@onready var world_sfx: AudioStreamPlayer = %WorldSFX
@onready var interface_sfx: AudioStreamPlayer = %InterfaceSFX

func _ready() -> void:
	AudioEvents.play_music.connect(_on_play_music);
	AudioEvents.play_sfx.connect(_on_play_sfx);
	AudioEvents.switch_music_track.connect(_on_stop_current_music);

func _on_play_music(audio: AudioStream, fade_in: bool = false, fade_in_time: float = 2.0):
	if music.playing:
		music.stop()
		music.volume_db = 0

	music.stream = audio

	if fade_in:
		music.volume_db = -80
		music.play()
		var music_tween: Tween = get_tree().create_tween(); 
		music_tween.tween_property(music, "volume_db", 0, fade_in_time);
	else:
		music.volume_db = 0
		music.play()

func _on_stop_current_music(fade_out: bool = false, fade_out_time: float = 2.0):
	if not music.playing:
		return

	if fade_out:
		var music_tween: Tween = get_tree().create_tween();
		music_tween.tween_property(music, "volume_db", -80, fade_out_time);
		await music_tween.finished
	music.stop()
	music.volume_db = 0
	
func _on_switch_music_track(new_music: AudioStream, fade_between_tracks: bool = false, fade_time: float = 2.0):
	if fade_between_tracks:
		await _on_stop_current_music(true, fade_time)
		await get_tree().process_frame  # Optional: ensure frame gap between stop/start
		_on_play_music(new_music, true, fade_time)
	else:
		_on_stop_current_music();
		_on_play_music(new_music);

func _on_play_sfx(audio: AudioStream, source: AudioSource.Source = AudioSource.Source.WORLD_SFX):
	match (source):
		AudioSource.Source.PLAYER_SFX:
			player_sfx.stream = audio;
			player_sfx.play();
		AudioSource.Source.ENEMY_SFX:
			enemy_sfx.stream = audio;
			enemy_sfx.play();
		AudioSource.Source.WORLD_SFX:
			world_sfx.stream = audio;
			world_sfx.play();
		AudioSource.Source.UI_SFX:
			interface_sfx.stream = audio;
			interface_sfx.play();
	
