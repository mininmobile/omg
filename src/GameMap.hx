class GameMap {
	public var width : Int;
	public var height : Int;
	var image : hxd.BitmapData;
	var texture : h3d.mat.Texture;
	public var tile : h2d.Tile;

	public function new(width : Int = 500, height : Int = 500) {
		this.width = width;
		this.height = height;
		// prepare map tile for drawing in ui
		texture = new h3d.mat.Texture(width, height);
		image = new hxd.BitmapData(width, height);
		tile = h2d.Tile.fromTexture(texture);

		image.clear(0xFFFFFFFF);
		texture.uploadBitmap(image);

		image.fill(100, 100, 200, 200, 0xFFFF0000);
		texture.uploadBitmap(image);
	}
}
