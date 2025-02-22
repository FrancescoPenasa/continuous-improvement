import random

from django.db import models


# - prodotto: orario, giorno, prezzo, min_partecipanti, max_partecipanti, min_age, where, discount
class Product(models.Model):
	"""
	Product model
	"""
	# group by name?
	# id = models.AutoField(primary_key=True)
	name = models.CharField(max_length=100)
	description = models.TextField()

	full_price = models.DecimalField(max_digits=10, decimal_places=2)

	# discount e altre robe

	def __str__(self):
		return self.name


class TimeSlot(models.Model):
	"""
	TimeSlot model
	"""
	start = models.DateTimeField()
	end = models.DateTimeField()

	product = models.ForeignKey(Product, on_delete=models.PROTECT, default=1)

	assert start < end

	def __str__(self):
		return f"{self.start.year}-{self.start.month}-{self.start.day} {self.start.hour}:{self.start.minute:02d}-{self.end.hour}:{self.end.minute:02d}"


# todo add foreing key to product
class Order(models.Model):
	"""
	order model
	"""
	product = models.ForeignKey(Product, on_delete=models.PROTECT, default=1)
	participants = models.IntegerField(default=0)
	timeslot = models.ForeignKey(TimeSlot, on_delete=models.PROTECT, default=1)

	customer_name = models.CharField(max_length=100, default="")
	customer_email = models.CharField(max_length=100, default="")

	amount = models.DecimalField(default=0, max_digits=10, decimal_places=2)
	is_paid = models.BooleanField(default=False)

	secret = models.CharField(max_length=1000, default="", blank=True)
	checkout_url = models.CharField(max_length=1000, default="", blank=True)

	def generate_secret(self):
		self.secret = str(random.randint(10000, 99999))

# SELECT capacity - COALESCE(SUM(seats), 0) AS remaining_seats
# FROM timeslots
# LEFT JOIN orders ON timeslots.id = orders.timeslot_id
# WHERE timeslots.id = {selected_timeslot_id}
# GROUP BY timeslots.capacity;
