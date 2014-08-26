package
{

	import com.icerain.age.components.Globals;
	import com.icerain.age.components.MainApplaction;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	public class AgeTool extends Sprite
	{
		public static var mStarling:Starling;

		public function AgeTool()
		{
			super();
			this.stage.frameRate=60;
			Globals.flashStage=this.stage;
			trace(Capabilities.manufacturer);
			var iOS:Boolean=Capabilities.manufacturer.toLowerCase().indexOf("ios") != -1;
			var android:Boolean=Capabilities.manufacturer.toLowerCase().indexOf("android") != -1;

			if (iOS)
				Globals.platform=Globals.PLATFORM_IPHONE;
			else if (android)
				Globals.platform=Globals.PLATFORM_ANDROID;

			Starling.handleLostContext=!iOS; // not necessary on iOS. Saves a lot of memory!

			Globals.srcWidth=640;
			Globals.srcHeight=stage.fullScreenHeight / stage.fullScreenWidth * Globals.srcWidth;

			var viewPort:Rectangle=RectangleUtil.fit(new Rectangle(0, 0, Globals.srcWidth, Globals.srcHeight), new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), ScaleMode.SHOW_ALL);

			// launch Starling
			mStarling=new Starling(MainApplaction, stage, viewPort);
			mStarling.antiAliasing=1;
			mStarling.stage.stageWidth=Globals.srcWidth; // <- same size on all devices!
			mStarling.stage.stageHeight=Globals.srcHeight; // <- same size on all devices!
			mStarling.simulateMultitouch=true;
			mStarling.enableErrorChecking=false;
			mStarling.start();
//			mStarling.showStats=true;

			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, function(e:*):void
			{
				mStarling.start();
			});

			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, function(e:*):void
			{
				mStarling.stop();
			});
			if (android || iOS)
				stage.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE;

		}

	}
}
