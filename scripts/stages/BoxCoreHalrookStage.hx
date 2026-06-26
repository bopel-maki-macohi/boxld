import funkin.play.stage.Stage;
import funkin.play.stage.StageProp;

class BoxCoreHalrookStage extends Stage
{
	override public function new()
	{
		super('box-coreHalrook');
	}

	var time:Float = 0;

	public function onUpdate(event):Void
	{
		super.onUpdate(event);

		time += event.elapsed;

		getNamedProp('backRocks').y = -220 + (Math.cos(time) * 16);
	}
}
