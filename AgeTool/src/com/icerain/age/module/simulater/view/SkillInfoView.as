package com.icerain.age.module.simulater.view
{
	import com.greensock.TweenLite;
	import com.icerain.age.components.Frame;
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.template.ComboXml;
	import com.icerain.age.template.SkillXml;
	import com.icerain.age.utils.MeasureTextHeight;
	import com.icerain.age.vo.BuffVO;

	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.ui.Keyboard;

	import starling.display.Graphics;
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class SkillInfoView extends Frame
	{
		private static var _instace:SkillInfoView;
		private var desc:TextField;
		private var _skillIcon:Image;

		public function SkillInfoView(skillXml:SkillXml)
		{
			super();
			this.width=600;
			this.height=0;

			var iconFrame:Image=new Image(ResourceModule.getSkillIconTexture("iconFrame"));
			iconFrame.width=100;
			iconFrame.height=100;
			iconFrame.x=28;
			iconFrame.y=28;
			this.addChild(iconFrame);

			_skillIcon=new Image(ResourceModule.getSkillIconTexture(skillXml.icon));
			_skillIcon.width=96;
			_skillIcon.height=96;
			_skillIcon.x=30;
			_skillIcon.y=30;
			this.addChild(_skillIcon);
			this.height+=130;

			if (skillXml.passive == 0)
			{
				var giftName:TextField=new TextField(80, 40, skillXml.gift, "simhei", 26, 0xffa127);
				giftName.touchable=false;
				giftName.hAlign="left";
				giftName.x=_skillIcon.x + _skillIcon.width + 10;
				giftName.y=45;
				this.addChild(giftName);
				this.height+=50;

				var skillName:TextField=new TextField(250, 40, skillXml.name + " (1级)", "simhei", 30, 0xf1f0ef);
				skillName.touchable=false;
				skillName.hAlign="left";
				skillName.x=giftName.x;
				skillName.y=giftName.y + giftName.height;
				this.addChild(skillName);


				var cost:TextField=new TextField(180, 30, skillXml.cost, "simhei", 26, 0xd2c1ad);
				cost.touchable=false;
				cost.hAlign="left";
				cost.x=30;
				cost.y=140;
				this.addChild(cost);
				this.height+=30;

				var distance:TextField=new TextField(300, 30, skillXml.distance.split(";")[0], "simhei", 26, 0xd2c1ad);
				distance.hAlign="left";
				distance.x=cost.x;
				var cdY:Number=distance.y=cost.y + cost.height;
				this.addChild(distance);
				this.height+=30;

				if (skillXml.distance.indexOf(";") != -1)
				{
					var distance2:TextField=new TextField(300, 30, skillXml.distance.split(";")[1], "simhei", 26, 0xd2c1ad);
					distance2.hAlign="left";
					distance2.x=cost.x;
					cdY=distance2.y=distance.y + distance.height;
					this.addChild(distance2);
					this.height+=30;
				}
				var castTime:TextField=new TextField(200, 30, skillXml.getCastTime(), "simhei", 26, 0xd2c1ad);
				castTime.hAlign="right";
				castTime.y=cost.y;
				castTime.x=this.width - castTime.width - 30;
				this.addChild(castTime);

				var cd:TextField=new TextField(300, 30, skillXml.getCD(), "simhei", 26, 0xd2c1ad);
				cd.hAlign="right";
				cd.y=cdY;
				cd.x=this.width - cd.width - 30;
				this.addChild(cd);

				var effectArray:Array=skillXml.getEffect();

				if (effectArray.length > 0)
				{
					var effectLayout:HorizontalLayout=new HorizontalLayout();
					effectLayout.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
					effectLayout.gap=10;
					var effectHBox:ScrollContainer=new ScrollContainer();
					effectHBox.layout=effectLayout;
					effectHBox.scrollerProperties.horizontalScrollerProperties=Scroller.SCROLL_POLICY_OFF;
					effectHBox.scrollerProperties.verticalScrollerProperties=Scroller.SCROLL_POLICY_OFF;
					effectHBox.width=200;
					effectHBox.height=65;
					effectHBox.y=cd.y + cd.height + 10;
					effectHBox.x=this.width - effectHBox.width - 30;
					this.addChild(effectHBox);
					for each (var vo:BuffVO in effectArray)
					{
						var buff:BuffIcon=new BuffIcon(vo);
						effectHBox.addChild(buff);
					}
					this.height+=70;
				}
				var descStr:String=skillXml.getDesc();
				desc=new TextField(this.width - 60, MeasureTextHeight.measure(descStr), descStr, "simhei", 26, 0xd2c1ad);
				desc.autoScale=true;
//				desc.border=true;
				desc.x=30
				if (effectHBox)
					desc.y=effectHBox.y + effectHBox.height + 20;
				else
					desc.y=cd.y + cd.height + 20;
				desc.hAlign="left";
				desc.vAlign="top";
				this.addChild(desc);
				var descBg:Frame=new Frame();
				descBg.width=desc.width;
				descBg.height=descBg.height;
				this.addChildAt(descBg, 0);
				var gh:Graphics=new Graphics(descBg);
				gh.beginFill(0x0, .5);
				gh.drawRect(desc.x, desc.y, desc.width, desc.height);
				gh.endFill();
				this.height+=desc.height;

				var comboArray:Array=skillXml.getComboArray();
				if (comboArray.length > 0)
				{
					var comboMark:Image=new Image(ResourceModule.getSkillIconTexture("comboMark"));
					comboMark.width=64;
					comboMark.height=38;
					comboMark.x=(this.width - comboMark.width) / 2;
					comboMark.y=this.height;
					this.addChild(comboMark);
					this.height+=comboMark.height + 5;

					var combotLayout:VerticalLayout=new VerticalLayout();
					combotLayout.horizontalAlign=VerticalLayout.HORIZONTAL_ALIGN_CENTER;
					combotLayout.verticalAlign=VerticalLayout.VERTICAL_ALIGN_TOP;
					var comboVBox:ScrollContainer=new ScrollContainer();
					comboVBox.layout=combotLayout;
					comboVBox.scrollerProperties.horizontalScrollerProperties=Scroller.SCROLL_POLICY_OFF;
					comboVBox.scrollerProperties.verticalScrollerProperties=Scroller.SCROLL_POLICY_OFF;
					comboVBox.width=540;
//					effectHBox.height=65;
					comboVBox.y=this.height;
					comboVBox.x=30;
					this.addChild(comboVBox);
					for each (var comboXml:ComboXml in comboArray)
					{
						var comboCell:ComboView=new ComboView(comboXml);
						comboVBox.addChild(comboCell);
						this.height+=comboCell.height;
					}
					this.height+=10;
				}

				var conditionStr:String="学习需要[" + skillXml.gift + "]天赋" + skillXml.level + "级";
				var condition:TextField=new TextField(300, 30, conditionStr, "simhei", 26, 0xbf3d36);
				condition.hAlign="left";
				condition.x=30;
				condition.y=this.height;
				this.addChild(condition);
				this.height+=40;

			}
			else
			{
				castTime=new TextField(200, 30, "持续技能", "simhei", 20, 0xd2c1ad);
				castTime.hAlign="left";
				castTime.y=_skillIcon.y + 20;
				castTime.x=_skillIcon.x + _skillIcon.width + 10;
				this.addChild(castTime);

				skillName=new TextField(250, 40, skillXml.name, "simhei", 30, 0xd2c1ad);
				skillName.touchable=false;
				skillName.hAlign="left";
				skillName.x=castTime.x;
				skillName.y=castTime.y + castTime.height;
				this.addChild(skillName);

				descStr=skillXml.getDesc();
				desc=new TextField(this.width - 60, MeasureTextHeight.measure(descStr), descStr, "simhei", 26, 0xd2c1ad);
				desc.autoScale=true;
//				desc.border=true;
				desc.y=this.height + 20;
				desc.x=30
				desc.hAlign="left";
				desc.vAlign="top";
				this.addChild(desc);
				descBg=new Frame();
				descBg.width=desc.width;
				descBg.height=descBg.height;
				this.addChildAt(descBg, 0);
				gh=new Graphics(descBg);
				gh.beginFill(0x0, .5);
				gh.drawRect(desc.x, desc.y, desc.width, desc.height);
				gh.endFill();
				this.height+=desc.height + 20;

				conditionStr="学习需要学习" + skillXml.level + "点[" + skillXml.gift + "]天赋的技能";
				condition=new TextField(500, 30, conditionStr, "simhei", 26, 0xbf3d36);
				condition.hAlign="left";
				condition.x=30;
				condition.y=this.height + 20;
				this.addChild(condition);
				this.height+=condition.height + 20;

				this.height+=10;


			}


			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(0x0, .7);
			sp.graphics.drawRect(0, 0, this.width, this.height);
			sp.graphics.endFill();
			var bd:BitmapData=new BitmapData(this.width, this.height);
			bd.draw(sp);
			var bg:Image=Image.fromBitmap(new Bitmap(bd));
			this.addChildAt(bg, 0);
			this.addEventListener(TouchEvent.TOUCH, onTouched);
		}

		private function onTouched(e:TouchEvent):void
		{
			if (e.getTouch(this, TouchPhase.ENDED))
			{
				close();
			}
		}

		public static function show(skillXml:SkillXml):void
		{
			if (_instace == null)
				_instace=new SkillInfoView(skillXml);
			PopUpManager.addPopUp(_instace);
			_instace.alpha=.5;
			TweenLite.to(_instace, .3, {alpha: 1});
			MainApplaction.getInstance().stage.addEventListener(KeyboardEvent.KEY_DOWN, _instace.onKeyDown);
		}

		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.BACK)
			{
				e.stopPropagation();
				e.stopImmediatePropagation();
				close();
			}
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
			MainApplaction.getInstance().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.removeEventListener(TouchEvent.TOUCH, onTouched);
			super.dispose();
			_instace=null;
		}
	}
}
