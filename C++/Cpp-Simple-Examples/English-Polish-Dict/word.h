#pragma once
#include <iostream>
#include <string>
using namespace std;

using std::string;
using std::ostream;
using std::istream;


class word
{
	string eng;	
	string pol;	

public:
	word() = default;
	word(string eng, string pol);
	    	
	friend bool operator==(const word& s1, const word& s2);

	friend ostream& operator<<(ostream& out, const word& s);
	friend istream& operator>>(istream& in, word& s);

	friend class dictionary;
	friend class Cmp;	//functor
	
};