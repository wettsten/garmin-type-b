using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time.Gregorian;

class TimeSetter {
	    
    function setTime(dc,today,timeView) {
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

        timeView.setColor(App.getApp().getProperty("ForegroundColor"));
        timeView.setLocation(dc.getWidth() / 2, dc.getHeight() * 0.8);
        timeView.setText(timeString);
	}
	
	function setDate(dc,today,dateView) {
		var months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
		//var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
        var dateString = Lang.format("$1$ $2$", [today.day, months[today.month - 1]]);
        
        dateView.setColor(App.getApp().getProperty("ForegroundColor"));
        dateView.setLocation(dc.getWidth() / 2, dc.getHeight() * 0.12);
        dateView.setText(dateString);
	}
	
	function getText(dc,array) {
		var text = StringUtil.join(array,' ');
		var textSize = dc.getTextDimensions(text,Resources.Font);
		if (textSize[0] < dc.getWidth() * 0.8) {
			return text;
		}
		var smallestWidth = 0;
		var finalText = "";
		for (var i = 1; i < array.size(); i++) {
			text = StringUtil.join(array.slice(null,i),' ') + "\n" + StringUtil.join(array.slice(i,null),' ');
			textSize = dc.getTextDimensions(text,Resources.Font);
			if (smallestWidth == 0 || textSize[0] < smallestWidth) {
				smallestWidth = textSize[0];
				finalText = text;
			}
		}
		return finalText;
	}
	
	function setText(dc,today,textView) {
		var mod = Math.floor((today.min + 2) / 5);
		
		var five = today.min == 0 ? "{hour}" : Resources.Fives[mod];
		var hour = Resources.Hours[(today.hour + (mod < 8 ? 0 : 1)) % 24];
		
		var textArray = StringUtil.split(StringUtil.replace(five,"{hour}",hour),' ');
		if (today.min % 10 == 0) {
			textArray.remove("about");
		}		
		var text = getText(dc,textArray);
        var textSize = dc.getTextDimensions(text,Resources.Font);
		
		textView.setLocation(dc.getWidth() / 2, dc.getHeight() / 2 - textSize[1] / 2);
		textView.setColor(App.getApp().getProperty("ForegroundColor"));
        textView.setSize(dc.getWidth() * 0.8, dc.getHeight());
        textView.setText(text);
	}
}
