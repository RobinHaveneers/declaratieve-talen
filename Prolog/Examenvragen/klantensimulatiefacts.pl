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