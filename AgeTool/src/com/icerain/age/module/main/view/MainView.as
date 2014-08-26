package com.icerain.age.module.main.view
{
	import com.icerain.age.components.BaseViewMediator;
	import com.icerain.age.components.Frame;
	import com.icerain.age.components.Globals;
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.components.ModuleGlobals;
	import com.icerain.age.module.main.MainGlobals;
	import com.icerain.age.module.simulater.GiftSimulaterGlobals;
	import com.icerain.age.utils.TS;

	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;

	import org.puremvc.as3.interfaces.INotification;

	public class MainView extends BaseViewMediator
	{
		private var _grap:Number=10;
		private var _skillBtn:MetroCell;
		private var _clockBtn:MetroCell;
		private var _aboutBtn:MetroCell;
		private var _combineBtn:MetroCell;

		private var _container:ScrollContainer;

		public function MainView()
		{
			super(ModuleGlobals.MAIN_MEDIATOR, viewComponent);
		}

		private function initView():void
		{
			this.width=Globals.stageWidth;
			this.height=Globals.stageHeight;

			if (_container == null)
			{
				_container=new ScrollContainer();
				_container.scrollerProperties.horizontalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
				_container.height=Globals.stageHeight;

				var sp:Frame=new Frame();
				sp.width=640;
				sp.height=1080;
				_container.addChild(sp);
				_skillBtn=new MetroCell(TS.SIMULATER_TEXT, 410, 200, 0x009CAE);
				_skillBtn.x=_skillBtn.y=10;
				sp.addChild(_skillBtn);

				_clockBtn=new MetroCell(TS.CLOCK_TEXT, 200, 200, 0x00A500);
				_clockBtn.x=430;
				_clockBtn.y=10;
				sp.addChild(_clockBtn);

				_aboutBtn=new MetroCell(TS.ABOUT_TEXT, 200, 200, 0x2777EC);
				_aboutBtn.x=10;
				_aboutBtn.y=220;
				sp.addChild(_aboutBtn);

				_combineBtn=new MetroCell(TS.COMBINE_TEXT, 200, 200, 0xDC562E);
				_combineBtn.x=220;
				_combineBtn.y=220
				sp.addChild(_combineBtn);

				var cell1:MetroCell=new MetroCell("1", 200, 410, 0x003300, "metro_image3");
				cell1.x=10;
				cell1.y=430;
				sp.addChild(cell1);

				var cell2:MetroCell=new MetroCell("2", 410, 200, 0x9C00A4, "metro_image2");
				cell2.x=220;
				cell2.y=640;
				sp.addChild(cell2);

				var cell3:MetroCell=new MetroCell(TS.TIME_TEXT, 200, 410, 0x009CAE);
				cell3.x=430;
				cell3.y=220;
				sp.addChild(cell3);

				var cell4:MetroCell=new MetroCell("4", 200, 200, 0x00A500, "metro_image1");
				cell4.x=220;
				cell4.y=430;
				sp.addChild(cell4);

				var cell5:MetroCell=new MetroCell("5", 200, 200, 0x009CAE, "metro_image4");
				cell5.x=10;
				cell5.y=850;
				sp.addChild(cell5);

				var cell6:MetroCell=new MetroCell("6", 200, 200, 0x003300, "metro_image5");
				cell6.x=220;
				cell6.y=850;
				sp.addChild(cell6)

				var cell7:MetroCell=new MetroCell("7", 200, 200, 0xDC562E, "metro_image6");
				cell7.x=430;
				cell7.y=850;
				sp.addChild(cell7)
			}
			this.addChild(_container);

		}

		private function releaseView():void
		{
			if (_container && _container.parent)
				_container.parent.removeChild(_container);
		}


		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case Globals.GAME_RESOURCE_LOADED:
					initView();
					MainApplaction.getInstance()._mainLayer.addChild(this);
					break;
				case MainGlobals.FUNC_BUTTON_CLICK:
					handFunc(String(notification.getBody()));
					break;
			}
		}

		private function handFunc(func:String):void
		{
			switch (func)
			{
				case TS.SIMULATER_TEXT:
					facade.sendNotification(GiftSimulaterGlobals.INIT_GIFT_SIMULATER);
					releaseView();
					break;
			}

		}

		override public function listNotificationInterests():Array
		{
			return [Globals.GAME_RESOURCE_LOADED, MainGlobals.FUNC_BUTTON_CLICK];
		}

		override public function dispose():void
		{
			super.dispose();
		}
	}
}
