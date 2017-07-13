Let's Encrypt
=============

Stage and prod environment

    letsencrypt certonly

<https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf>

    IMPORTANT NOTES:
     - Congratulations! Your certificate and chain have been saved at
       /etc/letsencrypt/live/miserve.danidemi.com/fullchain.pem. Your cert
       will expire on 2016-09-09. To obtain a new version of the
       certificate in the future, simply run Let's Encrypt again.
     - If you like Let's Encrypt, please consider supporting our work by:

       Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
       Donating to EFF:                    https://eff.org/donate-le

To renew

    letsencrypt renew --dry-run --agree-tos

    Processing /etc/letsencrypt/renewal/miserve.danidemi.com.conf
    2016-06-11 22:25:55,141:WARNING:letsencrypt.client:Registering without email!
    ** DRY RUN: simulating 'letsencrypt renew' close to cert expiry
    **          (The test certificates below have not been saved.)

    Congratulations, all renewals succeeded. The following certs have been renewed:
      /etc/letsencrypt/live/miserve.danidemi.com/fullchain.pem (success)
    ** DRY RUN: simulating 'letsencrypt renew' close to cert expiry
    **          (The test certificates above have not been saved.)

    IMPORTANT NOTES:
     - Your account credentials have been saved in your Let's Encrypt
       configuration directory at /etc/letsencrypt. You should make a
       secure backup of this folder now. This configuration directory will
       also contain certificates and private keys obtained by Let's
       Encrypt so making regular backups of this folder is ideal.
