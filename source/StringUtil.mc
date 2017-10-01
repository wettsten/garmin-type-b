static class StringUtil {
	static function split(str,char) {
		var charArray = str.toCharArray();
		var strArray = new [0];
		var buffer = "";
		for (var i = 0; i < charArray.size(); i++) {
			if (charArray[i] == char) {
				strArray.add(buffer);
				buffer = "";
			} else {
				buffer += charArray[i];
			}
		}
		strArray.add(buffer);
		return strArray;
	}
	
	static function join(arr,char) {
		var text = "";
		for (var i = 0; i < arr.size(); i++) {
			if (i != 0) {
				text += char;
			}
			text += arr[i];
		}
		return text;
	}
	
	static function replace(str,txt1,txt2) {
		var text = str;
		var index = str.find(txt1);
		while (index != null) {
			text = text.substring(0,index) + txt2 + text.substring(index + txt1.length(), text.length());
			index = text.find(txt1);
		}
		return text; 
	}
}