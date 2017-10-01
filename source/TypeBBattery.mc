using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System;

class Battery extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Battery"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {        
		var stats = System.getSystemStats();
    	dc.setColor(App.getApp().getProperty("ForegroundColor"), Graphics.COLOR_TRANSPARENT);
    	var total = stats.battery * 360 / 100;
    	var end = total <= 90 ? 90 - total : 360 - total + 90;
    	
    	dc.setPenWidth(16);
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2, dc.getWidth() / 2, Gfx.ARC_CLOCKWISE, 90, end);
    }
}
