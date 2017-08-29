require 'rest-client'
require 'json'
require 'pry'

def fetch_api(api_url)
  x = RestClient.get(api_url)
  JSON.parse(x)
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

def fetch_films(films_api)
  films_array = []
  films_api.each {|api|
    film_hash = fetch_api(api)
    films_array << film_hash
  }
  films_array
end

def get_character_movies_from_api(character)
  films_array = []
  page = 1
  current_page = fetch_api("http://www.swapi.co/api/people/?page=#{page.to_s}")
  until current_page["next"] == nil
    current_page = fetch_api("http://www.swapi.co/api/people/?page=#{page.to_s}")
    current_page["results"].each {|person|
      if person["name"].downcase == character
        films_array = fetch_films(person["films"])
      end
    }

    page += 1
  end
  films_array
end

def parse_character_movies(films_array)
  films_arr = []
  films_array.each {|film|
    films_arr << "Episode #{film["episode_id"]}: #{film["title"]}"
  }
  films_arr.sort_by {|film| film[8].to_i}.each { |film|
    puts film
  }
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  parse_character_movies(films_array)
end
