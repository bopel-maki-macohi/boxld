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

class BoxCollapsedSong extends Song
{
	var hasPlayedInGameCutscene:Bool;

	public function new()
	{
		super('collapsed');

		hasPlayedInGameCutscene = false;
	}

	public override function onCountdownStart(event:CountdownScriptEvent):Void
	{
		super.onCountdownStart(event);

		// if (!PlayStatePlaylist.isStoryMode)
		// {
		// 	hasPlayedInGameCutscene = true;
		// }

		FlxTween.cancelTweensOf(PlayState.instance.camHUD);
		PlayState.instance.camHUD.alpha = 1;

		if (!hasPlayedInGameCutscene)
		{
			trace('Pausing countdown to play in game cutscene');

			hasPlayedInGameCutscene = true;

			event.cancel(); // CANCEL THE COUNTDOWN!

			PlayState.instance.camHUD.alpha = 0;

			introCutscene();
		}
	}

	function introCutscene()
	{
		PlayState.instance.togglePauseButton();
		PlayState.instance.isInCutscene = true;
		PlayState.instance.mayPauseGame = false;

		var bf = PlayState.instance.currentStage.getBoyfriend();
		var gf = PlayState.instance.currentStage.getGirlfriend();
		var dad = PlayState.instance.currentStage.getDad();

		gf.anim.pause();
		dad.anim.pause();

		gf.anim.frameIndex = 0;
		dad.anim.frameIndex = 13;

		var endTime = 0;
		if (bf.characterId == 'boxld-protag')
		{
			endTime = 4;

			var picoPos:Array<Float> = [bf.cameraFocusPoint.x, bf.cameraFocusPoint.y];
			var nenePos:Array<Float> = [gf.cameraFocusPoint.x, gf.cameraFocusPoint.y];
			var darnellPos:Array<Float> = [dad.cameraFocusPoint.x, dad.cameraFocusPoint.y];

			var protagFall = FunkinSprite.createTextureAtlas(bf.x - 118, bf.y - 445, 'cutscenes/collapsed-intro-protag-fall');
			protagFall.zIndex = bf.zIndex - 1;
			protagFall.anim.addByFrameLabel('fall', 'fall', 24, false);
			protagFall.anim.addByFrameLabel('idle', 'idle', 24, false);
			bf.visible = false;
			// bf.alpha = 0.5;

			protagFall.anim.play('idle', true);
			protagFall.anim.onFinish.add(function(anim)
			{
				if (anim == 'fall')
				{
					bf.visible = true;
					PlayState.instance.currentStage.remove(protagFall);
					PlayState.instance.currentStage.refresh();

					// bf.dance();
				}
			});

			PlayState.instance.currentStage.add(protagFall);
			PlayState.instance.currentStage.refresh();

			PlayState.instance.tweenCameraToPosition(nenePos[0], nenePos[1], endTime / 2);

			protagFall.visible = false;
			new FlxTimer().start(endTime / 2, function(tmr)
			{
				protagFall.visible = true;
				protagFall.anim.play('fall', true);
			});
		}

		new FlxTimer().start(endTime, function(tmr)
		{
			PlayState.instance.isInCutscene = false;
			PlayState.instance.startCountdown();

			PlayState.instance.togglePauseButton(true);
			PlayState.instance.isInCutscene = false;
			PlayState.instance.mayPauseGame = true;

			FlxTween.tween(PlayState.instance.camHUD, {alpha: 1}, 2, {startDelay: 0});
		});
	}

	/**
	 * Don't replay the cutscene between restarts.
	 */
	function onSongRetry(event:ScriptEvent)
	{
		super.onSongRetry(event);

		hasPlayedInGameCutscene = true;
	}

	/**
	 * Replay the cutscene after leaving the song.
	 */
	function onCreate(event:ScriptEvent):Void
	{
		super.onCreate(event);

		hasPlayedInGameCutscene = false;
	}
}
