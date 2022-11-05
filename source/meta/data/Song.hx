package meta.data;

import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;
import meta.data.Section.SwagSection;
import meta.state.PlayState;

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var stage:String;
	var noteSkin:String;
	var validScore:Bool;
	var threeLanes:Bool;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;
	public var lanes:Int = 2;

	public var player1:String = 'bf';
	public var player2:String = 'dad';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String, ?library:String, old:Bool):SwagSong
	{
		var rawJson;
		PlayState.old = old;
		PlayState.songLibrary = library;
		if (library != null)
			rawJson = Assets.getText(Paths.songJson(folder.toLowerCase(), jsonInput.toLowerCase(), PlayState.old, PlayState.songLibrary)).trim();
		else 
			rawJson = Assets.getText(Paths.songJson(folder.toLowerCase(), jsonInput.toLowerCase(), PlayState.old, PlayState.songLibrary)).trim();

		while (!rawJson.endsWith("}"))
			rawJson = rawJson.substr(0, rawJson.length - 1);
		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):SwagSong {
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}
}
