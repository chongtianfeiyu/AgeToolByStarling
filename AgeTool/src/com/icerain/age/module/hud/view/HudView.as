package com.icerain.age.module.hud.view
{
	import com.icerain.age.components.BaseViewMediator;
	import com.icerain.age.components.Globals;
	import com.icerain.age.components.MainApplaction;
	import com.icerain.age.components.ModuleGlobals;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;

	public class HudView extends BaseViewMediator implements IMediator
	{

		public function HudView()
		{
			super(ModuleGlobals.HUD_VIEW, this);
		}

		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case Globals.SHOW_HUD:
					MainApplaction.getInstance()._uiLayer.addChild(this);
					initHudView();
					break;
				case Globals.HIDE_HUD:
					break;
			}
		}

		private function initHudView():void
		{

		}

		override public function listNotificationInterests():Array
		{
			return [Globals.GAME_RESOURCE_LOADED];
		}

		override public function dispose():void
		{
			this.removeChildren(0, -1, true);
			super.dispose();
		}

	}
}


