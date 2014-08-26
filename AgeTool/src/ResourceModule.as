package
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;

	import starling.textures.Texture;

	public class ResourceModule extends Sprite
	{
		[Embed(source="../assets/Skill.xml", mimeType="application/octet-stream")]
		public static var skillData:Class;
		[Embed(source="../assets/Combo.xml", mimeType="application/octet-stream")]
		public static var comboData:Class;
		[Embed(source="../assets/Career.xml", mimeType="application/octet-stream")]
		public static var careerData:Class;
		[Embed(source="/../assets/fonts/SourceSansPro-Regular.ttf", fontName="SourceSansPro")]
		protected static const SOURCE_SANS_PRO_REGULAR:Class;

		[Embed(source="/../assets/fonts/SourceSansPro-Semibold.ttf", fontName="SourceSansProSemibold")]
		protected static const SOURCE_SANS_PRO_SEMIBOLD:Class;

		[Embed(source="/../assets/fonts/simhei.ttf", fontName="simhei", embedAsCFF="false", fontFamily="simhei", unicodeRange="u+41,u+67,u+65,u+54,u+6f,u+6c,u+44,u+77,u+6e,u+61,u+64,u+57,u+69,u+6b,u+4e0a,u+53e4,u+4e16,u+7eaa,u+52a9,u+624b,u+4e0b,u+8f7d,u+767e,u+79d1")]
		protected static const MSYH:Class;

//		[Embed(source="/../assets/skillicons/icons.swf")]
//		protected static const ICONS:Class;

		public static var domain:ApplicationDomain;

		private static var skillIcons:MovieClip;

		public static function getSkillIcon(iconName:String):BitmapData
		{
			var clz:Class=domain.getDefinition(iconName) as Class;
			var bd:BitmapData=new clz() as BitmapData;
			return bd;
		}

		public static function getSkillIconTexture(iconName:String):Texture
		{
			return Texture.fromBitmapData(getSkillIcon(iconName));
		}

	}
}

