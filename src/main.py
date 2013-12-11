import os
import sys


sys.path.append(os.path.join(os.path.abspath('.'), 'lib'))

# import django.core.handlers.wsgi
from django.core.handlers.wsgi import WSGIHandler

application = WSGIHandler()

