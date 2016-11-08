package  com.sty.boardgame.manager
{
	import flash.utils.Dictionary;

	public class AccountManager
	{
		
		static private var _instance:AccountManager;
		
		public var accountList:Array;
		
		
		public function AccountManager(lock:Lock) 
		{
			accountList = new Array();
			
		}
		
		public static function getInstance():AccountManager{
			if(_instance == null){
				_instance = new AccountManager(new Lock);
			}
			return _instance;
		}
		
		public function add(vo:AccountVo):void{
			accountList.push(vo);
		}
				
	}
}class Lock{}