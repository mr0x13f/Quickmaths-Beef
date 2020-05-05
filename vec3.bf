using System;

namespace Quickmaths {

public struct vec3 : IFormattable {

    public static readonly vec3 X = vec3(1,0,0);
    public static readonly vec3 Y = vec3(0,1,0);
    public static readonly vec3 Z = vec3(0,0,1);

	public float x;
	public float y;
	public float z;

	public float r {
		get { return x; }
		set mut { x = value; }}

	public float g {
		get { return y; }
		set mut { y = value; }}

	public float b {
		get { return z; }
		set mut { z = value; }}

	//////////////////////////////////////////////////////////////////////////
	// Constructors	 
	////////////////////////////////////////////////////////////////////////// 

	public this(float x, float y, float z) {
		this.x = x;	  
		this.y = y;
		this.z = z;	
	}

	public this(float x) {
		this.x = x;	  
		this.y = x;
		this.z = x;	 
	}

    public this(vec2 xy, float z) {
		this.x = xy.x;	  
		this.y = xy.y;
        this.z = z;
	}

    public this(float x, vec2 yz) {
		this.x = x;	
        this.y = yz.x;
        this.z = yz.y;
	}

	//////////////////////////////////////////////////////////////////////////
	// Methods	 
	//////////////////////////////////////////////////////////////////////////

    public float dot(vec3 vec) {
        return this.x*vec.x + this.y+vec.y + this.z*vec.z;
    }

    public vec3 cross(vec3 vec) {
		return vec3(
		    this.y*vec.z + this.z*vec.y,
		    this.z*vec.x + this.x*vec.z,
		    this.x*vec.y + this.y*vec.x );
    }


	public float magnitude() {
		return Math.Sqrt(magnitude2());
	}

	public float magnitude2() {
		return x*x + y*y + z*z;
	}

	public vec3 normal() {
        float mag = magnitude();

        if (mag == 0)
            return this;

		return this / magnitude();
	}

    public vec3 trim(float length) {
        return this.normal() * length;
    }

    public vec3 clampLength(float min, float max) {
		return this.normal() * Math.Clamp(this.magnitude(), min, max);
    }


    public vec3 abs() {
		return vec3(
		   Math.Abs(this.x),
		   Math.Abs(this.y),
		   Math.Abs(this.z) );
    }

    public vec3 floor() {
		return vec3(
		   Math.Floor(this.x),
		   Math.Floor(this.y),
		   Math.Floor(this.z) );
    }

    public vec3 ceil() {
		return vec3(
		   Math.Ceiling(this.x),
		   Math.Ceiling(this.y),
		   Math.Ceiling(this.z) );
    }

    public vec3 clamp(vec3 min, vec3 max) {
		return vec3(
		   Math.Clamp(this.x, min.x, max.x),
		   Math.Clamp(this.y, min.y, max.y),
		   Math.Clamp(this.z, min.z, max.z) );
    }

	/*
    public static vec3 fromHex(string hex) {
        if (hex[0] == '#')
            hex = hex.Substring(1);

        try {
        
            if (hex.Length == 6)
                return vec3(
                    int.Parse(hex.Substring(0,2), System.Globalization.NumberStyles.HexNumber) / 255f,
                    int.Parse(hex.Substring(2,2), System.Globalization.NumberStyles.HexNumber) / 255f,
                    int.Parse(hex.Substring(4,2), System.Globalization.NumberStyles.HexNumber) / 255f );
            else
                return vec3(0,0,0);

        } catch(System.FormatException) {
            return vec3(0,0,0);
        }
    }

    public string toHex() {
        return ((int) Math.min(this.x * 255, 255)).ToString("X") + 
               ((int) Math.min(this.y * 255, 255)).ToString("X") + 
               ((int) Math.min(this.z * 255, 255)).ToString("X");
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
		outString.Append(")");
	}

	//////////////////////////////////////////////////////////////////////////
	// Casting	 
	//////////////////////////////////////////////////////////////////////////

	public static explicit operator vec3(float[3] v) {
	    return vec3( v[0], v[1], v[2] );
	}

	public static explicit operator float[3](vec3 v) {
	    return float[3]( v.x, v.y, v.z);
	}

	//////////////////////////////////////////////////////////////////////////
	// Operators	 
	//////////////////////////////////////////////////////////////////////////

	public static bool operator==(vec3 a, vec3 b) {
		return a.x == b.x
			&& a.y == b.y
			&& a.z == b.z;
	}

	public static bool operator!=(vec3 a, vec3 b) {
		return a.x != b.x
			|| a.y != b.y
			|| a.z != b.z;
	}

	public static vec3 operator+(vec3 a, vec3 b) {
		return vec3(
			a.x + b.x,	
			a.y + b.y,
			a.z + b.z );
	}

	public static vec3 operator-(vec3 a, vec3 b) {
		return vec3(
			a.x - b.x,	
			a.y - b.y,
			a.z - b.z );
	}

	public static vec3 operator-(vec3 a) {
		return vec3(
			-a.x,	
			-a.y,
			-a.z );
	}	

	public static vec3 operator*(vec3 a, vec3 b) {
		return vec3(
			a.x * b.x,	
			a.y * b.y,
			a.z * b.z );
	}  	

	public static vec3 operator*(float a, vec3 b) {
		return vec3(
			a * b.x,	
			a * b.y,
			a * b.z );
	}  	

	public static vec3 operator*(vec3 a, float b) {
		return vec3(
			a.x * b,	
			a.y * b,
			a.z * b );
	}  

	public static vec3 operator/(vec3 a, vec3 b) {
		return vec3(
			a.x / b.x,	
			a.y / b.y,
			a.z / b.z );
	} 	  

	public static vec3 operator/(float a, vec3 b) {
		return vec3(
			a / b.x,	
			a / b.y,
			a / b.z );
	}  

	public static vec3 operator/(vec3 a, float b) {
		return vec3(
			a.x / b,	
			a.y / b,
			a.z / b );
	} 		 

	public static vec3 operator%(vec3 a, vec3 b) {
		return vec3(
			a.x % b.x,	
			a.y % b.y,
			a.z % b.z );
	} 	

}
}
