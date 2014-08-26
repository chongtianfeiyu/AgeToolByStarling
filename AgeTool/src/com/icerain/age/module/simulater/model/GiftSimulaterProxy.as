package com.icerain.age.module.simulater.model
{
	import com.icerain.age.components.Globals;
	import com.icerain.age.components.ModuleGlobals;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class GiftSimulaterProxy extends Proxy implements IProxy
	{
		private static var _instance:GiftSimulaterProxy;
		public static const maxAP:int=23;

		public function GiftSimulaterProxy(proxyName:String=null, data:Object=null)
		{
			super(ModuleGlobals.GIFT_SIMULATER_PROXY, data);
			_instance=this;
		}

		public static function get instance():GiftSimulaterProxy
		{
			return _instance;
		}
		private var _curThreeGifts:Array=[];

		public function get curThreeGifts():Array
		{
			return _curThreeGifts;
		}

		public function getOtherSevenGifts():Array
		{
			var ret:Array=[];
			for each (var giftType:uint in Globals.TOTAL_GIFTS)
			{
				if (curThreeGifts.indexOf(giftType) == -1)
					ret.push(giftType);
			}
			return ret;
		}
	}
}
