package com.icerain.age.module.simulater.controller
{
	import com.icerain.age.components.ModuleGlobals;

	import org.puremvc.as3.extend.CommandDTO;
	import org.puremvc.as3.patterns.facade.Facade;

	public class GiftSimulaterCmd extends CommandDTO
	{
		public function GiftSimulaterCmd()
		{
			super();
		}
		private static var _instance:GiftSimulaterCmd;

		public static function get instance():GiftSimulaterCmd
		{
			if (_instance == null)
				_instance=new GiftSimulaterCmd();
			return _instance;
		}

		private function send():void
		{
			Facade.getInstance().sendNotification(ModuleGlobals.GIFT_SIMULATER_CMD, this);
		}
	}
}
