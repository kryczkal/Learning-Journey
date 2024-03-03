#include <iostream>

#include "account.hpp"
std::ostream& operator << (std::ostream& out, const AccountData& data)
{
	return out << data.firstName << " | " << data.lastName << " | " << data.age;
}

std::istream& operator>>(std::istream& in, AccountData& data)
{
	return in >> data.firstName >> data.lastName >> data.age;
}

int Account::IDCounter = 0;

Account::Account(const AccountData& data) : id{ ++IDCounter }, data{ data }
{
	std::cout << "Created user " << *this << '\n';
}

void Account::Remove()
{
	std::cout << "Removed unused account " << *this << '\n';
}

void Account::Update(const AccountData& data)
{
	std::cout << "Updating user: " << *this << '\n';
	std::cout << " with data: " << data << '\n';

	this->data = data;
}

std::ostream& operator << (std::ostream& out, const Account& account)
{
	return out << "(" << account.id << ") " << account.data;
}
