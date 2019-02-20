require 'csv'

# csvファイルを読み込み
def read
  texts = CSV.read("****", encoding: "Shift_JIS:UTF-8")
end

