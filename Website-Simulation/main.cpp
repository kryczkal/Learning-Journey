#include <iostream>

#include "Utilities.hpp"
#include "account.hpp"
#include "website.hpp"

int main(int argc, char* argv[])
{
	std::cout << "============================== Testing Functionality 1 ==============================" << '\n';
	{
		std::vector<std::string> names = {
			"Benjamin",
			"Sophia",
			"Charlotte",
			"Mia",
			"Lucas",
			"James",

			"benjamin",
			"sophia",
			"charlotte",
			"mia",
			"lucas",
			"james",

			"BENJAMIN",
			"SOPHIA",
			"CHARLOTTE",
			"MIA",
			"LUCAS",
			"JAMES",

			"beNJaMIN",
			"SOphia",
			"chaRlOtTE",
			"mIA",
			"lUCas",
			"JaMeS",
		};

		auto set = ToSet(names);

		std::cout << "Set elements " << set.size() << ":" << '\n';
		for (const auto& element : set)
		{
			std::cout << "  " << element << '\n';
		}

		std::cout << '\n';
	}


	std::cout << "============================== Testing Functionality 2 ==============================" << '\n';
	{
		Account::IDCounter = 0;

		Website website{ "Stage2.com" };

		website.AddAccount("Thompson.Evelyn1986@news.net", { "Evelyn", "Thompson", 34 });
		website.AddAccount("Jackson1973@inlook.com", { "Lucas", "Jackson", 47 });
		website.AddAccount("anderson1968@inlook.com", { "Liam", "Anderson", 52 });
		website.AddAccount("Davis_Lucas@news.net", { "Lucas", "Davis", 21 });

		website.AddAccount("jackson1973@inlook.com", { "Liam", "Jackson", 31 });
		website.AddAccount("ANDERSON1968@inlook.com", { "Noah", "Anderson", 21 });

		website.AddAccount("MARTINEZ1969@news.net", { "Elijah", "Martinez", 51 });

		std::cout << '\n' << website << '\n';
	}


	std::cout << "============================== Testing Functionality 3 ==============================" << '\n';
	{
		Account::IDCounter = 0;

		Website website{ "Stage3.com" };
		website.LoadAccounts("Accounts.txt");
		std::cout << '\n' << website << '\n';


		const auto SendBirthdayWishes = [&](std::string email)
		{
			std::cout << "Searching for account with email " << email << '\n';

			const Account* account = website.FindAccount(email);
			if (account != nullptr)
			{
				std::cout << "  Found " << *account << '\n';
				website.SendEmail(email, *account, "Happy birthday!");
			}
			else
			{
				std::cout << "  Account not found" << '\n';
			}

		};

		SendBirthdayWishes("white1955@news.net");
		SendBirthdayWishes("THOMAS1977@INLOOK.com");
		SendBirthdayWishes("smith.wilson@INLOOK.COM");
		SendBirthdayWishes("Jones1964@PMail.com");
		SendBirthdayWishes("Williams2002@inlook.com");


		std::cout << '\n' << "Sending marketing mail" << '\n';

		std::map<int, std::string> messagesByAge =
		{
			{ 14,  "Click here to buy new LEGO bricks set." },
			{ 20, "Sale on new computer games. Buy them now!" },
			{ 30, "Brand new clothes in great prices." },
			{ 45, "Great choice of glasses in best prices." },
			{ 60, "Sale on cars! Brand new SUVs in great prices." },
			{ 90, "Take care of your heart with Heartol." },
		};

		website.SendEmails(messagesByAge);

		std::cout << '\n';
	}


	std::cout << "============================== Testing Functionality 4 ==============================" << '\n';
	{
		Account::IDCounter = 0;

		Website website{ "Stage4.com" };
		website.LoadAccounts("Accounts.txt");
		std::cout << '\n' << website << '\n';


		std::vector<std::pair<std::string, AccountData>> updatedAccounts =
		{
			{ "GARCIA_NOAH@pmail.com", { "Noah", "Garcia", 45 } },
			{ "GARCIA_NOAH@pmail.com", { "____", "Garcia", 45 } },
			{ "garcia.noah2009@inlook.com", { "Noah", "Garcia", 11 } },
			{ "rodriguez1997@inlook.com", { "Amelia", "Rodriguez", 23 } },
			{ "williams1989@inlook.com", { "Ava", "Johnson", 31 } },
			{ "RODRIGUEZ1997@inlook.com", { "____", "Rodriguez", 23 } },
			{ "white1955@news.net", { "Eric", "White", 66 } },
			{ "THOMPSON1965@news.net", { "William", "Thompson", 55 } },
			{ "WILLIAMS1989@inlook.com", { "____", "Johnson", 31 } },
			{ "thompson.isabella@inlook.com", { "Isabella", "Thompson", 57 } },
			{ "WILLIAMS.liam@pmail.com", { "Liam", "Williams", 14 } },
			{ "WHITE1988@inlook.com", { "Liam", "White", 32 } },
			{ "white.amelia1987@news.net", { "Amelia", "White", 33 } },
			{ "THOMPSON1965@news.net", { "____", "Thompson", 55 } },
			{ "taylor.isabella2001@inlook.com", { "Isabella", "Taylor", 20 } },
			{ "RODRIGUEZ_BENJAMIN@inlook.com", { "Benjamin", "Rodriguez", 69 } },
			{ "williams2001@inlook.com", { "Harper", "Garcia", 19 } },
			{ "thompson.evelyn1986@news.net", { "Evelyn", "Thompson", 34 } },
			{ "GARCIA.NOAH2009@inlook.com", { "____", "Garcia", 11 } },
			{ "wilson.sophia1977@pmail.com", { "Sophia", "Wilson", 43 } },
			{ "davis_isabella@inlook.com", { "Isabella", "Davis", 51 } },
			{ "martinez1969@news.net", { "Elijah", "Martinez", 52 } },
			{ "WILLIAMS.LIAM@pmail.com", { "____", "Williams", 14 } },
			{ "wilson_benjamin@inlook.com", { "Benjamin", "Wilson", 59 } },
			{ "WILLIAMS2001@inlook.com", { "____", "Garcia", 19 } },
			{ "JACKSON1973@inlook.com", { "Lucas", "Jackson", 47 } },
			{ "williams.ava1958@news.net", { "Ava", "Williams", 62 } },
			{ "ANDERSON1968@inlook.com", { "Patrick", "Anderson", 52 } },
			{ "johnson2002@news.net", { "Evelyn", "Johnson", 18 } },
			{ "jackson.oliver@news.net", { "Oliver", "Jackson", 19 } },
			{ "johnson_mia@news.net", { "Mia", "Johnson", 58 } },
			{ "JOHNSON2002@news.net", { "____", "Johnson", 18 } },
			{ "johnson_mia@news.net", { "____", "Johnson", 58 } },
		};

		auto foundAccounts = website.UpdateAccounts(updatedAccounts);
		std::cout << '\n';

		std::cout << "Updated or created accounts" << '\n';
		for (const auto& email : foundAccounts)
		{
			std::cout << "  " << email << '\n';
		}

		std::cout << '\n';
		website.RemoveExcept(foundAccounts);
		std::cout << '\n';

		std::cout << website << '\n';
	}


	std::cout << "============================== Testing Functionality 5 ==============================" << '\n';
	{
		Account::IDCounter = 0;

		Website website{ "Stage5.com" };
		website.LoadAccounts("Accounts.txt");
		std::cout << '\n' << website << '\n';


		std::cout << "Accounts grouped by age from 20 to 40:" << '\n';
		std::multimap<int, std::string> accountsGroupedByAges = website.GroupByAge(20, 40);
		for (auto pair : accountsGroupedByAges)
		{
			std::cout << pair.first << ": " << *website.FindAccount(pair.second) << '\n';
		}

		std::cout << '\n';
		std::set<int> ages = { 50, 51, 52, 53, 54, 55, 60, 70 };

		std::cout << "Accounts in specified age:" << '\n';
		website.PrintAges(ages);
	}

	return 0;
}
