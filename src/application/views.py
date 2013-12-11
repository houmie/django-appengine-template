# Create your views here.
from django.http.response import HttpResponse
import django, logging


def index(request):
    return HttpResponse("Django version {0}.".format(django.get_version()) )