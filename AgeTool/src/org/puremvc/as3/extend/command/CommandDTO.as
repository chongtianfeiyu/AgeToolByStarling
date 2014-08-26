package org.puremvc.as3.extend.command
{
public class CommandDTO
{
	public function CommandDTO()
	{
	}
	
	public var map:Array = [];
	
	protected function AddFunction(funcName:String, args:Array = null):Object
	{
		var data:Object = new Object();
		data.name = funcName;
		data.arg = args;
		map.push(data);
		return this;
	}
	
}
}