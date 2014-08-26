
package com.icerain.age.components
{
	import com.icerain.age.module.hud.controller.HudCommand;
	import com.icerain.age.module.hud.model.HudProxy;
	import com.icerain.age.module.hud.view.HudView;
	import com.icerain.age.module.main.controller.MainCommand;
	import com.icerain.age.module.main.model.MainProxy;
	import com.icerain.age.module.main.view.MainView;
	import com.icerain.age.module.simulater.controller.GiftSimulaterCommand;
	import com.icerain.age.module.simulater.model.GiftSimulaterProxy;
	import com.icerain.age.module.simulater.view.GiftSimulaterView;
	import com.icerain.age.module.sql.model.SqlManager;
	import com.icerain.age.template.XMLSetuper;

	import feathers.themes.AeonDesktopTheme;

	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	import starling.core.Starling;
	import starling.display.Graphics;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;


	public class MainApplaction extends starling.display.Sprite
	{
		public static var mStarling:Starling;
		public static var mAssetsManager:AssetManager;

		public var _bgLayer:Sprite;
		public var _uiLayer:Sprite;
		public var _effectLayer:Sprite;
		public var _mainLayer:Sprite;
		public var _popupLayer:Sprite;

		public function MainApplaction()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, function():void
			{
				start(AgeTool.mStarling);
			});
		}

		public function start(starling:Starling):void
		{
			mStarling=starling;

			new AeonDesktopTheme();

			_bgLayer=new Sprite();
			_bgLayer.touchable=false;
			this.addChild(_bgLayer);
			var gh:Graphics=new Graphics(_bgLayer);
			gh.beginFill(0x0, 1);
			gh.drawRect(0, 0, Globals.stageWidth, Globals.stageHeight);
			gh.endFill();

			_mainLayer=new Sprite();
			this.addChild(_mainLayer);

			_uiLayer=new Sprite();
			this.addChild(_uiLayer);

			_effectLayer=new Sprite();
			_effectLayer.touchable=false;
			this.addChild(_effectLayer);

			_popupLayer=new Sprite();
			this.addChild(_popupLayer);

			mAssetsManager=new AssetManager();
			mAssetsManager.enqueue("image/images.png", "image/images.xml");
			mAssetsManager.loadQueue(function(ratio:Number):void
			{
				trace("资源加载进度:" + ratio);
				if (ratio >= 1)
				{
					facade.sendNotification(Globals.GAME_RESOURCE_LOADED);
				}
			});

			initPureMVC();
			initTemplates();
			SqlManager.init();
		}

		private function initPureMVC():void
		{

			facade.registerCommand(ModuleGlobals.HUD_CMD, HudCommand);
			facade.registerMediator(new HudView());
			facade.registerProxy(new HudProxy());

//			facade.registerCommand(ModuleGlobals.SQL_CMD, SqlCommand);
//			facade.registerMediator(new SqlMediator());
//			facade.registerProxy(new SqlProxy());

			facade.registerCommand(ModuleGlobals.MAIN_CMD, MainCommand);
			facade.registerMediator(new MainView());
			facade.registerProxy(new MainProxy());

			facade.registerCommand(ModuleGlobals.GIFT_SIMULATER_CMD, GiftSimulaterCommand);
			facade.registerMediator(new GiftSimulaterView());
			facade.registerProxy(new GiftSimulaterProxy());
		}

		private function initTemplates():void
		{
			XMLSetuper.intiXML();
		}

		/**
		 *只允许starling创建实例
		 * @return
		 *
		 */
		public static function getInstance():MainApplaction
		{
			return mStarling.root as MainApplaction;
		}

		public static function get facade():IFacade
		{
			return Facade.getInstance();
		}

		override public function dispose():void
		{
			this.removeEventListeners(Event.ADDED_TO_STAGE);
			super.dispose();
		}

	}
}


