package org.puremvc.as3.extend
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.observer.Notifier;

	public class StrongTypeCommand extends Notifier implements ICommand, INotifier
	{
		public function StrongTypeCommand()
		{
			super();
		}

		public final function execute(notification:INotification):void
		{
			var dto:CommandDTO = notification.getBody() as CommandDTO;
			var i:int,data:Object;
			for (i =0;i<dto.map.length;i++)
			{
				data = dto.map[i];
				var func:Function =this[data.name] as Function;
				func.apply(this,data.arg);
			}

		}
	}
}

