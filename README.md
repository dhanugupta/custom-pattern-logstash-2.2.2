# custom-pattern-logstash-2.2.2
Custom Pattern Tomcat - Logstash 2.2.2 Dockerized Container

# Build Docker
docker build -t logstash .

#Run Docker
docker run -d --name logstash logstash

# Input filter
 - >Tomcat Logs are multiline codec => multiline
 - > max_lines => 500 ( make it more efficient)
 - > mutate - https://www.elastic.co/guide/en/logstash/current/plugins-filters-mutate.html
 
## More Log Patterns

--> https://github.com/logstash-plugins/logstash-patterns-core/tree/master/patterns

# Tomcat Log Example
2017-01-12 02:05:02,003 ERROR [http-nio-8080-exec-349]       c.a.c.c.ExceptionHandlerController - Handling OAuth2Exception: AuthenticationException, {} 
com.abc.authentication.AuthenticationException: Unable to get response from abc.aol.com for client_Id: ABC_CLIENT
	at com.abc.authorization.service.AuthenticationServiceImpl.getOAuth2Authentication(AuthenticationServiceImpl.java:42) ~[abc-auth-publish-1.0.127.jar:na]
	at com.abc.controller.TokenController.createAccessToken(TokenController.java:51) ~[abc-auth-publish-1.0.127.jar:na]
	at com.abc.controller.TokenController.createAccessTokenGet(TokenController.java:47) ~[abc-auth-publish-1.0.127.jar:na]
	at com.abc.controller.TokenController$$FastClassBySpringCGLIB$$8519078f.invoke(<generated>) ~[abc-auth-publish-1.0.127.jar:na]
    
# Parsed 
{
  "exceptionByMicroservice": [
    [
      "com.abc.authentication.AuthenticationException: Unable to get response from abc.aol.com for client_Id: ABC_CLIENT"
    ]
  ],
  "JAVACLASS": [
    [
      "com.abc.authentication.AuthenticationException",
      "abc.aol.com"
    ]
  ],
  "clientId": [
    [
      "ABC_CLIENT"
    ]
  ]
}

# Tomcat Log Example 2
2017-01-07 19:43:08,037 DEBUG [http-nio-8080-exec-10]       c.a.l.MappingJackson2RequestLogger - RequestLog : {"date":1483836188037,"serverName":"server.com","method":"GET","uri":"/location","remoteAddr":"0.0.0.0","forwardedFor":"0.0.0.0","parameters":{"zip":["93720"],"country":["US"]},"requestBody":"","responseStatus":200,"responseBody":"{\"country\":\"US\",\"state\":\"CA\",\"city\":\"Fresno\",\"zipCode\":\"93720\",\"county\":\"Fresno County\"}","responseLength":88,"userAgent":"Mozilla/5.0 (Windows NT 6.3; Win64; x64; Trident/7.0; Touch; MALNJS; rv:11.0) like Gecko","referer":"https://abc.com/","remoteLogs";:[],"attributes":{}}

# Parsed
{
  "DATE": [
    [
      "17-01-07"
    ]
  ],
  "DATE_US": [
    [
      null
    ]
  ],
  "MONTHNUM": [
    [
      null,
      "01"
    ]
  ],
  "MONTHDAY": [
    [
      null,
      "17"
    ]
  ],
  "YEAR": [
    [
      null,
      "07"
    ]
  ],
  "DATE_EU": [
    [
      "17-01-07"
    ]
  ],
  "TIME": [
    [
      "19:43:08"
    ]
  ],
  "HOUR": [
    [
      "19"
    ]
  ],
  "MINUTE": [
    [
      "43"
    ]
  ],
  "SECOND": [
    [
      "08"
    ]
  ],
  "INT": [
    [
      "037"
    ]
  ],
  "loglevel": [
    [
      "DEBUG"
    ]
  ],
  "requestData": [
    [
      "{"date":1483836188037,"serverName":"server.com","method":"GET","uri":"/location","remoteAddr":"0.0.0.0","forwardedFor":"0.0.0.0","parameters":{"zip":["93720"],"country":["US"]},"requestBody":"","responseStatus":200,"responseBody":"{\\"country\\":\\"US\\",\\"state\\":\\"CA\\",\\"city\\":\\"Fresno\\",\\"zipCode\\":\\"93720\\",\\"county\\":\\"Fresno County\\"}","responseLength":88,"userAgent":"Mozilla/5.0 (Windows NT 6.3; Win64; x64; Trident/7.0; Touch; MALNJS; rv:11.0) like Gecko","referer":"https://abc.com/","remoteLogs";:[],"attributes":{}}"
    ]
  ]
}

