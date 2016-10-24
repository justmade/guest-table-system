package com.sty.boardgame.manager
{

	public class ShopItemVo
	{
		
		public var id:String = "10010";
		
		public var price:Number = 1;
		
		public var num:int = 1;
		
		public var name:String;
		
		public function ShopItemVo()
		{
			
		}
		
		public static function createShopItemVo(xml:XML):ShopItemVo{
			var vo:ShopItemVo = new ShopItemVo();
			vo.id = xml.@id
			vo.price = xml.@targetItem
			vo.name = xml.@name
			return vo ; 
		}
	}
}