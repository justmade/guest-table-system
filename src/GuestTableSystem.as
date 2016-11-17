package
{
	import com.sty.boardgame.MainView;
	import com.sty.boardgame.load.LoadingMoudle;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	import org.aswing.AsWingManager;
	import org.aswing.EmptyLayout;
	import org.aswing.JPanel;
	import org.aswing.JWindow;
	import org.aswing.table.sorter.SortableHeaderRenderer;
	
	[SWF (width="1250", height="750")]
	public class GuestTableSystem extends Sprite
	{
		public static var WINDOW:JWindow;
		
		private var tabpane:JPanel;
		
		private var mainView:MainView;
		
		public static var wstage:Stage
		
		public function GuestTableSystem()
		{
			init();
			var load:LoadingMoudle = new LoadingMoudle();
		}
		
		private function init():void{
			wstage = this.stage
			AsWingManager.setRoot(this);
			WINDOW = new JWindow(this);
			
			tabpane = new JPanel();
			tabpane.setLayout(new EmptyLayout());
			
			WINDOW.setContentPane(tabpane);
			WINDOW.setSizeWH(1250, 750);
			WINDOW.show();
			
			mainView = new MainView()
			tabpane.append(mainView);				
		}
		
		private function printt():void{
//			var myPrintJob:PrintJob = new PrintJob(); 
//			var options:PrintJobOptions = new PrintJobOptions(); 
//			options.printAsBitmap = true; 
//			myPrintJob.start();
//			
//			
//			
//			try { 
//				if (myPrintJob.start()) {
//					myPrintJob.addPage(this, new Rectangle(0,0,200,200), options); 
//				}
//			}
//			catch(e:Error) { 
//				trace ("Had problem adding the page to print job: " + e); 
//			}
//			try {
//				myPrintJob.send();
//			} 
//			catch (e:Error) { 
//				trace ("Had problem printing: " + e);    
//			} 
		}
	}
}