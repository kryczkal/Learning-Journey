#include <map>
#include <iomanip>
#include <algorithm>
#include <sstream>
#include <fstream>
#include "evaluation.h"

using namespace std;

const map<int, student::marks, greater<int>> evaluation::levels{ { 57,student::marks::THREE},
											{ 70, student::marks::FOUR}, { 85, student::marks::FIVE} };

evaluation::evaluation(const string& file_name)
{
	ifstream file(file_name);
	if (!file)
		cerr << "error reading data\n";
	string line, first_name, last_name;
	int points;
	list<int> scores;
	while (getline(file, line))
	{
		istringstream row(line);
		row >> first_name >> last_name;
		while (row >> points)
			scores.push_back(points);
		students.push_back(student(first_name, last_name, scores));
		scores.clear();
	}
	file.close();
}

ostream& operator<<(ostream& out, const evaluation& e)
{
	for_each(e.students.begin(), e.students.end(), [&out](student st) { out << st << '\n'; });
	
	return out;
}

void evaluation::sort()
{
	students.sort([](const student& a, const student& b) { 
		return a.surname == b.surname ? a.name < b.name : a.surname < b.surname;
	});
}

void evaluation::set_marks() 
{
	for_each(students.begin(), students.end(), [](student &st) {
		auto iter = levels.lower_bound(st.sum_of_points());
		if(iter != levels.end())
			st.mark = iter->second;
	});
}

void evaluation::reset_points(const int& p) 
{
	for_each(students.begin(), students.end(), [&p](student &st) {
		transform(st.points.begin(), st.points.end(), st.points.begin(), [&p](int& point) {
			return point ? point + p : 0;
		});
	});
}

void evaluation::clear_not_passing()
{
	students.remove_if([](student& st) {return st.mark == student::marks::TWO; });
}

std::map<int,int> evaluation::histogram(ostream& out) const
{
    map<int, int> m;

	for_each(students.begin(), students.end(), [&m](const student st) {st.add_to_histogram(m); });
  
	for_each(m.begin(), m.end(), [](pair<int, int> p) {
		cout << "points: " << right << setw(2) << p.first << ": " << string(p.second, '*') << '\n';
	});

	return m;
}
