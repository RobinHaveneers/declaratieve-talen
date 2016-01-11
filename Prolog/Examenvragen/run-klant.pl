:- use_module(library(lists)).

writeall([],_,_).
writeall([X|R],Prefix,Postfix) :-
    write(Prefix),
    write(X),
    writeln(Postfix),
    writeall(R,Prefix,Postfix).

loadfiles :-
    ['gequoteerde-klanten.pl'], % If needed, edit your name file here
    [klantensimulatiefacts].

test_assignment_1 :-
	findall((CustID,Prod)->BestBuy,(customer(CustID,_,_,_), member(Prod,[chocolate,water,bread]), cust_buys(CustID,Prod,BestBuy)),Buys),
    writeln('\nALL SOLUTIONS TO ASSIGNMENT 1:'),
    writeall(Buys, '   ','').

% Desired output:
%ALL SOLUTIONS TO ASSIGNMENT 1:
   %cust1,chocolate->purchase(cust1,2,chocolate,60,yellow,pos(6,0))
   %cust1,water->purchase(cust1,15,water,10,blue,pos(3,3))
   %cust1,bread->purchase(cust1,10,bread,25,red,pos(1,1))
   %cust2,chocolate->purchase(cust2,5,chocolate,80,blue,pos(3,3))
   %cust2,water->purchase(cust2,20,water,10,blue,pos(3,3))
   %cust2,bread->purchase(cust2,13,bread,30,blue,pos(3,3))
   %cust3,chocolate->purchase(cust3,1,chocolate,50,red,pos(7,4))
   %cust3,water->purchase(cust3,50,water,10,blue,pos(3,3))
   %cust3,bread->purchase(cust3,15,bread,28,red,pos(7,4))
   %cust4,chocolate->purchase(cust4,2,chocolate,50,red,pos(7,4))
   %cust4,water->purchase(cust4,10,water,10,blue,pos(3,3))
   %cust4,bread->purchase(cust4,8,bread,25,red,pos(1,1))
   %cust5,chocolate->purchase(cust5,3,chocolate,60,yellow,pos(6,0))
   %cust5,water->purchase(cust5,35,water,13,yellow,pos(6,0))
   %cust5,bread->purchase(cust5,12,bread,28,yellow,pos(6,0))



test_assignment_2 :-
	findall(BestBuy,(customer(CustID,_,_,_), member(Prod,[chocolate,water,bread]), cust_buys(CustID,Prod,BestBuy)),Transactions),
	findall(StoreChainID->Rev,(storechain(StoreChainID), get_revenue_for_transactions(StoreChainID,Transactions,Rev)),List),
    writeln('\nALL SOLUTIONS TO ASSIGNMENT 2:'),
    writeall(List, '   ','').

% Desired output:
%ALL SOLUTIONS TO ASSIGNMENT 2:
   %red->revenue(red,1020)
   %blue->revenue(blue,1740)
   %yellow->revenue(yellow,1091)

% test_assignment_3 :-
% 	findall(Pos->NewRevs, red_place_store(Pos,NewRevs),List),
%     writeln('\nALL SOLUTIONS TO ASSIGNMENT 3:'),
%     writeall(List, '   ','').

% Desired output:
%ALL SOLUTIONS TO ASSIGNMENT 3:
   %pos(0,0)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(0,1)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(0,2)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(0,3)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(0,4)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(0,5)->[revenue(red,1370),revenue(blue,1740),revenue(yellow,636)]
   %pos(1,0)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(1,1)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(1,2)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(1,3)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(1,4)->[revenue(red,2475),revenue(blue,750),revenue(yellow,300)]
   %pos(1,5)->[revenue(red,1370),revenue(blue,1740),revenue(yellow,636)]
   %pos(2,0)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(2,1)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(2,2)->[revenue(red,2275),revenue(blue,950),revenue(yellow,300)]
   %pos(2,3)->[revenue(red,2475),revenue(blue,750),revenue(yellow,300)]
   %pos(2,4)->[revenue(red,2475),revenue(blue,750),revenue(yellow,300)]
   %pos(2,5)->[revenue(red,2360),revenue(blue,750),revenue(yellow,636)]
   %pos(3,0)->[revenue(red,2370),revenue(blue,950),revenue(yellow,180)]
   %pos(3,1)->[revenue(red,2370),revenue(blue,950),revenue(yellow,180)]
   %pos(3,2)->[revenue(red,2620),revenue(blue,700),revenue(yellow,180)]
   %pos(3,3)->[revenue(red,2370),revenue(blue,950),revenue(yellow,180)]
   %pos(3,4)->[revenue(red,2475),revenue(blue,750),revenue(yellow,300)]
   %pos(3,5)->[revenue(red,1370),revenue(blue,1740),revenue(yellow,636)]
   %pos(4,0)->[revenue(red,2370),revenue(blue,950),revenue(yellow,180)]
   %pos(4,1)->[revenue(red,2550),revenue(blue,850),revenue(yellow,0)]
   %pos(4,2)->[revenue(red,2550),revenue(blue,850),revenue(yellow,0)]
   %pos(4,3)->[revenue(red,3050),revenue(blue,350),revenue(yellow,0)]
   %pos(4,4)->[revenue(red,2450),revenue(blue,950),revenue(yellow,0)]
   %pos(4,5)->[revenue(red,2234),revenue(blue,950),revenue(yellow,336)]
   %pos(5,0)->[revenue(red,2770),revenue(blue,850),revenue(yellow,0)]
   %pos(5,1)->[revenue(red,2670),revenue(blue,850),revenue(yellow,0)]
   %pos(5,2)->[revenue(red,3170),revenue(blue,350),revenue(yellow,0)]
   %pos(5,3)->[revenue(red,2834),revenue(blue,350),revenue(yellow,336)]
   %pos(5,4)->[revenue(red,2834),revenue(blue,350),revenue(yellow,336)]
   %pos(5,5)->[revenue(red,2234),revenue(blue,950),revenue(yellow,336)]
   %pos(6,0)->[revenue(red,2134),revenue(blue,850),revenue(yellow,636)]
   %pos(6,1)->[revenue(red,3170),revenue(blue,350),revenue(yellow,0)]
   %pos(6,2)->[revenue(red,2834),revenue(blue,350),revenue(yellow,336)]
   %pos(6,3)->[revenue(red,2834),revenue(blue,350),revenue(yellow,336)]
   %pos(6,4)->[revenue(red,2834),revenue(blue,350),revenue(yellow,336)]
   %pos(6,5)->[revenue(red,2834),revenue(blue,350),revenue(yellow,336)]
   %pos(7,0)->[revenue(red,1684),revenue(blue,950),revenue(yellow,1091)]
   %pos(7,1)->[revenue(red,1884),revenue(blue,950),revenue(yellow,791)]
   %pos(7,2)->[revenue(red,1884),revenue(blue,950),revenue(yellow,791)]
   %pos(7,3)->[revenue(red,1884),revenue(blue,950),revenue(yellow,791)]
   %pos(7,4)->[revenue(red,1884),revenue(blue,950),revenue(yellow,791)]
   %pos(7,5)->[revenue(red,1884),revenue(blue,950),revenue(yellow,791)]

:- loadfiles.
:- test_assignment_1.
:- test_assignment_2.
%:- test_assignment_3.


%:- halt.
