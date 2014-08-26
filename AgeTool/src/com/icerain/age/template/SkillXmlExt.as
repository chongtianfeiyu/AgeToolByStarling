import com.icerain.age.template.ComboXml;
import com.icerain.age.template.SkillXml;
import com.icerain.age.vo.BuffVO;

// ActionScript file
public static function getSkillList(giftName:String):Array
{
	var ret:Array=[];
	for each (var tpl:SkillXml in items)
	{
		if (tpl.gift == giftName)
			ret.push(tpl);
	}
	return ret;
}

public function getDesc():String
{
	return desc.replace(/[&#xA;]/g, "\b");
}

public function getCastTime():String
{
	if (castTime == -1)
	{
		return "持续施法";
	}
	else if (castTime == 0)
	{
		return "瞬发";
	}
	else if (castTime % 1000 > 0)
		return "施法时间" + (castTime / 1000).toFixed(1).split(".")[0] + "秒";
	else
		return "施法时间" + int(castTime / 1000) + "秒";

}

public function getCD():String
{
	var timeStr:String;
	if (cooldown >= 60000)
	{
		var minute:int=cooldown / 60000;
		var second:int=(cooldown % 60000) / 1000;
		timeStr=minute + "分" + second + "秒";
	}
	else
	{
		timeStr=(cooldown / 1000) + "秒";
	}
	return timeStr + "之后可再次使用";
}

public function getEffect():Array
{
	var ret:Array=[];
	if (effect == "")
		return ret;
	for each (var eff:String in effect.split(";"))
	{
		ret.push(new BuffVO(eff.split(":")[0], eff.split(":")[1] == "debuff"));
	}
	return ret;
}

public function getComboArray():Array
{
	var ret:Array=[];
	if (combo == "")
		return ret;
	for each (var comboId:String in combo.split(";"))
	{
		var comboXml:ComboXml=ComboXml.getTemplateByKey(comboId);
		if (comboXml)
			ret.push(comboXml)
	}
	return ret;
}
