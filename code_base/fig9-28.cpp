// C++ program to provide I/O for quadratic equation solver
// author: R. Detmer
// date: 7/2013

#include <iostream>
using namespace std;

extern "C" void roots(float a, float b, float c, float& x1, float& x2);
// find roots of quadratic equation

int main()
{
    float a, b, c;
    float root1, root2;

    cout << "please enter coefficients: ";
    cin >> a >> b >> c; 
    roots(a, b, c, root1, root2);
    cout << "\nroot 1 " << root1 << "\nroot 2 " << root2 << endl;

    return 0;
}