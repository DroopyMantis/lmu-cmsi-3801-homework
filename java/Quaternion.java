import java.util.ArrayList;
import java.util.List;

public class Quaternion {
    public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public static final Quaternion I = new Quaternion(0, 1, 0, 0);
    public static final Quaternion J = new Quaternion(0, 0, 1, 0);
    public static final Quaternion K = new Quaternion(0, 0, 0, 1);

    private double a;
    private double b;
    private double c;
    private double d;

    // Constructor
    public Quaternion(double a, double b, double c, double d) {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
    }

    // Accessors
    public double a() {
        return a;
    }

    public double b() {
        return b;
    }

    public double c() {
        return c;
    }

    public double d() {
        return d;
    }

    // Coefficients as List
    public List<Double> coefficients() {
        List<Double> coeffs = new ArrayList<>();
        coeffs.add(a);
        coeffs.add(b);
        coeffs.add(c);
        coeffs.add(d);
        return coeffs;
    }

    // Addition
    public Quaternion plus(Quaternion other) {
        return new Quaternion(
                this.a + other.a,
                this.b + other.b,
                this.c + other.c,
                this.d + other.d
        );
    }

    // Multiplication
    public Quaternion times(Quaternion other) {
        return new Quaternion(
                this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
                this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
                this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
                this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
        );
    }

    // Conjugate
    public Quaternion conjugate() {
        return new Quaternion(this.a, -this.b, -this.c, -this.d);
    }

    // String representation
    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();

        if (a != 0) str.append(a);

        if (b != 0) {
            if (b > 0 && !str.isEmpty()) str.append("+");
            if (b == -1) {
                str.append("-i");
            } else if (b == 1) {
                str.append("i");
            } else {
                str.append(b).append("i");
            }
        }

        if (c != 0) {
            if (c > 0 && !str.isEmpty()) str.append("+");
            if (c == -1) {
                str.append("-j");
            } else if (c == 1) {
                str.append("j");
            } else {
                str.append(c).append("j");
            }
        }

        if (d != 0) {
            if (d > 0 && !str.isEmpty()) str.append("+");
            if (d == -1) {
                str.append("-k");
            } else if (d == 1) {
                str.append("k");
            } else {
                str.append(d).append("k");
            }
        }

        if (str.isEmpty()) str.append("0");
        return str.toString();
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Quaternion other = (Quaternion) obj;
        return Double.compare(other.a, a) == 0 &&
                Double.compare(other.b, b) == 0 &&
                Double.compare(other.c, c) == 0 &&
                Double.compare(other.d, d) == 0;
    }

    @Override
    public int hashCode() {
        int result = Double.hashCode(a);
        result = 31 * result + Double.hashCode(b);
        result = 31 * result + Double.hashCode(c);
        result = 31 * result + Double.hashCode(d);
        return result;
    }
}
