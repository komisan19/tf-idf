require 'csv'

# csvファイルを読み込み
def read_all
  texts = CSV.read("csv/note_all.csv", encoding: "Shift_JIS:UTF-8")
end

# 多分いらないと思う

def read_positive
  texts = CSV.read("csv/note_positive.csv", encoding: "Shift_JIS:UTF-8")
end 

def read_negative
  texts = CSV.read("csv/note_negative.csv", encoding: "Shift_JIS:UTF-8")
end

