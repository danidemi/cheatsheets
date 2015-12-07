# Overview

Locally a (dev-private-key, dev-public-key) pair is generated.

The dev-private-key is kept secret.

Locally, a dev-certificate-signing-request is generated.
dev-certificate-signing-request contains dev-identification signed with dev-private-key and dev-public-key.

The CA reveices the dev-certificate-signing-request
extract the dev-public-key
uses dev-public-key to decrypt dev-identification
check dev-identification
a dev-certificate is generated
dev-certificate contains the dev-identification, dev-public-key, signed with ca-private-key

when tom checks the dev-certificate,
it uses ca-public-key to decrypt dev-certificate
obtains dev-identification, dev-public-key
using dev-public-key it can decrypt content encrypted using dev-private-key