package com.icerain.age.template
{

	import flash.utils.Dictionary;
	
	/**
	 * Generate by cexcel2class tool. Please do not edit this as file!
	 */
	public class CraftXml
	{
		public function CraftXml()
		{
		}
		
		
		/**	流水id 
	*/
		public var id:int;

		/**	目标道具id
	*/
		public var targetId:String;

		/**	材料 : 1:2;2:30;{道具ID}:{数量};多个材料用;分割	*/
		public var material:String;


		
		public function parseItem(xml:XML):void{
			
			id = xml.@id;
			targetId = xml.@targetId;
			material = xml.@material;

		}
		
		public static function getTemplateByKey(key:*):CraftXml
		{
			return itemsDic[key];
		}

		
		public static var items:Array = [];
		
		public static var itemsDic:Dictionary = new Dictionary();
		
		include "CraftXmlExt.as"
	}
}
