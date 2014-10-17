from django.conf.urls import patterns, include, url
from django.conf.urls.i18n import i18n_patterns
from django.views.generic import TemplateView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = i18n_patterns('',
    url(r'^$', TemplateView.as_view(template_name="visualization.html")),
    )
if getattr(settings,'DEBUG',False):
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
