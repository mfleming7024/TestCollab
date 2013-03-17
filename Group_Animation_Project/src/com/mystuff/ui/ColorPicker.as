package com.mystuff.ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class ColorPicker extends Sprite
	{
		private var _color:uint;
		private var _img:Bitmap;
		public static const COLOR_PICKER:String = "colorPicker";
		
		public function ColorPicker(filePath:String)
		{
			super();
			//loads image path given in constructor
			loadPic(filePath);
		}
		
		private function loadPic(file:String):void
		{
			//makes new loader for the file path
			var ld:Loader = new Loader();
			ld.load(new URLRequest(file));
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
		}
		
		private function onLoad(event:Event):void
		{
			//loads image and adds click functionality
			_img = event.currentTarget.content;
			this.addChild(_img);
			this.addEventListener(MouseEvent.CLICK, onClick)
		}
		
		private function onClick(event:MouseEvent):void
		{
			//sets color = mousex and mousey
			_color = _img.bitmapData.getPixel(mouseX, mouseY);
			this.dispatchEvent(new Event(ColorPicker.COLOR_PICKER));
		}

		public function get color():uint
		{
			return _color;
		}

	}
}