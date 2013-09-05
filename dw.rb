
require 'mechanize'

host = "http://dragonwrench.bandcamp.com/"
xpath = '//*[@id="trackInfoInner"]/div[1]/table/tr[1]/td[1]/a/div' 
#this site is rather recursive
agent = Mechanize.new

#page = agent.get(host)
page.parser.xpath(xpath).methods


