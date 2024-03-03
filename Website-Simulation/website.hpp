#pragma once

#include "utilities.hpp"
#include "account.hpp"

#include <iostream>
#include <fstream>
#include <map>
#include <string>
#include <algorithm>
#include <vector>

class Website
{
private:
	std::string name;
	std::map<std::string, Account, StringCaseInsensitiveComparer> accounts;

public:
	void SendEmail(const std::string& email, const Account& account, const std::string& message) const;

	Website(std::string name);
	void AddAccount(std::string email, const AccountData data);

	friend std::ostream& operator << (std::ostream& out, const Website& website);

	const Account* FindAccount(std::string email) const;
	void LoadAccounts(std::string fileName);
	void SendEmails(const std::map<int, std::string>& messagesByAge) const;

	std::set<std::string, StringCaseInsensitiveComparer> UpdateAccounts(const std::vector<std::pair<std::string, AccountData>>& newData);
	void RemoveExcept(std::set<std::string, StringCaseInsensitiveComparer> accountsToKeep);

	std::multimap<int, std::string> GroupByAge(int minAge, int maxAge) const;
	void PrintAges(const std::set<int>& ages) const;
};

std::ostream& operator << (std::ostream& out, const Website& website);