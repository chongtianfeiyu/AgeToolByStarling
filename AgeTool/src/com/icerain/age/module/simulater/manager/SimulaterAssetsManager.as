package com.icerain.age.module.simulater.manager
{
	import starling.utils.AssetManager;

	public class SimulaterAssetsManager extends AssetManager
	{
		private static var _instance:SimulaterAssetsManager;

		public function SimulaterAssetsManager(scaleFactor:Number=-1, useMipmaps:Boolean=false)
		{
			super(scaleFactor, useMipmaps);
		}

		public static function get instance():SimulaterAssetsManager
		{
			return _instance;
		}

		public static function createInstance():void
		{
			if (_instance == null)
				_instance=new SimulaterAssetsManager();
			else
				throw(new Error("SimulaterAssetsManager单例不可重复创建"));
		}

		public static function releaseInstance():void
		{
			if (_instance)
				_instance.dispose();
			_instance=null;
		}
	}
}
