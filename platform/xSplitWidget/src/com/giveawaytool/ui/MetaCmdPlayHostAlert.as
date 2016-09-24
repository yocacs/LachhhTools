package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaHostAlert;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayHostAlert extends MetaCmd {
		public var metaHostAlert:MetaHostAlert;
		

		public function MetaCmdPlayHostAlert(m : MetaHostAlert) {
			metaHostAlert = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			UI_News.closeAllNews();
			var ui:UI_NewHostAnim = new UI_NewHostAnim(metaHostAlert);
			ui.callbackOnDestroy = new Callback(onAnimEnded, this, null); 
		}
		
		private function onAnimEnded():void {
			MainGame.instance.createNews();
			endCmd();
		}
	}
}