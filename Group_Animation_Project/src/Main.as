package
{
	import com.mystuff.ui.DrawingApp;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class Main extends Sprite
	{
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//adds drawing app
			var drawing:DrawingApp = new DrawingApp();
			this.addChild(drawing);
		}
	}
}