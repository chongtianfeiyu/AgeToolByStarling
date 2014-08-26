package com.icerain.age.template
{
	import flash.utils.Dictionary;

	public class XMLSetuper
	{
		private static var XML_LIST:Array=[
			[ComboXml, ResourceModule.comboData, "id"],
			[SkillXml, ResourceModule.skillData, "id"],
			[CareerXml, ResourceModule.careerData,"id"]
			];

		public function XMLSetuper()
		{
		}

		public static function intiXML():void
		{
			for each (var data:Array in XML_LIST)
			{
				var clz:Class=data[0];
				var dataClz:Class=data[1];

				var xml:XML=XML(new dataClz());
				var xmlList:XMLList=xml["item"];
				for each (var node:XML in xmlList)
				{
					var tpl:Object=new clz();
					tpl.parseItem(node);
					clz.itemsDic[tpl[data[2]]]=tpl;
					clz.items.push(tpl);
				}
			}
		}

	}
}
