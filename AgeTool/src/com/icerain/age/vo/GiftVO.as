package com.icerain.age.vo
{

	public class GiftVO
	{
		/**
		 *死亡
		 */
		public static const SIWANG:uint=0x1;
		/**
		 *格斗
		 */
		public static const GEDOU:uint=0x2;
		/**
		 *爱情
		 */
		public static const SHENGMING:uint=0x4;
		/**
		 *元素
		 */
		public static const YUANSU:uint=0x8;
		/**
		 *幻术
		 */
		public static const HUANSHU:uint=0x10;
		/**
		 *野性
		 */
		public static const YEXING:uint=0x20;
		/**
		 *意志
		 */
		public static const YIZHI:uint=0x40;
		/**
		 *吟游
		 */
		public static const YINYOU:uint=0x80;
		/**
		 *暗杀
		 */
		public static const ANSHA:uint=0x100;
		/**
		 *铁壁
		 */
		public static const TIEBI:uint=0x200;

		public static function getName(type:uint):String
		{
			switch (type)
			{
				case SIWANG:
					return "死亡";
					break;
				case GEDOU:
					return "格斗";
					break;
				case SHENGMING:
					return "生命";
					break;
				case YUANSU:
					return "元素";
					break;
				case HUANSHU:
					return "幻术";
					break;
				case YEXING:
					return "野性";
					break;
				case YIZHI:
					return "意志";
					break;
				case YINYOU:
					return "吟游";
					break;
				case ANSHA:
					return "暗杀";
					break;
				case TIEBI:
					return "铁壁";
					break;
			}
			return "";
		}

		public static function getIcon(type:uint):String
		{
			switch (type)
			{
				case SIWANG:
					return "icon_skill_death13";
					break;
				case GEDOU:
					return "icon_skill_fight18";
					break;
				case SHENGMING:
					return "icon_skill_love26";
					break;
				case YUANSU:
					return "icon_skill_magic13";
					break;
				case HUANSHU:
					return "icon_skill_illusion04";
					break;
				case YEXING:
					return "icon_skill_wild02";
					break;
				case YIZHI:
					return "icon_skill_will14";
					break;
				case YINYOU:
					return "icon_skill_romance02";
					break;
				case ANSHA:
					return "icon_skill_vocation05";
					break;
				case TIEBI:
					return "icon_skill_adamant04";
					break;
			}
			return "";
		}


		public static function getType(gift:String):uint
		{
			switch (gift)
			{
				case "死亡":
					return SIWANG;
					break;
				case "格斗":
					return GEDOU;
					break;
				case "生命":
					return SHENGMING;
					break;
				case "元素":
					return YUANSU;
					break;
				case "幻术":
					return HUANSHU;
					break;
				case "野性":
					return YEXING;
					break;
				case "意志":
					return YIZHI;
					break;
				case "吟游":
					return YINYOU;
					break;
				case "暗杀":
					return ANSHA;
					break;
				case "铁壁":
					return TIEBI;
					break;
			}
			return 0;
		}
	}
}
