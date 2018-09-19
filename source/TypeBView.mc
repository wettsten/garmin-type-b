using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time.Gregorian;

class TypeBView extends Ui.WatchFace {
	
	private var _timeSetter;
	private var _font;
	private var _phoneConnected;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));        
        
        var textView = View.findDrawableById("TextLabel");
        _font = Ui.loadResource( Rez.Fonts.expressway_bold_150 );
        textView.setFont(_font);
        
        _timeSetter = new TypeBTimeSetter();
		_phoneConnected = System.getDeviceSettings().phoneConnected;
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
    	if (App.getApp().getProperty("ShowPhoneDisconnected") == true) {
		
			var phoneConnected = System.getDeviceSettings().phoneConnected;
			if (phoneConnected != _phoneConnected) {
				System.println("Partial update...");
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
