using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;

class LabelDate extends Ui.Text {

    function initialize() {
        var dictionary = {
            :identifier => "LabelDate"
        };

        Text.initialize(dictionary);
    }

    function draw(dc) {
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
		//var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
        var dateString = Lang.format("$1$ $2$", [today.day, months[today.month - 1]]);
        
        dc.setColor(Settings.ForegroundColor, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() * 0.13, Gfx.FONT_TINY, dateString, Gfx.TEXT_JUSTIFY_CENTER);
    }
}
