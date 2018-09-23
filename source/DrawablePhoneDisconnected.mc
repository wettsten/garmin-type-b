using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;

class DrawablePhoneDisconnected extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "DrawablePhoneDisconnected"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
		if (Settings.ShowPhoneDisconnected) {
			if (Sys.getDeviceSettings().phoneConnected == false) {
				
				dc.setColor(Settings.PhoneDisconnectedColor, Gfx.COLOR_TRANSPARENT);
				dc.setPenWidth(5);				
				
        		var x1 = dc.getWidth() * 0.15;
        		var x2 = dc.getWidth() * 0.85;
        		var y = dc.getHeight() * 0.28;
        		dc.drawLine(x1, y, x2, y);
        		
        		y = dc.getHeight() * 0.72;
        		dc.drawLine(x1, y, x2, y);
			}
		}
    }
}
