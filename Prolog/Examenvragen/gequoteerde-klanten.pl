%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% !     !     !     !     !     !     !     !    !   %%
%% OPGELET: Heel lelijke oefen-overkill-implementatie %%
%% !     !     !     !     !     !     !     !    !   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Input predicate: width/1
%	width(Width).
width(8).

%Input predicate: height/1
%	height(Height).
height(6).

%Input predicate: storechain/1
%	storechain(StoreChainID)
storechain(red).
storechain(blue).
storechain(yellow).

%Input predicate: store/3
%	store(StoreChainID, Location, ListOfProducts)
store(red, pos(1,1), [sells(chocolate,65), sells(water,12), sells(bread,25)]).
store(red, pos(7,4), [sells(chocolate,50), sells(water,13), sells(bread,28)]).
store(blue, pos(3,3), [sells(chocolate,80), sells(water,10), sells(bread,30)]).
store(yellow, pos(6,0), [sells(chocolate,60), sells(water,13), sells(bread,28)]).

%Input predicate: customer/4
%	customer(CustomerID, Location, Stamina, CustomerNeeds)
customer(cust1, pos(3,2), 5, [needs(chocolate,2), needs(water,15), needs(bread,10)]).
customer(cust2, pos(2,4), 3, [needs(chocolate,5), needs(water,20), needs(bread,13)]).
customer(cust3, pos(6,3), 3, [needs(chocolate,1), needs(water,50), needs(bread,15)]).
customer(cust4, pos(6,2), 6, [needs(chocolate,2), needs(water,10), needs(bread,8)]).
customer(cust5, pos(5,1), 2, [needs(chocolate,3), needs(water,35), needs(bread,12)]).

distance(pos(X1,Y1), pos(X2,Y2), D) :-
    Dx is abs(X2-X1),
    Dy is abs(Y2-Y1),
    D is Dx + Dy.

cust_buys(CustomerID,Product,BestBuy) :-
    customer(CustomerID,_,_,_),
    findall(Purchase,(possible_customer_purch(CustomerID, Product, Purchase)),PriceList),
    make_combination(PriceList,[],ComboList),
    get_lowest(ComboList,[],Cheapest),
    get_nearest(Cheapest,[],BestBuy),!.

make_combination([],Result,Result).

make_combination([purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos)|T], [], Result) :-
    make_combination(T, [pp(Price,purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos))], Result).
make_combination([purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos)|PT],Temp,Result) :-
    make_combination(PT, [pp(Price,purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos))|Temp], Result).

get_lowest([H|T], [], Result) :-
    get_lowest(T, [H], Result).
get_lowest([], Result, Result).
get_lowest([pp(Price, Purchase)|PT], [pp(CurPrice,CurPurchase)|CT], Result) :-
    Price =< CurPrice,
    get_lowest(PT, [pp(Price, Purchase),pp(CurPrice,CurPurchase)|CT], Result).
get_lowest([pp(Price, _)|PT], [pp(CurPrice,CurPurchase)|CT], Result) :-
    Price > CurPrice,
    get_lowest(PT, [pp(CurPrice,CurPurchase)|CT], Result).



get_nearest([pp(_,Result)],[], Result).
get_nearest([H|T], [], Result) :-
    get_nearest(T, H, Result).
get_nearest([],Result,Result).
get_nearest([pp(_,purchase(CustomerID,_,_,_,_,StorePos))|PT],
              purchase(CCustomerID,CAmount,CProduct,CPrice,CStoreChain,CStorePos), Result) :-
    customer(CustomerID,CusPos,_,_),
    distance(CusPos, StorePos,D),
    distance(CusPos, CStorePos,E),
    D > E,
    get_nearest(PT,purchase(CCustomerID,CAmount,CProduct,CPrice,CStoreChain,CStorePos), Result).

get_nearest([pp(_,purchase(CustomerID,Amount,Product,Price,Chain,StorePos))|PT],
              purchase(_,_,_,_,_,CStorePos), Result) :-
    customer(CustomerID,CusPos,_,_),
    distance(CusPos, StorePos,D),
    distance(CusPos, CStorePos,E),
    D =< E,
    get_nearest(PT,purchase(CustomerID,Amount,Product,Price,Chain,StorePos), Result).

possible_customer_purch(CustomerID, Product, Purchase) :-
    customer(CustomerID, CusPos, CusStam, CusNeeds),
    store(StoreChain, StorePos, StoreSell),
    distance(CusPos,StorePos,Dist),
    Dist =< CusStam,
    member(needs(Product,Amount),CusNeeds),
    member(sells(Product,Price),StoreSell),
    Purchase = purchase(CustomerID,Product,Amount,Price,StoreChain,StorePos).
