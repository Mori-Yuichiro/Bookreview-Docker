# 使用するgemを読み込み
require 'net/http'
require 'json'
require 'uri'

API_BASE_URL='https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706'

# 送信するパラメータを設定
keyword = ARGV[0] || 'Ruby'
params = {
  'keyword'       => URI.encode(keyword),
  'format'        => 'json',
  'applicationId' => '1086129247199252625',
  'hits'          => 10,
  'imageFlag'     => 1
}

# パラメータを組み立ててURLの後ろに `?keyword=#{keyword}?format=json?...`という形にしてURLとして扱えるようにする
uri = URI(API_BASE_URL + '?' + params.map{|k,v| "
#{k}
=
#{v}
"}.join('&'))

# Rubyの標準ライブラリ処理を用いてHTTPのGETリクエストを送る
response_json = Net::HTTP.get(uri)

# Rubyの標準ライブラリ処理を用いて受け取ったJSONをパース（分解）してRubyの処理として使えるようにする
response_data = JSON.parse(response_json)

# 取得したデータを10件まで表示
response_data['Items'].first(10).each do |item_data|
  puts "
#{item_data['Item']['itemName']}
, 
#{item_data['Item']['itemPrice']}
 yen"
end