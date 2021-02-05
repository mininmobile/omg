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
	public var minRadius     (default, set) = 0.0;
	public var maxRadius     (default, set) = 1.0;
	public var detail        (default, set) = 50.0;
	public var noiseScale    (default, set) = 3.0;
	public var perlinGain    (default, set) = 0.5;
	public var perlinDivisor (default, set) = 1.0;
	public var fractalOctaves(default, set) = 4;
	public var fractalScale  (default, set) = 0.3;
	// shader settings setters
	function set_seed(_nv)           return seed           = shader.seed           = _nv;
	function set_minRadius(_nv)      return minRadius      = shader.minRadius      = _nv;
	function set_maxRadius(_nv)      return maxRadius      = shader.maxRadius      = _nv;
	function set_detail(_nv)         return detail         = shader.detail         = _nv;
	function set_noiseScale(_nv)     return noiseScale     = shader.noiseScale     = _nv;
	function set_perlinGain(_nv)     return perlinGain     = shader.perlinGain     = _nv;
	function set_perlinDivisor(_nv)  return perlinDivisor  = shader.perlinDivisor  = _nv;
	function set_fractalOctaves(_nv) return fractalOctaves = shader.fractalOctaves = _nv;
	function set_fractalScale(_nv)   return fractalScale   = shader.fractalScale   = _nv;

	public function new(width : Int = 500, height : Int = 500) {
		this.width = width;
		this.height = height;
		// prepare map texture and bitmapData for export
		exportTexture = new h3d.mat.Texture(width, height, [ Target ]);
		// prepare output view
		bitmap = new h2d.Bitmap();
		bitmap.width = width;
		bitmap.height = height;
		// create shader
		shader = new MapShader();
		shader.seed           = seed;
		shader.minRadius      = minRadius;
		shader.maxRadius      = maxRadius;
		shader.detail         = detail;
		shader.noiseScale     = noiseScale;
		shader.perlinGain     = perlinGain;
		shader.perlinDivisor  = perlinDivisor;
		shader.fractalOctaves = fractalOctaves;
		shader.fractalScale   = fractalScale;
		// assign genshader to it
		bitmap.addShader(shader);
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
