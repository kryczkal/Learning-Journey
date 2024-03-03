#pragma once

#include <ostream>
#include <string>
#include <list>
#include <map>

class student
{
	friend class evaluation;

public:

	enum class marks { TWO = 2, THREE, FOUR, FIVE };

	student() = default;
    student(const std::string &name, const std::string &surname, const std::list<int> &points);
	friend std::ostream& operator<<(std::ostream& out, const student& st);

	int sum_of_points() const;
	void add_to_histogram(std::map<int, int>& m) const;

private:
    std::string name, surname;
    std::list<int> points;
	marks mark = student::marks::TWO;
};



