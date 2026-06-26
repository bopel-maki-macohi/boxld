import flixel.FlxSprite;
import flixel.math.FlxBasePoint;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import funkin.Conductor;
import funkin.graphics.FunkinSprite;
import funkin.data.song.SongRegistry;
import funkin.play.GameOverSubState;
import funkin.play.PlayState;
import funkin.play.song.Song;
import funkin.play.stage.StageProp;
import funkin.save.Save;
import funkin.audio.FunkinSound;
import funkin.play.cutscene.VideoCutscene;
import funkin.play.cutscene.CutsceneType;
import funkin.play.PlayStatePlaylist;

class BoxCompromisedSong extends Song
{
	public function new()
	{
		super('compromised');
	}

	public override function onCountdownStart(event:CountdownScriptEvent):Void
	{
		super.onCountdownStart(event);

		if (PlayState.instance.currentStage.getBoyfriend() != null) PlayState.instance.currentStage.getBoyfriend().visible = true;
		if (PlayState.instance.currentStage.getGirlfriend() != null) PlayState.instance.currentStage.getGirlfriend().visible = true;
		if (PlayState.instance.currentStage.getDad() != null) PlayState.instance.currentStage.getDad().visible = true;
	}

	function onSongRetry(event:ScriptEvent)
	{
		super.onSongRetry(event);

		if (PlayState.instance.currentStage.getBoyfriend() != null) PlayState.instance.currentStage.getBoyfriend().visible = true;
		if (PlayState.instance.currentStage.getGirlfriend() != null) PlayState.instance.currentStage.getGirlfriend().visible = true;
		if (PlayState.instance.currentStage.getDad() != null) PlayState.instance.currentStage.getDad().visible = true;
	}

	function onCreate(event:ScriptEvent):Void
	{
		super.onCreate(event);

		if (PlayState.instance.currentStage.getBoyfriend() != null) PlayState.instance.currentStage.getBoyfriend().visible = true;
		if (PlayState.instance.currentStage.getGirlfriend() != null) PlayState.instance.currentStage.getGirlfriend().visible = true;
		if (PlayState.instance.currentStage.getDad() != null) PlayState.instance.currentStage.getDad().visible = true;
	}

	function onStepHit(event:SongTimeScriptEvent)
	{
		super.onStepHit(event);

		if (event.step == 352)
		{
			if (PlayState.instance.currentStage.getBoyfriend() != null) PlayState.instance.currentStage.getBoyfriend().visible = false;
			if (PlayState.instance.currentStage.getGirlfriend() != null) PlayState.instance.currentStage.getGirlfriend().visible = false;
			if (PlayState.instance.currentStage.getDad() != null) PlayState.instance.currentStage.getDad().visible = false;
		}
	}
}
