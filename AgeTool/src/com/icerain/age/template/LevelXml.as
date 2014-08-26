package com.icerain.age.template
{

	import flash.utils.Dictionary;
	
	/**
	 * Generate by cexcel2class tool. Please do not edit this as file!
	 */
	public class LevelXml
	{
		public function LevelXml()
		{
		}
		
		
		/**	等级
	*/
		public var id:int;

		/**	经验
	*/
		public var desc:int;


		
		public function parseItem(xml:XML):void{
			
			id = xml.@id;
			desc = xml.@desc;

		}
		
		public static function getTemplateByKey(key:*):LevelXml
		{
			return itemsDic[key];
		}

		
		public static var items:Array = [];
		
		public static var itemsDic:Dictionary = new Dictionary();
		
		include "LevelXmlExt.as"
	}
}
