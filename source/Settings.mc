using Toybox.Application as App;

static class Settings {

	static var ShowPhoneDisconnected = App.getApp().getProperty("ShowPhoneDisconnected");
	static var BackgroundColor = App.getApp().getProperty("BackgroundColor");
	static var PhoneDisconnectedColor = App.getApp().getProperty("PhoneDisconnectedColor");
	static var ForegroundColor = App.getApp().getProperty("ForegroundColor");
	static var TickerLength = App.getApp().getProperty("TickerLength");
	static var TickerWidth = App.getApp().getProperty("TickerWidth");
}
