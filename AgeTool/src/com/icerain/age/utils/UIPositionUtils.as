package com.icerain.age.utils
{
	import com.icerain.age.components.Globals;

	import starling.display.DisplayObject;

	public class UIPositionUtils
	{
		public function UIPositionUtils()
		{
		}

		public static function setCenter(ui:DisplayObject):Boolean
		{
			if (ui != null)
			{
				ui.x=(Globals.stage.stageWidth - ui.width) / 2;
				ui.y=(Globals.stage.stageHeight - ui.height) / 2;
				return true;
			}
			else
				return false;
		}
	}
}
