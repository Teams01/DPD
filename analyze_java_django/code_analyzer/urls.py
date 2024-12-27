from django.urls import path
from . import views
from . import viewGemini

urlpatterns = [
    path('analyze/', views.analyze_java_code, name='analyze_java_code'),
    path('analyze_coupling/', views.analyze_Coupling, name='analyze_Coupling'),
    path('generate/', views.generate_java_classes, name='generate_java_classes'),
    path('analyze_repo/', viewGemini.analyze_repo, name='analyze_repo'),
]
