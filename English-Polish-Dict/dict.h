#pragma once

#include <set>
#include "dict.h"
#include "criteria.h"

using std::set;


class dictionary
{
	set<word,Cmp> S;

public:
	dictionary() = default;
	dictionary(initializer_list<word> init);

	bool words_from_file(string nazwa_pliku);

	void sort(Cmp::sort jak);

	void insert();

	bool find_word(word s) const;
	void test() const;

	bool save_words() const;
	
	friend ostream& operator<<(ostream& out, const dictionary& S);


};

