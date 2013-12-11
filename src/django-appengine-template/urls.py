from django.conf.urls import patterns, include, url  # @UnresolvedImport

from django.contrib import admin
from application import views
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'application.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^$', views.index, name='index'),
#     url(r'^admin/', include(admin.site.urls)),
)
