using System;

namespace Quickmaths {

public struct vec2 : IFormattable {

    public static readonly vec2 X = vec2(1,0);
    public static readonly vec2 Y = vec2(0,1);

	public float x;
	public float y;

	//////////////////////////////////////////////////////////////////////////
	// Constructors	 
	////////////////////////////////////////////////////////////////////////// 

	public this(float x, float y) {
		this.x = x;	  
		this.y = y;
	}

	public this(float x) {
		this.x = x;	  
		this.y = x; 
	}

	//////////////////////////////////////////////////////////////////////////
	// Methods	 
	//////////////////////////////////////////////////////////////////////////

    public float dot(vec2 vec) {
        return this.x*vec.x + this.y+vec.y;
    }

    public float cross(vec2 vec) {
		return this.x*vec.y + this.y*vec.x;
    }


	public float magnitude() {
		return Math.Sqrt(magnitude2());
	}

	public float magnitude2() {
		return x*x + y*y;
	}

	public vec2 normal() {
        float mag = magnitude();

        if (mag == 0)
            return this;

		return this / magnitude();
	}

    public vec2 trim(float length) {
        return this.normal() * length;
    }

    public vec2 clampLength(float min, float max) {
		return this.normal() * Math.Clamp(this.magnitude(), min, max);
    }


    public vec2 abs() {
		return vec2(
		   Math.Abs(this.x),
		   Math.Abs(this.y) );
    }

    public vec2 floor() {
		return vec2(
		   Math.Floor(this.x),
		   Math.Floor(this.y) );
    }

    public vec2 ceil() {
		return vec2(
		   Math.Ceiling(this.x),
		   Math.Ceiling(this.y) );
    }

    public vec2 clamp(vec2 min, vec2 max) {
		return vec2(
		   Math.Clamp(this.x, min.x, max.x),
		   Math.Clamp(this.y, min.y, max.y) );
    }

	//////////////////////////////////////////////////////////////////////////
	// Overrides	 
	//////////////////////////////////////////////////////////////////////////

	public void ToString(String outString, String format, IFormatProvider formatProvider) {
		outString.Append("(");
		x.ToString(outString, format, formatProvider);
		outString.Append(",");	
		y.ToString(outString, format, formatProvider);
		outString.Append(")");
	}

	//////////////////////////////////////////////////////////////////////////
	// Casting	 
	//////////////////////////////////////////////////////////////////////////

    public static explicit operator vec2(float[2] v) {
        return vec2( v[0], v[1] );
    }

    public static explicit operator float[2](vec2 v) {
        return float[2]( v.x, v.y );
    }

	//////////////////////////////////////////////////////////////////////////
	// Operators	 
	//////////////////////////////////////////////////////////////////////////

	public static bool operator==(vec2 a, vec2 b) {
		return a.x == b.x
			&& a.y == b.y;
	}

	public static bool operator!=(vec2 a, vec2 b) {
		return a.x != b.x
			|| a.y != b.y;
	}

	public static vec2 operator+(vec2 a, vec2 b) {
		return vec2(
			a.x + b.x,	
			a.y + b.y );
	}

	public static vec2 operator-(vec2 a, vec2 b) {
		return vec2(
			a.x - b.x,	
			a.y - b.y );
	}

	public static vec2 operator-(vec2 a) {
		return vec2(
			-a.x,	
			-a.y );
	}	

	public static vec2 operator*(vec2 a, vec2 b) {
		return vec2(
			a.x * b.x,	
			a.y * b.y );
	}  	

	public static vec2 operator*(float a, vec2 b) {
		return vec2(
			a * b.x,	
			a * b.y );
	}  	

	public static vec2 operator*(vec2 a, float b) {
		return vec2(
			a.x * b,	
			a.y * b );
	}   

	public static vec2 operator/(vec2 a, vec2 b) {
		return vec2(
			a.x / b.x,	
			a.y / b.y );
	} 	  

	public static vec2 operator/(float a, vec2 b) {
		return vec2(
			a / b.x,	
			a / b.y );
	}  

	public static vec2 operator/(vec2 a, float b) {
		return vec2(
			a.x / b,	
			a.y / b );
	} 		 

	public static vec2 operator%(vec2 a, vec2 b) {
		return vec2(
			a.x % b.x,	
			a.y % b.y );
	}

}
}

