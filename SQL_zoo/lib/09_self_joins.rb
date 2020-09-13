# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT
      COUNT(id)
    FROM
      stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT
      id
    FROM
      stops
    WHERE
      name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      stops.id, stops.name
    FROM
      routes
    JOIN
      stops ON routes.stop_id = stops.id
    WHERE
      routes.num = '4' AND routes.company = 'LRT'
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP bY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have starts count of 2. Add starts HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
    SELECT
    company,
    num,
    COUNT(*)
  FROM
    routes
  WHERE
    stop_id = 149 OR stop_id = 53
  GROUP bY
    company, num
  HAVING
    COUNT(*) > 1
  SQL
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   starts.company,
  #   starts.num,
  #   starts.stop_id,
  #   b.stop_id
  # FROM
  #   routes starts
  # JOIN
  #   routes b ON (starts.company = b.company AND starts.num = b.num)
  # WHERE
  #   starts.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
      starts.company,
      starts.num,
      starts.stop_id,
      b.stop_id
    FROM
      routes starts
    JOIN
      routes b ON (starts.company = b.company AND starts.num = b.num)
    WHERE
      starts.stop_id = 53 AND b.stop_id = 149
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   starts.company,
  #   starts.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes starts
  # JOIN
  #   routes b ON (starts.company = b.company AND starts.num = b.num)
  # JOIN
  #   stops stopa ON (starts.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
  SELECT
    starts.company,
    starts.num,
    stopa.name,
    stopb.name
  FROM
    routes starts
  JOIN
    routes b ON (starts.company = b.company AND starts.num = b.num)
  JOIN
    stops stopa ON (starts.stop_id = stopa.id)
  JOIN
    stops stopb ON (b.stop_id = stopb.id)
  WHERE
    stopa.name = 'Craiglockhart' AND stopb.name = 'London Road'
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT DISTINCT
      starts.company, starts.num
    FROM
      routes starts
    JOIN
      routes b ON (starts.company = b.company AND starts.num = b.num)
    WHERE
      starts.stop_id = 115 AND b.stop_id = 137
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT
      starts.company, starts.num
    FROM
      routes starts
    JOIN
      routes b ON (starts.company = b.company AND starts.num = b.num)
    JOIN
      stops stopa ON (starts.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give starts distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT DISTINCT
      stops.name, routes.company, routes.num
    FROM
      stops
    JOIN
      routes ON stops.id = routes.stop_id
    WHERE
      routes.num IN (
        SELECT
          routes.num
        FROM
          routes
        JOIN
          stops ON stops.id = routes.stop_id
        WHERE 
          stops.name = 'Craiglockhart'
      ) AND routes.company IN (
        SELECT
          routes.company
        FROM
          routes
        JOIN
          stops ON stops.id = routes.stop_id
        WHERE 
          stops.name = 'Craiglockhart'
      )
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
    SELECT DISTINCT
      starts.num, starts.company, transfer_stops.name, b.num, b.company
    FROM
      routes starts
    JOIN
      routes to_transfer ON (to_transfer.num = starts.num AND to_transfer.company = starts.company)
    JOIN
      stops transfer_stops ON (transfer_stops.id = to_transfer.stop_id)
    JOIN
      routes from_transfer ON transfer_stops.id = from_transfer.stop_id
    JOIN
      routes b ON (from_transfer.num = b.num AND from_transfer.company = b.company)
    JOIN
      stops start_stops ON start_stops.id = starts.stop_id
    JOIN
      stops end_stops ON end_stops.id = b.stop_id
    WHERE
      start_stops.name = 'Craiglockhart' AND end_stops.name = 'Sighthill'
  SQL
end
