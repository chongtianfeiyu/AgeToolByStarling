package com.icerain.age.template
{

	import flash.utils.Dictionary;
	
	/**
	 * Generate by cexcel2class tool. Please do not edit this as file!
	 */
	public class CareerXml
	{
		public function CareerXml()
		{
		}
		
		
		/**	流水ID	*/
		public var id:int;

		/**	职业名	*/
		public var career:String;

		/**	天赋	*/
		public var gifts:String;


		
		public function parseItem(xml:XML):void{
			
			id = xml.@id;
			career = xml.@career;
			gifts = xml.@gifts;

		}
		
		public static function getTemplateByKey(key:*):CareerXml
		{
			return itemsDic[key];
		}

		
		public static var items:Array = [];
		
		public static var itemsDic:Dictionary = new Dictionary();
		
		include "CareerXmlExt.as"
	}
}
