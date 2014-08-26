package org.puremvc.as3.extend.proxy
{
public class MsgObserver
{
	private var _msgClass:Class;
	private var _msgProxy:IMsgProxy;
	
	public function MsgObserver(msgClass:Class, msgProxy:IMsgProxy)
	{
		this._msgClass = msgClass;
		this._msgProxy = msgProxy;
		
	}
	
	public function get msgClass():Class
	{
		return _msgClass;
	}
	
	public function get msgProxy():IMsgProxy
	{
		return _msgProxy;
	}
	
	public function compareProxy(proxy:IMsgProxy):Boolean
	{
		return msgProxy == proxy;
	}
}
}