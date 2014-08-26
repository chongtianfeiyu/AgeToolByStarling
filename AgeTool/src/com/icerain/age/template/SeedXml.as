package com.icerain.age.template
{

	import flash.utils.Dictionary;
	
	/**
	 * Generate by cexcel2class tool. Please do not edit this as file!
	 */
	public class SeedXml
	{
		public function SeedXml()
		{
		}
		
		
		/**	种子id 
 : 作者:自己写递增 不唯一即可	*/
		public var id:int;

		/**	种子类型
 : 1:采集类植物2:农业类植物3:采集类树木(多种功能的选择主要推荐功能)4:伐木类树木(多种功能的选择主要推荐功能)5:海底养殖场类	*/
		public var type:int;

		/**	成熟时间 : 成熟时间 格式:a日b小时c分d秒没有的填写0 必须填写	*/
		public var ripening:String;

		/**	加速类型 : 0:无加速1:温带2:热带3:干燥气候	*/
		public var rapidArea:int;

		/**	产量 : 作者:产量格式:最小值:最大量如 1:2	*/
		public var yield:String;

		/**	体力消耗	*/
		public var cost:int;

		/**	种植占地 : 作者:4*4则填写416*16填写16以此类推	*/
		public var space:int;

		/**	商店售价 : 作者:无出售的填写0	*/
		public var price:int;


		
		public function parseItem(xml:XML):void{
			
			id = xml.@id;
			type = xml.@type;
			ripening = xml.@ripening;
			rapidArea = xml.@rapidArea;
			yield = xml.@yield;
			cost = xml.@cost;
			space = xml.@space;
			price = xml.@price;

		}
		
		public static function getTemplateByKey(key:*):SeedXml
		{
			return itemsDic[key];
		}

		
		public static var items:Array = [];
		
		public static var itemsDic:Dictionary = new Dictionary();
		
		include "SeedXmlExt.as"
	}
}
