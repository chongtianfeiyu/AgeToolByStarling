package com.icerain.age.template
{

	import flash.utils.Dictionary;
	
	/**
	 * Generate by cexcel2class tool. Please do not edit this as file!
	 */
	public class ItemXml
	{
		public function ItemXml()
		{
		}
		
		
		/**	道具id 
	*/
		public var id:int;

		/**	道具描述
	*/
		public var desc:String;

		/**	道具图标 : 1:2;2:30;{道具ID}:{数量};多个材料用;分割	*/
		public var icon:String;

		/**	是装备 : 0:不是1:是	*/
		public var int:int;


		
		public function parseItem(xml:XML):void{
			
			id = xml.@id;
			desc = xml.@desc;
			icon = xml.@icon;
			int = xml.@int;

		}
		
		public static function getTemplateByKey(key:*):ItemXml
		{
			return itemsDic[key];
		}

		
		public static var items:Array = [];
		
		public static var itemsDic:Dictionary = new Dictionary();
		
		include "ItemXmlExt.as"
	}
}
