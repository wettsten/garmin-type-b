using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;

class DrawableMinuteTickers extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "DrawableMinuteTickers"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var mod = today.min % 5;
    	dc.setColor(Settings.ForegroundColor, Gfx.COLOR_TRANSPARENT);
    	
    	var length = Settings.TickerLength;
    	var width = Settings.TickerWidth;
    	var dia = dc.getWidth();
    	var height = dc.getHeight();
    	var radius = dia / 2;
		var x1 = radius * Math.cos(45);
		var y1 = radius * Math.sin(45);
		var x2 = (radius - length) * Math.cos(45);
		var y2 = (radius - length) * Math.sin(45);
    	dc.setPenWidth(width);
    	switch (mod) {
    		case 0:
        		dc.drawLine(radius, 0, radius, length);
        		dc.drawLine(radius, dia, radius, dia - length);
    			break;
    		case 1:
        		dc.drawLine(radius + x1, radius - y1, radius + x2, radius - y2);
        		dc.drawLine(radius + x1, radius + y1, radius + x2, radius + y2);
    			break;
    		case 2:
    			dc.setPenWidth(width * 2);
        		dc.drawLine(dia, radius, dia - length, radius);
    			break;
    		case 3:
    			dc.setPenWidth(width * 2);
        		dc.drawLine(0, radius, length, radius);
    			break;
    		case 4:
        		dc.drawLine(radius - x1, radius - y1, radius - x2, radius - y2);
        		dc.drawLine(radius - x1, radius + y1, radius - x2, radius + y2);
    			break;
    	}
    }
}
