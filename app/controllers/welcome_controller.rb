class WelcomeController < ApplicationController

	def index
		p = Person.new('http://ric', 'http://people')
		p.name = 'Ric'
		p.age = 31
		p.aliases = ['Rich', 'Richard']
		p.important_dates = [Date.new(2011,1,1)]
		p.save!

		p = Person.new('http://arnaud', 'http://people')
		p.name = 'Arnaud'
		p.age = 34
		p.aliases = ['Arnaud']
		p.important_dates = [Date.new(2011,1,1)]
		p.save!

		# Note: queries supplied to the where method should return the uris of the resource,
		# and what graph they're in.
		@people = Person.where("
		  SELECT ?person ?graph
		  WHERE {
		    GRAPH ?graph {
		      ?person ?p ?o .
		      ?person a <http://person> .
		    }
		  }")
		# => returns an array of Person objects, containing all data we know about them.

		@ric = Person.find('http://ric')
		@arnaud = Person.find('http://arnaud')
		# => returns a single Person object.
	end
end