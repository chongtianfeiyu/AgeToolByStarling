package com.icerain.age.module.sql.model
{
	import com.icerain.age.components.ModuleGlobals;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class SqlProxy extends Proxy implements IProxy
	{
		public function SqlProxy()
		{
			super(ModuleGlobals.SQL_PROXY, null);
		}
	}
}
