package com.sty.boardgame.manager
{
	
	import org.aswing.JTable;
	import org.aswing.VectorListModel;
	import org.aswing.table.PropertyTableModel;
	import org.aswing.table.TableModel;
	
	public class ShopItemManager
	{
		
		private var tableModel:PropertyTableModel;
		
		private var	targetLists:VectorListModel;
		
		static private var _instance:ShopItemManager;
		
		public function ShopItemManager(lock:Lock) 
		{
			init();
		}
		
		public static function getInstance():ShopItemManager{
			if(_instance == null){
				_instance = new ShopItemManager(new Lock);
			}
			return _instance;
		}
		
		
		public function init():void{
			targetLists = new VectorListModel();
			
			var names:Array = ["商品","数量","价格"];
			
			var p:Array = ["targetItem","num","price"]
			
			var t:Array = new Array(names.length);
			
			tableModel = new PropertyTableModel(targetLists,names,p,t);
			
			tableModel.setAllCellEditable(false);
		}
		
		public function removeTarget(target:*):void{
			targetLists.remove(target);
		}
		
		
		public function getSelectedTask(_table:JTable):ShopItemVo{ 
			var row:int = _table.getSelectedRow(); 
			var target:ShopItemVo = null;
			if(row >= 0){
				target = targetLists.getElementAt(row);
			}
			return target; 
		}
		
		public function addTarget(target:*):void{
			targetLists.append(target);
		}
		
		public function clearList():void{
			for(var i:int = targetLists.getSize()-1 ; i >=0  ; i --){
				targetLists.removeAt(i);
			}
		}
		
		public function getAllData():Array{
			var arr:Array = new Array()
			for(var i:int = 0 ; i < targetLists.getSize() ; i ++){
				var target:ShopItemVo = targetLists.getElementAt(i);
				arr.push(target);
			}
			
			return arr;
		}
		
		public function getTableModel():TableModel{
			return tableModel;
		}
	}
}class Lock{}