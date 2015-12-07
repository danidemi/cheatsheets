# 


# Generate a Private Key

	openssl genrsa -des3 -out server.key 1024
	openssl genrsa -aes128 -passout pass:pazzword -out server.key 2048

# Generate a CSR (Certificate Signing Request)

	openssl req -new -key server.key -out server.csr
	openssl req -new -key server.key -out server.csr -subj "/C=IT/ST=Milan/L=Milan/O=DaniDemi/OU=IT Department/CN=miserve.com"

# Remove Passphrase from Key

	cp server.key server.key.org
	openssl rsa -in server.key.org -out server.key

# Generating a Self-Signed Certificate

	openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
	
# The following command loads a PEM encoded certificate in the jetty.crt file into a JSSE keystore:

	keytool -keystore keystore -import -alias miserve -file server.crt -trustcacerts	

# References

<http://www.akadia.com/services/ssh_test_certificate.html>
<http://www.shellhacks.com/en/HowTo-Create-CSR-using-OpenSSL-Without-Prompt-Non-Interactive>
<http://www.eclipse.org/jetty/documentation/current/configuring-ssl.html#loading-keys-and-certificates>

# Code

mkdir /tmp/keys
cd /tmp/keys
openssl genrsa -aes128 -passout pass:pazzword -out server.protected.key 2048
openssl rsa -passin pass:pazzword -in server.protected.key -out server.key
openssl req -new -key server.key -out server.csr -subj "/C=IT/ST=Milan/L=Milan/O=Studio DaniDemi/OU=IT Department/CN=miserve.com"
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
keytool -keystore keystore -import -alias miserve -file server.crt -trustcacerts -storepass pazzword
