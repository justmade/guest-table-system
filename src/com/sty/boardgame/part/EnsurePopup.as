package com.sty.boardgame.part
{
	import com.sty.boardgame.event.MyEvent;
	
	import org.aswing.ASColor;
	import org.aswing.ButtonGroup;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	import org.aswing.ext.Form;

	public class EnsurePopup extends Form
	{
		
			private var btnYes:JButton
		
			private var btnNo:JButton
			public function EnsurePopup(){
				init()
			}
			
			private function init():void{
				var buttonPanel:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER,16,5))
				btnYes = new JButton("确定");
				btnNo  = new JButton("取消");
				buttonPanel.appendAll(btnYes,btnNo);
				this.addRow(buttonPanel)
				btnYes.addActionListener(onEnsurePrint)
			}
			
			private function onEnsurePrint(e):void
			{
				var evt:MyEvent = new MyEvent(MyEvent.ENSURE_PRINT_LIST)
				this.dispatchEvent(evt)
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