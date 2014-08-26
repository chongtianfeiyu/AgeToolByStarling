package com.icerain.age.template
{

	import flash.utils.Dictionary;
	
	/**
	 * Generate by cexcel2class tool. Please do not edit this as file!
	 */
	public class ComboXml
	{
		public function ComboXml()
		{
		}
		
		
		/**	连锁ID	*/
		public var id:int;

		/**	图标	*/
		public var icon:String;

		/**	描述	*/
		public var desc:String;


		
		public function parseItem(xml:XML):void{
			
			id = xml.@id;
			icon = xml.@icon;
			desc = xml.@desc;

		}
		
		public static function getTemplateByKey(key:*):ComboXml
		{
			return itemsDic[key];
		}

		
		public static var items:Array = [];
		
		public static var itemsDic:Dictionary = new Dictionary();
		
		include "ComboXmlExt.as"
	}
}
