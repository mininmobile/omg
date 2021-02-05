class Main extends hxd.App {
	static function main() {
		var game = new Main();
	}

	var map : GameMap;
	var window : hxd.Window;

	override function init() {
		window = hxd.Window.getInstance();
		window.addEventTarget(onEvent);
		window.title = "Open Map Gen";
		engine.backgroundColor = 0xFF1c1c1c;

		map = new GameMap(500, 500);
		s2d.addChild(map.bitmap);
		map.bitmap.setPosition(50, 50);
	}

	function onEvent(event : hxd.Event) {
		switch (event.kind) {
			case EKeyDown:
				if (event.keyCode == 65 || event.keyCode == 37) {
					map.seed--;
				} else if (event.keyCode == 68 || event.keyCode == 39) {
					map.seed++;
				}
			case _:
		}
	}
}
