package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;


class PlayState extends FlxState
{
	var txt:FlxText;
	var wowa:Array<FlxSprite> = [];
	override public function create()
	{
		txt = new FlxText(0,0,-1,"",18);
		add(txt);

		for (i in 0...4) {
			var e:FlxSprite = new FlxSprite(20 + (60*i), 150).makeGraphic(50,50,0xFFFFFFFF);
			add(e);

			wowa.push(e);
		}
		super.create();
	}

	override public function update(elapsed:Float)
	{
		txt.text = ""
		+ "Raw MS: " + Main.input.lastPassedMS
		+ "\nInput FPS: " + (1000 / Main.input.lastPassedMS)
		+ "\nPressed A: " + Main.input.keys
		+ "Game FPS: " + (1000 / (elapsed*1000));

		for (index => key in Main.input.keys) {
			var scale:Float = key ? 0.6 : 1;
			wowa[index].scale.set(scale,scale);
		}
		super.update(elapsed);
	}
}
