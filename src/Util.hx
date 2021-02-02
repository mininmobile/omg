class Util {
	public static function valueToRgba(v : Int, a : Int = 255) : Int {
		return (a << 24) + (v << 16) + (v << 8) + v;
	}
}
