package com.icerain.age.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;

	import starling.display.Image;

	public class HtmlTextField extends Frame
	{
		public var textField:TextField;

		public function HtmlTextField(w:Number, h:Number)
		{
			super();
			this.width=w;
			this.height=h;

			textField=new TextField();
			textField.width=this.width;
			textField.height=this.height;
			renderText();
		}

		private function renderText():void
		{
			this.removeChildren(0, -1);
			var bp:BitmapData=new BitmapData(this.width, this.height, true, 0);
			bp.draw(textField);
			this.addChild(Image.fromBitmap(new Bitmap(bp)));
		}

		public function set htmlText(str:String):void
		{
			textField.htmlText=str;
			renderText();
		}
	}
}
