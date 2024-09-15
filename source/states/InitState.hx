package states;

import backend.WeekData;
import states.StoryMenuState;
import flixel.input.keyboard.FlxKey;

class InitState extends flixel.FlxState
{
    public static var psychEngineVersion:String = '1.0-prerelease'; // This is also used for Discord RPC
    
    public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

    public static var initialized:Bool = false;

    override function create() 
    {
        super.create();

        // -- FLIXEL STUFF -- //

        FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];
        FlxG.mouse.visible = false;

        FlxTransitionableState.skipNextTransIn = true;

        // -- SETTINGS -- //

		FlxG.save.bind('funkin', CoolUtil.getSavePath());

        Controls.instance = new Controls();

        ClientPrefs.loadDefaultKeys();
		ClientPrefs.loadPrefs();

        Language.reloadPhrases();

        if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
				FlxG.fullscreen = FlxG.save.data.fullscreen;

			persistentUpdate = true;
			persistentDraw = true;
		}

        if (FlxG.save.data.weekCompleted != null)
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;

        // -- -- -- //

        Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

        FlxG.switchState(new TitleState());
    }
}