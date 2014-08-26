package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Frame;
	import com.icerain.age.components.Globals;
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.module.simulater.model.GiftSimulaterProxy;
	import com.icerain.age.utils.TS;
	import com.icerain.age.vo.GiftFillVO;

	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.core.PopUpManager;
	import feathers.layout.VerticalLayout;

	import starling.display.Button;
	import starling.display.Graphics;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;

	public class GiftSelectView extends Frame
	{
		private static var _instace:GiftSelectView;
		private static var _callback:Function;
		private var _closeBtn:Button;
		private var _list:ScrollContainer;

		public function GiftSelectView(giftList:Array)
		{
			super();

			this.width=400;
			this.height=660;
			var gh:Graphics=new Graphics(this);
			gh.beginFill(0x999999, 1);
			gh.drawRect(0, 0, this.width, this.height);
			gh.endFill();

			var tf:TextField=new TextField(this.width, 80, TS.TIPS_TEXT_01, "simhei", 30, 0xffffff);
			tf.hAlign="center";
			this.addChild(tf);

			_closeBtn=new Button(MainApplaction.mAssetsManager.getTexture("closeBtn"));
			_closeBtn.width=64;
			_closeBtn.height=64;
			_closeBtn.x=this.width - _closeBtn.width;
			this.addChild(_closeBtn);
			_closeBtn.addEventListener(Event.TRIGGERED, onTriggered);

			var layout:VerticalLayout=new VerticalLayout();
			layout.horizontalAlign=VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.gap=0;
			_list=new ScrollContainer();
			_list.layout=layout;
			_list.scrollerProperties.verticalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			_list.scrollerProperties.horizontalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			_list.width=this.width;
			_list.height=this.height;
			_list.x=0;
			_list.y=80
			_list.hasElasticEdges=false;
			this.addChild(_list);

			var otherGifts:Array=GiftSimulaterProxy.instance.getOtherSevenGifts();

			for (var i:int=0; i < otherGifts.length; i++)
			{
				var cell:GiftSelectedCell=new GiftSelectedCell(otherGifts[i]);
				cell.addEventListener(Event.TRIGGERED, function(e:Event):void
				{
					var seletedCell:GiftSelectedCell=e.currentTarget as GiftSelectedCell;
					if (_callback != null)
					{
						_callback(new GiftFillVO(seletedCell.giftType));
					}
					close();
				});
				_list.addChild(cell);
			}
		}

		private function onTriggered():void
		{

			close();
		}

		public static function show(giftList:Array, callback:Function):void
		{
			_callback=callback;
			if (_instace == null)
				_instace=new GiftSelectView(giftList);
			PopUpManager.addPopUp(_instace);
		}


		public static function close():void
		{
			if (_instace)
			{
				PopUpManager.removePopUp(_instace, true);
			}
		}

		override public function dispose():void
		{
			_closeBtn.removeEventListener(Event.TRIGGERED, onTriggered);
			while (_list.numChildren)
				_list.removeChildAt(0, true).removeEventListeners(Event.TRIGGERED);
			super.dispose();
			_instace=null;
		}
	}
}
