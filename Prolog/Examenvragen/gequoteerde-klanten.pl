%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% !     !     !     !     !     !     !     !    !   %%
%% OPGELET: Heel lelijke oefen-overkill-implementatie %%
%% !     !     !     !     !     !     !     !    !   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distance(pos(X1,Y1), pos(X2,Y2), D) :-
    Dx is abs(X2-X1),
    Dy is abs(Y2-Y1),
    D is Dx + Dy.

cust_buys(CustomerID,Product,BestBuy) :-
    customer(CustomerID,_,_,_),
    findall(Purchase,(possible_customer_purch(CustomerID, Product, Purchase)),PriceList),
    make_combination(PriceList,[],ComboList),
    get_lowest(ComboList,[],Cheapest),
    reverse(Cheapest, CheapReverse),
    check_final_element(CheapReverse, CheapestNew),
    reverse(CheapestNew, CheapestChecked),
    get_nearest(CheapestChecked,[],BestBuy),!.

make_combination([],Result,Result).
make_combination([purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos)|T], [], Result) :-
    make_combination(T, [pp(Price,purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos))], Result).
make_combination([purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos)|PT],Temp,Result) :-
    make_combination(PT, [pp(Price,purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos))|Temp], Result).

check_final_element([pp(P2, purchase(A, B, C, P2, D, E))],[pp(P2, purchase(A, B, C, P2, D, E))]).
check_final_element([pp(P1, purchase(_, _, _, P1, _, _)),pp(P2, purchase(A, B, C, P2, D, E))|R], [pp(P2, purchase(A, B, C, P2, D, E))|R]) :-
    P1 > P2.

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
              pp(_,purchase(CCustomerID,CAmount,CProduct,CPrice,CStoreChain,CStorePos)), Result) :-
    customer(CustomerID,CusPos,_,_),
    distance(CusPos, StorePos,D),
    distance(CusPos, CStorePos,E),
    D > E,
    get_nearest(PT,pp(_,purchase(CCustomerID,CAmount,CProduct,CPrice,CStoreChain,CStorePos)), Result).

get_nearest([pp(_,purchase(CustomerID,Amount,Product,Price,Chain,StorePos))|PT],
              pp(_,purchase(_,_,_,_,_,CStorePos), Result)) :-
    customer(CustomerID,CusPos,_,_),
    distance(CusPos, StorePos,D),
    distance(CusPos, CStorePos,E),
    D =< E,
    get_nearest(PT,pp(purchase(CustomerID,Amount,Product,Price,Chain,StorePos), Result)).

possible_customer_purch(CustomerID, Product, Purchase) :-
    customer(CustomerID, CusPos, CusStam, CusNeeds),
    store(StoreChain, StorePos, StoreSell),
    distance(CusPos,StorePos,Dist),
    Dist =< CusStam,
    member(needs(Product,Amount),CusNeeds),
    member(sells(Product,Price),StoreSell),
    Purchase = purchase(CustomerID,Amount,Product,Price,StoreChain,StorePos).

% Overbodig: price zit al in purchase
get_price_for_product(sells(Product,Price), Product, Price).
get_price_for_product([H|T], Product,Price) :-
    get_price_for_product(H, Product, Price);
    get_price_for_product(T, Product, Price),!.


get_revenue_for_transactions(StoreChainID,Transactions,Revenue) :-
    storechain(StoreChainID),
    get_all_purchases_for_store(StoreChainID, Transactions, StorePurch),
    calculate_revenue(StorePurch, Revenue).

get_all_purchases_for_store(StoreChainID, Transactions, StorePurch) :-
    storechain(StoreChainID),
    findall(purchase(_,Amount,_,Price,StoreChainID,_), member(purchase(_,Amount,_,Price,StoreChainID,_),Transactions), StorePurch).

calculate_revenue(StorePurch, Revenue) :-
    findall(ap(Amount,Price), member(purchase(_,Amount,_,Price,_,_), StorePurch), Combis),
    multiply_pair(Combis, [], RevList),
    sum_list(RevList, Revenue).

multiply_pair([],Result, Result).
multiply_pair([ap(Amount,Price)|R],[], Result) :- !,
    Mult is Amount*Price,
    multiply_pair(R, [Mult], Result).
multiply_pair([ap(Amount,Price)|R], RevList, Result) :-
    Mult is Amount*Price,
    multiply_pair(R, [Mult|RevList], Result).
