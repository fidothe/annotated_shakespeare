require 'nokogiri'

xml_file = File.open('/path/to/play.tei')
document = Nokogiri::XML(xml_file)
selector = 'teiHeader > fileDesc > titleStmt > title'
document.css(selector).text

selector = '/z:TEI/z:teiHeader/z:fileDesc/z:titleStmt/z:title'
ns = {'z' => 'http://www.tei-c.org/ns/1.0'}
document.xpath(selector, ns).text
