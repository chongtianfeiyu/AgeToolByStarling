package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Frame;
	import com.icerain.age.template.SkillXml;

	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class SkillIcon extends Frame
	{
		public static const LONG_PRESS_TIME:int=300;
		public var index:uint;
		public var skillXml:SkillXml;
		private var _skillIcon:Image;
		private var _selected:Boolean=false;
		private var _startPt:Point;
		private var _endPt:Point;
		private var _startTime:Number;
		private var _endTime:Number;
		private var _timer:Timer=new Timer(LONG_PRESS_TIME, 1);
		private var textField:TextField;

		public function SkillIcon(skillXml:SkillXml)
		{
			super();
			this.width=96;
			this.height=96;
			this.skillXml=skillXml;
			_skillIcon=new Image(ResourceModule.getSkillIconTexture(skillXml.icon));
			_skillIcon.width=this.width;
			_skillIcon.height=this.height;
			this.addChild(_skillIcon);
			selected=false;
			if (skillXml.passive == 1)
			{
				textField=new TextField(100, 100, "" + skillXml.level, "SourceSansProSemibold", 60, 0xffffff, true);
				textField.touchable=false;
				this.addChild(textField);
			}
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onLongPressTimer);
			this.addEventListener(TouchEvent.TOUCH, onTouched);
		}

		protected function onLongPressTimer(event:TimerEvent):void
		{
			_timer.stop();
			_timer.reset();
			SkillInfoView.show(skillXml);
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		protected function onTouched(e:TouchEvent):void
		{
			var touch:Touch;
			if (e.getTouch(this, TouchPhase.BEGAN))
			{
				touch=e.getTouch(this, TouchPhase.BEGAN);
				_startPt=new Point(touch.globalX, touch.globalY);
				_startTime=getTimer();
				_timer.start();
			}
			else if (e.getTouch(this, TouchPhase.MOVED))
			{
				touch=e.getTouch(this, TouchPhase.MOVED);
				if (Math.abs(touch.globalX - _startPt.x) + Math.abs(touch.globalY - _startPt.y) >= 100)
				{
					_timer.reset();
					_timer.stop();
				}
			}
			else if (e.getTouch(this, TouchPhase.ENDED))
			{
				touch=e.getTouch(this, TouchPhase.ENDED);
				_endTime=getTimer();
				_endPt=new Point(touch.globalX, touch.globalY);
				if (Math.abs(_endPt.x - _startPt.x) + Math.abs(_endPt.y - _startPt.y) <= 30)
				{
					if (_endTime - _startTime <= LONG_PRESS_TIME)
					{
						var ev:Event=new Event(Event.TRIGGERED, false, this);
						dispatchEvent(ev);
						_timer.stop();
						_timer.reset();
					}

				}
				else
				{
					_timer.stop();
					_timer.reset();
				}
			}
		}

		public function set selected(value:Boolean):void
		{
			_selected=value;
			if (textField)
				textField.visible=!_selected;
			if (_selected)
				_skillIcon.color=0xffffff;
			else
				_skillIcon.color=0x555555;
		}

		override public function dispose():void
		{
			this.removeEventListener(TouchEvent.TOUCH, onTouched);
			super.dispose();
		}
	}
}
