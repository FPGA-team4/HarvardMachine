#include <iostream>
#include <cstdlib>
using namespace std;
#define rep(i,n) for(int i=0;i<n;++i)
//OPECODE [MSB]abcde[LSB]
int main()
{
    rep(a,2)
        rep(b,2)
            rep(c,2)
                rep(d,2)
                    rep(e,2)
                    {
                        if (a&b)
                            continue;
                        cout <<a<<b<<c<<d<<e<<endl;
                        if (!a & !b & !c & !d & e)
                            cout << 1;
                        else
                            cout << 0;
                        if ((!a & !b & !c & d & e) | (~a & b &c))
                            cout << 1;
                        else
                            cout << 0;
                        if ((a & !b) | (!b & !c & d)){
                            cout << 1<< endl <<endl;
                        } else {
                            cout << 0 << endl <<endl;
                        }
                    }
}