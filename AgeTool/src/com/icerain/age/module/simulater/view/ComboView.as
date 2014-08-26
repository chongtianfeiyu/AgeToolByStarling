package com.icerain.age.module.simulater.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.HorizontalLayout;

	import com.icerain.age.components.Frame;
	import com.icerain.age.template.ComboXml;
	import com.icerain.age.vo.BuffVO;

	import starling.display.Image;
	import starling.text.TextField;

	public class ComboView extends Frame
	{
		public var comboXml:ComboXml;

		public function ComboView(comboXml:ComboXml)
		{
			super();
			this.comboXml=comboXml;
			this.width=540;
			this.height=80;


			var effectArray:Array=comboXml.getEffect();
			if (effectArray.length > 0)
			{
				var effectLayout:HorizontalLayout=new HorizontalLayout();
				effectLayout.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
				effectLayout.gap=10;
				var effectHBox:ScrollContainer=new ScrollContainer();
				effectHBox.layout=effectLayout;
				effectHBox.scrollerProperties.horizontalScrollerProperties=Scroller.SCROLL_POLICY_OFF;
				effectHBox.scrollerProperties.verticalScrollerProperties=Scroller.SCROLL_POLICY_OFF;
				effectHBox.width=200;
				effectHBox.height=65;
				effectHBox.y=10;
				effectHBox.x=15;
				this.addChild(effectHBox);
				for each (var vo:BuffVO in effectArray)
				{
					var buff:BuffIcon=new BuffIcon(vo);
					effectHBox.addChild(buff);
				}
			}
			var desc:TextField=new TextField(this.width - effectHBox.numChildren * 70 - 25, 60, comboXml.desc, "simhei", 24, 0x8ba947);
			desc.hAlign="left";
//			desc.border=true;
			desc.x=effectHBox.numChildren * 80;
			desc.y=10;
			this.addChild(desc);

			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(0x111111, .9);
			sp.graphics.drawRect(0, 0, this.width, this.height);
			sp.graphics.endFill();
			var bd:BitmapData=new BitmapData(this.width, this.height);
			bd.draw(sp);
			var bg:Image=Image.fromBitmap(new Bitmap(bd));
			this.addChildAt(bg, 0);
		}
	}
}
