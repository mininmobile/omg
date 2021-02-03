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
		texture = new h3d.mat.Texture(width, height, [ Dynamic ]);
		tile = h2d.Tile.fromTexture(texture);
		// generate a map with default properties
		generate();
		// update the texture with the new map
		update();
	}

	public function generate() {
		var heightmap : hxd.Pixels;
		{ // generate island shape
			var g = new h2d.Graphics();
			var i = 0.;
			g.beginFill(0xFFFFFF);
			var noise = new Perlin(0.5, 2.0, 0.5, 16, 42, MEDIUM);
			do {
				var cos = Math.cos(i);
				var sin = Math.sin(i);
				var r = Util.mapFloat(noise.getValue(cos, sin, 0), -1.5, 1.5, 0, Math.min(width, height) * .8);
				var x = (cos * r) + width / 2;
				var y = (sin * r) + height / 2;
				if (i == 0)
					g.moveTo(x, y);
				else
					g.lineTo(x, y);
			} while ((i += 0.1) < Math.PI * 2);
			g.endFill();
			// convert into bitmapData
			var shapeTexture = new h3d.mat.Texture(width, height, [ Target ]);
			g.drawTo(shapeTexture);
			heightmap = shapeTexture.capturePixels();
			// cleanup
			shapeTexture.dispose();
		}

		{ // generate heightmap
			var noise = new Perlin(0.01, 2.0, 0.5, 16, 42, MEDIUM);
			for (i in 0...width * height) {
				var y = Math.floor(i / width);
				var x = i - y * width;
				var land = heightmap.getPixel(x, y) > 0 ?
					((noise.getValue(x, y, 0) + 1.5) / 3) * 255 : 0.0;

				heightmap.setPixel(x, y, Std.int(land));
			}
		}

		// generate preview
		{
			image.lock();
			image.clear(0xffffffff);
			for (i in 0...width * height) {
				var y = Math.floor(i / width);
				var x = i - y * width;
				var c = heightmap.getPixel(x, y);

				image.setPixel(x, y, Util.valueToRgba(c));
			}
			image.unlock();
		}
	}

	public function update() {
		texture.uploadBitmap(image);
	}
}
