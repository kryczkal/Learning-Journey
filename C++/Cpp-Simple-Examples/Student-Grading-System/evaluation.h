#pragma once

#include <iostream>
#include <string>
#include <list>
#include <map>
#include "student.h"


class evaluation
{
public:
	evaluation() { }
	evaluation(const std::string& file_name);
	friend std::ostream& operator<<(std::ostream& out, const evaluation& e);

	void sort();	//sort by surname, name

	void reset_points(const int& p); 
	void set_marks(); 

	void clear_not_passing();

	std::map<int, int> histogram(std::ostream& out) const;

private:
	std::list<student> students;

	static const std::map<int, student::marks, std::greater<int>> levels;
	
};

