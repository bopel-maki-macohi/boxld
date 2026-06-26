import funkin.play.stage.Stage;
import funkin.play.stage.StageProp;

class BoxCoreRootStage extends Stage
{
	override public function new()
	{
		super('box-coreRoot');
	}

	var floatingRocks:Int = 2;
	var backFloatingRocks:Int = 2;

	var floatingRockStartY:Array<Float> = [];
	var backFloatingRockStartY:Array<Float> = [];

	var rockYOff:Array<Float> = [25, 80];
	var backRockYOff:Array<Float> = [40, -80];

	var rockTimeShit:Array<Float> = [80, 40];
	var backRockTimeShit:Array<Float> = [10, 25];

	public function onCreate(event):Void
	{
		super.onCreate(event);

		forEachFloatingRock(function(prop, id)
		{
			floatingRockStartY.push(prop.y);
		});
		forEachBackFloatingRock(function(prop, id)
		{
			backFloatingRockStartY.push(prop.y);
		});

		// trace(floatingRockStartY);
		// trace(backFloatingRockStartY);
	}

	var time:Float = 0;

	public function onUpdate(event):Void
	{
		super.onUpdate(event);

		time += event.elapsed;

		getNamedProp('backRocks').y = -360 + (Math.cos(time) * 32);

		forEachFloatingRock(function(prop, id)
		{
			prop.y = floatingRockStartY[id] + rockYOff[id] + (Math.cos(time) * rockTimeShit[id]);
		});
		forEachBackFloatingRock(function(prop, id)
		{
			prop.y = backFloatingRockStartY[id] + backRockYOff[id] + (Math.cos(time) * backRockTimeShit[id]);
		});
	}

	function forEachFloatingRock(method:StageProp->Int->Void)
	{
		for (i in 1...(floatingRocks + 1))
		{
			var prop = getNamedProp('floatingRock$i');

			if (method != null && prop != null) method(prop, i - 1);
		}
	}

	function forEachBackFloatingRock(method:StageProp->Int->Void)
	{
		for (i in 1...(backFloatingRocks + 1))
		{
			var prop = getNamedProp('backFloatingRock$i');

			if (method != null && prop != null) method(prop, i - 1);
		}
	}
}
