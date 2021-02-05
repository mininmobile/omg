import haxe.io.Bytes;
import h3d.mat.Texture;

class GameMap {
	public var width(default, null): Int;
	public var height(default, null): Int;
	public var bitmap : h2d.Bitmap;
	var shader : MapShader;
	var exportTexture : h3d.mat.Texture;
	public var exportOut : Bytes;
	// shader settings
	public var seed          (default, set) = 1;
	public var minRadius     (default, set) = 0.;
	public var maxRadius     (default, set) = 1.;
	public var detail        (default, set) = 50.;
	public var heightNScale  (default, set) = 10.;
	public var heightFScale  (default, set) = 0.5;
	public var heightOctaves (default, set) = 16;
	public var coastNScale   (default, set) = 3.;
	public var coastFScale   (default, set) = 0.3;
	public var coastOctaves  (default, set) = 4;
	public var perlinGain    (default, set) = 0.5;
	public var perlinDivisor (default, set) = 1.;
	// shader settings setters
	function set_seed(_nv)          return seed          = shader.seed          = _nv;
	function set_minRadius(_nv)     return minRadius     = shader.minRadius     = _nv;
	function set_maxRadius(_nv)     return maxRadius     = shader.maxRadius     = _nv;
	function set_detail(_nv)        return detail        = shader.detail        = _nv;
	function set_heightNScale(_nv)  return heightNScale  = shader.heightNScale  = _nv;
	function set_heightFScale(_nv)  return heightFScale  = shader.heightFScale  = _nv;
	function set_heightOctaves(_nv) return heightOctaves = shader.heightOctaves = _nv;
	function set_coastNScale(_nv)   return coastNScale   = shader.coastNScale   = _nv;
	function set_coastFScale(_nv)   return coastFScale   = shader.coastFScale   = _nv;
	function set_coastOctaves(_nv)  return coastOctaves  = shader.coastOctaves  = _nv;
	function set_perlinGain(_nv)    return perlinGain    = shader.perlinGain    = _nv;
	function set_perlinDivisor(_nv) return perlinDivisor = shader.perlinDivisor = _nv;

	public function new(width : Int = 500, height : Int = 500) {
		this.width = width;
		this.height = height;
		// prepare map texture and bitmapData for export
		exportTexture = new h3d.mat.Texture(width, height, [ Target ]);
		// prepare output view
		bitmap = new h2d.Bitmap();
		bitmap.width = width;
		bitmap.height = height;
		// create shader and assign to output view
		shader = new MapShader();
		update();
		bitmap.addShader(shader);
	}

	public function update() : Void {
		shader.seed          = seed;
		shader.minRadius     = minRadius;
		shader.maxRadius     = maxRadius;
		shader.detail        = detail;
		shader.heightNScale  = heightNScale;
		shader.heightFScale  = heightFScale;
		shader.heightOctaves = heightOctaves;
		shader.coastNScale   = coastNScale;
		shader.coastFScale   = coastFScale;
		shader.coastOctaves  = coastOctaves;
		shader.perlinGain    = perlinGain;
		shader.perlinDivisor = perlinDivisor;
	}

	/**
	 * export the map, returns mapdata
	 * @return Bytes
	 */
	public function export() : Bytes {
		// draw output of shader to image
		bitmap.drawTo(exportTexture);
		// return mapdata
		exportOut = exportTexture.capturePixels().toPNG();
		return exportOut;
	}
}
