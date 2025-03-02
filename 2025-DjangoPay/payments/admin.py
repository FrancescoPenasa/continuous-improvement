from django.contrib import admin

from .models import Product, Order, TimeSlot

admin.site.register(Product)
admin.site.register(Order)
admin.site.register(TimeSlot)
