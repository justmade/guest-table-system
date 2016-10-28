package com.sty.boardgame.manager
{
	public class BasicVo
	{
		
		public var name:String
		
		public var id:String;
		
		public var min:int
		
		public var price:int
		
		public var extraPrice:int
		
		public function BasicVo()
		{
		}
		
		public static function createBasicVo(xml:XML):BasicVo{
			var vo:BasicVo = new BasicVo();
			vo.id = xml.@id
			vo.price = xml.@price
			vo.name = xml.@name
			vo.min = xml.@min
			vo.extraPrice = xml.@ex_price;
			return vo ; 
		}
	}
}