#include <vector>
#include <set>
#include <algorithm>

#include "utilities.hpp"

bool StringCaseInsensitiveComparer::operator() (const std::string& lhs, const std::string& rhs) const
{
	return std::lexicographical_compare(lhs.begin(), lhs.end(), rhs.begin(), rhs.end(),
		[](char lhs, char rhs)
		{
			return std::tolower(lhs) < std::tolower(rhs);
		}
	);
}

set<string, StringCaseInsensitiveComparer> ToSet(vector<string> v)
{
	set<string, StringCaseInsensitiveComparer> s;
	for_each(v.begin(), v.end(), [&s](string &x) {
		s.insert(x);
	});
	return s;
}