require 'json'
require 'natto'
require 'mecab'
require './read_csv.rb'

# 形態素解析
natto = Natto::MeCab.new

# TF
texts = read_all()
tf = {}
texts.each do |text|
  tf[text[0]] = {}
  word_count = 0
  natto.parse(text[0]) do |n|
    if n.feature.split(',')[0] == '名詞'
      if tf[text[0]][n.surface].nil?
        tf[text[0]][n.surface] = 1
      else
        tf[text[0]][n.surface] += 1
      end
    end
    word_count += 1
  end
  tf[text[0]].each do |word|
    tf[text[0]][word[0]] = word[1].to_f / word_count.to_f
  end
end

# JSON
tf_json = JSON.pretty_generate(tf)
file =  File.open("json/tf.json", "w+") do |text_json|
  text_json.puts ("#{tf_json}")
end

include Math

# IDF
idf = {}
tf.each do |text|
  text[1].each do |word|
    if idf[word[0]].nil?
      idf[word[0]] = 1
    else
      idf[word[0]] += 1
    end
  end
end
num = 64
idf.each do |word|
  idf[word[0]] = log(num.to_f / idf[word[0]].to_f)
end

idf_json = JSON.pretty_generate(idf)
File.open("json/idf.json", "w+") do |text_json|
  text_json.puts ("#{idf_json}")
end

# TF-IDF
tfidf = {}
tf.each do |text|
  tfidf[text[0]] = {}
  text[1].each do |word|
    tfidf[text[0]][word[0]] = word[1] * idf[word[0]]
  end
end

tfidf_json = JSON.pretty_generate(tfidf)
File.open("json/tfidf.json", "w+") do |text_json|
  text_json.puts ("#{tfidf_json}")
end

# Sortしたやつ
File.open("json/sort_data_idf.json", "w+") do |text_json|
  results = idf.sort {|a,b| a[1] <=> b[1]}
  results[1..10].each do |result|
    text_json.puts "#{result[0]}\t#{result[1]}"
  end
end

