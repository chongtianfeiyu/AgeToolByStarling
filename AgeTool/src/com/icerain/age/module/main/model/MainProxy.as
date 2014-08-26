package com.icerain.age.module.main.model
{
	import com.icerain.age.components.ModuleGlobals;

	import org.puremvc.as3.patterns.proxy.Proxy;

	public class MainProxy extends Proxy
	{
		public function MainProxy(proxyName:String=null, data:Object=null)
		{
			super(ModuleGlobals.MAIN_PROXY, data);
		}
	}
}
