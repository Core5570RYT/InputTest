package;

import flixel.input.keyboard.FlxKey;
import haxe.Timer;
import openfl.media.Sound;
import sys.thread.Thread;

/**
 * Input Helper Class for CDEV Engine.
 * Todo: Make all of this works like InputManager.SPACE or something idk
 */
@:cppFileCode('
#include <Windows.h>
')
class InputManager {
    public var lastPassedMS:Float = 0.01;
    public var keys:Array<Bool> = [];
    public var keysPressed:Array<Bool> = [];
    private var lastTime:Float;
    private var prevKeys:Array<Bool> = [];
    
    public function new() {
        trace("Initializing Thread for Inputs...");
        lastTime = Timer.stamp();
		Thread.createWithEventLoop(loop);
    }

    private function loop() {
        while (true) {
            var startTime = Timer.stamp();
            try{
                update();
            } catch(e) { //this does NOT work
                trace("bruh: " + e.toString());
            }

            lastPassedMS = (Timer.stamp() - startTime) * 1000;
			Thread.processEvents();
        }
    }

    public function update() {
        // key press thing
        for (i in 0...keys.length) prevKeys[i] = keys[i];
        
        // Key Down thing
        keys[0] = getKeyPress(FlxKey.S); // 'S'
        keys[1] = getKeyPress(FlxKey.D); // 'D'
        keys[2] = getKeyPress(FlxKey.K); // 'K'
        keys[3] = getKeyPress(FlxKey.L); // 'L'
        
        // Just like Flixel's "JUST_PRESSED" key state :pray:
        for (i in 0...keys.length) keysPressed[i] = keys[i] && !prevKeys[i];

        // wowah
        for (i in keysPressed){
            if (i) {
				Sound.fromFile("./assets/sounds/hitsound.ogg").play();
            }
        }
    }

    @:functionCode('
        int keyCode = key;
        if (GetKeyState(keyCode) & 0x8000) return true;
    ')
    private function getKeyPress(key:Int):Bool {
        return false;
    }
}
