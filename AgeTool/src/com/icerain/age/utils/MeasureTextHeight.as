package com.icerain.age.utils
{

	public class MeasureTextHeight
	{
		public function MeasureTextHeight()
		{
		}

		public static function measure(src:String):Number
		{
			var line:Number=0;
			for each (var str:String in src.split("\n"))
			{
				line+=Math.ceil(str.length / 20);
			}
			return line * 30;
		}
	}
}
