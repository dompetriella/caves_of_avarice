extends Node

signal play_music(audio: AudioStream, fade_in: bool, fade_in_time: float);

signal stop_current_music(fade_out: bool, fade_out_time: float);

signal switch_music_track(new_music: AudioStream, 	fade_between_tracks: bool, fade_time: float);
	
signal play_sfx(audio: AudioStream, source: AudioSource.Source)

class Constants:
	static var default_transition_time: float = 2.0;
