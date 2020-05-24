-- Exercise 2
match (n) return n

-- Exercise 3
match
(r:Restaurant)
<-[:SERVES]-
(d:Dish {cuisine: 'Sushi'})
<-[:LIKES]-
(pp:Person)
<-[:IS_FRIEND_OF]-
(p:Person {name: 'Philip'})
return pp

-- Exercise 4
match
(r:Restaurant)
where r.name contains 'ushi'
return r

-- Exercise 5
match
(r:Restaurant)
<-[:SERVES]-
(d:Dish {cuisine: 'Sushi'})
return d

-- Exercise 6
create
(parrillada_paraside:Restaurant {name: 'ParrilladaParadise'})
return parrillada_paraside

create
(parrillada:Dish {cuisine: 'Parrillada'})
return parrillada

MATCH (r:Restaurant), (c:City)
WHERE r.name = 'ParrilladaParadise' AND c.location = 'New York'
CREATE (r)-[:LOCATED_IN]->(c)
RETURN r, c

MATCH (r:Restaurant), (d:Dish)
WHERE r.name = 'ParrilladaParadise' AND d.cuisine = 'Parrillada'
CREATE (r)-[:LOCATED_IN]->(d)
RETURN r, d

-- Exercise 7
match (n:Restaurant {name: 'Zuzhi Zam'})
set n.name = 'Zuzhi'
return n

-- Exercise 8
match (n:City {name: 'New York'})
set n.country = 'USA'
return n

-- Exercise 9
create (d:Dish {cuisine: 'Sashimi'})
return d

match
(r:Restaurant)
<-[:LOCATED_IN]:
(c:City {location: 'New York'})
<-[:SERVES]-
(d:Dish {cuisine: 'Sushi'})
<-[:LIKES]-
(pp:Person)
<-[:IS_FRIEND_OF]-
(p:Person {name: 'Philip'}),
(dd:Dish {cuisine: 'Sashimi'})
CREATE (r)-[:SERVES]->(dd)
return r, dd

-- Exercise 10
MATCH (n)
RETURN n
SKIP 3
LIMIT 1

-- Exercise 11
MATCH (n:City { location: 'New York' })
OPTIONAL MATCH (n)-[r]-() 
DELETE n, r