
#include <iomanip>
using namespace std;
#include "word.h"

//----------------------------------------------------
word::word(string eng, string pol):pol(pol),eng(eng) { }

//---------------------------------------------------
bool operator==(const word& s1, const word& s2)
{
	return  (s1.pol==s2.pol && s1.eng==s2.eng );
}
//---------------------------------------------------
ostream& operator<<(ostream& out, const word& s)
{
	out<<setw(30)<<left<<s.eng;
	out<<setw(30)<<left<<s.pol;
	return out<<endl;
}
//---------------------------------------------------
istream& operator>>(istream& in,  word& s)
{
	// print prompt only when reading from the keyboard
	if(&in==&cin)
		cout << "Enter the ENGLISH word: ";
		
	in>>s.eng;

	// print prompt only when reading from the keyboard
	if (&in == &cin)
		cout << "Enter the POLISH word: ";

	in>>s.pol;

	return in;
}
//---------------------------------------------------
