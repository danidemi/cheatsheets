## Http

### Multipart

* HTTP multipart request
	* HTTP request that 
		* HTTP clients construct to 
			* send files and data over to a HTTP Server
			* commonly used by browsers and HTTP clients to upload files to the server.

Shape of a multipart request

	POST /cgi-bin/qtest HTTP/1.1
	Host: aram
	User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.10) Gecko/2009042316 	Firefox/3.0.10
	Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
	Accept-Language: en-us,en;q=0.5
	Accept-Encoding: gzip,deflate
	Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
	Keep-Alive: 300
	Connection: keep-alive
	Referer: http://aram/~martind/banner.htm
	Content-Type: multipart/form-data; boundary=---------------------------287032381131322
	Content-Length: 582
	
	-----------------------------287032381131322
	Content-Disposition: form-data; name="datafile1"; filename="r.gif"
	Content-Type: image/gif
	
	GIF87a.............,...........D..;
	-----------------------------287032381131322
	Content-Disposition: form-data; name="datafile2"; filename="g.gif"
	Content-Type: image/gif
	
	GIF87a.............,...........D..;
	-----------------------------287032381131322
	Content-Disposition: form-data; name="datafile3"; filename="b.gif"
	Content-Type: image/gif
	
	GIF87a.............,...........D..;
	-----------------------------287032381131322--