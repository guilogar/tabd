-- persons
create (philip: Person {name: 'Philip'}) return philip
create (mark: Person {name: 'Mark'}) return mark
create (bruno: Person {name: 'Bruno'}) return bruno

-- restaurants
create (isushi: Restaurant {name: 'iSushi'}) return isushi
create (zushi_zam: Restaurant {name: 'Zuzhi Zam'}) return zushi_zam

-- dish
create (sushi: Dish {cuisine: 'Sushi'}) return sushi

-- cities
create (ny: City {location: 'New York'}) return ny

-- relations
-- persons -> persons
MATCH (p:Person), (m:Person)
WHERE p.name = 'Philip' AND m.name = 'Mark'
CREATE (p)-[r:IS_FRIEND_OF]->(m)
RETURN p, m

MATCH (p:Person), (b:Person)
WHERE p.name = 'Philip' AND b.name = 'Bruno'
CREATE (p)-[r:IS_FRIEND_OF]->(b)
RETURN p, b

-- persons -> dish
MATCH (b:Person), (p:Restaurant)
WHERE b.name = 'Bruno' AND p.name = 'iSushi'
CREATE (b)-[r:LIKES]->(p)
RETURN b, p

MATCH (m:Person), (p:Restaurant)
WHERE m.name = 'Mark' AND p.name = 'Zuzhi Zam'
CREATE (m)-[r:LIKES]->(p)
RETURN m, p

-- dish -> restaurant
MATCH (p:Restaurant), (r:Dish)
WHERE p.name = 'iSushi' AND r.cuisine = 'Sushi'
CREATE (p)-[s:SERVES]->(r)
RETURN p, r

MATCH (p:Restaurant), (r:Dish)
WHERE p.name = 'Zuzhi Zam' AND r.cuisine = 'Sushi'
CREATE (p)-[s:SERVES]->(r)
RETURN p, r

-- dish -> city
MATCH (p:Restaurant), (c:City)
WHERE p.name = 'iSushi' AND c.location = 'New York'
CREATE (p)-[r:LOCATED_IN]->(c)
RETURN p, r

MATCH (p:Restaurant), (c:City)
WHERE p.name = 'Zuzhi Zam' AND c.location = 'New York'
CREATE (p)-[r:LOCATED_IN]->(c)
RETURN p, r