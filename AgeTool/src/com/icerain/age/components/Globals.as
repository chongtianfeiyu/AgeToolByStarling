package com.icerain.age.components
{
	import com.icerain.age.vo.GiftVO;

	import flash.display.Stage;
	import flash.display.StageAspectRatio;
	import flash.geom.Rectangle;


	public class Globals
	{
		public static const PLATFORM_IPHONE:String="PLATFORM_IPHONE";
		public static const PLATFORM_IPHONE5:String="PLATFORM_IPHONE5";
		public static const PLATFORM_ANDROID:String="PLATFORM_ANDROID";
		public static const TOTAL_GIFTS:Array=[
			GiftVO.SIWANG,
			GiftVO.YEXING,
			GiftVO.ANSHA,
			GiftVO.GEDOU,
			GiftVO.HUANSHU,
			GiftVO.SHENGMING,
			GiftVO.TIEBI,
			GiftVO.YEXING,
			GiftVO.YIZHI,
			GiftVO.YINYOU
			];

		public static var srcWidth:Number;
		public static var srcHeight:Number;
		/**
		 *平台
		 */
		public static var platform:String;
		/**
		 *资源初始化完毕
		 */
		public static var GAME_RESOURCE_LOADED:String="GAME_RESOURCE_LOADED";


		public static var stageDataInited:Boolean=false;
		public static var userDataInited:Boolean=false;


		public static function getGameDataInited():Boolean
		{
			return stageDataInited && userDataInited;
		}


		public static var flashStage:flash.display.Stage;

		private static var _curAspect:String;
		public static var SHOW_HUD:String="SHOW_HUD";
		public static var HIDE_HUD:String="SHOW_HUD";

		public static function get curAspect():String
		{
			return _curAspect;

		}

		public static function set curAspect(value:String):void
		{
			_curAspect=value;
			if (_curAspect == StageAspectRatio.LANDSCAPE)
			{
				Globals.flashStage.setAspectRatio(StageAspectRatio.LANDSCAPE);
				MainApplaction.mStarling.viewPort=new Rectangle(0, 0, srcHeight, srcWidth);
				MainApplaction.mStarling.stage.stageHeight=srcWidth;
				MainApplaction.mStarling.stage.stageWidth=srcHeight;
			}
			else
			{
				Globals.flashStage.setAspectRatio(StageAspectRatio.PORTRAIT);
				MainApplaction.mStarling.viewPort=new Rectangle(0, 0, srcWidth, srcHeight);
				MainApplaction.mStarling.stage.stageHeight=srcWidth;
				MainApplaction.mStarling.stage.stageWidth=srcHeight;
			}
		}

		public static function get stageHeight():Number
		{
			return MainApplaction.mStarling.stage.stageHeight;
		}

		public static function get stageWidth():Number
		{
			return MainApplaction.mStarling.stage.stageWidth;
		}
	}
}


