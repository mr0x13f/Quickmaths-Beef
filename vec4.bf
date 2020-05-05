using System;

namespace Quickmaths {

public struct vec4 : IFormattable {

	public static readonly vec4 X = vec4(1,0,0,0);
	public static readonly vec4 Y = vec4(0,1,0,0);
	public static readonly vec4 Z = vec4(0,0,1,0);
	public static readonly vec4 W = vec4(0,0,0,1);

	public float x;
	public float y;
	public float z;
	public float w;

	public float r {
		get { return x; }
		set mut { x = value; }}

	public float g {
		get { return y; }
		set mut { y = value; }}

	public float b {
		get { return z; }
		set mut { z = value; }}

	public float a {
		get { return w; }
		set mut { w = value; }}

	//////////////////////////////////////////////////////////////////////////
	// Constructors	 
	////////////////////////////////////////////////////////////////////////// 

	public this(float x, float y, float z, float w) {
		this.x = x;	  
		this.y = y;
		this.z = z;	
		this.w = w;
	}

	public this(float x) {
		this.x = x;	  
		this.y = x;
		this.z = x;	 
		this.w = x;
	}

	public this(vec3 xyz, float w) {
		this.x = xyz.x;	  
		this.y = xyz.y;
		this.z = xyz.z;	
		this.w = w;
	}

	public this(float x, vec3 yzw) {
		this.x = x;	  
		this.y = yzw.x;
		this.z = yzw.y;	
		this.w = yzw.z;
	}

	public this(vec2 xy, vec2 zw) {
		this.x = xy.x;	  
		this.y = xy.y;
		this.z = zw.x;	
		this.w = zw.y;
	}

	public this(vec2 xy, float z, float w) {
		this.x = xy.x;	  
		this.y = xy.y;
		this.z = z;	
		this.w = w;
	}

	public this(float x, float y, vec2 zw) {
		this.x = x;	  
		this.y = y;
		this.z = zw.x;	
		this.w = zw.y;
	}

	public this(float x, vec2 yz, float w) {
		this.x = x;	  
		this.y = yz.x;
		this.z = yz.y;	
		this.w = w;
	}

	//////////////////////////////////////////////////////////////////////////
	// Methods	 
	//////////////////////////////////////////////////////////////////////////

	public float dot(vec4 vec) {
	    return this.x*vec.x + this.y+vec.y + this.z*vec.z + this.w*vec.w;
	}

	public vec4 cross(vec4 vec) {
		return vec4(
		    this.y*vec.z + this.z*vec.y,
		    this.z*vec.w + this.w*vec.z,
		    this.w*vec.x + this.x*vec.w,
		    this.x*vec.y + this.y*vec.x );
	}


	public float magnitude() {
		return Math.Sqrt(magnitude2());
	}

	public float magnitude2() {
		return x*x + y*y + z*z + w*w;
	}

	public vec4 normal() {
	    float mag = magnitude();

	    if (mag == 0)
	        return this;

		return this / magnitude();
	}

	public vec4 trim(float length) {
	    return this.normal() * length;
	}

	public vec4 clampLength(float min, float max) {
		return this.normal() * Math.Clamp(this.magnitude(), min, max);
	}


	public vec4 abs() {
		return vec4(
		   Math.Abs(this.x),
		   Math.Abs(this.y),
		   Math.Abs(this.z),
		   Math.Abs(this.w) );
	}

	public vec4 floor() {
		return vec4(
		   Math.Floor(this.x),
		   Math.Floor(this.y),
		   Math.Floor(this.z),
		   Math.Floor(this.w) );
	}

	public vec4 ceil() {
		return vec4(
		   Math.Ceiling(this.x),
		   Math.Ceiling(this.y),
		   Math.Ceiling(this.z),
		   Math.Ceiling(this.w) );
	}

	public vec4 clamp(vec4 min, vec4 max) {
		return vec4(
		   Math.Clamp(this.x, min.x, max.x),
		   Math.Clamp(this.y, min.y, max.y),
		   Math.Clamp(this.z, min.z, max.z),
		   Math.Clamp(this.w, min.w, max.w) );
	}

	/*
	public static vec4 fromHex(StringView hex, float a=1) {
		StringView hexStr = hex;
	    if (hexStr[0] == '#')
	        hexStr = hexStr.Substring(1);

	    try {
	        
	        if (hexStr.Length == 8)
	            return vec4(
	                int.Parse(hexStr.Substring(0,2), System.Globalization.NumberStyles.HexNumber) / 255f,
	                int.Parse(hexStr.Substring(2,2), System.Globalization.NumberStyles.HexNumber) / 255f,
	                int.Parse(hexStr.Substring(4,2), System.Globalization.NumberStyles.HexNumber) / 255f,
	                int.Parse(hexStr.Substring(6,2), System.Globalization.NumberStyles.HexNumber) / 255f );
	        else if (hex.Length == 6)
	            return vec4(
	                int.Parse(hexStr.Substring(0,2), System.Globalization.NumberStyles.HexNumber) / 255f,
	                int.Parse(hexStr.Substring(2,2), System.Globalization.NumberStyles.HexNumber) / 255f,
	                int.Parse(hexStr.Substring(4,2), System.Globalization.NumberStyles.HexNumber) / 255f,
	                a );
	        else
	            return vec4(0,0,0,a);

	    } catch(System.FormatException) {
	        return vec4(0,0,0,a);
	    }
	}

	public string toHex() {
	    return ((int) Math.min(this.x * 255, 255)).ToString("X") + 
	           ((int) Math.min(this.y * 255, 255)).ToString("X") + 
	           ((int) Math.min(this.z * 255, 255)).ToString("X") + 
	           ((int) Math.min(this.w * 255, 255)).ToString("X");
	}
	*/

	//////////////////////////////////////////////////////////////////////////
	// Overrides	 
	//////////////////////////////////////////////////////////////////////////

	public void ToString(String outString, String format, IFormatProvider formatProvider) {
		outString.Append("(");
		x.ToString(outString, format, formatProvider);
		outString.Append(",");	
		y.ToString(outString, format, formatProvider);
		outString.Append(","); 
		z.ToString(outString, format, formatProvider);	
		outString.Append(","); 
		w.ToString(outString, format, formatProvider);
		outString.Append(")");
	}

	//////////////////////////////////////////////////////////////////////////
	// Casting	 
	//////////////////////////////////////////////////////////////////////////

	public static implicit operator vec4(vec3 v) {
	    return vec4(v,0);
	}

	public static explicit operator vec4(float[4] v) {
	    return vec4( v[0], v[1], v[2], v[3] );
	}

	public static explicit operator float[4](vec4 v) {
	    return float[4]( v.x, v.y, v.z, v.w );
	}

	//////////////////////////////////////////////////////////////////////////
	// Operators	 
	//////////////////////////////////////////////////////////////////////////

	public static bool operator==(vec4 a, vec4 b) {
		return a.x == b.x
			&& a.y == b.y
			&& a.z == b.z
			&& a.w == b.w;
	}

	public static bool operator!=(vec4 a, vec4 b) {
		return a.x != b.x
			|| a.y != b.y
			|| a.z != b.z
			|| a.w != b.w;
	}

	public static vec4 operator+(vec4 a, vec4 b) {
		return vec4(
			a.x + b.x,	
			a.y + b.y,
			a.z + b.z,
			a.w + b.w );
	}

	public static vec4 operator-(vec4 a, vec4 b) {
		return vec4(
			a.x - b.x,	
			a.y - b.y,
			a.z - b.z,
			a.w - b.w );
	}

	public static vec4 operator-(vec4 a) {
		return vec4(
			-a.x,	
			-a.y,
			-a.z,
			-a.w );
	}	

	public static vec4 operator*(vec4 a, vec4 b) {
		return vec4(
			a.x * b.x,	
			a.y * b.y,
			a.z * b.z,
			a.w * b.w );
	}  	

	public static vec4 operator*(float a, vec4 b) {
		return vec4(
			a * b.x,	
			a * b.y,
			a * b.z,
			a * b.w );
	}  	

	public static vec4 operator*(vec4 a, float b) {
		return vec4(
			a.x * b,	
			a.y * b,
			a.z * b,
			a.w * b );
	}   

	public static vec4 operator/(vec4 a, vec4 b) {
		return vec4(
			a.x / b.x,	
			a.y / b.y,
			a.z / b.z,
			a.w / b.w );
	} 	  

	public static vec4 operator/(float a, vec4 b) {
		return vec4(
			a / b.x,	
			a / b.y,
			a / b.z,
			a / b.w );
	}  

	public static vec4 operator/(vec4 a, float b) {
		return vec4(
			a.x / b,	
			a.y / b,
			a.z / b,
			a.w / b );
	} 		 

	public static vec4 operator%(vec4 a, vec4 b) {
		return vec4(
			a.x % b.x,	
			a.y % b.y,
			a.z % b.z,
			a.w % b.w );
	} 
}
}
