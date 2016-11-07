package  com.sty.boardgame.load
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	public class XmlLoader extends EventDispatcher
	{
		private var myFileStream:FileStream = new FileStream();
		
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
			
			var myFile:File = File.documentsDirectory.resolvePath("res/site.txt");
			
			myFileStream.addEventListener(Event.COMPLETE, completed);
			myFileStream.openAsync(myFile, FileMode.UPDATE);
			
			
		}
		protected function completed(event:Event):void
		{
			var str:String = "";
			str = myFileStream.readMultiByte(myFileStream.bytesAvailable, "gb2312");
			myFileStream.writeUTFBytes(str + "111")
			myFileStream.close()
		}
		
		public function getTxts(name:String):String
		{
			return txtDic[name] as String;
		}
	}
}