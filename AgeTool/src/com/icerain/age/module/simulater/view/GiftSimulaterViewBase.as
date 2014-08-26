package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.BaseViewMediator;
	import com.icerain.age.components.Globals;
	import com.icerain.age.components.HtmlTextField;
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.module.simulater.GiftSimulaterGlobals;
	import com.icerain.age.vo.CareerVO;

	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.layout.HorizontalLayout;

	import flash.text.TextFormat;

	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	public class GiftSimulaterViewBase extends BaseViewMediator
	{
		protected var _scroller:ScrollContainer;
		protected var _isShow:Boolean=false;
		protected var _tips:HtmlTextField;
		protected var giftBtn1:GiftNameButton;
		protected var giftBtn2:GiftNameButton;
		protected var giftBtn3:GiftNameButton;
		protected var giftPanel3:GiftPanel;
		protected var giftPanel1:GiftPanel;
		protected var giftPanel2:GiftPanel;
		protected var qrImage:Image;
		protected var shareBtn:Button;
		protected var getBtn:Button;
		protected var _inited:Boolean=false;

		public function GiftSimulaterViewBase(mediatorName:String, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}

		public function initView(careerVO:CareerVO):void
		{
			var layout:HorizontalLayout=new HorizontalLayout();
			layout.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			_scroller=new ScrollContainer();
			_scroller.layout=layout;
			_scroller.width=Globals.stageWidth;
			_scroller.height=700;
			_scroller.x=0;
			_scroller.y=Globals.stageHeight - _scroller.height;
			_scroller.scrollerProperties.verticalScrollerProperties=Scroller.SCROLL_POLICY_OFF;
			_scroller.snapToPages=true;
			addChild(_scroller);

			_tips=new HtmlTextField(450, 100);
			_tips.touchable=false;
			_tips.x=(Globals.srcWidth - _tips.width) / 2;
			_tips.y=_scroller.y + 10;
			addChild(_tips);

			qrImage=new Image(Texture.empty(150, 150));
			qrImage.width=qrImage.height=150;
			qrImage.x=180;
			qrImage.y=Globals.stageHeight - 770 - qrImage.height;
			this.addChild(qrImage);

			shareBtn=new Button(MainApplaction.mAssetsManager.getTexture("button-up-skin"));
//			shareBtn.fontName="simhei";
			shareBtn.fontSize=24;
			shareBtn.text="分享";
			shareBtn.width=160;
			shareBtn.height=44;
			shareBtn.x=400;
			shareBtn.y=Globals.stageHeight - 860 - shareBtn.height;
			shareBtn.addEventListener(Event.TRIGGERED, function():void
			{
				facade.sendNotification(GiftSimulaterGlobals.SHARE_MY_SKILL_POINT);
			});
			this.addChild(shareBtn);

			getBtn=new Button(MainApplaction.mAssetsManager.getTexture("button-up-skin"));
//			getBtn.fontName="simhei"
			getBtn.fontSize=24;
			getBtn.text="获取";
			getBtn.width=160;
			getBtn.height=44;
			getBtn.x=400;
			getBtn.y=Globals.stageHeight - 800 - getBtn.height;
			getBtn.addEventListener(Event.TRIGGERED, function():void
			{
				facade.sendNotification(GiftSimulaterGlobals.GET_OTHERS_SKILL_POINT);
			});
			this.addChild(getBtn);

			_inited=true;
		}

		override public function dispose():void
		{
			shareBtn.removeEventListeners(Event.TRIGGERED);
			getBtn.removeEventListeners(Event.TRIGGERED);
			super.dispose();
		}

	}
}
