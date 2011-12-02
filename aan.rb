require 'sinatra'
require 'yaml'

get '/' do
  @phrase = phrase
  erb :home
end

post '/' do
  phrase
end

not_found do  
  halt 404, 'Shit\'s busted.' 
end

def phrase
  words = YAML::load(File.open('words.yml'))
  new_phrase = %w[adj2 noun].map { |type| words[type].sample }
  addition = rand(10)
  new_phrase.unshift(words['adj1'].sample) if addition == (2..9)
  new_phrase.push(words['sequels'].sample) if addition < 3
  new_phrase.push(words['sequel_titles'].sample) if addition < 3
  new_phrase.push(words['suffix'].sample) if addition == (4..7)
  new_phrase.unshift(words['prefix'].sample) if addition > 5
  new_phrase = new_phrase.join(' ').split(' ')
  new_phrase = new_phrase.each_with_index.map do |word, i|
    if [0, new_phrase.size - 1].include?(i) || !['the', 'of', 'for'].include?(word) 
    word.capitalize
    else
      word
    end
  end.join(' ')
end


  
