package com.sty.boardgame.part
{
	import com.sty.boardgame.event.MyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.event.WindowEvent;
	
	public class Table extends Sprite
	{
		private var tableSp:Sprite;
		
		private var tableNum:int;
		
		private var numTf:TextField;
		
		private var hasGuest:Boolean = false;
		
		private var startDate:Number;
		
		private var startTime:Number;
		
		private var endTime:Number;
		
		private var settingTime:Number;
		
		private var playerNum:int = 0
		
		private var tableWidth:int = 200;
		private var tableHeigh:int = 160;
		
		private var createFrame:JFrame = new JFrame(null,"create table");
		
		private var createTablePopup:CreateTablePopup ;

		
		public function Table(_num:int)
		{
			super();
			tableNum = _num;
			initSkin();
			initNumTf()
			addListener()
		}
		
		private function initNumTf():void{
			numTf 		= new TextField()
			numTf.defaultTextFormat = new TextFormat(null,18,0x000000,true)
			numTf.text 	= String(tableNum)
			numTf.width  = numTf.textWidth + 5;
			numTf.height = numTf.textHeight + 5;
			this.addChild(numTf)
			numTf.mouseEnabled = false
		}
		
		private function initSkin():void{
			tableSp = new Sprite();
			this.addChild(tableSp)
			tableSp.graphics.beginFill(0x6effd1,1);
			tableSp.graphics.drawRect(0,0,tableWidth,tableHeigh)
			tableSp.graphics.endFill();
		}
		
		private function addListener():void{
			this.addEventListener(MouseEvent.CLICK , onClick)
		}
		
		private function addFrame(_frame:*):void{
			createFrame = new JFrame();
			createFrame.setTitle("create")
			createFrame.setContentPane(_frame);
			createFrame.show();
			createFrame.pack();
			createFrame.setLocationXY(1250/2 - createFrame.width/2,750/2 - createFrame.height/2);
			createFrame.addEventListener(WindowEvent.WINDOW_DEACTIVATED , onLostFocusCreateFrame)
		}
		
		protected function onLostFocusCreateFrame(event):void
		{
			createFrame.hide()	
		}
		
		private function onCreateTable(e:Event):void{
			createFrame.hide()	
		}
		
		
		protected function onClick(event:MouseEvent):void
		{
			createTablePopup = new CreateTablePopup();
			createTablePopup.addEventListener(MyEvent.CREATE_TABLE , onCreateTable);
			addFrame(createTablePopup)
			
			hasGuest = !hasGuest;
			if(hasGuest){
				startDate = new Date().hours;
				startTime = getTimer();
				trace(new Date().hours,new Date().minutes)
				tableSp.graphics.clear();
				tableSp.graphics.beginFill(0xff6e6e,1);
				tableSp.graphics.drawRect(0,0,tableWidth,tableHeigh)
				tableSp.graphics.endFill();
			}else{
				endTime = getTimer();
				var progressTime:int = endTime - startTime;
				settingTime = progressTime/1000/60;
				trace("时间" + settingTime + "分钟")
				tableSp.graphics.clear();
				tableSp.graphics.beginFill(0x6effd1,1);
				tableSp.graphics.drawRect(0,0,tableWidth,tableHeigh)
				tableSp.graphics.endFill();
			}
		}
	}
}