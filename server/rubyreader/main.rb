#!/usr/bin/env ruby
require 'net/http'
require 'json'

builddir = "build/"

url = 'https://www.inoreader.com/stream/user/1004973503/tag/all-articles/view/json'
uri = URI(url)
response = Net::HTTP.get(uri)
js = JSON.parse(response)

i = 0

#f = File.new("/tmp/lawl.json", "r")
#data = f.read
#js = JSON.parse(data)

links = []

smallheader = "<html><body>"
smallfooter = "</body></html>"

js["items"].each do |item|
  title = item["title"]
  contenthtml = item["content_html"]

  html = smallheader + contenthtml + smallfooter
  if contenthtml.end_with?("Continue reading...<\/a>") or contenthtml.end_with?("Source<\/a>")
    print "Fetching #{item['url']}\n"
    articleuri = URI(item["url"])
    articleresponse = Net::HTTP.get(articleuri)
    html = articleresponse
  end


  filename = i.to_s.rjust(3, "0") + ".html"

  w = File.new(builddir + filename, "w")
  #w.syswrite(articleresponse)
  w.syswrite(html)

  links.append("<div class='muhlink'><a href=#{filename}>#{title}</a></div>")

  i = i + 1

end

header = "<html>
<head>
<style>
  a {
    font-size: 24px;
  }
  .muhlink {
    border: 1px solid black;
  }
</style>
</head>
<body>
    <p style='text-indent:0pt'>
"

footer = "</p></body></html>"

contents = header + links.join("\n") + footer

indexfile = File.new(builddir + "index.html", "w")
indexfile.syswrite(contents)

