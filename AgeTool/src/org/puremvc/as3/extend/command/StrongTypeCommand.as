package org.puremvc.as3.extend.command
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
	
	public function execute(notification:INotification):void
	{
		var cmd:CommandDTO = notification.getBody() as CommandDTO;
		var i:int, 
			length:int = cmd.map.length,
			data:Object;
		for (i = 0; i < length; i++)
		{
			data = cmd.map[i];
			var func:Function = this[data.name] as Function;
			func.apply(this, data.arg);
		}
	}
}
}