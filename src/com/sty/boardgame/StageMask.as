package com.sty.boardgame
{
	import com.sty.boardgame.manager.ShopItemManager;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class StageMask extends Sprite
	{
		public  var maskSp:Sprite;
		
		public  var _stage:Stage
		
		static private var _instance:StageMask;
		
		public function StageMask(lock:Lock)
		{
			getMask()
		}
		
		public static function getInstance():StageMask{
			if(_instance == null){
				_instance = new StageMask(new Lock);
			}
			return _instance;
		}
		
		public function getMask():Sprite{
			maskSp = new Sprite();
			maskSp.graphics.beginFill(0x000000,0.6)
			maskSp.graphics.drawRect(0,0,1250,750)
			maskSp.graphics.endFill()
			return maskSp
		}
		
		public function setStage(stage:Stage):void{
			_stage = stage
		}
		
		public function addMask():void{
			_stage.addChild(maskSp)
		}
		
		public function removeMask():void{
			_stage.removeChild(maskSp)
		}
	}
}class Lock{}