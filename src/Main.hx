import h2d.Tile;

class Main extends hxd.App {
	static function main() {
		var game = new Main();
	}

	override function init() {
		var map = new GameMap(500, 500);
		var g = new h2d.Graphics(s2d);
		g.beginTileFill(50, 50, 1, 1, map.tile);
		g.drawRect(50, 50, map.width, map.height);
		g.endFill();
	}
}
