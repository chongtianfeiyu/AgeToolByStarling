package com.icerain.age.module.simulater.view
{

	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.Binarizer;
	import com.google.zxing.BinaryBitmap;
	import com.google.zxing.BufferedImageLuminanceSource;
	import com.google.zxing.DecodeHintType;
	import com.google.zxing.MultiFormatReader;
	import com.google.zxing.MultiFormatWriter;
	import com.google.zxing.Result;
	import com.google.zxing.common.BitMatrix;
	import com.google.zxing.common.HybridBinarizer;
	import com.google.zxing.common.flexdatatypes.HashTable;
	import com.icerain.age.components.Globals;
	import com.icerain.age.components.LoadingView;
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.components.ModuleGlobals;
	import com.icerain.age.module.simulater.GiftSimulaterGlobals;
	import com.icerain.age.module.simulater.manager.SimulaterAssetsManager;
	import com.icerain.age.module.simulater.model.GiftSimulaterProxy;
	import com.icerain.age.template.CareerXml;
	import com.icerain.age.utils.FileUtil;
	import com.icerain.age.utils.PNGEncoder;
	import com.icerain.age.utils.TS;
	import com.icerain.age.utils.TextUtil;
	import com.icerain.age.vo.CareerVO;
	import com.icerain.age.vo.GiftFillVO;
	import com.icerain.age.vo.GiftVO;
	import com.ssd.ane.AndroidExtensions;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.MediaEvent;
	import flash.external.ExtensionContext;
	import flash.filesystem.File;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.MediaPromise;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;

	import org.puremvc.as3.interfaces.INotification;

	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;

	public class GiftSimulaterView extends GiftSimulaterViewBase
	{

		private var _curIndex:uint=0;
		private var _curCareerVO:CareerVO;
		private var _qrBitmapData:BitmapData;

		public function GiftSimulaterView(viewComponent:Object=null)
		{
			super(ModuleGlobals.GIFT_SIMULATER_MEDIATOR, viewComponent);
		}

		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GiftSimulaterGlobals.INIT_GIFT_SIMULATER:
					if (!_isShow)
					{
						MainApplaction.getInstance()._mainLayer.addChild(this);
						var loader:Loader=new Loader();
						loader.load(new URLRequest("skillicons/icons.swf"));
						loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, function(e:flash.events.Event):void
						{
							var bg:Image=new Image(MainApplaction.mAssetsManager.getTexture("bg"));
							bg.width=Globals.stageWidth;
							bg.height=Globals.stageHeight;
							addChildAt(bg, 0);
							ResourceModule.domain=(e.currentTarget as LoaderInfo).applicationDomain;
							initView(new CareerVO(new GiftFillVO(GiftVO.ANSHA), new GiftFillVO(GiftVO.GEDOU), new GiftFillVO(GiftVO.TIEBI)));
							MainApplaction.getInstance().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
						})
					}
					_isShow=true;
					break;
				case GiftSimulaterGlobals.RELEASE_GIFT_SIMULATER:
					relaseView();
					_isShow=false;
					break;
				case GiftSimulaterGlobals.SKILL_TREE_CHANED:
					updateAP();
					break;
				case GiftSimulaterGlobals.GET_OTHERS_SKILL_POINT:
					CameraView.show();
					break;
				case GiftSimulaterGlobals.QR_IMAGE_COMPLETED:
					CameraView.close();
					var bd:BitmapData=notification.getBody() as BitmapData;
					var qrTexture:Texture=Texture.fromBitmapData(bd);
					qrImage.texture=qrTexture;
					var binaryBitmap:BinaryBitmap=new BinaryBitmap(new HybridBinarizer(new BufferedImageLuminanceSource(bd)));
					var hints:HashTable=new HashTable();
					hints.Add(DecodeHintType.CHARACTER_SET, "GBK");
					var decoder:MultiFormatReader=new MultiFormatReader();
					var result:Result=decoder.decode(binaryBitmap, hints);
					if (result)
					{
						initView(CareerVO.fromQRCode(result.getText()));
					}
					else
					{
						trace("无法解析");
					}
					break;
				case GiftSimulaterGlobals.SHARE_MY_SKILL_POINT:
					if (Globals.platform == Globals.PLATFORM_ANDROID)
					{
						updateQR();
						if (_qrBitmapData)
						{
							var by:ByteArray=PNGEncoder.encode(_qrBitmapData);
							var time:Date=new Date();
							var fileName:String=_curCareerVO.careerXml.career + "_" + time.month + "_" + time.day;
							var filePath:String=File.documentsDirectory.nativePath + "/AgeTool/" + fileName + ".png";
							FileUtil.writeBytesTofile(filePath, by);
							AndroidExtensions.shareImage(filePath, "分享");
						}
					}
					break;
			}
		}

		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.BACK)
			{
				e.stopPropagation();
				facade.sendNotification(GiftSimulaterGlobals.RELEASE_GIFT_SIMULATER);
			}
		}

		private function authComplete(result:String):void
		{
		}

		private function shareError(e:String):void
		{
			trace(e);
		}

		private function shareBack(e:String):void
		{
			trace(e);
		}

		protected function getOtherSkill(event:MediaEvent):void
		{
			event.target.addEventListener(MediaEvent.COMPLETE, getOtherSkill);
			var mediaPromise:MediaPromise=event.data as MediaPromise;
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, function(e:flash.events.Event):void
			{
				var bp:Bitmap=loader.contentLoaderInfo.content as Bitmap;
				var scale:Number=150 / bp.width;
				var bd:BitmapData=new BitmapData(150, scale * bp.height, true, 0x0);
				var mt:Matrix=new Matrix();
				mt.scale(scale, scale);
				bd.draw(bp, mt);
				_qrBitmapData=bd;
				var qrTexture:Texture=Texture.fromBitmapData(bd);
				qrImage.texture=qrTexture;
				var binaryBitmap:BinaryBitmap=new BinaryBitmap(new Binarizer(new BufferedImageLuminanceSource(bd)));
				var decoder:MultiFormatReader=new MultiFormatReader();
//				trace(decoder.decode(binaryBitmap).getText());
			});
			loader.loadFilePromise(mediaPromise);
		}

		override public function initView(careerVO:CareerVO):void
		{
			_curCareerVO=careerVO;
			if (!_inited)
			{
				super.initView(careerVO);
				_scroller.addEventListener(starling.events.Event.SCROLL, onScrollerRun);

				giftPanel1=new GiftPanel(_curCareerVO.gift1, 0);
				_scroller.addChild(giftPanel1);
				giftBtn1=new GiftNameButton(giftPanel1.giftFillVO);
				giftBtn1.y=_scroller.y - giftBtn1.height;
				giftBtn1.x=80;
				giftBtn1.addEventListener(starling.events.Event.TRIGGERED, onGiftBtnClick);
				giftBtn1.isSelected=true;
				addChild(giftBtn1);


				giftPanel2=new GiftPanel(_curCareerVO.gift2, 1);
				_scroller.addChild(giftPanel2);
				giftBtn2=new GiftNameButton(giftPanel2.giftFillVO);
				giftBtn2.y=_scroller.y - giftBtn2.height;
				giftBtn2.x=250;
				giftBtn2.addEventListener(starling.events.Event.TRIGGERED, onGiftBtnClick);
				addChild(giftBtn2)

				giftPanel3=new GiftPanel(_curCareerVO.gift3, 2);
				_scroller.addChild(giftPanel3);
				giftBtn3=new GiftNameButton(giftPanel3.giftFillVO);
				giftBtn3.y=_scroller.y - giftBtn3.height;
				giftBtn3.x=420;
				giftBtn3.addEventListener(starling.events.Event.TRIGGERED, onGiftBtnClick);
				addChild(giftBtn3)
			}
			else if (_inited)
			{
				giftPanel1.setGift(_curCareerVO.gift1);
				giftBtn1.setGift(giftPanel1.giftFillVO);
				giftPanel2.setGift(_curCareerVO.gift2);
				giftBtn2.setGift(giftPanel2.giftFillVO);
				giftPanel3.setGift(_curCareerVO.gift3);
				giftBtn3.setGift(giftPanel3.giftFillVO);
			}

			LoadingView.close();
			updateAP();
			updateQR();
		}

		private function updateQR():void
		{
			var qrString:String=giftPanel1.giftFillVO + ";";
			qrString+=giftPanel2.giftFillVO + ";"
			qrString+=giftPanel3.giftFillVO + ";"
			var qrCoder:MultiFormatWriter=new MultiFormatWriter();
			var bmd:BitmapData=new BitmapData(150, 150, true, 0x0);
			var matrix:BitMatrix;
			matrix=qrCoder.encode(qrString, BarcodeFormat.QR_CODE, 150, 150) as BitMatrix;
			for (var h:int=0; h < 250; h++)
			{
				for (var w:int=0; w < 250; w++)
				{
					if (matrix._get(w, h) == 0)
					{
						bmd.setPixel32(w, h, 0xFFFFFFFF);
					}
					else
					{
						bmd.setPixel32(w, h, 0xFF000000);
					}
				}
			}
			_qrBitmapData=bmd;
			var qrTexture:Texture=Texture.fromBitmapData(bmd);
			qrImage.texture=qrTexture;

		}

		public function onScrollerRun():void
		{
			if (!_scroller.isScrolling)
			{
				for (var i:int=0; i < 3; i++)
				{
					var giftNameBtn:GiftNameButton=this["giftBtn" + (i + 1)];
					giftNameBtn.isSelected=(i == _scroller.horizontalPageIndex);
				}
			}

		}

		private function onGiftBtnClick(e:starling.events.Event):void
		{
			var index:uint=0;
			var giftPanel:GiftPanel;
			var btn:GiftNameButton=e.currentTarget as GiftNameButton;
			giftBtn1.isSelected=false;
			giftBtn2.isSelected=false;
			giftBtn3.isSelected=false;
			btn.isSelected=true;
			switch (btn)
			{
				case giftBtn1:
					giftPanel=giftPanel1;
					index=0;
					break;
				case giftBtn2:
					giftPanel=giftPanel2;
					index=1;
					break;
				case giftBtn3:
					giftPanel=giftPanel3;
					index=2;
					break;
			}
			if (_curIndex != index)
			{
				_curIndex=index;
				_scroller.scrollToPageIndex(_curIndex, 0, .5);
			}
			else
			{
				GiftSelectView.show(GiftSimulaterProxy.instance.getOtherSevenGifts(), function(vo:GiftFillVO):void
				{
					btn.setGift(vo);
					giftPanel.setGift(vo);
					updateAP();
				});
			}
		}


		private function relaseView():void
		{
			MainApplaction.getInstance()._mainLayer.removeChild(this, true);
		}

		public function updateAP():void
		{
			var carrerName:String=CareerXml.getCareerByType(giftPanel1.giftType | giftPanel2.giftType | giftPanel3.giftType).career;
			var costAP:uint=giftPanel1.giftFillVO.getPointCount() + giftPanel2.giftFillVO.getPointCount() + giftPanel3.giftFillVO.getPointCount();
			_tips.htmlText=TextUtil.formate(TS.AP_TEXT, carrerName, costAP);
		}

		override public function listNotificationInterests():Array
		{
			return [GiftSimulaterGlobals.INIT_GIFT_SIMULATER,
				GiftSimulaterGlobals.SKILL_TREE_CHANED,
				GiftSimulaterGlobals.GET_OTHERS_SKILL_POINT,
				GiftSimulaterGlobals.SHARE_MY_SKILL_POINT,
				GiftSimulaterGlobals.QR_IMAGE_COMPLETED];
		}

		override public function dispose():void
		{
			MainApplaction.getInstance().stage.removeEventListeners(KeyboardEvent.KEY_DOWN);
			_scroller.removeEventListener(starling.events.Event.SCROLL, onScrollerRun);
			giftBtn1.removeEventListener(starling.events.Event.TRIGGERED, onGiftBtnClick);
			giftBtn2.removeEventListener(starling.events.Event.TRIGGERED, onGiftBtnClick);
			giftBtn3.removeEventListener(starling.events.Event.TRIGGERED, onGiftBtnClick);
			super.dispose();
		}

	}
}
