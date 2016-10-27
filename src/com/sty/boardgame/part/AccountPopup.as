package com.sty.boardgame.part
{
	import com.sty.boardgame.manager.ShopElementManager;
	import com.sty.boardgame.manager.ShopItemManager;
	import com.sty.boardgame.manager.ShopItemVo;
	
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTable;
	import org.aswing.JTextField;
	import org.aswing.SoftBoxLayout;
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

		public function AccountPopup(_allTimes:int)
		{
			super();
			setSize(new IntDimension(350, 500));
//			this.layout = new SoftBoxLayout(SoftBoxLayout.Y_AXIS);
			allTimes = _allTimes
			init();
		}

		private function init():void{
			addRow(new JLabel(" ") ,null)

//			items = ShopElementManager.getInstance().getAllItems()
			var arr:Array = new Array();
			for(var i:int = 0 ; i < 3 ; i++ ){
//				var vo:ShopItemVo = items[i]
				arr.push(i+1)
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

			labelHold([elementList,basePriceText],"基础：",null,true)
			labelHold([addHourText,addPriveText] , "增加时间",null,true)
			labelHold([valueText],"Target Value:")

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
			elementList.getSelectedIndex();
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
