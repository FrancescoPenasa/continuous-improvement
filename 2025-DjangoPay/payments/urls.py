from django.urls import path

from . import views

app_name = "payments"

urlpatterns = [
    path("", views.index, name="index"),

    path("products/<int:product_id>/", views.detail, name="detail"),
    path("products/<int:product_id>/checkout", views.submit, name="submit"),
    path("orders/<int:order_id>/", views.checkout, name="checkout"),
]
