package  com.sty.boardgame.manager
{
	import com.mybo.data.ElementType;
	import com.mybo.data.MapElementVo;
	
	import flash.utils.Dictionary;

	public class ShopElementManager
	{
		
		static private var _instance:ShopElementManager;
		
		private var mapElementsDic:Dictionary ;
		
		public var mapElements:Array
		
		public var portals:Array;
		
		
		
		
		public function ShopElementManager(lock:Lock) 
		{
			
		}
		
		public static function getInstance():ShopElementManager{
			if(_instance == null){
				_instance = new ShopElementManager(new Lock);
			}
			return _instance;
		}
		
		public function initXML(xml:XML):void{
			mapElementsDic = new Dictionary();
			mapElements = new Array();
			portals = new Array();
			for(var i:int=0;i<xml.children().length();i++){
				var vo:ShopItemVo = ShopItemVo.createShopItemVo(xml.children()[i]);
				mapElementsDic[vo.id] = vo;
				trace("[vo.id",vo.id)
				mapElements.push(vo);
			}
		}
		

		
	}
}class Lock{}