#include <stdio.h>
#include <math.h>
#include <complex.h>

#define PI 3.14159265358979323846

/* Calculates the log2 of number */
int logint(int N) {
    int k = N, i = 0;
    while (k) {
        k >>= 1;
        i++;
    }
    return i - 1;
}

/* Bitwise reverses the number */
int reverse(int N, int n) {
    int j, p = 0;
    for (j = 1; j <= logint(N); j++) {
        if (n & (1 << (logint(N) - j))) {
            p |= 1 << (j - 1);
        }
    }
    return p;
}

/* Performs the FFT */
void fft(complex double *a, int N) {
    // Bit-reversal permutation
    for (int i = 0; i < N; i++) {
        int rev = reverse(N, i);
        if (i < rev) {
            complex double temp = a[i];
            a[i] = a[rev];
            a[rev] = temp;
        }
    }

    // FFT computation
    for (int s = 1; s <= logint(N); s++) {
        int m = 1 << s; // 2^s
        complex double wm = cexp(-2.0 * PI * I / m);
        for (int k = 0; k < N; k += m) {
            complex double w = 1.0;
            for (int j = 0; j < m / 2; j++) {
                complex double t = w * a[k + j + m / 2];
                complex double u = a[k + j];
                a[k + j] = u + t;
                a[k + j + m / 2] = u - t;
                w *= wm;
            }
        }
    }
}

int main() {
    int N = 8; // Length of input (must be a power of 2)
    complex double a[] = {1, 1, 1, 1, 0, 0, 0, 0}; // Example input

    printf("Input:\n");
    for (int i = 0; i < N; i++) {
        printf("%lf + %lfi\n", creal(a[i]), cimag(a[i]));
    }

    fft(a, N);

    printf("\nOutput:\n");
    for (int i = 0; i < N; i++) {
        printf("%lf + %lfi\n", creal(a[i]), cimag(a[i]));
    }

    return 0;
}
