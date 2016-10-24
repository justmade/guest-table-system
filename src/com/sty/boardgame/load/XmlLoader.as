package  com.sty.boardgame.load
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	public class XmlLoader extends EventDispatcher
	{
		
		
		private var loader:BulkLoader ;
		
		private var names:Array = ["itemlist"];
		
		private var txtDic:Dictionary = new Dictionary();
		public function XmlLoader()
		{
			
		}
		
		public function load():void{
			loader = new BulkLoader();
			var baseUrl:String = ""
			loader.add("res/itemlist.xml", {id:"itemlist"});
			
			loader.addEventListener(BulkProgressEvent.COMPLETE, onXmlLoadComplete);
			loader.start(1);
		}
		
		protected function onXmlLoadComplete(event:Event):void
		{
			for(var i:int = 0;i < names.length; i++){
				var name:String = names[i] as String;
				var txt:String = String(loader.getContent(name));
				txtDic[name] = txt;
			}
			dispatchEvent(new Event("MyXmlLoadComplete"));			
		}
		
		public function getTxts(name:String):String
		{
			return txtDic[name] as String;
		}
	}
}