package com.icerain.age.components
{
	import feathers.controls.ProgressBar;
	import feathers.core.PopUpManager;


	public class LoadingView extends Frame
	{
		private var _progressBar:ProgressBar;
		private static var _instance:LoadingView;

		public function LoadingView()
		{
			super();

			this.width=200;
			this.height=50;
			_progressBar=new ProgressBar();
			_progressBar.width=200;
			_progressBar.height=50;
			_progressBar.maximum=100;
			this.addChild(_progressBar);
		}

		public function updateRatio(ratio:Number):void
		{
			_progressBar.value=ratio;
		}

		public static function show(ratio:Number):LoadingView
		{
			return _instance;
		}

		public static function close():void
		{
		}

		override public function dispose():void
		{
			super.dispose();
		}
	}
}
