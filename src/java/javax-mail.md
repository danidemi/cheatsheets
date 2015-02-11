## Big Picture

Session
The Session class represents a mail session and is not subclassed.
A single default session can be shared by multiple applications on the desktop. 
Unshared sessions can also be created.

Store
An abstract class that models a message store and its access protocol, for storing and retrieving messages. Subclasses provide actual implementations.
i.e. IMAPStore

Transport
n abstract class that models a message transport. Subclasses provide actual implementations.
i.e. SMTPTransport
