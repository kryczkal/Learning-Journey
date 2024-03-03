#pragma once

#include <set>
#include <vector>
#include <string>

using namespace std;

struct StringCaseInsensitiveComparer
{
	bool operator() (const std::string& lhs, const std::string& rhs) const;
};

set<string, StringCaseInsensitiveComparer> ToSet(vector<string> v);