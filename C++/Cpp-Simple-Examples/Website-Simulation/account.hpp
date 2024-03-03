#pragma once

#include <string>
#include <iostream>

struct AccountData
{
	std::string firstName;
	std::string lastName;
	int age;

	friend std::ostream& operator << (std::ostream& out, const AccountData& data);

	// Etap 3
	friend std::istream& operator>>(std::istream& in, AccountData& data);
};


class Account
{
public:
	static int IDCounter;

private:
	const int id;
	AccountData data;

public:
	// It's not possible to copy an account
	Account& operator = (const Account&) = delete;

	Account(const AccountData& data);
	
	void Remove();
	void Update(const AccountData& data);
	
	std::string GetFirstName() const { return this->data.firstName; }
	std::string GetLastName() const { return this->data.lastName; }
	int GetAge() const { return this->data.age; }
	
	friend std::ostream& operator << (std::ostream& out, const Account& account);
};
