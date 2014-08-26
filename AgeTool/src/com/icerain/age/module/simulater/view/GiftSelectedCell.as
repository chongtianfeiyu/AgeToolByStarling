package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Frame;
	import com.icerain.age.vo.GiftVO;

	import flash.geom.Point;

	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class GiftSelectedCell extends Frame
	{
		public var giftType:uint;
		private var _startPt:Point;
		private var _endPt:Point;

		public function GiftSelectedCell(gt:uint)
		{
			super();
			this.width=400;
			this.height=80;
//			var gh:Graphics=new Graphics(this);
//			gh.beginFill(0x0, .3);
//			gh.drawRect(0, 0, this.width, this.height);
//			gh.endFill();

			var tx:TextField=new TextField(100, 80, GiftVO.getName(gt), "simhei", 30, 0xffffff);
			tx.x=160;
			this.addChild(tx);

			this.giftType=gt;
			var icon:Image=new Image(ResourceModule.getSkillIconTexture(GiftVO.getIcon(gt)));
			icon.x=50;
			icon.y=5;
			icon.width=70;
			icon.height=70;
			this.addChild(icon);

			this.addEventListener(TouchEvent.TOUCH, onTouched);
		}

		protected function onTouched(e:TouchEvent):void
		{
			var touch:Touch;
			if (e.getTouch(this, TouchPhase.BEGAN))
			{
				touch=e.getTouch(this, TouchPhase.BEGAN);
				_startPt=new Point(touch.globalX, touch.globalY);
			}
			else if (e.getTouch(this, TouchPhase.ENDED))
			{
				touch=e.getTouch(this, TouchPhase.ENDED);
				_endPt=new Point(touch.globalX, touch.globalY);
				if (Math.abs(_endPt.x - _startPt.x) + Math.abs(_endPt.y - _startPt.y) <= 30)
				{
					var ev:Event=new Event(Event.TRIGGERED, false, giftType);
					dispatchEvent(ev);
				}

			}

		}

		override public function dispose():void
		{
			this.removeEventListener(TouchEvent.TOUCH, onTouched);
			super.dispose();
		}
	}
}
