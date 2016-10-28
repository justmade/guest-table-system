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
		
		private var basicDic:Dictionary;
		
		public var basicArray:Array
		
		
		
		
		
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
			basicDic	= new Dictionary()
			basicArray  = new Array();
			for(var i:int=0;i<xml.children().length();i++){
				var childXml:XML = xml.children()[i]
//				trace("xml",xml.children()[i])
				if(childXml.@type == "item"){
					var vo:ShopItemVo = ShopItemVo.createShopItemVo(childXml);
					mapElementsDic[vo.id] = vo;
					mapElements.push(vo);
				}else if(childXml.@type == "price"){
					var basicVo:BasicVo = BasicVo.createBasicVo(childXml)
					basicDic[basicVo.id] = basicVo;
					basicArray.push(basicVo)
				}
			
			}
		}
		
		
		public function getAllItems():Array{
			return mapElements 
		}
		
		public function getAllBasic():Array{
			return basicArray
		}
		

		
	}
}class Lock{}