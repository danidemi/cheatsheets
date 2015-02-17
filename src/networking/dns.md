## DNS

* translates domain names (i.e. google.com) 
* to a corresponding numerical IP addresses

DNS 
* distributes the responsibility 
* designating authoritative name servers for each domain

### Resource Record

* Resource Record Fields
* **NAME** fully qualified domain name of the node in the tree
* **TYPE** gives a hint of its intended use
	* **A** translate from a domain name to an IPv4 address 
	* **NS** lists which name servers can answer lookups on a DNS zone
	* **MX** specifies the mail server used to handle mail for a domain specified in an e-mail address
* **RDATA** is data of type-specific relevance
	* If **TYPE=A** the IP address
	* If **TYPE=MX** priority and hostname for MX records
* **CLASS** set to IN (Internet) for common DNS records involving Internet

### A Record

* A (Address)
* host address (A record)

|NAME |TYPE |RDATA |CLASS |
|-----|-----|------|------|
|host  |A  |IP   |the amount of time your record will stay in cache on systems requesting your record in sec|

example

	NAME           TTL	TYPE  DATA
	www.example.com. 1800 A    192.168.1.2

### MX Record

* mail exchanger record (MX record)
	* resource record in the Domain Name System 
	* specifies 
		* a mail server responsible for accepting email messages on behalf of a recipient's domain 			
		* preference value used to prioritize mail delivery if multiple mail servers are available 
	* Use
		* set of MX records of a domain name specifies how email should be routed with the Simple Mail Transfer Protocol (SMTP)
		* used by mail servers to determine where to deliver email. 
		* MX records should only map to A records (not CNAME records). 
		* If an MX record is missing for the domain the mail for the domain will normally be attempted to be delivered to the matching A record.

|NAME |TYPE |RDATA |CLASS |
|-----|-----|------|------|
|Host or blank  |MX  |The mail server   |???   |

Example

	NAME         TTL   TYPE   DATA
	Blank or @   10    MX     xASPMX2.GOOGLEMAIL.COM.

#### Mail Delivery

1. User send a mail from `a.eng.sun.com` to `b.ucsb.edu`.
2. The MTA on `a.eng.sun.com` looks up the MX record for `b.ucsb.edu`
3. MX record tells to route the message to `venus.sun.com`. 
4. The MTA on `venus.sun.com` looks up the MX record for `b.ucsb.edu`, which tells it to route the message to `hub.ucsb.edu`. 
5. The MTA on `hub.ucsb.edu` looks up the MX record for `b.ucsb.edu`, which tells it to route the message directly to `b.ucsb.edu`. 
6. The MTA on `b.ucsb.edu` recognizes that the message has arrived at its intended destination and processes the message for local delivery.

### TXT Record

* TXT Record (Text Record)
	* holds free form text of any type 
	* a domain name may have many TXT records
	* usage
		* Sender Policy Framework (SPF) 
		* DomainKeys (DK)
		* DomainKeys Identified E-mail (DKIM)

|NAME |TYPE |RDATA |CLASS |
|-----|-----|------|------|
|Host  |TXT  |some text   |IN   |

### Tools

DIG

#### References
<http://tools.ietf.org/html/rfc1035>
<http://en.wikipedia.org/wiki/List_of_DNS_record_types>
<http://support.name.com/entries/21077306-What-is-an-MX-record->
<http://www.google.com/support/enterprise/static/postini/docs/admin/en/activate/mx_faq.html>


