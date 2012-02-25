--- 
title: Test your django-piston API (with auth)
tags:
    - django
---

I have to build the API for one of my web service. It is Django and
django-piston powered application and it works well. Okay. I chose the [TDD
technique](http://en.wikipedia.org/wiki/Test_Driven_Development).  So my
problem was: how do I test the API parts which need authentication (basic HTTP,
not OAuth for now)? The built-in test client of Django doesn't seem to have
such a feature.

So, here is my small workaround: you have to generate the `HTTP_AUTHORIZATION`
field of your HTTP request. I wrote a small base test class for tests which
need authentication:

~~~ python
import base64
import unittest
from django.test.client import Client

class BaseAuthenticatedClient(unittest.TestCase):
    def setUp(self):
        self.client = Client()
        auth = '%s:%s' % ('username', 'password')
        auth = 'Basic %s' % base64.encodestring(auth)
        auth = auth.strip()
        self.extra = {
            'HTTP_AUTHORIZATION': auth,
        }
~~~


You just have to replace *username* and *password*, and write your own test suite:

~~~ python
class TestAPIAuth(BaseAuthenticatedClient):

    def testrootauth(self):
        response = self.client.get('/api/aresource/id', {}, **self.extra)
        self.assertEqual(response.status_code, 200)
~~~

It should be OK. Have fun!
