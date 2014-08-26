package com.icerain.age.vo
{
	import com.icerain.age.template.SkillXml;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class GiftFillVO extends EventDispatcher
	{
		public var giftType:uint;
		/**
		 * 0到23位根本等级次序表示主动技能,
		 *
		 * 24到31位依次表示被动技能2,3,5,6,7点数
		 *
		 */
		public var skillFill:uint=0x0;

		public function GiftFillVO(giftType:uint)
		{
			this.giftType=giftType;
		}

		public function toString():String
		{
			return "gift:" + giftType.toString() + ",skills:" + skillFill.toString();
		}

		public function updateSkillStatus(skillXml:SkillXml, isFilled:Boolean):void
		{
			var pos:uint=getSkillPos(skillXml.level, skillXml.passive == 1);
			if (isFilled)
				skillFill|=0x1 << pos;
			else
				skillFill&=~(0x1 << pos);

			dispatchEvent(new Event(Event.CHANGE));
		}

		public function getPointCount():uint
		{
			var ret:uint=0;
			var temp:uint=skillFill;
			for (var i:uint=1; i <= 32; i++)
			{
				if ((temp & 0x01) == 0x1)
				{
					ret++;
				}
				temp=temp >> 1;
			}
			return ret;
		}

		public static function getSkillPos(level:int, isPassive:Boolean):uint
		{
			var pos:uint;
			if (isPassive)
			{
				switch (level)
				{
					case 2:
						pos=24;
						break;
					case 3:
						pos=25;
						break;
					case 5:
						pos=26
						break;
					case 6:
						pos=27
						break;
					case 7:
						pos=28
						break;
				}
			}
			else
			{
				if (level == 1)
				{
					pos=0;
				}
				else
				{
					pos=uint(level / 5);
				}
			}
			return pos;
		}

		public function getIsFilled(pos:uint):Boolean
		{
			return (((skillFill >> pos) & 0x1) == 0x1)
		}

		public static function fromQRCode(code:String):GiftFillVO
		{
			var patter:RegExp=/gift:([\d]+),skills:([\d]+)/;
			var result:Array=code.match(patter);
			var ret:GiftFillVO=new GiftFillVO(uint(result[1]));
			ret.skillFill=uint(result[2]);
			return ret;
		}
	}
}
