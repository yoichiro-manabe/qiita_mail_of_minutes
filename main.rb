require 'qiita'
require 'pp'

# APIトークンを読み込む
auth_info ={}

# note:同一ディレクトリに secret.txt ファイルを作成すること。
# note:ファイルは以下の形式で記述すること。
# note:access_token:xxxx
# note:host:qiita_team名.qiita.com
File.open 'secret.txt' do |file|
  file.each_line do |line|
    auth_info[line.split(':')[0].to_sym]=line.split(':')[1]
  end
end

client = Qiita::Client.new(host: auth_info[:host], access_token:auth_info[:access_token])

unless client.status == 200
  p 'データの取得に失敗しました。'
  return
end

client.list_tag_items("議事録").body.each do |item|
  p "タイトル:#{item["title"]}"
  p "タグ:#{item['tags']}"
  p "本文:#{item['rendered_body']}"
end
