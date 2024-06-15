package;

import flixel.FlxG;
import flixel.FlxGame;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.UncaughtErrorEvent;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

class Main extends Sprite
{
	public static var input:InputManager;

	public function new()
	{
		super();
		input = new InputManager();
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		addChild(new FlxGame(0, 0, PlayState,240,240,true,false));
		FlxG.autoPause = false;
		FlxG.fixedTimestep = false;
	}

	function onCrash(uncaught:UncaughtErrorEvent):Void
	{
		var textStuff:String = "";
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					textStuff += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}
		textStuff += "\nError: " + uncaught.error;

		var reportClassic:String = "CDEV Engine crashed during runtime.\n\nCall Stacks:\n"
			+ textStuff
			+ "Please report this error to CDEV Engine's GitHub page: \nhttps://github.com/Core5570RYT/FNF-CDEV-Engine";

		lime.app.Application.current.window.alert(reportClassic);
		Sys.exit(1);
	}
}
