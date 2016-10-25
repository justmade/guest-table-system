package com.sty.boardgame
{
	import com.sty.boardgame.part.Table;
	
	import org.aswing.ASColor;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.LayoutManager;
	import org.aswing.border.TitledBorder;
	import org.aswing.event.WindowEvent;
	import org.aswing.geom.IntDimension;

	public class MainView extends JPanel
	{
		private var tableNum:int = 10
			
		private var tables:Array
		
		private var viewWidth:int
		private var viewHeight:int
		
		public function MainView(layout:LayoutManager=null)
		{
			super(layout);
			viewWidth = 800
			viewHeight = 800;
			
			setSize(new IntDimension(viewWidth, viewHeight));
			var board:TitledBorder = new TitledBorder();
			board.setColor(new ASColor(0x0,1));
			board.setTitle("Map Editor");
			board.setPosition(1);
			board.setBeveled(true);
			this.setBorder(board);
			StageMask.getInstance().setStage(this)
			init();
//			StageMask.getInstance().addMask()
		}
		
	
		
		private function init():void{
			for(var i:int = 0 ; i < tableNum ; i ++){
				var table:Table = new Table(i+1);
				this.addChild(table);
				table.x = (i % 3) * (table.width + 30) + 30
				table.y = int(i /3 ) * (table.height + 30) + 30
			}
		}
	}
}