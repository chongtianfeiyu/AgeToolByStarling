package com.icerain.age.vo
{
	import com.icerain.age.template.CareerXml;

	public class CareerVO
	{
		public var gift1:GiftFillVO;
		public var gift2:GiftFillVO;
		public var gift3:GiftFillVO;

		public var careerXml:CareerXml;
		public var careerType:uint;

		public function CareerVO(gift1:GiftFillVO, gift2:GiftFillVO, gift3:GiftFillVO)
		{
			this.gift1=gift1;
			this.gift2=gift2;
			this.gift3=gift3;
			careerType=gift1.giftType | gift2.giftType | gift3.giftType;
			careerXml=CareerXml.getCareerByType(careerType);
		}

		public static function fromQRCode(code:String):CareerVO
		{
			var giftCodes:Array=code.split(";");
			var gift1:GiftFillVO=GiftFillVO.fromQRCode(giftCodes[0]);
			var gift2:GiftFillVO=GiftFillVO.fromQRCode(giftCodes[1]);
			var gift3:GiftFillVO=GiftFillVO.fromQRCode(giftCodes[2]);
			return new CareerVO(gift1, gift2, gift3);
		}

	}
}
