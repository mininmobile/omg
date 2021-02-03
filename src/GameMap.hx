import hxd.BitmapData;
import h2d.Bitmap;
import h3d.mat.Texture;
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
		texture = new h3d.mat.Texture(width, height, [ Target, Dynamic ]);
		tile = h2d.Tile.fromTexture(texture);
		// generate a map with default properties
		generate();
		// update the texture with the new map
		update();
	}

	static var calls : Int = 0;

	public function generate() {
		// create blank object + texture
		var out = new Texture(width, height, [ Target ]);
		var bmp = new h2d.Bitmap();
		bmp.width = width;
		bmp.height = height;
		// create shader
		var shader = new GenShader();
		shader.seed           = 1;
		shader.minRadius      = .2;
		shader.maxRadius      = .8;
		shader.detail         = 50;
		shader.noiseScale     = 3;
		shader.perlinGain     = 0.5;
		shader.perlinDivisor  = 1;
		shader.fractalOctaves = 3;
		shader.fractalScale   = 0.5;
		// assign genshader to it
		bmp.addShader(shader);
		// draw output of shader to image
		bmp.drawTo(texture);
	}

	public function update() {
		// texture.uploadBitmap(image);
	}
}
