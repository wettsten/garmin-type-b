using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;

class LabelTime extends Ui.Text {

    function initialize() {
        var dictionary = {
            :identifier => "LabelTime"
        };

        Text.initialize(dictionary);
    }

    function draw(dc) {
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
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

        dc.setColor(Settings.ForegroundColor, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() * 0.77, Gfx.FONT_TINY, timeString, Gfx.TEXT_JUSTIFY_CENTER);
    }
}
