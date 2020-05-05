using System;

namespace Quickmaths {

public struct mat3 {

    public static readonly mat3 IDENTITY = mat3(
        1, 0, 0,
        0, 1, 0,
        0, 0, 1 );

    public float m11, m12, m13,
                 m21, m22, m23,
                 m31, m32, m33;

	//////////////////////////////////////////////////////////////////////////
	// Constructors	 
	////////////////////////////////////////////////////////////////////////// 

    public this(float m11, float m12, float m13,
                float m21, float m22, float m23,
                float m31, float m32, float m33 ) {

        // Row 1
        this.m11 = m11;
        this.m12 = m12;
        this.m13 = m13;
        // Row 2
        this.m21 = m21;
        this.m22 = m22;
        this.m23 = m23;
        // Row 3
        this.m31 = m31;
        this.m32 = m32;
        this.m33 = m33;
    }

	//////////////////////////////////////////////////////////////////////////
	// Methods	 
	//////////////////////////////////////////////////////////////////////////

    public mat3 transpose() {
        return mat3(
            m11, m21, m31,
            m12, m22, m32,
            m13, m23, m33 );
    }

    public static mat3 fromScale(vec3 scale) {
        return mat3(
            scale.x, 0, 0,
            0, scale.y, 0,
            0, 0, scale.z );
    }

    public static mat3 fromRotationX(float angle) {
        float c = Math.Cos(angle);
        float s = Math.Sin(angle);

        return mat3(
            1, 0, 0,
            0, c, s,
            0,-s, c );
    }

    public static mat3 fromRotationY(float angle) {
        float c = Math.Cos(angle);
        float s = Math.Sin(angle);

        return mat3(
            c, 0,-s,
            0, 1, 0,
            s, 0, c );
    }

    public static mat3 fromRotationZ(float angle) {
        float c = Math.Cos(angle);
        float s = Math.Sin(angle);

        return mat3(
            c, s, 0,
           -s, c, 0,
            0, 0, 1 );
    }

    public static mat3 fromRotation(vec3 euler) {
        return fromRotationX(euler.x) * fromRotationY(euler.y) * fromRotationZ(euler.z);
    }

    public static mat3 fromTransform(vec3 euler, vec3 scale) {
        return fromScale(scale) * fromRotation(euler);
    }

    // https://www.mathsisfun.com/algebra/matrix-inverse-minors-cofactors-adjugate.html
    public mat3 inverse() {

        float[3][3] grid = (float[3][3]) this;

        // Step 1: Matrix of Minors
        float[3][3] minors = (float[3][3]) mat3.IDENTITY;

        for (int minorRow = 0; minorRow < 3; minorRow++ ) {
            for (int minorColumn = 0; minorColumn < 3; minorColumn++ ) {

                // Find all the components not in the current row or column
                float[] components = new float[4];
                int componentsIndex = 0;
            
                for (int detRow = 0; detRow < 3; detRow++ ) {

                    if (detRow == minorRow)
                        continue;
                    
                    for (int detColumn = 0; detColumn < 3; detColumn++ ) {

                        if (detColumn == minorColumn)
                            continue;

                        components[componentsIndex] = grid[detRow][detColumn];
                        componentsIndex++;
                    }
                }

                // Calculate the determinant of the components not in the current row or column
                float minor = ((mat2) components).determinant();
                minors[minorRow][minorColumn] = minor;
            }
		}
    
        // Step 2: Matrix of Cofactors
        // Apply a "checkerboard" of minuses to the "Matrix of Minors"
        // + - +
        // - + -
        // + - +
        float[,] cofactors = new float[3,3];

        for (int cofactorsRow = 0; cofactorsRow < 3; cofactorsRow++ ) {
            for (int cofactorsColumn = 0; cofactorsColumn < 3; cofactorsColumn++ ) {
                bool isEven = (cofactorsRow + cofactorsColumn) % 2f == 0;
                float scalar = isEven ? 1f : -1f;
                cofactors[cofactorsRow,cofactorsColumn] = minors[cofactorsRow][cofactorsColumn] * scalar;
            }
		}

        // Step 3: Adjugate 
        mat3 adjugate = ((mat3) cofactors).transpose();

        // Step 4: Multiply by 1/Determinant
        float determinant =
            grid[0][0] * minors[0][0] +
            grid[0][1] * minors[0][1] +
            grid[0][2] * minors[0][2];

        // Matrix is singular :(
        if (determinant == 0f)
            return IDENTITY;

        return adjugate * (1/determinant);

    }

    public float determinant() {
        return m11 * m22 * m33
             + m12 * m23 * m31
             + m13 * m21 * m32
         
             - m12 * m21 * m33
             - m11 * m23 * m32
             - m13 * m22 * m31;
    }

	//////////////////////////////////////////////////////////////////////////
	// Overrides	 
	//////////////////////////////////////////////////////////////////////////

	public void ToString(String outString, String format, IFormatProvider formatProvider) {
		// Row 1
		outString.Append("|");
		m11.ToString(outString, format, formatProvider);
		outString.Append(",");	
		m12.ToString(outString, format, formatProvider);
		outString.Append(","); 
		m13.ToString(outString, format, formatProvider);	
		outString.Append("|\n");
		// Row 2
		outString.Append("|");
		m21.ToString(outString, format, formatProvider);
		outString.Append(",");	
		m22.ToString(outString, format, formatProvider);
		outString.Append(","); 
		m23.ToString(outString, format, formatProvider);	
		outString.Append("|\n");
		// Row 3
		outString.Append("|");
		m31.ToString(outString, format, formatProvider);
		outString.Append(",");	
		m32.ToString(outString, format, formatProvider);
		outString.Append(","); 
		m33.ToString(outString, format, formatProvider);  
		outString.Append("|");
	}

	//////////////////////////////////////////////////////////////////////////
	// Casting	 
	//////////////////////////////////////////////////////////////////////////

    public static explicit operator mat3(float[9] m) {
        return mat3(
            m[0], m[1], m[2],
            m[3], m[4], m[5],
            m[6], m[7], m[8] );
    }

    public static explicit operator float[9](mat3 m) {
        return float[9](
            m.m11, m.m12, m.m13,
            m.m21, m.m22, m.m23,
            m.m31, m.m32, m.m33 );
    }

    public static explicit operator mat3(float[3][3] m) {
        return mat3(
            m[0][0], m[0][1], m[0][2],
            m[1][0], m[1][1], m[1][2],
            m[2][0], m[2][1], m[2][2] );
    }

    public static explicit operator float[3][3](mat3 m) {
        return float[3][3](
            float[3]( m.m11, m.m12, m.m13 ),
            float[3]( m.m21, m.m22, m.m23 ),
            float[3]( m.m31, m.m32, m.m33 ) );
    }

	//////////////////////////////////////////////////////////////////////////
	// Operators	 
	//////////////////////////////////////////////////////////////////////////

    public static bool operator==(mat3 a, mat3 b) {
		return a.m11 == b.m11 && a.m12 == b.m12 && a.m13 == b.m13
            && a.m21 == b.m21 && a.m22 == b.m22 && a.m23 == b.m23
            && a.m31 == b.m31 && a.m32 == b.m32 && a.m33 == b.m33;
	}

	public static bool operator!=(mat3 a, mat3 b) {
		return a.m11 != b.m11 || a.m12 != b.m12 || a.m13 != b.m13
            || a.m21 != b.m21 || a.m22 != b.m22 || a.m23 != b.m23
            || a.m31 != b.m31 || a.m32 != b.m32 || a.m33 != b.m33;
	}

	public static mat3 operator*(mat3 a, mat3 b) {
        return mat3(
            // Row 1
            a.m11*b.m11 + a.m12*b.m21 + a.m13*b.m31,
            a.m11*b.m12 + a.m12*b.m22 + a.m13*b.m32,
            a.m11*b.m13 + a.m12*b.m23 + a.m13*b.m33,
            // Row 2
            a.m21*b.m11 + a.m22*b.m21 + a.m23*b.m31,
            a.m21*b.m12 + a.m22*b.m22 + a.m23*b.m32,
            a.m21*b.m13 + a.m22*b.m23 + a.m23*b.m33,
            // Row 3
            a.m31*b.m11 + a.m32*b.m21 + a.m33*b.m31,
            a.m31*b.m12 + a.m32*b.m22 + a.m33*b.m32,
            a.m31*b.m13 + a.m32*b.m23 + a.m33*b.m33 );
	}

	public static mat3 operator*(mat3 a, vec3 b) {
        return mat3(
            a.m11*b.x, a.m12*b.x, a.m13*b.x,
            a.m21*b.y, a.m22*b.y, a.m23*b.y,
            a.m31*b.z, a.m32*b.z, a.m33*b.z );
	}

	public static mat3 operator*(vec3 a, mat3 b) {
	    return mat3(
	        a.x*b.m11, a.x*b.m12, a.x*b.m13,
	        a.y*b.m11, a.y*b.m12, a.y*b.m13,
	        a.z*b.m11, a.z*b.m12, a.z*b.m13 );
	}

	public static mat3 operator*(mat3 a, float b) {
        return mat3(
            a.m11*b, a.m12*b, a.m13*b,
            a.m21*b, a.m22*b, a.m23*b,
            a.m31*b, a.m32*b, a.m33*b );
	}

	public static mat3 operator*(float a, mat3 b) {
	    return mat3(
	        a*b.m11, a*b.m12, a*b.m13,
	        a*b.m11, a*b.m12, a*b.m13,
	        a*b.m11, a*b.m12, a*b.m13 );
	}

}
}