package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Frame;
	import com.icerain.age.module.simulater.GiftSimulaterGlobals;
	import com.icerain.age.module.simulater.model.GiftSimulaterProxy;
	import com.icerain.age.template.SkillXml;
	import com.icerain.age.vo.GiftFillVO;
	import com.icerain.age.vo.GiftVO;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.events.Event;

	public class GiftPanel extends Frame
	{
		private var _initiativeSkillView:InitiativeSkillView;
		private var _passivitySkillView:PassivitySkillView;
		private var _skillList:Array;
		public var index:uint;
		public var giftFillVO:GiftFillVO;

		public function GiftPanel(giftFillVO:GiftFillVO, index:uint)
		{
			super();
			this.index=index;
			this.width=640;
			this.height=600;

			_initiativeSkillView=new InitiativeSkillView();
			_initiativeSkillView.width=300;
			_initiativeSkillView.height=360;
			_initiativeSkillView.x=80;
			_initiativeSkillView.y=120;
			_initiativeSkillView.addEventListener(Event.TRIGGERED, onInitiativeSkillChanged);
			this.addChild(_initiativeSkillView);

			_passivitySkillView=new PassivitySkillView();
			_passivitySkillView.width=100;
			_passivitySkillView.height=480;
			_passivitySkillView.x=_initiativeSkillView.width + 160;
			_passivitySkillView.y=_initiativeSkillView.y;
			this.addChild(_passivitySkillView);
			_passivitySkillView.addEventListener(Event.TRIGGERED, onPassivitySkillChanged);

			setGift(giftFillVO);

		}

		public function get giftType():uint
		{
			return giftFillVO.giftType;
		}

		private function onPassivitySkillChanged(e:Event):void
		{
			var skillIcon:SkillIcon=e.data as SkillIcon;
			if (!skillIcon.selected && !checkZeroAP() && checkEnoughCostAP(skillIcon.skillXml))
			{
				skillIcon.selected=true;
				giftFillVO.updateSkillStatus(skillIcon.skillXml, true);
				Facade.getInstance().sendNotification(GiftSimulaterGlobals.SKILL_TREE_CHANED);
			}
			else if (skillIcon.selected)
			{
				skillIcon.selected=false;
				giftFillVO.updateSkillStatus(skillIcon.skillXml, false);
				Facade.getInstance().sendNotification(GiftSimulaterGlobals.SKILL_TREE_CHANED);
			}
			trace(giftFillVO);
		}

		private function checkZeroAP():Boolean
		{
			return 23 - giftFillVO.getPointCount() == 0;
		}

		private function checkEnoughCostAP(skillXml:SkillXml):Boolean
		{
			return giftFillVO.getPointCount() >= skillXml.level;
		}

		private function onInitiativeSkillChanged(e:Event):void
		{
			var skillIcon:SkillIcon=e.data as SkillIcon;
			if (!skillIcon.selected && !checkZeroAP())
			{
				skillIcon.selected=true;
				giftFillVO.updateSkillStatus(skillIcon.skillXml, true);
				Facade.getInstance().sendNotification(GiftSimulaterGlobals.SKILL_TREE_CHANED);
			}
			else if (skillIcon.selected)
			{
				skillIcon.selected=false;
				giftFillVO.updateSkillStatus(skillIcon.skillXml, false);
				Facade.getInstance().sendNotification(GiftSimulaterGlobals.SKILL_TREE_CHANED);
			}
			trace(giftFillVO);
		}


		public function setGift(vo:GiftFillVO):void
		{
			this.giftFillVO=vo;
			GiftSimulaterProxy.instance.curThreeGifts[index]=giftFillVO.giftType;
			_skillList=SkillXml.getSkillList(GiftVO.getName(giftFillVO.giftType));

			_passivitySkillView.removeChildren(0, -1, true);
			_initiativeSkillView.removeChildren(0, -1, true);
			for each (var skillXml:SkillXml in _skillList)
			{
				var pos:uint=GiftFillVO.getSkillPos(skillXml.level, skillXml.passive == 1);
				var isFilled:Boolean=giftFillVO.getIsFilled(pos);
				//被动技能
				if (skillXml.passive == 1)
				{
					_passivitySkillView.addSkill(skillXml, isFilled);
				}
				//主动技能
				else
				{
					_initiativeSkillView.addSkill(skillXml, isFilled);
				}
			}
		}

		override public function dispose():void
		{
			_initiativeSkillView.removeEventListener(Event.TRIGGERED, onInitiativeSkillChanged);
			_passivitySkillView.removeEventListener(Event.TRIGGERED, onPassivitySkillChanged);
			super.dispose();
		}
	}
}
