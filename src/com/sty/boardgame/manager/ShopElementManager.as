package  com.sty.boardgame.manager
{
	
	import flash.utils.Dictionary;

	public class ShopElementManager
	{
		
		static private var _instance:ShopElementManager;
		
		private var mapElementsDic:Dictionary ;
		
		public var mapElements:Array
		
		private var basicDic:Dictionary;
		
		private var boardGameDic:Dictionary
		
		public var basicArray:Array
		
		public var boardGameArray:Array
		
		
		
		
		
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
			boardGameDic = new Dictionary()
			boardGameArray = new Array()
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
				}else if(childXml.@type == "game"){
					var boardVo:BoardGameVo = BoardGameVo.createBoardGameVo(childXml);
					boardGameDic[boardVo.id] = boardVo
					boardGameArray.push(boardVo);
				}
			
			}
		}
		
		
		public function getAllGames():Array{
			return boardGameArray
		}
		
		public function getAllItems():Array{
			return mapElements 
		}
		
		public function getAllBasic():Array{
			return basicArray
		}
		

		
	}
}class Lock{}