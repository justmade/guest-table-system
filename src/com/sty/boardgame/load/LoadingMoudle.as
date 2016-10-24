package  com.sty.boardgame.load
{	
	
	import com.sty.boardgame.manager.ShopElementManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class LoadingMoudle extends EventDispatcher
	{
		private var myXmlL:XmlLoader ;
		
		public function LoadingMoudle()
		{
			loadXml();
		}
		
		private function loadXml():void{
			myXmlL = new XmlLoader();
			myXmlL.addEventListener("MyXmlLoadComplete", onXmlCompleteHandler);
			myXmlL.load();
		}
		
		protected function onXmlCompleteHandler(event:Event):void
		{
			ShopElementManager.getInstance().initXML(XML(myXmlL.getTxts("itemlist")));
			this.dispatchEvent(new Event("LoaderComplete"))
		}
	}
}