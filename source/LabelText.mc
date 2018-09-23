using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian;

class LabelText extends Ui.Text {

    function initialize() {
        var dictionary = {
            :identifier => "LabelText"
        };

        Text.initialize(dictionary);
    }

    function draw(dc) {
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var mod = Math.floor((today.min + 2) / 5);
		
		var five = today.min == 0 ? "{hour}" : Resources.Fives[mod];
		var hour = Resources.Hours[(today.hour + (mod < 8 ? 0 : 1)) % 24];
		
		var textArray = StringUtil.split(StringUtil.replace(five,"{hour}",hour),' ');
		if (today.min % 10 == 0) {
			textArray.remove("about");
		}		
		var text = getText(dc,textArray);
        var textSize = dc.getTextDimensions(text,Resources.Font);
		
        dc.setColor(Settings.ForegroundColor, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - textSize[1] / 2, Resources.Font, text, Gfx.TEXT_JUSTIFY_CENTER);
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
}
