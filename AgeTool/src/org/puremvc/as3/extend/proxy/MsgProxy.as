package org.puremvc.as3.extend.proxy
{
import org.puremvc.as3.patterns.proxy.Proxy;

public class MsgProxy extends Proxy implements IMsgProxy
{
	public function MsgProxy(proxyName:String = null, data:Object = null)
	{
		super(proxyName, data);
	}
	
	override public function onRegister():void
	{
		MsgManager.RegisterMsgProxy(this);
		super.onRegister();
	}
	
	override public function onRemove():void
	{
		MsgManager.RemoveMsgProxy(this);
		super.onRemove();
	}
	
	public function ServerDataList():Array
	{
		return null;
	}
	
	public function ServerDataHandler(msgType:int, msgData:Object):void
	{
	}
}
}