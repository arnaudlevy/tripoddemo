class WelcomeController < ApplicationController

	def index
		uri = 'http://ric'
		graph = 'http://people'
		p = Person.new(uri, graph)
		p.name = 'Ric'
		p.age = 31
		p.aliases = ['Rich', 'Richard']
		p.important_dates = [Date.new(2011,1,1)]
		p.save!

		# Note: queries supplied to the where method should return the uris of the resource,
		# and what graph they're in.
		people = Person.where("
		  SELECT ?person ?graph
		  WHERE {
		    GRAPH ?graph {
		      ?person ?p ?o .
		      ?person a <http://person> .
		    }
		  }",
		:uri_variable => 'person' ) # optionally, set a different name for the uri parameter (default: uri)
		# => returns an array of Person objects, containing all data we know about them.

		ric = Person.find('http://ric')
		# => returns a single Person object.
	end
end