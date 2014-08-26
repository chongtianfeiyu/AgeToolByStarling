package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.vo.GiftFillVO;
	import com.icerain.age.vo.GiftVO;

	import feathers.controls.Button;

	import flash.events.Event;

	import starling.display.Image;
	import starling.text.TextField;

	public class GiftNameButton extends Button
	{
		public var _nameText:TextField;
		public var _selectedFlag:Image;
		public var giftFillVO:GiftFillVO;

		public function GiftNameButton(vo:GiftFillVO)
		{
			super();

			this.width=158;
			this.height=49;

			var bg:Image=new Image(MainApplaction.mAssetsManager.getTexture("giftBtn_diselected"));
			bg.touchable=false;
			this.addChild(bg);

			_selectedFlag=new Image(MainApplaction.mAssetsManager.getTexture("giftBtn_selectedFlag"));
			_selectedFlag.touchable=false;
			_selectedFlag.width=bg.width=this.width;
			_selectedFlag.height=bg.height=this.height;

			_nameText=new TextField(158, 49, "", "simhei", 35, 0x0);
			_nameText.touchable=false;
			this.addChild(_nameText);

			setGift(vo);
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected=value;
			if (isSelected)
			{
				this.addChild(_selectedFlag);
			}
			else
			{
				this.removeChild(_selectedFlag);
			}
		}

		public function setGift(vo:GiftFillVO):void
		{
			if (giftFillVO)
				giftFillVO.removeEventListeners(Event.CHANGE);
			this.giftFillVO=vo;
			giftFillVO.addEventListener(Event.CHANGE, updateCost);
			updateCost();
		}

		private function updateCost():void
		{
			_nameText.text=GiftVO.getName(giftFillVO.giftType) + "(" + giftFillVO.getPointCount() + ")";
		}
	}
}
