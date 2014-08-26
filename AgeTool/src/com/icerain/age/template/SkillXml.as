package com.icerain.age.template
{

	import flash.utils.Dictionary;
	
	/**
	 * Generate by cexcel2class tool. Please do not edit this as file!
	 */
	public class SkillXml
	{
		public function SkillXml()
		{
		}
		
		
		/**	流水id 
	*/
		public var id:int;

		/**	技能名
	*/
		public var name:String;

		/**	所属天赋
	*/
		public var gift:String;

		/**	技能学习等级
 : moyubing0514@hotmail.com:被动技能填写所需技能点	*/
		public var level:int;

		/**	是否是被动
 : moyubing0514@hotmail.com:被动技能:1主动技能:0	*/
		public var passive:int;

		/**	图标名
	*/
		public var icon:String;

		/**	技能描述
	*/
		public var desc:String;

		/**	施法时间(毫秒)
 : moyubing0514@hotmail.com:0为瞬发大于0为施法时间-1为持续施法	*/
		public var castTime:int;

		/**	消耗
	*/
		public var cost:String;

		/**	施法距离
	*/
		public var distance:String;

		/**	CD(毫秒)
	*/
		public var cooldown:int;

		/**	效果
 : moyubing0514@hotmail.com:	*/
		public var effect:String;

		/**	连锁id
	*/
		public var combo:String;


		
		public function parseItem(xml:XML):void{
			
			id = xml.@id;
			name = xml.@name;
			gift = xml.@gift;
			level = xml.@level;
			passive = xml.@passive;
			icon = xml.@icon;
			desc = xml.@desc;
			castTime = xml.@castTime;
			cost = xml.@cost;
			distance = xml.@distance;
			cooldown = xml.@cooldown;
			effect = xml.@effect;
			combo = xml.@combo;

		}
		
		public static function getTemplateByKey(key:*):SkillXml
		{
			return itemsDic[key];
		}

		
		public static var items:Array = [];
		
		public static var itemsDic:Dictionary = new Dictionary();
		
		include "SkillXmlExt.as"
	}
}
