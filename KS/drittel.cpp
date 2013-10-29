/*** start: KS-leq.c */
// lexicographic order for pairs
inline bool leq(int a1, int a2,   int b1, int b2) {
    return(a1 < b1 || a1 == b1 && a2 <= b2);
}
// and triples
inline bool leq(int a1, int a2, int a3,   int b1, int b2, int b3) {
    return(a1 < b1 || a1 == b1 && leq(a2,a3, b2,b3));
}
/*** end: KS-leq.c */

/*** start: KS-radix-sort.c */
// stably sort a[0..n-1] to b[0..n-1] with keys in 0..K from r
static void radixPass(int* a, int* b, int* r, int n, int K)
{ // count occurrences
    int* c = new int[K + 1];                          // counter array
    for (int i = 0;  i <= K;  i++) c[i] = 0;         // reset counters
    for (int i = 0;  i < n;  i++) c[r[a[i]]]++;    // count occurences
    for (int i = 0, sum = 0;  i <= K;  i++) { // exclusive prefix sums
        int t = c[i];  c[i] = sum;  sum += t;
    }
    for (int i = 0;  i < n;  i++) b[c[r[a[i]]]++] = a[i];      // sort
    delete c;
}
/*** end: KS-radix-sort.c */

/*** start: KS-define.c */
#define GetI() (SA12[t] < n0 ? SA12[t]*3+1 : (SA12[t] - n0)*3+2)
/*** end: KS-define.c */


/*** start: KS1.c */
// find the suffix array SA of s[0..n-1] in {1..K}^n
// require s[n]=s[n+1]=s[n+2]=0, n>=2
void suffixArray(int* s, int* SA, int n, int K) {
    int n0=(n+2)/3, n1=(n+1)/3, n2=n/3, n02=n0+n2;
    int* s12  = new int[n02 + 3];
    s12[n02]= s12[n02+1]= s12[n02+2]=0;
    int* SA12 = new int[n02 + 3];
    SA12[n02]=SA12[n02+1]=SA12[n02+2]=0;
    int* s0   = new int[n0];
    int* SA0  = new int[n0];
/*** end: KS1.c */
/*** start: KS2.c */
    // generate positions of mod 1 and mod  2 suffixes
    // the "+(n0-n1)" adds a dummy mod 1 suffix if n%3 == 1
    for (int i=0, j=0;  i < n+(n0-n1);  i++)
        if (i%3 != 0) s12[j++] = i;

    // least significant bit radix sort the mod 1 and mod 2 triples
    radixPass(s12 , SA12, s+2, n02, K);
    radixPass(SA12, s12 , s+1, n02, K);
    radixPass(s12 , SA12, s  , n02, K);
/*** end: KS2.c */
/*** start: KS3.c */
    // find lexicographic names of triples
    int name = 0, c0 = -1, c1 = -1, c2 = -1;
    for (int i = 0;  i < n02;  i++) {
        if (s[SA12[i]]!=c0 || s[SA12[i]+1]!=c1 || s[SA12[i]+2]!=c2) {
            name++;
            c0 = s[SA12[i]]; c1 = s[SA12[i]+1]; c2 = s[SA12[i]+2];
        }
        if (SA12[i] % 3 == 1)
            s12[SA12[i]/3]      = name;  // left half
        else
            s12[SA12[i]/3 + n0] = name;  // right half
    }
/*** end: KS3.c */
/*** start: KS4.c */
    // recurse if names are not yet unique
    if (name < n02) {
        suffixArray(s12, SA12, n02, name);
        // store unique names in s12 using the suffix array
        for (int i = 0;  i < n02;  i++) s12[SA12[i]] = i + 1;
    } else // generate the suffix array of s12 directly
        for (int i = 0;  i < n02;  i++) SA12[s12[i] - 1] = i;
/*** end: KS4.c */
/*** start: KS5.c */
//stably sort the mod 0 suffixes from SA12 by their first character
    for (int i=0, j=0;  i < n02;  i++)
        if (SA12[i] < n0)
            s0[j++] = 3*SA12[i];
    radixPass(s0, SA0, s, n0, K);
/*** end: KS5.c */
/*** start: KS6.c */
    // merge sorted SA0 suffixes and sorted SA12 suffixes
    for (int p=0,  t=n0-n1,  k=0;  k < n;  k++) {
        int i = GetI(); // pos of current offset 12 suffix
        int j = SA0[p]; // pos of current offset 0  suffix
/*** end: KS6.c */
/*** start: KS7.c */
        if (SA12[t] < n0 ?
            leq(s[i],       s12[SA12[t] + n0],
                s[j],       s12[j/3]         ) :
            leq(s[i],s[i+1],s12[SA12[t]-n0+1],
                s[j],s[j+1],s12[j/3+n0])     )
/*** end: KS7.c */
/*** start: KS8.c */
        { // suffix from SA12 is smaller
            SA[k] = i;  t++;
            if (t == n02) // done --- only SA0 suffixes left
                for (k++;  p < n0;  p++, k++) SA[k] = SA0[p];
        } else {
            SA[k] = j;  p++;
            if (p == n0)  // done --- only SA12 suffixes left
                for (k++;  t < n02;  t++, k++) SA[k] = GetI();
        }
/*** end: KS8.c */
    }
    delete [] s12; delete [] SA12; delete [] SA0; delete [] s0;
}
