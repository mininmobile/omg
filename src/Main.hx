import libnoise.generator.Perlin;
import h3d.scene.Graphics;
import h2d.Bitmap;
import h2d.Tile;

class Main extends hxd.App {
	static function main() {
		var game = new Main();
	}

	override function init() {
		var map = new GameMap(500, 500);
		var display = new h2d.Bitmap(map.tile, s2d);
		display.setPosition(50, 50);
	}
}
