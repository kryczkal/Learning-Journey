#include <iomanip>
#include <fstream>
#include <algorithm>
using namespace std;
#include "dict.h"
#include "word.h"
#include "criteria.h"


//------------------------------------------------------
dictionary::dictionary(initializer_list<word> init)
{
	S.insert(init);

}
//------------------------------------------------------
bool  dictionary::words_from_file(string file_name)
{
	ifstream in;
	word s;
	in.open(file_name);
	if (!in.good())
	{
		cout << "blad odczytu pliku\n";
		return false;
	}
	while (!in.eof())
	{
		in >> s;
		S.insert(s);
	}

	return true;
}
//------------------------------------------------------
void dictionary::sort(Cmp::sort how)
{
	S = set<word, Cmp>(how);
}

//------------------------------------------------------
void dictionary::insert()
{
	word s;
	cin >> s;
	S.insert(s);

}
//------------------------------------------------------
bool dictionary::find_word(word s) const
{
	auto it = S.find(s);
	return it != S.end();
}
//------------------------------------------------------
void dictionary::test() const
{
	int los = rand() % S.size();
	auto it = S.begin();
	advance(it, los);
	cout << "Wylosowano: " << los + 1 << ". Czesc polska: " << it->pol << '\n';
	cout << "Podaj word po eng: ";
	string eng;
	cin >> eng;
	if (find_word(word(eng, it->pol)))
	{
		cout << "Odpowiedz poprawna!\n";
	}
	else
	{
		cout << "Bledna odpowiedz\n";
	}

}
//------------------------------------------------------
bool dictionary::save_words() const
{


	return true;
}
//------------------------------------------------------
ostream& operator<<(ostream& out, const dictionary& S)
{
	for_each(S.S.begin(), S.S.end(), [&out, nr=1](const word& s) mutable -> bool {
		if (&out == &cout)
		{
			cout << nr << " ";
			nr++;
		}
		out << s;
		return true;
		});
	

	return out;
}
//------------------------------------------------------