package com.icerain.age.module.simulater.view
{
	import com.icerain.age.components.Globals;
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.module.simulater.GiftSimulaterGlobals;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.ui.Keyboard;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.events.KeyboardEvent;

	public class CameraView extends Sprite
	{
		[Embed(source="/../assets/camera/CameraUI.swf", symbol="frontSight")]
		public static const FRONT_SIGHT:Class;
		[Embed(source="/../assets/camera/CameraUI.swf", symbol="cameraBtn")]
		public static const CAMERA_BNT:Class;
		public static var _instance:CameraView;
		private var _scale:Number;
		private var _camera:Camera;
		private var fronSight:Sprite;
		private var cameraBtn:Sprite;
		private var video:Video;

//		private var _timer:Timer=new Timer(5000);

		public function CameraView()
		{
			super();
			this.graphics.beginFill(0x0, 1);
			this.graphics.drawRect(0, 0, Globals.flashStage.fullScreenWidth, Globals.flashStage.fullScreenHeight);
			this.graphics.endFill();
			_scale=Globals.flashStage.fullScreenHeight / 960;

			if (Camera.isSupported)
			{
//				_timer.addEventListener(TimerEvent.TIMER, autoFocus);
//				_timer.start();
				_camera=Camera.getCamera();
				_camera.setMode(Globals.flashStage.fullScreenHeight / 2, Globals.flashStage.fullScreenWidth / 2, 30);
				video=new Video(Globals.flashStage.fullScreenHeight, Globals.flashStage.fullScreenWidth);
				video.attachCamera(_camera);
				video.rotation=90;
				video.x=video.width;
				addChild(video);
				_camera.addEventListener(ActivityEvent.ACTIVITY, onCameraActivity);
			}

			MainApplaction.getInstance().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.BACK)
			{
				e.stopPropagation();
				close();
			}
		}

		protected function onCameraActivity(event:ActivityEvent):void
		{
			fronSight=(new FRONT_SIGHT()) as Sprite;
			fronSight.alpha=.5;
			fronSight.scaleX=fronSight.scaleY=_scale;
			this.addChild(fronSight);
			fronSight.x=(this.width - fronSight.width) / 2;
			fronSight.y=(this.height - fronSight.height) / 2;

			cameraBtn=(new CAMERA_BNT()) as Sprite;
			cameraBtn.scaleX=cameraBtn.scaleY=_scale;
			cameraBtn.y=this.height - cameraBtn.height;
			cameraBtn.x=(this.width - cameraBtn.width) / 2;
			this.addChild(cameraBtn);
			cameraBtn.addEventListener(MouseEvent.CLICK, onClick);
		}

		protected function onClick(event:MouseEvent):void
		{
			var mt:Matrix=new Matrix();
			mt.rotate(Math.PI / 2);
			mt.translate(video.width, 0);
			mt.translate(-fronSight.x, -fronSight.y);
			var bd:BitmapData=new BitmapData(fronSight.width, fronSight.height, true, 0x0);
			bd.draw(video, mt);
			Facade.getInstance().sendNotification(GiftSimulaterGlobals.QR_IMAGE_COMPLETED, bd);
		}

		public static function show():void
		{
			if (Camera.isSupported)
			{
				if (!_instance)
					_instance=new CameraView();
				Globals.flashStage.addChild(_instance);
				MainApplaction.getInstance().touchable=false;
			}
		}

		public static function close():void
		{
			if (_instance)
			{
				_instance.parent.removeChild(_instance);
				_instance.dispose();
				MainApplaction.getInstance().touchable=true;
			}
		}

		public function dispose():void
		{
			MainApplaction.getInstance().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			cameraBtn.removeEventListener(MouseEvent.CLICK, onClick);
			this.removeChild(cameraBtn);
			this.removeChild(fronSight);
			this.removeChild(video);
			video.attachCamera(null);
//			_timer.stop();
//			_timer.removeEventListener(TimerEvent.TIMER, autoFocus);
			video.clear();
			_instance=null;
		}

//		private function autoFocus(e:TimerEvent):void
//		{
//			if (_camera)
//				_camera.removeEventListener(ActivityEvent.ACTIVITY, onCameraActivity);
//			_camera=Camera.getCamera();
//			_camera.setMode(Globals.flashStage.fullScreenHeight, Globals.flashStage.fullScreenWidth, 15);
//			video.clear();
//			video.attachCamera(_camera);
//		}
	}
}
