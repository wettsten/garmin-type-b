using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;

class DrawableBackground extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "DrawableBackground"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
        // Set the background color
        dc.setColor(Gfx.COLOR_TRANSPARENT, Settings.BackgroundColor);
        dc.clear();
    }
}
