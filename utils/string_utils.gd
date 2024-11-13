class_name String_utils

const hira_start = 0x3041
const hira_end = 0x3096

const kata_start = 0x30A1
const kata_end = 0x30F6

static func kata_to_hira(kata : String) -> String:
	var hira = ""
	for i in range(kata.length()):
		if (kata_start <= kata.unicode_at(i))and(kata.unicode_at(i) <= kata_end): 
			
			hira += String.chr(hira_start - kata_start + kata.unicode_at(i))
		else:
			hira += kata[i]
	return hira



static func str_replace(hira : String, eng : String, string : String):
	return string.replace(hira, eng)

static func translitterate(string : String):
	#this is very dumb
	string = kata_to_hira(string)
	
	string = str_replace("つ", "tsu", string);
	string = str_replace("きゃ", "kya", string);
	string = str_replace("きゅ", "kyu", string);
	string = str_replace("きょ", "kyo", string);
	string = str_replace("しゃ", "sha", string);
	string = str_replace("しゅ", "shu", string);
	string = str_replace("しょ", "sho", string);
	string = str_replace("し", "shi", string);

	string = str_replace("ちゃ", "cha", string);
	string = str_replace("ちゅ", "chu", string);
	string = str_replace("ちょ", "cho", string);
	string = str_replace("ち", "chi", string);
	string = str_replace("ひゃ", "hya", string);
	string = str_replace("ひゅ", "hyu", string);
	string = str_replace("ひょ", "hyo", string);
	string = str_replace("りゃ", "rya", string);
	string = str_replace("りゅ", "ryu", string);
	string = str_replace("りょ", "ryo", string);
	string = str_replace("ぎゃ", "gya", string);
	string = str_replace("ぎゅ", "gyu", string);
	string = str_replace("ぎょ", "gyo", string);
	string = str_replace("びゃ", "bya", string);
	string = str_replace("びゅ", "byu", string);
	string = str_replace("びょ", "byo", string);
	string = str_replace("ぴゃ", "pya", string);

	string = str_replace("ぴゅ", "pyu", string);
	string = str_replace("ぴょ", "pyo", string);
	string = str_replace("じゃ", "ja", string);
	string = str_replace("じゅ", "ju", string);
	string = str_replace("じょ", "jo", string);
	string = str_replace("ば", "ba", string);
	string = str_replace("だ", "da", string);
	string = str_replace("が", "ga", string);
	string = str_replace("は", "ha", string);
	string = str_replace("か", "ka", string);
	string = str_replace("ま", "ma", string);
	string = str_replace("ぱ", "pa", string);

	string = str_replace("ら", "ra", string);
	string = str_replace("さ", "sa", string);
	string = str_replace("た", "ta", string);
	string = str_replace("わ", "wa", string);
	string = str_replace("や", "ya", string);
	string = str_replace("ざ", "za", string);
	string = str_replace("な", "na", string);
	string = str_replace("あ", "a", string);

	string = str_replace("べ", "be", string);
	string = str_replace("で", "de", string);
	string = str_replace("げ", "ge", string);
	string = str_replace("へ", "he", string);
	string = str_replace("け", "ke", string);
	string = str_replace("め", "me", string);
	string = str_replace("ぺ", "pe", string);
	string = str_replace("れ", "re", string);
	string = str_replace("せ", "se", string);
	string = str_replace("て", "te", string);
	string = str_replace("ぜ", "ze", string);
	string = str_replace("ね", "ne", string);

	string = str_replace("え", "e", string);
	string = str_replace("び", "bi", string);
	string = str_replace("ぎ", "gi", string);
	string = str_replace("ひ", "hi", string);
	string = str_replace("き", "ki", string);
	string = str_replace("み", "mi", string);
	string = str_replace("ぴ", "pi", string);
	string = str_replace("り", "ri", string);
	string = str_replace("じ", "ji", string);
	string = str_replace("に", "ni", string);

	string = str_replace("い", "i", string);
	string = str_replace("ぼ", "bo", string);
	string = str_replace("ど", "do", string);
	string = str_replace("ご", "go", string);
	string = str_replace("ほ", "ho", string);
	string = str_replace("こ", "ko", string);

	string = str_replace("も", "mo", string);
	string = str_replace("ぽ", "po", string);
	string = str_replace("ろ", "ro", string);
	string = str_replace("そ", "so", string);
	string = str_replace("と", "to", string);
	string = str_replace("を", "wo", string);
	string = str_replace("よ", "yo", string);
	string = str_replace("ぞ", "zo", string);

	string = str_replace("の", "no", string);
	string = str_replace("お", "o", string);
	string = str_replace("ぶ", "bu", string);
	string = str_replace("ぐ", "gu", string);
	string = str_replace("ふ", "fu", string);
	string = str_replace("く", "ku", string);
	string = str_replace("む", "mu", string);
	string = str_replace("ぷ", "pu", string);
	string = str_replace("る", "ru", string);
	string = str_replace("す", "su", string);

	string = str_replace("ゆ", "yu", string);
	string = str_replace("ず", "zu", string);
	string = str_replace("ぬ", "nu", string);
	string = str_replace("う", "u", string);
	string = str_replace("ん", "n", string);
	
	#string = preg_replace("/っ([a-z])/", "$1$1", string);
	for i in range(string.length()):
		if string[i] == "っ":
			string[i] = string[i+1]
		if string[i] in "ーぁィぅぇぉ":
			string[i] = string[i-1]
	
	return string;


static func strip(str : String) -> String:
	str = str.to_lower()
	
	if str.begins_with("a "):
		str = str.right(-2)
	if str.begins_with("an "):
		str = str.right(-3)
	if str.begins_with("the "):
		str = str.right(-4)
	if str.begins_with("to "):
		str = str.right(-3)
	
	if str.find(" (") != -1:
		str = str.erase(str.find(" ("), str.find(")") - str.find(" (") + 1)
	if str.find("(") != -1:
		str = str.erase(str.find("("), str.find(") ") - str.find("(") + 2)
	
	return str



static func check_for_typo(str1 : String, str2 : String, strict : bool = false) -> bool:
	if strict:
		return str1 == str2
	if str1 == str2:
		return true
	if abs(str1.length() - str2.length()) > 1:
		return false
	
	for i in range(min(str1.length(), str2.length())):
		if str1[i] != str2[i]:
			if (str1.length() == str2.length()):
				return check_for_typo(str1.right(-(i + 1)), str2.right(-(i + 1)), true)
			#check missing
			var shorter = str1
			var longer = str2
			if str1.length() > str2.length():
				shorter = str2
				longer = str1
			
			shorter = shorter.right(- (i + 1))
			longer = longer.right(- (i + 1))
			
			#assume missing
			return check_for_typo(shorter, longer.right(-1), true)
			
	return true
