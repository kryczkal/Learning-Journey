#include <experimental/map>

#include "website.hpp"

void Website::SendEmail(const std::string& email, const Account& account, const std::string& message) const
{
	std::cout << "Sending email to " << email << " (age " << account.GetAge() << "):" << '\n';
	std::cout << "  Hello " << account.GetFirstName() << " " << account.GetLastName() << "! " << message << '\n';
}

Website::Website(std::string name): name(name) {}

void Website::AddAccount(std::string email, const AccountData data)
{
	auto s = accounts.find(email);
	if(s != accounts.end())
	{
		cout << "Account with email \"" << email << "\" already exists: "
			 << s->second << '\n';
		return;
	}
	Account acc(data);
	accounts.insert(make_pair(email, acc));
}

const Account* Website::FindAccount(std::string email) const
{
	auto i = accounts.find(email);
	if(i == accounts.end())
		return nullptr;
	return &(i->second);
}

void Website::LoadAccounts(std::string fileName)
{
	ifstream input(fileName);
	if(!input.is_open())
		cerr << "Failed to open file\n";
	std::string email;
	AccountData acc_data;
	while(input >> email)
	{
		input >> acc_data;
		AddAccount(email, acc_data);
	}
}

void Website::SendEmails(const std::map<int, std::string> &messagesByAge) const
{
	for_each(accounts.begin(), accounts.end(),
		[&messagesByAge, this](pair<string, Account> acc){
			auto i = messagesByAge.upper_bound(acc.second.GetAge());
			if(i == messagesByAge.end())
				return;
			SendEmail(acc.first, acc.second, i->second);
	});
}

set<string, StringCaseInsensitiveComparer> Website::UpdateAccounts(const vector<pair<string, AccountData>> &newData)
{
	set<string, StringCaseInsensitiveComparer> out;
	for_each(newData.begin(), newData.end(), [&out, this](pair<string, AccountData> data){
		if(out.count(data.first))
			return;

		out.insert(data.first);
		auto acc = accounts.find(data.first);
		if(acc != accounts.end())
			acc->second.Update(data.second);
		else
			AddAccount(data.first, data.second);
	});
    return out;
}

void Website::RemoveExcept(set<string, StringCaseInsensitiveComparer> accountsToKeep)
{
	experimental::erase_if(accounts, [&accountsToKeep](auto &data) -> bool {
		if(!accountsToKeep.count(data.first))
		{
			const_cast<Account&>(data.second).Remove();
			return true;
		}
		return false;
	});
}

multimap<int, string> Website::GroupByAge(int minAge, int maxAge) const
{
	multimap<int, string> s;
	for_each(accounts.begin(), accounts.end(), [minAge, maxAge, &s](auto p){
		if(p.second.GetAge() >= minAge && p.second.GetAge() <= maxAge)
			s.emplace(p.second.GetAge(), p.first);
	});
    return s;
}

void Website::PrintAges(const std::set<int> &ages) const
{
	int minAge = *ages.begin(), maxAge = *ages.rbegin();
	auto age_map = GroupByAge(minAge, maxAge);
	for_each(ages.begin(), ages.end(), [age_map, this](int age){
		cout << age << '\n';
		auto range = age_map.equal_range(age);
		for_each(range.first, range.second, [this](string &email){
			cout << "  " << accounts.find(email)->second << '\n';
		});
	});
}

std::ostream &operator<<(std::ostream &out, const Website &website)
{
	out << "Website " << website.name << "\n  Users:\n";
	for_each(website.accounts.begin(), website.accounts.end(),
		[&out](pair<string, Account> p) {
			out << "    " << p.second << '\n';
		});
	return out;
}
