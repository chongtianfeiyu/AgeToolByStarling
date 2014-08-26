package org.puremvc.as3.extend.proxy
{
public interface IMsgManagerImpl
{
	function RegisterMsgProxy(proxy:IMsgProxy):void
		
	function RemoveMsgProxy(proxy:IMsgProxy):void
		
	function NotifyMessage(type:int, msg:Object):Object
		
}
}