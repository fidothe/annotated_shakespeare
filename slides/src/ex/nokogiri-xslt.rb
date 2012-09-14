require 'nokogiri'
document = Nokogiri::XML(File.open('/path/to/play.tei'))
xslt = Nokogiri::XSLT(File.open('/path/to/your.xsl'))
params = Nokogiri::XSLT.quote_params(['act_number', '2'])
xslt.transform(document, params)
