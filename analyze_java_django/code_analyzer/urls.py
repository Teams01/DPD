from django.urls import path
from . import views

urlpatterns = [
    path('analyze/', views.analyze_java_code, name='analyze_java_code'),
    path('generate/', views.generate_java_classes, name='generate_java_classes'),
]
