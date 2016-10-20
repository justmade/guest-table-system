package com.sty.boardgame.event
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		
		public static var CREATE_TABLE:String = "CREATE_TABLE";
		
		public var personNum:int = 0;
		
		public function MyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}