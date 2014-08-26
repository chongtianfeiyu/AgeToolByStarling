import com.icerain.age.template.CareerXml;
import com.icerain.age.vo.GiftVO;

public function get careerType():uint
{
	var t:uint=0x0;
	var gifts:Array=getGiftNames();
	for each (var gift:String in gifts)
	{
		var giftType:uint=GiftVO.getType(gift);
		t|=giftType;
	}
	return t;
}

public static function getCareerByType(careerType:uint):CareerXml
{
	for each (var tpl:CareerXml in items)
	{
		if (tpl.careerType == careerType)
			return tpl;
	}
	return null;
}

public function getGiftNames():Array
{
	var gifts:Array=this.gifts.split(";");
	return gifts;
}
