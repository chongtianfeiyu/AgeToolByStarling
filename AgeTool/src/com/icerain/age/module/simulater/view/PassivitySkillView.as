package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Frame;
	import com.icerain.age.template.SkillXml;

	import starling.events.Event;

	public class PassivitySkillView extends Frame
	{
		public function PassivitySkillView()
		{
			super();
		}

		public function addSkill(skillXml:SkillXml, isFilled:Boolean):void
		{
			var skillIcon:SkillIcon=new SkillIcon(skillXml);
			skillIcon.selected=isFilled;
			var index:uint=0;
			switch (skillXml.level)
			{
				case 2:
					index=0;
					break;
				case 3:
					index=1;
					break;
				case 5:
					index=2;
					break;
				case 6:
					index=3;
					break;
				case 7:
					index=4;
					break;
			}
			skillIcon.y=100 * index;
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
