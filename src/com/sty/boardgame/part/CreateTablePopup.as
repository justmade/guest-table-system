package com.sty.boardgame.part
{
	import com.sty.boardgame.event.MyEvent;
	
	import flash.display.Sprite;
	
	import org.aswing.ASColor;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JTextField;
	import org.aswing.ext.Form;
	import org.aswing.geom.IntDimension;
	
	public class CreateTablePopup extends Form
	{
		
		private var numCombo:JComboBox;
		
		private var createButton:JButton;
		
		public function CreateTablePopup()
		{
			super();
			
			init()
			
			this.setPreferredHeight(200)
			this.setPreferredWidth(150)
		}
		
		private function init():void{
			addRow(new JLabel(" ") ,null)
			numCombo = new JComboBox();
			var arr:Array = new Array();
			for(var i:int = 1 ; i <= 20 ;arr.push((i++).toString()))
			numCombo.setListData(arr);
			labelHold([numCombo],"人数:");
			numCombo.setPreferredSize(new IntDimension(100,20))
				
			createButton = new JButton("Create"); 
			addRow(new JLabel(" ") ,null)
			addRow(new JLabel(" ") ,null)
			addRow(null,createButton);
			createButton.addActionListener(onCreateTable)
		}
		
		private function onCreateTable(e):void{
			if(numCombo.getSelectedIndex() != -1){
				var myEvent:MyEvent = new MyEvent(MyEvent.CREATE_TABLE);
				myEvent.personNum = numCombo.getSelectedItem()
				this.dispatchEvent(myEvent);
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