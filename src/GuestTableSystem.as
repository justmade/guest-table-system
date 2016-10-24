package
{
	import com.sty.boardgame.MainView;
	import com.sty.boardgame.StageMask;
	import com.sty.boardgame.load.LoadingMoudle;
	
	import flash.display.Sprite;
	
	import org.aswing.AsWingManager;
	import org.aswing.EmptyLayout;
	import org.aswing.JPanel;
	import org.aswing.JWindow;
	
	[SWF (width="1250", height="750")]
	public class GuestTableSystem extends Sprite
	{
		public static var WINDOW:JWindow;
		
		private var tabpane:JPanel;
		
		private var mainView:MainView;
		
		public function GuestTableSystem()
		{
			init();
			var load:LoadingMoudle = new LoadingMoudle();
		}
		
		private function init():void{
			AsWingManager.setRoot(this);
			WINDOW = new JWindow(this);
			
			tabpane = new JPanel();
			tabpane.setLayout(new EmptyLayout());
			
			WINDOW.setContentPane(tabpane);
			WINDOW.setSizeWH(1250, 750);
			WINDOW.show();
			
			mainView = new MainView()
			tabpane.append(mainView);
			
			StageMask.getInstance().setStage(this.stage)
		}
	}
}