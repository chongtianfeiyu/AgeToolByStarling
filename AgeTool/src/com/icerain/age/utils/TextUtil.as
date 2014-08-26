package com.icerain.age.utils
{

	public class TextUtil
	{

		public static function formate(tx:String, ... param):String
		{
			var ret:String=tx;
			for (var i:uint=0; i < param.length; i++)
			{
				var str:String=param[i];
				ret=ret.replace("{" + i + "}", str);
			}
			return ret;
		}
	}
}
