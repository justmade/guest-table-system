package com.sty.boardgame.part
{
	import com.sty.boardgame.manager.BasicVo;
	import com.sty.boardgame.manager.ShopElementManager;
	import com.sty.boardgame.manager.ShopItemManager;
	import com.sty.boardgame.manager.ShopItemVo;
	
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
		
		private var basePriceText:JTextField;
		private var addPriveText:JTextField;

		private var items:Array
		
		private var allTimes:int;
		
		private var money:Number;
		
		private var drinkTf:JTextField;

		public function AccountPopup(_allTimes:int , _money:Number)
		{
			super();
			setSize(new IntDimension(350, 500));
//			this.layout = new SoftBoxLayout(SoftBoxLayout.Y_AXIS);
			allTimes = _allTimes
			money    = _money;
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
			addPriveText = new JTextField("",12) 
			addPriveText.setEditable(false)
			addPriveText.setEnabled(false)
				
				
			idText = new JTextField("",12);
			valueText = new JTextField("",12)
			valueText.setText("1")
				
			addHourText = new JTextField("",12)
			addHourText.setText("0")
			addHourText.setEditable(false)
			addHourText.setEnabled(false)
				
			drinkTf = new JTextField("",12)
			drinkTf.setEditable(false)
			drinkTf.setEnabled(false)
			drinkTf.setText(String(money) + "圆")
				
			var empty:JTextField = new JTextField(" ",12)
			empty.setEditable(false)
			empty.setEnabled(false)
				
			labelHold([elementList,basePriceText],"基础：",null,true)
			labelHold([addHourText,addPriveText] , "增加时间：",null,true)
			labelHold([valueText],"Target Value:")
			labelHold([empty,drinkTf],"饮料：",null,true)

			addItemButton = new JButton("添加");
			append(addItemButton);

			deleteButton = new JButton("删除");
			deleteButton.setBackground(ASColor.RED);
			append(deleteButton);

			addItemButton.addActionListener(onAddTarget);
			deleteButton.addActionListener(onDelete)

			deleteButton.setToolTipText("Delete a selection item");

		}
		
		private function onSelectBaisc(e):void{
			var index:int = elementList.getSelectedIndex();
			var basicVo:BasicVo = items[index]
			var value:int = basicVo.price
			trace("价格",value)
			basePriceText.setText(String(value) + "圆")
			var time:int = allTimes - basicVo.min
			addHourText.setText(String(time) + "分钟")
			var ex:int = basicVo.extraPrice * (time / 60)
			addPriveText.setText(String(ex) + "圆")
		}


		private function onDelete(e):void{
			var vo:ShopItemVo = ShopItemManager.getInstance().getSelectedTask(table);
			if(vo){
				ShopItemManager.getInstance().removeTarget(vo);
			}
		}

		private function onAddTarget(e):void{
			if(elementList.getSelectedItem() ){
				var gameVo:ShopItemVo = new ShopItemVo();
				var num:Number = Number(valueText.getText())
				var index:int = elementList.getSelectedIndex()
				var vo:ShopItemVo = items[index]
				gameVo.id = vo.id;
				gameVo.name = vo.name
				gameVo.num = num
				gameVo.price = 5 * num;
				ShopItemManager.getInstance().addTarget(gameVo);
			}
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
