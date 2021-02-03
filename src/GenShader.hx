class GenShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;

		@param var PI : Float = 3.1415926535;

		// map settings
		@param var seed : Int = 0;
		@param var minRadius : Float = .2;
		@param var maxRadius : Float = .8;
		@param var detail : Float = 50;
		// perlin noise settings
		@param var noiseScale : Float = 3;
		@param var perlinGain : Float = 0.5;
		@param var perlinDivisor : Float = 1;
		// fractal noise settings
		@param var fractalOctaves : Int = 3;
		@param var fractalScale : Float = 0.5;

		function rand(coord : Vec2) : Float {
			return fract(sin(dot(coord.xy, vec2(12.9898, 78.233)) + seed - 1) * 43758.5453);
		}

		function perlinNoise(coord : Vec2) : Float {
			var i = floor(coord);
			var f = fract(coord);

			var tl = rand(i) * PI * 2;
			var tr = rand(i + vec2(1, 0)) * PI * 2;
			var bl = rand(i + vec2(0, 1)) * PI * 2;
			var br = rand(i + vec2(1, 1)) * PI * 2;
			// vectors
			var tlv = vec2(-sin(tl), cos(tl));
			var trv = vec2(-sin(tr), cos(tr));
			var blv = vec2(-sin(bl), cos(bl));
			var brv = vec2(-sin(br), cos(br));
			// dot products
			var tld = dot(tlv, f);
			var trd = dot(trv, f - vec2(1, 0));
			var bld = dot(blv, f - vec2(0, 1));
			var brd = dot(brv, f - vec2(1, 1));

			var cubic = f * f * (3 - 2 * f);

			var topmix = mix(tld, trd, cubic.x);
			var botmix = mix(bld, brd, cubic.x);
			var wholemix = mix(topmix, botmix, cubic.y);

			return (wholemix + perlinGain) / perlinDivisor;
		}

		function fractalNoise(coord : Vec2, octaves : Int) : Float {
			var normalizeFactor = 0.0;
			var value = 0.0;
			var scale = fractalScale;

			for (i in 0...octaves) {
				value += perlinNoise(coord) * scale;
				normalizeFactor += scale;
				coord *= 2;
				scale *= fractalScale;
			}

			return value / normalizeFactor;
		}

		function poly(position : Vec2, minRadius : Float, maxRadius : Float, sides : Float) : Float {
			position = position * 2 - 1;
			var angle = atan(position.x, position.y);
			var slice = PI * 2 / sides;
			var r = fractalNoise(position * noiseScale, fractalOctaves) * (maxRadius - minRadius) + minRadius;

			return step(r, cos(floor(0.5 + angle / slice) * slice - angle) * length(position));
		}

		function fragment() {
			var blob = poly(calculatedUV, minRadius, maxRadius, detail);
			output.color = vec4(vec3(blob), 1);
		}
	}
}
