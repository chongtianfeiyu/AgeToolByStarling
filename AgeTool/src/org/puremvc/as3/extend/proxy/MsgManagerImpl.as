package org.puremvc.as3.extend.proxy
{
import flash.accessibility.Accessibility;
import flash.utils.Dictionary;

public class MsgManagerImpl implements IMsgManagerImpl
{
	protected var map:Dictionary = new Dictionary();
	
	public function MsgManagerImpl()
	{
	}
	
	public function RegisterMsgProxy(proxy:IMsgProxy):void
	{
		var list:Array = proxy.ServerDataList();
		
		if (list == null
			|| list.length == 0)
			return;
		
		
		var ob:MsgObserver;
		var type:int;
		var msgClass:Class;
		var length:int = list.length;
		var i:int;
		
		for (i = 0; i < length; i++)
		{
			type = list[i][0];
			msgClass = list[i][1];
			ob = new MsgObserver(msgClass, proxy);
			
			if (map[type] == null)
				map[type] = [];
			
			(map[type] as Array).push(ob);
		}
	}
	
	public function RemoveMsgProxy(proxy:IMsgProxy):void
	{
		var list:Array = proxy.ServerDataList();
		
		if (list == null
			|| list.length == 0)
			return;
		
		var ob:MsgObserver;
		var type:int;
		var i:int;
		var j:int;
		var length:int = list.length;
		
		
		for (i = 0; i < length; i++)
		{
			type = list[i][0];
			if (map[type] != null)
			{
				var msgList:Array = map[type] as Array;
				var msgLength:int = msgList.length;
				for (j = 0; j < msgLength; j++)
				{
					ob = msgList[j] as MsgObserver;
					if (ob.compareProxy(proxy))
					{
						msgList.splice(j, 1);
						break;
					}
				}
				
				if (msgList.length == 0)
					map[type] = null;
				
			}
		}
		
	}
	
	
	public function NotifyMessage(type:int, msg:Object):Object
	{
		var obs:Array = map[type] as Array;
		var ob:MsgObserver;
		var classInstance:Object;
		var i:int;
		var j:int;
		
		if (obs != null)
		{
			for (i = 0; i < obs.length; i++)
			{
				ob = obs[i] as MsgObserver;
				if (ob == null)
				{
					classInstance = CreateInstanceWithMsg(ob.msgClass, msg);
				}
				
				ob.msgProxy.ServerDataHandler(type, classInstance);
			}
		}
		
		return classInstance;
		
	}
	
	public function CreateInstanceWithMsg(msgClass:Class, msg:Object):Object
	{
		return msg;
	}
}
}