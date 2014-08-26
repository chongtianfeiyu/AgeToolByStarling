package org.puremvc.as3.extend.proxy
{
public final class MsgManager
{
	
	public static var _impl:IMsgManagerImpl;
	
	public static function get impl():IMsgManagerImpl
	{
		if (_impl == null)
		{
			_impl = new MsgManagerImpl();
		}
		
		return _impl;
	}
	
	public static function RegisterMsgProxy(proxy:IMsgProxy):void
	{
		impl.RegisterMsgProxy(proxy);
	}
		
	public static function RemoveMsgProxy(proxy:IMsgProxy):void
	{
		impl.RemoveMsgProxy(proxy);
	}
	
	public static function NotifyMessage(type:int, msg:Object):void
	{
		impl.NotifyMessage(type, msg);
	}
	
	
}
}