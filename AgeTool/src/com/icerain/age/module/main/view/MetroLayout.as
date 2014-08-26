package com.icerain.age.module.main.view
{
	import com.icerain.age.components.Frame;

	public class MetroLayout extends Frame
	{
		private var _rowCount:Number=0;
		private var _maxHeight:Number=0;
		private var _lastWidth:Number=0;
		private var _grap:Number=0;

		public function MetroLayout(grap:Number=10)
		{
			super();
			_grap=grap;
		}

		public function addMetroCell(type:String, w:Number, h:Number, color:uint):void
		{
			var cell:MetroCell=new MetroCell(type, w, h, color);
			this.addChild(cell);

			if (_lastWidth + cell.width + _grap <= this.width)
			{
				cell.x=_lastWidth;
				_lastWidth=cell.width + _lastWidth + _grap;
				cell.y=_maxHeight;
			}
			else
			{
				_maxHeight=cell.y + cell.height + _grap;
				_rowCount++;
				_lastWidth=0;
				cell.x=_lastWidth;
				cell.y=_maxHeight;
				trace(cell.type);
			}


		}
	}
}
