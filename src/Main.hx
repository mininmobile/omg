import libnoise.generator.Perlin;
import h3d.scene.Graphics;
import h2d.Bitmap;
import h2d.Tile;

class Main extends hxd.App {
	static function main() {
		var game = new Main();
	}

	var map : GameMap;
	var window : hxd.Window;

	override function init() {
		window = hxd.Window.getInstance();
		window.title = "Open Map Gen";
		window.addEventTarget(onEvent);

		map = new GameMap(500, 500);
		var display = new h2d.Bitmap(map.tile, s2d);
		display.setPosition(50, 50);
	}

	function onEvent(event : hxd.Event) {
		switch (event.kind) {
			case EKeyDown: map.generate();
			case _:
		}
	}
}
