package feathers.ext
{
	import flash.geom.Matrix;
	
	import feathers.controls.Button;
	
	
	/**
	 *
	 * ScaleButton.as 
	 * 
	 * 不要手动设置按钮的scale x y属性
	 *
	 * @author hanlu
	 * @date 2013-7-31
	 * 
	 */
	public class ScaleButton extends Button
	{
		public function ScaleButton()
		{
			super();
		}
		
		public var scaleRate:Number = 0.9;
		
		private var _isScale:Boolean;
		
		protected override function layoutContent():void{
			super.layoutContent();
			
			
			
			if(this._currentState == STATE_DOWN){
				if(!_isScale){
					var hw:Number = this.width * 0.5;
					var hh:Number = this.height * 0.5;
					
					var matrix:Matrix = new Matrix();
					
					matrix.translate(-hw,-hh);
					matrix.scale(scaleRate,scaleRate);
					matrix.translate(hw,hh);
					matrix.concat(transformationMatrix);
					transformationMatrix = matrix;
					_isScale = true;
				}
			}else{
				if(_isScale){
					hw = this.width * 0.5;
					hh = this.height * 0.5;
					matrix = new Matrix();
					matrix.translate(-hw,-hh);
					matrix.scale(1/scaleRate,1/scaleRate);
					matrix.translate(hw,hh);
					matrix.concat(transformationMatrix);
					transformationMatrix = matrix;
					_isScale = false;
				}
			}
			
		}
		
	}
}