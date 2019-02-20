require 'json'
require 'natto'
require 'mecab'
require './read_csv.rb'

# 形態素解析
natto = Natto::MeCab.new

texts = read()
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
    word_count += 1
    end
  end
  tf[text[0]].each do |word|
    tf[text[0]][word[0]] = word[1].to_f / word_count.to_f
  end
end

# JSON形式をparseする
tf_json = JSON.pretty_generate(tf)
file =  File.open("json/#{ARGV[0]}.json", "w+") do |text_json|
  text_json.puts("#{tf_json}")
end
