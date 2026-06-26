import funkin.modding.module.Module;
import funkin.play.PlayState;

class BoxComboManager extends Module
{
	var boxldSongs:Array<String> = [
		'monis',
		'collapsed',
		'compromised',
		'new-signal-dispatcher',
	];

	override public function new()
	{
		super('BoxComboManager');
	}

	override function onNoteHit(event)
	{
		super.onNoteHit(event);

		if (PlayState.instance == null) return;

		if (!boxldSongs.contains(PlayState.instance.currentSong.id)) return;

		if (Math.floor(event.note.noteData.data / 4) == 0)
		{
			for (popup in PlayState.instance.comboPopUps)
				popup.visible = false;
		}
	}
}
