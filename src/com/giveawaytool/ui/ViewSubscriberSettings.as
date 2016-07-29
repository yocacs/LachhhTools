package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewSubscriberToolTip;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriberSettings extends ViewBase {
		public var viewSubscriberList : ViewSubscribersList;
		public var viewSubscriberToolTip : ViewSubscriberToolTip;
		public var viewSubscriberAlert : ViewSubscriberAlert;
		public var viewSubscriberGoal : ViewSubscriberGoal;
		
		
		public function ViewSubscriberSettings(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewSubscriberAlert = new ViewSubscriberAlert(screen, subAlertsMc);
			viewSubscriberGoal = new ViewSubscriberGoal(screen, goalsMc);
			viewSubscriberList = new ViewSubscribersList(screen, lastSubscriptionMc);
			viewSubscriberToolTip = new ViewSubscriberToolTip(screen, toolTipSubscriberMc);
			viewSubscriberList.toolTip = viewSubscriberToolTip; 
			
			screen.setNameOfDynamicBtn(refreshBtn, "Refresh");
			screen.setNameOfDynamicBtn(collectBtn, "Alert New");

			screen.registerClick(refreshBtn, onRefresh);
			screen.registerClick(collectBtn, onCollect);
			viewSubscriberList.showLoading(true);
			refresh();
		}

		private function onCollect() : void {
			UI_Menu.instance.logicNotification.logicSubAlert.collectNew();
			refresh();
		}

		private function onRefresh() : void {
			viewSubscriberList.showLoading(true);
			UI_Menu.instance.logicNotification.logicSubAlert.refreshSubsFromTwitch(new Callback(refresh, this, null));
		}

		override public function refresh() : void {
			super.refresh();
			
			viewSubscriberList.setData(MetaGameProgress.instance.metaSubsConfig.listOfSubs.subscribers);
			viewSubscriberList.refresh();
			viewSubscriberList.showLoading(false);
		}
		

		public function get lastSubscriptionMc() : MovieClip {return visual.getChildByName("lastSubscriptionMc") as MovieClip;}
		public function get toolTipSubscriberMc() : MovieClip { return visual.getChildByName("toolTipSubscriberMc") as MovieClip;}
		
		public function get refreshBtn() : MovieClip { return visual.getChildByName("refreshBtn") as MovieClip;}
		public function get collectBtn() : MovieClip { return visual.getChildByName("collectBtn") as MovieClip;}
		public function get subAlertsMc() : MovieClip { return visual.getChildByName("subAlertsMc") as MovieClip;}
		public function get goalsMc() : MovieClip { return visual.getChildByName("goalsMc") as MovieClip;}
	}
}