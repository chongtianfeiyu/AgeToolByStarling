package com.icerain.age.vo
{
	import flash.net.SharedObject;

	/**
	 *
	 * CookieVO.as
	 *
	 * @author moyubing
	 * @date 2013-9-6
	 *
	 */
	public class CookieVO
	{
		public var sharedObject:SharedObject;

		public function CookieVO(so:SharedObject)
		{
			sharedObject=so;
		}

		public function getValue(key:String):*
		{
			return sharedObject.data[key];
		}

		public function setValue(value:*, key:String):void
		{
			sharedObject.data[key]=value;
		}
	}
}


