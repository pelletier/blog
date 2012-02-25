---
title: Mixing Django Forms
layout: post
tags:
    - django
---

So you ever wanted to mix a simple Django form (subclass of
`django.forms.Form`) and a model form (subclass of `django.forms.ModelForm`)?

[TL;DR](#the-result).

## Some background

I was coding a website which has an email-based authentication backend (for the
record it is based on
[this snippet](http://www.micahcarrick.com/django-email-authentication.html)).
Such a design decision implies that you have to take care of multiple things,
and among them the forms. Django authentication system
[provides](https://code.djangoproject.com/browser/django/trunk/django/contrib/auth/forms.py)
multiple default forms for login, password editing and so on. They perfectly fit
the default situation (basic user name and password authentication), but they
have to be tweak in any other case. However I didn't wanted to rewrite my forms
from scratch, so obviously after a quite intense inheriting session, I found
myself having some highly refactorable code, mainly because I always needed to
add an `email` form field. My first idea was to create a simple `object`
subclass which just contains the field and its validation method, and make all
my forms inheriting from this proxy class (definitely not sure it's a good name
for it, suggestions?). I knew that Django forms are more complicated than that
in their way to "discover" fields, yet I tried. Yeah, it didn't work. Next idea:
if would be logical that we can inherit forms, and even merge them using
multiple inheritance. So I adjusted my code and made my "proxy" class inherit
from `django.forms.Form`. Well, it almost worked: things went well when a `Form`
inherited from the proxy class, but went wrong whenever a `ModelForm` was
involved. Obviously, in the documentation lie Truth and Wisdom:

> For technical reasons, a subclass cannot inherit from both a ModelForm and
> a Form simultaneously.
> 
> [Django documentation, ModelForms, Form inheritance](https://docs.djangoproject.com/en/dev/topics/forms/modelforms/#form-inheritance)

The "for technical reasons" excuse reminds me the "we can't because of security"
which unskilled sysadmins tell you when they are incapable of doing something
you politely asked them. So my first – horribly harmful – reflex was to search
the Internet for a solution. I quickly found
[Alex Gaynor's talk](http://www.slideshare.net/kingkilr/forms-getting-your-moneys-worth)
about combining Django forms. Nice solution. But 1) I'm too lazy for
reimplementing the form API and 2) I don't very like the code style this code
involves, unless I'm missing something:

~~~ python
# From the slides...
class UserForm(form.ModelForm):
    class Meta:
        model = User

class ProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile


UserProfile = multipleform_factory({
    'user': UserForm,
    'profile': ProfileForm,
}, ['user', 'profile'])

# And now I want to tweak the save() method...

def user_profile_save(self)
    pass

UserProfile.save = user_profile_save
~~~

So I dived in the source code of Django, created a
[patch queue on Bitbucket](https://bitbucket.org/pelletier/django-hack/) and
I was ready to hack.


## The result

(I removed the tests. You can get
[the full patch on bitbucket](https://bitbucket.org/pelletier/django-hack/src/4758a005e648/modelform_metaclass.patch))

~~~ diff
# HG changeset patch
# Parent f4f68695f8e007ef70b438c5cf653bc43cd7f2ca

diff -r f4f68695f8e0 django/forms/models.py
--- a/django/forms/models.py	Fri Sep 02 03:47:49 2011 +0000
+++ b/django/forms/models.py	Sat Sep 03 18:18:14 2011 +0200
@@ -12,7 +12,7 @@
 from django.utils.translation import ugettext_lazy as _, ugettext
 
 from util import ErrorList
-from forms import BaseForm, get_declared_fields
+from forms import BaseForm, get_declared_fields, Form, DeclarativeFieldsMetaclass
 from fields import Field, ChoiceField
 from widgets import SelectMultiple, HiddenInput, MultipleHiddenInput
 from widgets import media_property
@@ -181,8 +181,7 @@
         self.exclude = getattr(options, 'exclude', None)
         self.widgets = getattr(options, 'widgets', None)
 
-
-class ModelFormMetaclass(type):
+class ModelFormMetaclass(DeclarativeFieldsMetaclass):
     def __new__(cls, name, bases, attrs):
         formfield_callback = attrs.pop('formfield_callback', None)
         try:
@@ -191,6 +190,10 @@
             # We are defining ModelForm itself.
             parents = None
         declared_fields = get_declared_fields(bases, attrs, False)
+
+        simple_bases = [b for b in bases if issubclass(b, Form)]
+        declared_fields.update(get_declared_fields(simple_bases, attrs))
+
         new_class = super(ModelFormMetaclass, cls).__new__(cls, name, bases,
                 attrs)
         if not parents:
~~~

So now I can do things like this:

~~~ python
from django import forms
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, PasswordChangeForm



class ProxyWithEmail(forms.Form):
    """Proxy form to add the email field to the form (with validation)."""

    email = forms.EmailField(label='Email address', max_length=75,
                             required=True)

    def clean_email(self):
        email = self.cleaned_data["email"]
        if hasattr(self, 'user') and self.user.email == email:
            return email
        try:
            User.objects.get(email=email)
            raise forms.ValidationError("This email address already exists. Did you forget your password?")
        except User.DoesNotExist:
            return email


class RegisterForm(UserCreationForm, ProxyWithEmail):
    """Require email address when a user registers."""

    class Meta:
        model = User
        fields = ('username', 'email',) 

    def save(self, commit=True):
        user = super(UserCreationForm, self).save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        user.email = self.cleaned_data["email"]
        user.is_active = True
        if commit:
            user.save()
            user = authenticate(username=user.email,
                                password=self.cleaned_data["password1"])
        return user


class EditAccountForm(PasswordChangeForm, ProxyWithEmail):
    new_password1 = forms.CharField(label="New password",
                                    widget=forms.PasswordInput,
                                    required=False)
    new_password2 = forms.CharField(label="New password confirmation",
                                    widget=forms.PasswordInput,
                                    required=False)
    def save(self, commit=True):
        self.user.email = self.cleaned_data['email']
        if self.cleaned_data['new_password1']:
            self.user.set_password(self.cleaned_data['new_password1'])
        if commit:
            self.user.save()
        return self.user
~~~

Nice isn't it?


## Conclusion

I know, hacking the framework for such a thing is definitely **not** in the good
practices guide, and my patch is far from just good. However in my opinion there
is something to do about Django forms, and I hope this patch will be the
beginning of a reflexion about an improvement plan for Django forms.

Any comment, tip, idea, constructive criticism and hatred letters are highly
appreciated!
