package com.icerain.age.module.main.controller
{
	import com.icerain.age.components.ModuleGlobals;

	import org.puremvc.as3.extend.CommandDTO;
	import org.puremvc.as3.patterns.facade.Facade;

	public class MainCmd extends CommandDTO
	{
		public function MainCmd()
		{
			super();
		}
		private static var _instance:MainCmd;

		public static function get instance():MainCmd
		{
			if (_instance == null)
				_instance=new MainCmd();
			return _instance;
		}

		private function send():void
		{
			Facade.getInstance().sendNotification(ModuleGlobals.MAIN_CMD, this);
		}
	}
}
