package
{
	import com.mystuff.reusable.ui.SliderManager;
	
	import flash.events.Event;
	
	import libs.TackBarBase;
	
	public class Slider extends TackBarBase
	{
		private var _strokeSize:Number = 0.5;

		private var sm:SliderManager;
		
		public function Slider()
		{
			super();
			//positioning
			x = 355;
			y = 340;
			sm = new SliderManager();
			//sets up assets and pct and adds event listener
			sm.setUpAssets(track, knob, false);
			sm.pct = 0;
			sm.addEventListener(Event.CHANGE, onChange);
		}
		
		private function onChange(event:Event):void
		{
			//sets stroke size = 1-100 based on slider
			_strokeSize = Math.round((sm.pct * 99.9) + 0.1);
		}

		//getter for stroke
		public function get strokeSize():Number
		{
			return _strokeSize;
		}

	}
}