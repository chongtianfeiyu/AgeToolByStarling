package com.icerain.age.utils
{
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import com.icerain.age.vo.CookieVO;

	/**
	 *
	 * CookieManager.as
	 *
	 * @author moyubing
	 * @date 2013-9-6
	 *
	 */
	public class CookieManager
	{
		private static var _instance:CookieManager;
		private var _cookies:Dictionary;

		public function CookieManager()
		{
			_cookies=new Dictionary();
		}

		public static function get instance():CookieManager
		{
			return _instance;
		}

		public static function createInstance():CookieManager
		{
			if (_instance == null)
				_instance=new CookieManager();
			else
				//"CookieManager是单例只能创建一个"
				Error.throwError(CookieManager, 0);
			return _instance;
		}

		public function getCookie(key:String):CookieVO
		{
			var so:SharedObject=_cookies[key];
			if (so == null)
				_cookies[key]=so=SharedObject.getLocal(key);
			return new CookieVO(so);
		}
	}
}


