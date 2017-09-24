Ethereum
========

## Softwares

__Mist DApp Browser__

Mist is the browser for decentralized web apps. 
What Mozilla Firefox or Google Chrome are for the Web 2.0, 
the Mist Browser will be for the Web 3.0 (which will be decentralized).

Mist is still in heavy development 
(for instance it's not recommended to visit untrusted DApps 
until the full security audit is done). 

__Ethereum Wallet DApp__

All other releases of 'Mist' are no Mist releases at all, 
but a bundle of Mist Browser with a single DApp: The Ethereum Wallet, 
also known as the Meteor DApp Wallet.

These releases are therefore called Ethereum Wallet as it only offers 
a bundle of the Mist browser with a single DApp: the wallet.

The future, with Metropolis release, 
will provide a full Mist Browser able to open 
any DApp available out there. 
The Ethereum wallet will only be one among them.

## Mining

<https://www.cryptocompare.com/mining/guides/how-to-mine-ethereum/>

Get GETH

<https://geth.ethereum.org/downloads/>

On Win, you should have the PC time perfectly synchronized.
Check this guide <https://www.tenforums.com/tutorials/6410-synchronize-clock-internet-time-server-windows-10-a.html>

Or...if not in a domain, from an admin console

    w32tm /resync

If in a domain 

    net time /domain

Synch with ETH

    geth --rpc --fast --cache=1024
    geth --rpc --support-dao-fork

    
Get Ethminer from <https://github.com/ethereum-mining/ethminer>    