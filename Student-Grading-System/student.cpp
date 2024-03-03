

#include <iomanip>
#include <algorithm>
#include <numeric>
using namespace std;
#include "student.h"

student::student(const std::string &name, const std::string &surname, const std::list<int> &p): name(name), surname(surname)
{
	points.assign(p.begin(), p.end());
}

std::ostream& operator<<(std::ostream& out, const student& st)
{
	out << st.surname << "\t" << st.name << "\t, mark: ";
	switch (st.mark)
	{
	case student::marks::TWO:
		out << "2";
		break;
	case student::marks::THREE:
		out << "3";
		break;
	case student::marks::FOUR:
		out << "4";
		break;
	case student::marks::FIVE:
		out << "5";
		break;
	}
	out << ":";
	for_each(st.points.begin(), st.points.end(), [&out](const int n) {out << ' ' << n; });
	return out;
}

int student::sum_of_points() const
{
	return accumulate(points.begin(), points.end(), 0);
}

void student::add_to_histogram(std::map<int, int>& m) const
{
	for_each(points.begin(), points.end(), [&m](int n) {
		if (m.find(n) != m.end())
			m.insert(make_pair(n, 0));
		m[n]++;
	});
}

