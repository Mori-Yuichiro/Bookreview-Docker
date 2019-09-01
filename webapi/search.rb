# 使用するgemを読み込み
require 'rakuten_web_service'

# rakuten_web_service内のclassで使えるようにアプリケーションIDを設定
RakutenWebService.configure do |c|
  c.application_id = '1086129247199252625'
end

# ARGV[0]で実行時の1つめのパラメータを取得、存在しない場合は'Ruby'を設定
keyword = ARGV[0] || 'Ruby'

# rakuten_web_serviceの使用法に乗っ取りHTTPリクエストを送ってデータを取得
items = RakutenWebService::Ichiba::Item.search(keyword: keyword)

# 取得したデータを10件まで表示
items.first(10).each do |item|
  puts "
#{item['itemName']}
, 
#{item.price}
 yen"
end