package com.sty.boardgame.part
{
	import com.sty.boardgame.manager.BasicVo;
	import com.sty.boardgame.manager.ShopElementManager;
	import com.sty.boardgame.manager.ShopItemManager;
	import com.sty.boardgame.manager.ShopItemVo;
	
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import org.aswing.ASColor;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JScrollPane;
	import org.aswing.JTable;
	import org.aswing.JTextField;
	import org.aswing.ext.Form;
	import org.aswing.geom.IntDimension;



	public class AccountPopup extends Form
	{
		private var gameTargetFrame:JFrame;

		private var table:JTable;

		private var srcollPane:JScrollPane;


		private var addItemButton:JButton;

		private var deleteButton:JButton;

		private var idText:JTextField;

		private var valueText:JTextField ;
		private var addHourText:JTextField;
		private var elementList:JComboBox;
		private var guestNumberTf:JTextField
		private var guestNumber:int
		
		private var basePriceText:JTextField;
		private var addPriceText:JTextField;

		private var items:Array
		
		private var allTimes:int;
		
		private var money:Number;
		
		private var drinkTf:JTextField;

		private var totalPriceTf:JTextField
		
		public function AccountPopup(_allTimes:int , _money:Number,_playerNum:int)
		{
			super();
			setSize(new IntDimension(350, 500));
//			this.layout = new SoftBoxLayout(SoftBoxLayout.Y_AXIS);
			allTimes = _allTimes
			money    = _money;
			guestNumber = _playerNum;
			init();
		}

		private function init():void{
			addRow(new JLabel(" ") ,null)

			items = ShopElementManager.getInstance().getAllBasic()
			var arr:Array = new Array();
			for(var i:int = 0 ; i < items.length ; i++ ){
				var vo:BasicVo = items[i]
				arr.push(vo.name)
			}


			elementList = new JComboBox();
			elementList.setPreferredWidth(100);
			elementList.setListData(arr);
			elementList.addActionListener(onSelectBaisc)
			
			basePriceText = new JTextField("",12)
			basePriceText.setEditable(false)
			basePriceText.setEnabled(false)
			addPriceText = new JTextField("",12) 
			addPriceText.setEditable(false)
			addPriceText.setEnabled(false)
				
				
			idText = new JTextField("",12);
			valueText = new JTextField("",12)
			valueText.setText("1")
				
			guestNumberTf = new JTextField("",12)
			guestNumberTf.setText(String(guestNumber))
				
			addHourText = new JTextField("",12)
			addHourText.setText(String(allTimes))
			addHourText.setEditable(false)
			addHourText.setEnabled(false)
				
			drinkTf = new JTextField("",12)
			drinkTf.setEditable(false)
			drinkTf.setEnabled(false)
			drinkTf.setText(String(money))
				
			totalPriceTf = new JTextField("" ,12)
			totalPriceTf.setEditable(false)
			totalPriceTf.setEnabled(false)
				
			var empty:JTextField = new JTextField(" ",12)
			empty.setEditable(false)
			empty.setEnabled(false)
				
			labelHold([guestNumberTf],"人数：")
			labelHold([elementList,basePriceText],"基础：",null,true)
			labelHold([addHourText,addPriceText] , "增加时间：",null,true)
			labelHold([empty,drinkTf],"饮料：",null,true)
			labelHold([valueText,totalPriceTf],"折扣:",null,true)
			
			addItemButton = new JButton("结算");
			append(addItemButton);
			addItemButton.addActionListener(onAddTarget);
//			valueText.addActionListener(onSetSale)
			valueText.addEventListener(Event.CHANGE , onSetSale)
			calTotalPrice()
		}
		
		private function onSelectBaisc(e):void{
			var index:int = elementList.getSelectedIndex();
			var basicVo:BasicVo = items[index]
			var value:int = basicVo.price
			trace("价格",value)
			basePriceText.setText(String(value))
			var time:int = allTimes - basicVo.min
			time = Math.max(time,0)
			addHourText.setText(String(time) + "分钟")
			var ex:int = basicVo.extraPrice * (time / 60) * guestNumber
			addPriceText.setText(String(ex))
			calTotalPrice()
		}
		
		private function calTotalPrice():void{
			var basePrice:int =int( basePriceText.getText())
			var addPrice:int = int(addPriceText.getText())
			var sale:Number = Number(valueText.getText())
			var gamePrice:int = (basePrice + addPrice) * sale
				
			var drinkPice:int = int(drinkTf.getText())
			totalPriceTf.setText(String(gamePrice + drinkPice))
		}
		
		private function onSetSale(e):void{
			calTotalPrice()
		}


		private function onAddTarget(e):void{
			
		}

		private function labelHold(c:Array, text:String,  toolTip:String= null,isSpeical:Boolean = false):void{
			var label:JLabel = new JLabel(text); 
			var tip:JLabel ;
			if(toolTip != null){
				tip = new JLabel(toolTip,null,JLabel.LEFT);
				tip.setForeground(ASColor.GRAY);
			}
			if(isSpeical){
				addRow(label,c[0],c[1],c[2],tip);	
			}else{
				addRow(label,c[0],tip);	
			}
		}

	}
}
