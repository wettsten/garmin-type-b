using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time.Gregorian;

class TypeBView extends Ui.WatchFace {
	
	private var _font;
	private var _fives;
	private var _hours;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        
		_fives = Ui.loadResource( Rez.JsonData.fives );
		_hours = Ui.loadResource( Rez.JsonData.hours );
        
        var textView = View.findDrawableById("TextLabel");
        _font = Ui.loadResource( Rez.Fonts.expressway_bold_150 );
        textView.setFont(_font);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
    
    function setTime(dc,today) {
        var timeFormat = "$1$:$2$";
        var hours = today.hour;
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
        	hours = hours.format("%02d");
        }
        var timeString = Lang.format(timeFormat, [hours, today.min.format("%02d")]);

        var timeView = View.findDrawableById("TimeLabel");
        timeView.setColor(App.getApp().getProperty("ForegroundColor"));
        timeView.setLocation(dc.getWidth() / 2, dc.getHeight() * 0.8);
        timeView.setText(timeString);
	}
	
	function setDate(dc,today) {
		var months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
        var dateString = Lang.format("$1$ $2$", [today.day, months[today.month - 1]]);
        
        var dateView = View.findDrawableById("DateLabel");
        dateView.setColor(App.getApp().getProperty("ForegroundColor"));
        dateView.setLocation(dc.getWidth() / 2, dc.getHeight() * 0.1);
        dateView.setText(dateString);
	}
	
	function getText(dc,array) {
		var text = StringUtil.join(array,' ');
		var textSize = dc.getTextDimensions(text,_font);
		if (textSize[0] < dc.getWidth() * 0.8) {
			return text;
		}
		var smallestWidth = 0;
		var finalText = "";
		for (var i = 1; i < array.size(); i++) {
			text = StringUtil.join(array.slice(null,i),' ') + "\n" + StringUtil.join(array.slice(i,null),' ');
			textSize = dc.getTextDimensions(text,_font);
			if (smallestWidth == 0 || textSize[0] < smallestWidth) {
				smallestWidth = textSize[0];
				finalText = text;
			}
		}
		return finalText;
	}
	
	function setText(dc,today) {
		var mod = Math.floor((today.min + 2) / 5);
		
		var five = today.min == 0 ? "{hour}" : _fives[mod];
		var hour = _hours[today.hour + (mod < 8 ? 0 : 1)];
		
		var textArray = StringUtil.split(StringUtil.replace(five,"{hour}",hour),' ');
		if (today.min % 10 == 0) {
			textArray.remove("about");
		}		
		var text = getText(dc,textArray);
        var textSize = dc.getTextDimensions(text,_font);
		
        var textView = View.findDrawableById("TextLabel");
		textView.setLocation(dc.getWidth() / 2, dc.getHeight() / 2 - textSize[1] / 2);
		textView.setColor(App.getApp().getProperty("ForegroundColor"));
        textView.setSize(dc.getWidth() * 0.8, dc.getHeight());
        textView.setText(text);
	}
	
    // Update the view
    function onUpdate(dc) {
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		
        setTime(dc,today);
        setDate(dc,today);
        setText(dc,today);
                
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
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
