#pragma once
#include "word.h"


//functor - specifies the sorting criterion in the dictionary
class Cmp {

public:
	enum class sort { ANG_POL, POL_ANG }; //two sorting criteria

private:
	sort criterion;

public:
	Cmp(Cmp::sort criterion=Cmp::sort::ANG_POL): criterion{ criterion } {}
	Cmp::sort getCriterion() const { return criterion; }

	bool operator()(const word& s1, const word& s2) const
	{
		if (criterion == Cmp::sort::POL_ANG)
		{
			if (s1.pol < s2.pol)  return true;
			if (s1.pol == s2.pol && s1.eng < s2.eng) return true;
			return false;
		}
		else
		{
			if (s1.eng < s2.eng)  return true;
			if (s1.eng == s2.eng && s1.pol < s2.pol) return true;
			return false;
		}
	}
};






