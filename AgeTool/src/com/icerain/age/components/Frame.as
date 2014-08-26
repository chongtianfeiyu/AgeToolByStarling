package com.icerain.age.components
{
	import flash.geom.Point;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;


	/**
	 *
	 * Frame.as
	 *
	 * 用于设置容器的固定宽高，一般用来方便做布局使用
	 *
	 * @author hanlu
	 * @date 2013-9-17
	 *
	 */
	public class Frame extends Sprite
	{
		private var _width:Number;
		private var _height:Number;

		public function Frame()
		{
			super();
		}

		public override function get height():Number
		{
			return _height;
		}

		public override function set height(value:Number):void
		{
			_height=value;
		}

		public override function get width():Number
		{
			return _width;
		}

		public override function set width(value:Number):void
		{
			_width=value;
		}

		public function initWH(w:Number, h:Number):void
		{
			this.width=w;
			this.height=h;
		}

		override public function dispose():void
		{
			super.dispose();
		}
	}

}
