#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require 'benchmark'

welcome
character = get_character_from_user
x = show_character_movies(character)

until x != []
    puts "That is not a valid character. Please try again"
    character = get_character_from_user
end
