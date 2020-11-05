from django.contrib import admin
from django.urls import include, path
from accounts import views

urlpatterns = [
	path('connect', views.connect, name='connect'),
	# path('home/', views.home, name='home'),
	# path('home1/', views.home1, name='home1'),
]