require 'csv'

# csvファイルを読み込み
def read
  texts = CSV.read("csv/note_all.csv", encoding: "Shift_JIS:UTF-8")
end

