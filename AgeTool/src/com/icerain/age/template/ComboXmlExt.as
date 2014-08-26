import com.icerain.age.vo.BuffVO;


// ActionScript file


public function getEffect():Array
{
	var ret:Array=[];
	for each (var eff:String in icon.split(";"))
	{
		ret.push(new BuffVO(eff.split(":")[0], eff.split(":")[1] == "debuff"));
	}
	return ret;
}
