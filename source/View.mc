using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

class View extends Ui.WatchFace {
	private var _phoneConnected = Sys.getDeviceSettings().phoneConnected;
	private var _battery = Sys.getSystemStats().battery;
	
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.Main(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
	
    // Update the view
    function onUpdate(dc) {
        System.println("Updating...");
        View.onUpdate(dc);
    }
    
    function onPartialUpdate(dc) {
    	var update = false;	
		var phoneConnected = Sys.getDeviceSettings().phoneConnected;
		if (phoneConnected != _phoneConnected && Settings.ShowPhoneDisconnected) {
    		_phoneConnected = phoneConnected;
			Sys.println("Partial update due to phone connected change...");
    		update = true;
		}
		var battery = Sys.getSystemStats().battery;
		if (battery != _battery) {
			_battery = battery;
			Sys.println("Partial update due to battery change...");
			update = true;
		}
		if (update) {
    		View.onUpdate(dc);
    	}
    }
	
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
