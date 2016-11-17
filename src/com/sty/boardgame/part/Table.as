package com.sty.boardgame.part {
	import com.sty.boardgame.StageMask;
	import com.sty.boardgame.event.MyEvent;
	import com.sty.boardgame.manager.BoardGameManager;
	import com.sty.boardgame.manager.BoardGameVo;
	import com.sty.boardgame.manager.ShopItemManager;
	import com.sty.boardgame.manager.ShopItemVo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.event.WindowEvent;

	public class Table extends Sprite {
		private var tableSp: Sprite;

		private var tableNum: int;

		private var numTf: TextField;
		private var timeTf: TextField;
		private var playerNumTf: TextField

		private var hasGuest: Boolean = false;

		private var startDate: Number;

		private var startTime: Number;
		
		private var startHours:int;
		
		private var startMins:int

		private var endTime: Number;

		private var settingTime: Number;

		private var playerNum: int = 0

		private var tableWidth: int = 200;
		private var tableHeigh: int = 160;

		private var createFrame: JFrame = new JFrame(null, "create table");

		private var createTablePopup: CreateTablePopup;

		private var menuTablePopup:MenuTargetPopup;
		
		private var boardGamePopup:GameSelectPopup

		private var accountPopup: AccountPopup

		private var shopList:Array = new Array() ;
		private var boardGameList:Array = new Array()

		private var menuSp:Sprite ;
		private var cashSp:Sprite;
		private var boardGameSp:Sprite
		
		private var openMenu:Boolean = false
		private var openBoardGame:Boolean = false

		public function Table(_num: int) {
			super();
			tableNum = _num;
			initSkin();
			numTf = initTF(numTf)
			this.addChild(numTf)
			numTf.text = "桌号：" + tableNum
			timeTf = initTF(timeTf)
			this.addChild(timeTf)
			timeTf.y = 30
			playerNumTf = initTF(playerNumTf)
			this.addChild(playerNumTf)
			playerNumTf.y = 60

			/*addListener()*/
			initOption()
		}

		private function initOption(): void {
			menuSp = new Sprite();
			this.addChild(menuSp)
			menuSp.graphics.beginFill(0x0fa9db,1);
			menuSp.graphics.drawRect(0,0,tableWidth,tableHeigh/2)
			menuSp.graphics.endFill();
			menuSp.addEventListener(MouseEvent.CLICK, onClickMenu)
			menuSp.visible = false
			var menuTF: TextField
			menuTF = initTF(menuTF)
			menuTF.text = "菜单"
			menuSp.addChild(menuTF)
				
			boardGameSp = new Sprite();
			this.addChild(boardGameSp);
			boardGameSp.graphics.beginFill(0xb1c94b,1);
			boardGameSp.graphics.drawRect(0,tableHeigh/2,tableWidth/2,tableHeigh/2)
			boardGameSp.graphics.endFill();
			boardGameSp.visible = false
			boardGameSp.addEventListener(MouseEvent.CLICK , onClickGame)
			var boardTF:TextField
			boardTF = initTF(boardTF)
			boardTF.width = 100
			boardTF.text = "列表"
			boardGameSp.addChild(boardTF)
			boardTF.x = 0
			boardTF.y = tableHeigh/2
			

			cashSp = new Sprite();
			this.addChild(cashSp)
			cashSp.graphics.beginFill(0x9f9b39,1);
			cashSp.graphics.drawRect(tableWidth/2,tableHeigh/2,tableWidth/2,tableHeigh/2)
			cashSp.graphics.endFill();
			cashSp.addEventListener(MouseEvent.CLICK, onClickCash)
			cashSp.visible = false
			var cashTF: TextField
			cashTF = initTF(cashTF)
			cashTF.width = 100
			cashTF.text = "结账"
			cashSp.addChild(cashTF)
			cashTF.x = tableWidth/2
			cashTF.y = tableHeigh/2
		}

		private function initTF(_numTf: TextField): TextField {
			_numTf = new TextField()
			_numTf.defaultTextFormat = new TextFormat(null, 18, 0x000000, true)
			_numTf.text = String(" ")
			_numTf.width = 200
			_numTf.height = _numTf.textHeight + 5;
			/*this.addChild(_numTf)*/
			_numTf.mouseEnabled = false
			return _numTf
		}

		private function initSkin(): void {
			tableSp = new Sprite();
			this.addChild(tableSp)
			tableSp.graphics.beginFill(0x6effd1, 1);
			tableSp.graphics.drawRect(0, 0, tableWidth, tableHeigh)
			tableSp.graphics.endFill();
			tableSp.addEventListener(MouseEvent.CLICK, onClick)
		}

		private function addListener(): void {}

		private function addFrame(_frame: * , _name: String): void {
			createFrame = new JFrame();
			createFrame.setTitle(_name)
			createFrame.setContentPane(_frame);
			//			createFrame.setBackgroundDecorator(n
			createFrame.show();
			createFrame.pack();
			
			createFrame.setLocationXY(1250 / 2 - createFrame.width / 2, 750 / 2 - createFrame.height / 2);
			createFrame.addEventListener(WindowEvent.WINDOW_DEACTIVATED, onLostFocusCreateFrame)
		}

		protected function onLostFocusCreateFrame(event): void {
			StageMask.getInstance().removeMask()
			menuSp.visible = false
			cashSp.visible = false
			boardGameSp.visible = false
			createFrame.hide()
			if(openBoardGame){
				openBoardGame = false
				boardGameList = BoardGameManager.getInstance().getAllData()
			}
			
			if(openMenu){
				openMenu = false
				shopList = ShopItemManager.getInstance().getAllData();
			}
			trace("boardGameList!!!",boardGameList , shopList)
		}

		private function onCreateTable(e: MyEvent): void {
			createFrame.hide()
			playerNum = e.personNum
			playerNumTf.text = "人数：" + String(playerNum)
			onCreateTableComplete()
		}
		
		private function onClickGame(e:MouseEvent):void{
			openBoardGame = true
			StageMask.getInstance().addMask()
			BoardGameManager.getInstance().clearList()	
			for(var i:int = 0 ; i < boardGameList.length ; i++){
				var vo:BoardGameVo = new BoardGameVo()
				vo = boardGameList[i]
				BoardGameManager.getInstance().addTarget(vo)
			}
			boardGamePopup = new GameSelectPopup()
			addFrame(boardGamePopup,"BoardGame")
			createFrame.addEventListener(Event.REMOVED_FROM_STAGE ,onCloseBoardGame)
		}
		
		private function onCloseBoardGame(e:Event):void{
			openBoardGame = false
			StageMask.getInstance().removeMask()
			menuSp.visible = false
			cashSp.visible = false
			boardGameSp.visible = false
			var items:Array = BoardGameManager.getInstance().getAllData()
			boardGameList = items
			trace("boardGameList" , boardGameList)
		}

		private function onClickMenu(e: MouseEvent): void {
			openMenu = true
			StageMask.getInstance().addMask()
			ShopItemManager.getInstance().clearList()
			for (var i: int = 0; i < shopList.length; i++) {
				var vo: ShopItemVo = new ShopItemVo()
				vo = shopList[i]
				ShopItemManager.getInstance().addTarget(vo);
			}

			menuTablePopup = new MenuTargetPopup();
			addFrame(menuTablePopup, "Menu")
			createFrame.addEventListener(Event.REMOVED_FROM_STAGE, onCloseMenu)
		}

		private function accountItems(): Number {
			var money: Number = 0;
			for (var i: int = 0; i < shopList.length; i++) {
				var vo: ShopItemVo = new ShopItemVo()
				vo = shopList[i]
				money += vo.price * vo.num
			}
			return money
		}

		private function onClickCash(e: MouseEvent): void {
			var money: Number = accountItems()
			endTime = getTimer();
			var progressTime: int = endTime - startTime;
			settingTime = progressTime / 1000 / 60;

			StageMask.getInstance().addMask()
			accountPopup = new AccountPopup(settingTime, money, playerNum)
			addFrame(accountPopup, "Account")
			accountPopup.addEventListener(MyEvent.PRINT_LIST, onPrintList)
			accountPopup.addEventListener(Event.REMOVED_FROM_STAGE, onCloseAccount)
		}
		
		protected function onCloseAccount(event:Event):void
		{
			StageMask.getInstance().removeMask()
			menuSp.visible = false
			cashSp.visible = false
			boardGameSp.visible = false
			createFrame.hide()
		}
		
		private function onPrintList(e: MyEvent): void {
			trace("print")
			this.createFrame.hide()
			var ensurePopup: EnsurePopup = new EnsurePopup();
			StageMask.getInstance().addMask()
			addFrame(ensurePopup, "确认打印")
			createFrame.addEventListener(Event.REMOVED_FROM_STAGE, onEnsureClose)
		}
		
		private function onEnsureClose(e:Event):void{
			StageMask.getInstance().removeMask()
			menuSp.visible = false
			cashSp.visible = false
			boardGameSp.visible = false
			createFrame.hide()
		}


		protected function onClick(event: MouseEvent): void {
			if (hasGuest == false) {
				StageMask.getInstance().addMask()
				createTablePopup = new CreateTablePopup();
				createTablePopup.addEventListener(MyEvent.CREATE_TABLE, onCreateTable);
				addFrame(createTablePopup, "Create Table")
			} else {
				menuSp.visible = true
				cashSp.visible = true
				boardGameSp.visible = true
			}

		}

		private function onCloseMenu(e:Event): void {
			openMenu = false
			StageMask.getInstance().removeMask()
			menuSp.visible = false
			cashSp.visible = false
			boardGameSp.visible = false
			var items:Array = ShopItemManager.getInstance().getAllData();
			shopList = items
			trace("shopList", shopList)
		}

		private function onLevelTable(): void {
			hasGuest = false
			endTime = getTimer();
			var progressTime: int = endTime - startTime;
			settingTime = progressTime / 1000 / 60;
			trace("时间" + settingTime + "分钟")
			tableSp.graphics.clear();
			tableSp.graphics.beginFill(0x6effd1, 1);
			tableSp.graphics.drawRect(0, 0, tableWidth, tableHeigh)
			tableSp.graphics.endFill();

			timeTf.text = ""
			playerNumTf.text = ""
		}

		/**
		 *创建成功
		 *
		 */
		private function onCreateTableComplete(): void {
			hasGuest = true;
			startDate = new Date().hours;
			startHours =  new Date().hours;
			startTime = getTimer();
			trace(new Date().hours, new Date().minutes)
			timeTf.text = "开始时间：" + String(new Date().hours + "时" + new Date().minutes + "分钟")
			tableSp.graphics.clear();
			tableSp.graphics.beginFill(0xff6e6e, 1);
			tableSp.graphics.drawRect(0, 0, tableWidth, tableHeigh)
			tableSp.graphics.endFill();
		}
	}
}