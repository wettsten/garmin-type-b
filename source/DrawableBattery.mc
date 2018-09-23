using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;

class DrawableBattery extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "DrawableBattery"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
		var stats = Sys.getSystemStats();
    	dc.setColor(Settings.ForegroundColor, Graphics.COLOR_TRANSPARENT);
    	var total = stats.battery * 360 / 100;
    	var end = total <= 90 ? 90 - total : 360 - total + 90;
    	
    	dc.setPenWidth(16);
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2, dc.getWidth() / 2, Gfx.ARC_CLOCKWISE, 90, end);
    }
}
