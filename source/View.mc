using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Time.Gregorian;

class View extends Ui.WatchFace {
	private var _timeSetter = new TimeSetter();
	private var _phoneConnected = Sys.getDeviceSettings().phoneConnected;
	
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));        
        
        var textView = View.findDrawableById("TextLabel");
        textView.setFont(Resources.Font);        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
	
    // Update the view
    function onUpdate(dc) {
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		
        _timeSetter.setTime(dc,today,View.findDrawableById("TimeLabel"));
        _timeSetter.setDate(dc,today,View.findDrawableById("DateLabel"));
        _timeSetter.setText(dc,today,View.findDrawableById("TextLabel"));
                
        System.println("Updating...");
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    
    function onPartialUpdate(dc) {
    	if (Settings.ShowPhoneDisconnected) {
		
			var phoneConnected = Sys.getDeviceSettings().phoneConnected;
			if (phoneConnected != _phoneConnected) {
				Sys.println("Partial update...");
        		View.onUpdate(dc);
        		_phoneConnected = phoneConnected;
			}
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
