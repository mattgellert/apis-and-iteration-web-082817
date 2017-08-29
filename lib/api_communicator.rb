require 'rest-client'
require 'json'
require 'pry'

def fetch_api(api_url)
  JSON.parse(RestClient.get(api_url))
end

def fetch_character(characters_hash, character)
  character_hash = {}
  characters_hash["results"].each {|data|
    if data["name"] == character
      character_hash = data
    end
  }
  character_hash
end

def fetch_films(character_hash)
  films_hash = []
  character_hash["films"].each {|api|
    film_hash = fetch_api(api)
    films_hash << film_hash
  }
  films_hash
end

def get_character_movies_from_api(character)
  characters_hash = fetch_api('http://www.swapi.co/api/people/')
  character_hash = fetch_character(characters_hash, character)
  films_hash = fetch_films(character_hash)
end

def parse_character_movies(films_hash)
  films_arr = []
  films_hash.each {|film|
    films_arr << "Episode #{film["episode_id"]}: #{film["title"]}"
  }


  films_arr.sort_by {|film| film[8].to_i}.each { |film|
    puts film
  }
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
