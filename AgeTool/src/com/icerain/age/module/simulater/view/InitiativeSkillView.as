package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Frame;
	import com.icerain.age.template.SkillXml;

	import starling.events.Event;

	public class InitiativeSkillView extends Frame
	{
		public function InitiativeSkillView()
		{
			super();
		}

		public function addSkill(skillXml:SkillXml, isFilled:Boolean):void
		{
			var skillIcon:SkillIcon=new SkillIcon(skillXml);
			skillIcon.selected=isFilled;
			var index:uint;
			if (skillXml.level != 1)
			{
				index=skillXml.level / 5;
			}
			else
			{
				index=0;
			}
			skillIcon.index=index;
			skillIcon.x=100 * (index % 3);
			skillIcon.y=100 * int(index / 3);
			this.addChild(skillIcon);

			skillIcon.addEventListener(Event.TRIGGERED, function(e:Event):void
			{
				e.stopImmediatePropagation();
				dispatchEvent(new Event(Event.TRIGGERED, false, e.currentTarget));
			});
		}

		override public function dispose():void
		{
			while (this.numChildren > 0)
				this.removeChildAt(0, true).removeEventListeners(Event.TRIGGERED);
			super.dispose();
		}
	}
}
