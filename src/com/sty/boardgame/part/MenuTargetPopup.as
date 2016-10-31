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
	import org.aswing.geom.IntDimension;
	
	
	
	public class MenuTargetPopup extends JPanel
	{
		private var gameTargetFrame:JFrame;
		
		private var table:JTable;
		
		private var srcollPane:JScrollPane;
		
		
		private var addItemButton:JButton;
		
		private var deleteButton:JButton;
		
		private var idText:JTextField;
		
		private var valueText:JTextField ;
		private var elementList:JComboBox;
		
		private var items:Array
		
		public function MenuTargetPopup()
		{
			super();
			setSize(new IntDimension(350, 500));
			this.layout = new SoftBoxLayout(SoftBoxLayout.Y_AXIS);
			
			init();
		}
		
		private function init():void{
			table = new JTable();
			srcollPane = new JScrollPane(table);
			
			table.setModel(ShopItemManager.getInstance().getTableModel());
			srcollPane.setPreferredHeight(150);
			srcollPane.setPreferredWidth(200);
			append(srcollPane);
			
			items = ShopElementManager.getInstance().getAllItems()
			var eArrs:Array = []
			var arr:Array = new Array();
			for(var i:int = 0 ; i < items.length ; i++ ){
				var vo:ShopItemVo = items[i]
				arr.push(vo.name)
			}
			
			
		
			
//			for(var i:int = 0 ; i < eArrs.length ; i++){
//				arr.push(eArrs[i])
//			}
			
			elementList = new JComboBox();
			elementList.setPreferredWidth(150);
			elementList.setListData(arr);
			
			
			idText = new JTextField("",12);
			valueText = new JTextField("",12)
			valueText.setText("1")
			
			append(labelHold(elementList,"商品："))
//			append(labelHold(idText,"Target id:"))
			append(labelHold(valueText,"数量:"))
			
			
			addItemButton = new JButton("添加");
			append(addItemButton);
			
			deleteButton = new JButton("删除");
			deleteButton.setBackground(ASColor.RED);
			append(deleteButton);
			
			addItemButton.addActionListener(onAddTarget);
			deleteButton.addActionListener(onDelete)
				
			deleteButton.setToolTipText("Delete a selection item");
			
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
				gameVo.price = vo.price * num;
				ShopItemManager.getInstance().addTarget(gameVo);
			}
		}
		
		private function labelHold(c:Component, text:String,toolTip:String=null):Container{
			var panel:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT,2, 0, false));
			var label:JLabel = new JLabel(text); 
			panel.appendAll(label, c); 
			if(toolTip != null){
				panel.setToolTipText(toolTip); 
			}
			return panel; 
		}
		
	}
}