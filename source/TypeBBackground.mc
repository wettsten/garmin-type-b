using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Time.Gregorian;

class Background extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {        
        // Set the background color
        dc.setColor(Gfx.COLOR_TRANSPARENT, App.getApp().getProperty("BackgroundColor"));
        dc.clear();
        
        drawBattery(dc);
        drawTicker(dc);
    }

    function drawBattery(dc) {        
		var stats = System.getSystemStats();
    	dc.setColor(App.getApp().getProperty("ForegroundColor"), Graphics.COLOR_TRANSPARENT);
    	var total = stats.battery * 360 / 100;
    	var end = total <= 90 ? 90 - total : 360 - total + 90;
    	
    	dc.setPenWidth(16);
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2, dc.getWidth() / 2, Gfx.ARC_CLOCKWISE, 90, end);
    }

    function drawTicker(dc) {
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var mod = today.min % 5;
    	dc.setColor(App.getApp().getProperty("ForegroundColor"), Graphics.COLOR_TRANSPARENT);
    	
    	var length = App.getApp().getProperty("TickerLength");
    	var width = App.getApp().getProperty("TickerWidth");
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
