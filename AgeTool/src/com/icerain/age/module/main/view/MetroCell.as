package com.icerain.age.module.main.view
{
	import feathers.controls.Button;

	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.module.main.MainGlobals;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.display.Graphics;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;

	public class MetroCell extends feathers.controls.Button
	{
		private var _type:String;
		private var _text:TextField;

		public function MetroCell(type:String, w:Number, h:Number, color:uint=0x0, texture:String=null)
		{
			super();
			this.width=w;
			this.height=h;
			_type=type;
			if (texture == null)
			{
				var gh:Graphics=new Graphics(this);
				gh.beginFill(color, 1);
				gh.drawRect(0, 0, this.width, this.height);
				gh.endFill();

				_text=new TextField(this.width, this.height, type, "simhei", 50, 0xffffff);
				this.addChild(_text);
			}
			else
			{
				var bg:Image=new Image(MainApplaction.mAssetsManager.getTexture(texture));
				bg.width=this.width;
				bg.height=this.height;
				this.addChild(bg);
			}
			this.addEventListener(Event.TRIGGERED, onTriggered);
		}

		public function onTriggered():void
		{
			Facade.getInstance().sendNotification(MainGlobals.FUNC_BUTTON_CLICK, _type);
		}

		public function get type():String
		{
			return _type;
		}

	}
}
