package com.mystuff.ui
{
	import com.mystuff.reusable.ui.DrawingTools;
	import com.mystuff.reusable.ui.LayoutBox;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Mouse;
	
	import libs.DrawingAPIBase;
	import libs.cursorBase;
	
	public class DrawingApp extends DrawingAPIBase
	{
		private var _canvas:Sprite;
		private var _cp:ColorPicker;
		private var _slider:Slider;
		
		private var _color:uint = 0xff0000;
		private var _strokeSize:Number = 1;
		private var _drawing:Boolean = false;
		private var _mode:String = "line";
		private var cursor:cursorBase;
		
		//Testing
		private var _pics:Array = [];
		private var lb:LayoutBox;
		
		public function DrawingApp()
		{
			super();
			//adds canvas with mask
			_canvas = new Sprite();
			_canvas.mask = this.myMask;
			this.addChild(_canvas);
			
			//new cursor, hides original
			cursor = new cursorBase();
			Mouse.hide();
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			
			//new color picker with changeColor when clicked
			_cp = new ColorPicker("pics/picker_wide.jpg");
			_cp.x = 7;
			_cp.y = 287.5;
			_cp.addEventListener(ColorPicker.COLOR_PICKER, changeColor);
			this.addChild(_cp);
			
			//adds new slider 
			_slider = new Slider;
			this.addChild(_slider);
			this.addChild(cursor);
			
			//stops animations
			squarBox.stop();
			lineBox.stop();
			circleBox.stop();
			
			//adds click events
			squarBox.addEventListener(MouseEvent.CLICK, onSquar);
			lineBox.addEventListener(MouseEvent.CLICK, onLine);
			circleBox.addEventListener(MouseEvent.CLICK, onCirc);
			clearBtn.addEventListener(MouseEvent.CLICK , onClear);
			saveBtn.addEventListener(MouseEvent.CLICK, saveCanvas);
			showBtn.addEventListener(MouseEvent.CLICK, showPics);
			
			//for drawing
			this.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
			this.addEventListener(MouseEvent.MOUSE_UP, onRelease);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onDraw);

		}
		
		private function showPics(event:MouseEvent):void
		{	
			var yPos:Number = 0;
			for each (var pic:Bitmap in _pics)
			{
				pic.scaleX = pic.scaleY = 0.3;
				pic.x = 540;
				pic.y = yPos;
				addChild(pic);
				yPos += pic.height;
			}
		}
		
		private function saveCanvas(event:MouseEvent):void
		{
			var bmd:BitmapData = new BitmapData(504, 270);
			bmd.draw(_canvas);
			var test:Bitmap = new Bitmap(bmd, "auto");
			_pics.push(test);
		}
		
		private function onMove(event:MouseEvent):void
		{
			//repositions cursor
			cursor.x = mouseX - 10;
			cursor.y = mouseY - 10;
		}
		
		private function changeColor(event:Event):void
		{
			//sets current color for drawing and the color_btn
			_color = _cp.color;
			var ct:ColorTransform = new ColorTransform()
			ct.color = _color;
			this.color_btn.currentColor.transform.colorTransform = ct;
		}
		
		private function onRelease(event:MouseEvent):void
		{
			//stop drawing
			_drawing = false;
		}
		
		private function onPress(event:MouseEvent):void
		{
			//sets the stroke size
			_strokeSize = _slider.strokeSize;
			
			//start drawing and move to wherever the mouse is
			_drawing = true;
			_canvas.graphics.moveTo(mouseX, mouseY);
			if(_mode == "squar")
			{
				//draws a square
				var radius:uint = 10;
				var square:Sprite = DrawingTools.makeSquare(_color, 0x000000, mouseX - radius, mouseY - radius, radius*2,  radius*2);
				_canvas.addChild(square);
			}
			if(_mode == "circle")
			{
				//draws a circle
				var circle:Sprite = DrawingTools.makeCircle(_color, 0x000000, mouseX, mouseY, 20);
				_canvas.addChild(circle);
			}
		}
		
		private function onDraw(event:MouseEvent):void
		{
			_canvas.graphics.lineStyle(_strokeSize, _color);
			//used to see if drawing(boolean) is true and then draws
			if(_drawing && _mode == "line")
			{
				_canvas.graphics.lineTo(mouseX, mouseY);
			}
		}
		
		//sets corresponding modes
		private function onSquar(e:Event):void
		{
			_mode = "squar";
		}
		
		private function onLine(e:Event):void
		{
			_mode = "line";
		}
		
		private function onCirc(event:MouseEvent):void
		{
			_mode = "circle";
		}
		
		private function onClear(e:Event):void
		{
			//clears canvas and display list
			_canvas.graphics.clear();
			
			while(_canvas.numChildren)
			{
				_canvas.removeChildAt(0);
			}
		}
	}
}