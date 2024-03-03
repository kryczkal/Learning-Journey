#include <iostream>
using namespace std;
#include <ctime>
#include "word.h"
#include "dict.h"
//------------------------------------------------------

int main()
{
	srand((unsigned)time(0));

	dictionary	S{ {"matrix","macierz"},{"number","liczba"},{"field","cialo"} };//these selected words should always be in the dictionary
	
	cout << "Dictionary Starter:" << endl;
	cout << S << endl;
		
	//-------------------------------------------------------------
	if (!S.words_from_file("daily_words.txt")) 
	{
		cout<<"File not found"<<endl;
		return 0;
	}
	
	int	K;
	do  {
				cout<<S;	//print dictionary

                cout<<"\nMENU:"<<endl;
                cout<<"1 - SORT list by POL_ANG"<<endl;
                cout<<"2 - SORT list by ANG_POL"<<endl;
                cout<<"3 - ADD word"<<endl;
				cout<<"4 - TEST"<<endl;
				cout<<"5 - SAVE dictionary"<<endl;
                cout<<"0 - EXIT"<<endl;
                cout<<"*** Enter option number:  ";
                
				cin>>K;
                switch (K)
                {
					case 1:	//SORT dictionary by pol and eng fields
						S.sort(Cmp::sort:: POL_ANG);
						break;

                    case 2:	//SORT dictionary by eng and pol fields
						S.sort(Cmp::sort::ANG_POL);
						break;
                   
                    case 3:	//ADD word
						S.insert();
						break;
					
					case 4: //TEST
						S.test();
						break; 
					
					case 5: //SAVE
						if (!S.save_words()) cout<<"Save failed"<<endl;
						break;
                }//switch
	} while (K != 0);
}
