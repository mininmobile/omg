import libnoise.generator.Perlin;

class GameMap {
	public var width(default, null): Int;
	public var height(default, null): Int;
	var image : hxd.BitmapData;
	var texture : h3d.mat.Texture;
	public var tile : h2d.Tile;

	public function new(width : Int = 500, height : Int = 500) {
		this.width = width;
		this.height = height;
		// prepare map tile for drawing in ui
		image = new hxd.BitmapData(width, height);
		texture = new h3d.mat.Texture(width, height);
		tile = h2d.Tile.fromTexture(texture);
		// generate a map with default properties
		generate();
		// update the texture with the new map
		update();
	}

	public function generate() {
		image.lock();
		image.clear(0xffffffff);
		var noise = new Perlin(0.01, 2.0, 0.5, 16, 42, MEDIUM);
		for (i in 0...width * height) {
			var y = Math.floor(i / width);
			var x = i - y * width;
			var c = Std.int(((noise.getValue(x, y, 0) + 1.5) / 3) * 255);

			image.setPixel(x, y, Util.valueToRgba(c));
		}
		image.unlock();
	}

	public function update() {
		texture.uploadBitmap(image);
	}
}
