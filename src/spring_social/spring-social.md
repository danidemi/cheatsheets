# Spring Social Cheat Sheet

## Big Picture

* Social Integration
	* Facebook is the service provider
	* the movie club application is the service consumer
	* Paul is the user of both

* Social integration is a three-way conversation between
	* a service provider (i.e. Facebook) 
	* a service consumer (i.e. Movie Forum) 
	* a user who holds an account on both the provider and consumer (i.e. Paul)

* Spring Social
	* Connect Framework that handles the core authorization and connection flow with service providers
	* Connect Controller that handles the OAuth exchange between a service provider, consumer, and user in a web application environment
	* A Signin Controller that allows users to authenticate with your application by signing in with their Provider accounts, such as their Twitter or Facebook accounts.

* Provider-based authentication
	* The user signs into (or may already be signed into) his or her provider account. 
	* The application then tries to match that provider account to a local user account. 
		* If a match is found, the user is automatically signed into the application.

* Authentication
	* ProviderSignInController (if one doesn’t use Spring Security)
	* SocialAuthenticationFilter (if one use Spring Security)

## Architecture

* The spring-social-core module includes a Service Provider Connect Framework
	* establish connections between local user accounts and accounts those users have with external service providers
	* Once a connection is established, it can be be used to obtain a strongly-typed Java binding to the ServiceProvider’s API, giving your application the ability to invoke the API on behalf of a user
	
### ServiceProvider
Object that wraps the API of the provider, i.e. Facebook API, Twitter API, etc...

### Connection<ServiceProvider> 
interface models a connection to an external service provider such as Facebook
methods as

~~~~~~~~~~~~~~~~~~~~~~{.java}
ConnectionKey getKey();
String getDisplayName();
String getProfileUrl();
String getImageUrl();
void sync(); => Updates the profile
boolean test();
boolean hasExpired();
<ServiceProvider> getApi(); // Api for the ServiceProvider
ConnectionData createData(); // returns a storable representation of this connection
~~~~~~~~~~~~~~~~~~~~~~

### ConnectionKey
Uniquely identifies the connection

### Authorization Protocol (Concept)
Not a class, just a concept.

*The ways a ServiceProvider authorize a user:
	* OAuth
	* OAuth2
	* etc...

### Authorization Scope (Concept)
Not a class, just a concept.

What a Service Consumer wants to do

* Post messages on the user’s wall
* update statuses
* etc...

### ConnectionFactory
Encapsulates the construction of connections that use a specific authorization protocol

### OAuth2ConnectionFactory < ConnectionFactory
Connection Factory for OAuth2 based connections.

### OAuth1ConnectionFactory < ConnectionFactory
Connection Factory for OAuth1 based connections.

### FacebookConnectionFactory < OAuth2ConnectionFactory < ConnectionFactory
Connection Factory for Facebook connections, that is based on OAuth2.

### ConnectionFactoryLocator
This creates a registry of connection factories that other objects can use to lookup connection factories dynamically.
methods

### ConnectionFactory<?> getConnectionFactory(String providerId);

~~~~~~~~~~~~~~~~~~~~~~{.java}
<A> ConnectionFactory<A> getConnectionFactory(Class<A> apiType);
Set<String> registeredProviderIds();
~~~~~~~~~~~~~~~~~~~~~~

### ConnectionRepository
Persists connections of a single user for later use

### UsersConnectionRepository
A data access interface for managing a global store of users connections to service providers.
Provides data access operations that apply across multiple user records.

### JdbcUsersConnectionRepository < UsersConnectionRepository
persisting connections to a RDBMS.

Script are in `/org/springframework/social/connect/jdbc/JdbcUsersConnectionRepository.sql` 
but you should possibly adapt it to your RDBMS

### ConnectController

As ConnectController directs the overall connection flow, it depends on several other objects to do its job.

* It needs
	* at least 1 ConnectionFactory
		* JdbcConnectionRepository
		* InMemoryConnectionRepository
	* 1 org.springframework.social.connect.ConnectionRepository
* What it does ?
	* Delegates to one or more ConnectionFactory instances to establish connections to providers on behalf of users. 
	* Once a connection has been established, it delegates to a ConnectionRepository to persist user connection data. Therefore, we’ll also need to configure one or more ConnectionFactorys and a ConnectionRepository.

### UserIdSource
Unique Id of a User

### AuthenticationNameUserIdSource < UserIdSource

### ConnectInterceptor
Filter around a connection

~~~~~~~~~~~~~~~~~~~~~~{.java}
void preConnect(ConnectionFactory<A> connectionFactory, MultiValueMap<String, String> parameters, WebRequest request);
void postConnect(Connection<A> connection, WebRequest request);
~~~~~~~~~~~~~~~~~~~~~~

### SocialAuthenticationFilter
Manage sign in through SpringSecuirty

### SocialUserDetailsService
Similar to UserDetailsService (from Spring Security) but loads details by user id, not username

### SocialUserDetails < UserDetails (from Spring Security)
An "extended" UserDetails that store also how a user is recognized in a provider.

![Architecture](architecture.png)

## Sign In

SocialAuthenticationFilter reacts to requests whose path fits a pattern of "/auth/{providerid}". 
Therefore, to initiate a provider sign-in flow via SocialAuthenticationFilter, you can simply provide a link to "/auth/{providerid}" on a web page.

### Flows
#### Provider using OAuth 2

* POST /signin/{providerId} - Initiates the sign in flow by redirecting to the provider's authentication endpoint.
* GET /signin/{providerId}?code={verifier} - Receives the authentication callback from the provider, accepting a code. Exchanges this code for an access token. Using this access token, it retrieves the user's provider user ID and uses that to lookup a connected account and then authenticates to the application through the sign in service.
	* If the provider user ID doesn't match any existing connection, ProviderSignInController will redirect to a sign up URL. The default sign up URL is "/signup" (relative to the application root), but can be customized by setting the signUpUrl property.
	* If the provider user ID matches more than one existing connection, ProviderSignInController will redirect to the application's sign in URL to offer the user a chance to sign in through another provider or with their username and password. The request to the sign in URL will have an "error" query parameter set to "multiple_users" to indicate the problem so that the page can communicate it to the user. The default sign in URL is "/signin" (relative to the application root), but can be customized by setting the signInUrl property.
	* If any error occurs while fetching the access token or while fetching the user's profile data, ProviderSignInController will redirect to the application's sign in URL. The request to the sign in URL will have an "error" query parameter set to "provider" to indicate an error occurred while communicating with the provider. The default sign in URL is "/signin" (relative to the application root), but can be customized by setting the signInUrl property.
#### OAuth 1 Providers

* POST /signin/{providerId} - Initiates the sign in flow. This involves fetching a request token from the provider and then redirecting to Provider's authentication endpoint.
	* If any error occurs while fetching the request token, ProviderSignInController will redirect to the application's sign in URL. The request to the sign in URL will have an "error" query parameter set to "provider" to indicate an error occurred while communicating with the provider. The default sign in URL is "/signin" (relative to the application root), but can be customized by setting the signInUrl property.
* GET /signin/{providerId}?oauth_token={request token}&oauth_verifier={verifier} - Receives the authentication callback from the provider, accepting a verification code. Exchanges this verification code along with the request token for an access token. Using this access token, it retrieves the user's provider user ID and uses that to lookup a connected account and then authenticates to the application through the sign in service.
	* If the provider user ID doesn't match any existing connection, ProviderSignInController will redirect to a sign up URL. The default sign up URL is "/signup" (relative to the application root), but can be customized by setting the signUpUrl property. here you can hook the "implicit signup" command.
	* If the provider user ID matches more than one existing connection, ProviderSignInController will redirect to the application's sign in URL to offer the user a chance to sign in through another provider or with their username and password. The request to the sign in URL will have an "error" query parameter set to "multiple_users" to indicate the problem so that the page can communicate it to the user. The default sign in URL is "/signin" (relative to the application root), but can be customized by setting the signInUrl property.

## Implicit SignUp

* Write an implementation of ConnectionSignUp
* Inject it into the connection repository

public class AccountConnectionSignUp implements ConnectionSignUp {

~~~~~~~~~~~~~~~~~~~~~~{.java}
private final AccountRepository accountRepository;

public AccountConnectionSignUp(AccountRepository accountRepository) {
	this.accountRepository = accountRepository;
}

public String execute(Connection<?> connection) {
	UserProfile profile = connection.fetchUserProfile();
	Account account = new Account(profile.getUsername(), profile.getFirstName(), profile.getLastName());
	accountRepository.createAccount(account);
	return account.getUsername();
}
~~~~~~~~~~~~~~~~~~~~~~

## Connection
The path pattern that ConnectController handles is "/connect/{providerId}". 
* Therefore, if ConnectController is handling a request for "/connect/twitter", 
* then the ConnectionFactory whose getProviderId() returns "twitter" will be used. 
* ConnectController constructs a callback URL for the provider to redirect to after the user grants authorization.


### Flows
####OAuth2 Paths

* GET /connect - Displays a web page showing connection status for all providers.
	* ConnectController respond with a view that has URL
		* connect/status
* GET /connect/{providerId} - Displays a web page showing connection status to the provider. 
	* ConnectController respond with a view URL depending on the connection status
		* connect/{providerId}Connect (if already connected)
		* connect/{providerId}Connected (if not yet connected)
* POST /connect/{providerId} - Initiates the connection flow with the provider.
	* You should POST fields containing the Authorizations Scopes
		* Facebook Example

~~~~~~~~~~~~~~~~~~~~~~{.html}
<input type="hidden" name="scope" value="publish_stream,offline_access" />
~~~~~~~~~~~~~~~~~~~~~~

		* https://developers.facebook.com/docs/facebook-login/permissions/v2.2?locale=it_IT
		* Free to use
			* public_profile
			* email
			* user_friends
		* Requires authorizations from FB
			* user_place_visits
			* age_range
			* user_birthday
			* publish_actions
	* GET /connect/{providerId}?code={code} - Receives the authorization callback from the provider, accepting an authorization code. Uses the code to request an access token and complete the connection.
	* DELETE /connect/{providerId} - Severs all of the user’s connection with the provider.
	* DELETE /connect/{providerId}/{providerUserId} - Severs a specific connection with the provider, based on the user’s provider user ID.
OAuth1 provider
	* GET /connect - Displays a web page showing connection status for all providers.
	* GET /connect/{providerId} - Displays a web page showing connection status to the provider.
	* POST /connect/{providerId} - Initiates the connection flow with the provider. 
	* GET /connect/{providerId}?oauth_token={request token}&oauth_verifier={verifier}
		* Receives the authorization callback from the provider, accepting a verification code. Exchanges this verification code along with the request token for an access token and completes the connection. The oauth_verifier parameter is optional and is only used for providers implementing OAuth 1.0a.
	* DELETE /connect/{providerId} - Severs all of the user’s connection with the provider.
	* DELETE /connect/{providerId}/{providerUserId} - Severs a specific connection with the provider, based on the user’s provider user ID.

## Set Up

### Maven

#### Basic Dependencies

	<dependency>
		<groupId>org.springframework.social</groupId>
		<artifactId>spring-social-core</artifactId>
		<version>1.1.0.RELEASE</version>
	</dependency>
	
	<dependency>
		<groupId>org.springframework.social</groupId>
		<artifactId>spring-social-config</artifactId>
		<version>1.1.0.RELEASE</version>
	</dependency>
	
	<dependency>
		<groupId>org.springframework.social</groupId>
		<artifactId>spring-social-security</artifactId>
		<version>1.1.0.RELEASE</version>
	</dependency>            
	
	<dependency>
		<groupId>org.apache.httpcomponents</groupId>
		<artifactId>httpclient</artifactId>
		<version>4.3.6</version>
	</dependency>
	
#### Twitter

	<dependency>
		<groupId>org.springframework.social</groupId>
		<artifactId>spring-social-twitter</artifactId>
		<version>1.1.0.RELEASE</version>
	</dependency>
	
#### Facebook

	<dependency>
		<groupId>org.springframework.social</groupId>
		<artifactId>spring-social-facebook</artifactId>
		<version>1.1.0.RELEASE</version>
	</dependency>

## Database
If you want to store info on a db, you have to execute the script stored in spring-social-core.sql

~~~~~~~~~~~~~~~~~~~~~~{.sql}
create table UserConnection (userId varchar(255) not null,
    providerId varchar(255) not null,
    providerUserId varchar(255),
    rank int not null,
    displayName varchar(255),
    profileUrl varchar(512),
    imageUrl varchar(512),
    accessToken varchar(255) not null,
    secret varchar(255),
    refreshToken varchar(255),
    expireTime bigint,
    primary key (userId, providerId, providerUserId));
create unique index UserConnectionRank on UserConnection(userId, providerId, rank);
~~~~~~~~~~~~~~~~~~~~~~

Spring Context

~~~~~~~~~~~~~~~~~~~~~~{.xml}
    <security:http>
        <security:intercept-url pattern="/app/admin/**" access="ROLE_ADMIN"/>
        <security:intercept-url pattern="/admin/**" access="ROLE_ADMIN"/>
        <security:custom-filter ref="socialAuthenticationFilter" before="PRE_AUTH_FILTER" />
        <security:form-login
            login-page="/security-sign-in.html"
            authentication-failure-url="/security-sign-in.html?param.error=bad_credentials" />
        <security:logout logout-url="/security-sign-out.html"/>
    </security:http>
~~~~~~~~~~~~~~~~~~~~~~

## Needed Customization

It is reasonable to think that your app will possibly use a completely different table to store "security" users, even though it can be reasonable to imagine to use the default "social" user table.

In such scenario

interface UserDetailsManager from Spring Security

You should provide an implementation of this interface that works with your underlying storage. 

It provides CRUD operations using "username" as the key to identify the user.

Here "username" means the clear text string that the user use to login.

It could be the email in some systems.

It could be a plain username.

Could it be both ? In Twitter, after all, you log in with both your email or twitter username.

Let users identify themselves by both email and username

Assign to each user an unique synthetic key, and use two fields both unique: username and email.

interface SocialUserDetailsService from Spring Social

You should provide an implementation of this interface that works with your underlying storage.

It provides just a 
SocialUserDetails loadUserByUserId(String userId)
Here "user id" is whatever you use to uniquely identify yous "social" users. 
So, if your "social" users are identified by a synthetic key, this method means loadUserByUserId(Stirng syntheticKey)
If you are able to retrieve a "security" user from UserDetailsManager, you can create a "social" SocialUserDetails just like that…

~~~~~~~~~~~~~~~~~~~~~~{.xml}
        SocialUserDetails sud = new SocialUser(
                securityUserDetails.getUsername(), 
                securityUserDetails.getPassword(), 
                securityUserDetails.getAuthorities());
~~~~~~~~~~~~~~~~~~~~~~

if you wants to support "social" from the beginning, is reasonable to implement UserDetailsManager and SocialUserDetailsService in a unique class.

