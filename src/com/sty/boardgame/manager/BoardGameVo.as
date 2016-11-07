package com.sty.boardgame.manager
{
	public class BoardGameVo
	{
		public var name:String;
		
		public var id:String
		public function BoardGameVo()
		{
		}
		
		public static function createBoardGameVo(xml:XML):BoardGameVo{
			var vo:BoardGameVo = new BoardGameVo();
			vo.name = xml.@name
			vo.id = xml.@id
			return vo ; 
		}
	}
}