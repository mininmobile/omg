class Util {
	public static function valueToRgba(v : Int, a : Int = 255) : Int {
		return (a << 24) + (v << 16) + (v << 8) + v;
	}

	/**
	 * maps a number to a range
	 * @param v input value
	 * @param x1 from min
	 * @param y1 from max
	 * @param x2 to min
	 * @param y2 to max
	 * @return Float
	 */
	public static function mapFloat(v : Float, x1 : Float, y1 : Float, x2 : Float, y2 : Float) : Float {
		return (v - x1) * (y2 - x2) / (y1 - x1) + x2;
	}

	/**
	 * maps a number to a range
	 * @param v input value
	 * @param x1 from min
	 * @param y1 from max
	 * @param x2 to min
	 * @param y2 to max
	 * @return Int
	 */
	public static function mapInt(v : Float, x1 : Int, y1 : Int, x2 : Int, y2 : Int) : Int {
		return Std.int((v - x1) * (y2 - x2) / (y1 - x1) + x2);
	}
}
