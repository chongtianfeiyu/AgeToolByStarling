package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Frame;
	import com.icerain.age.vo.BuffVO;

	import starling.display.Image;

	public class BuffIcon extends Frame
	{
		public var buffVO:BuffVO;
		public var frame:Image;

		public function BuffIcon(buffVO:BuffVO)
		{
			super();
			this.width=60;
			this.height=60;
			this.touchable=false;
			this.buffVO=buffVO;
			if (buffVO.isDebuff)
			{
				frame=new Image(ResourceModule.getSkillIconTexture("debuffFrame"));
				this.addChild(frame)
			}
			else if (!buffVO.isDebuff)
			{
				frame=new Image(ResourceModule.getSkillIconTexture("buffFrame"));
			}
			this.addChild(frame)
			frame.width=60;
			frame.height=60;

			var icon:Image=new Image(ResourceModule.getSkillIconTexture(buffVO.iconName));
			icon.width=52;
			icon.height=52;
			icon.x=4;
			icon.y=4;
			this.addChild(icon);
		}

		override public function dispose():void
		{
			super.dispose();
		}
	}
}
