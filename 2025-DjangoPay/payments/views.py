import logging

from django.shortcuts import render, get_object_or_404
from django.urls import reverse

from django.views.generic import TemplateView, ListView, DetailView
from django.shortcuts import render
from django.http import HttpResponse, Http404, HttpResponseRedirect

from payments.models import Product, Order, TimeSlot

logger = logging.getLogger(__name__)

def index(request):
    output = "ciaone"
    return HttpResponse(output)

# get
def detail(request, product_id):
    logger.warning("test warning")
    logger.info("test info")
    logger.debug("test debug")
    product = get_object_or_404(Product, pk=product_id)
    return render(request, "payments/detail.html", {"product":product, "timeslots":TimeSlot.objects.filter(product=product)})
    # try:
    #     return HttpResponse("aaa")
    # except Product.DoesNotExist:
    #     raise Http404("Product does not exist")

def submit(request, product_id):
    product = get_object_or_404(Product, pk=product_id)

    if request.method == "POST":
        try:
            # Retrieve form data
            logger.warning("test warning")
            logger.info("test info")
            logger.debug("test debug")
            logger.warning(request.POST)

            participants = int(request.POST.get("participants", 1))  # Default to 1
            timeslot_id = request.POST.get("timeslot")  # Assume timeslot selection
            timeslot = get_object_or_404(TimeSlot, pk=timeslot_id) if timeslot_id else None

            # Validate input
            if participants < 1:
                raise ValueError("Invalid number of participants.")

            # Extract user details (modify as needed)
            # customer_name = request.user.get_full_name() if request.user.is_authenticated else ""
            # customer_email = request.user.email if request.user.is_authenticated else ""

            # Calculate order amount
            amount = product.full_price * participants

            # Create and save the order
            order = Order(
                product=product,
                participants=participants,
                timeslot=timeslot,
                # customer_name=customer_name,
                # customer_email=customer_email,
                amount=amount
            )
            order.generate_secret()  # Generate a unique secret for the order
            order.save()  # Save the order

            # Redirect to checkout
            return HttpResponseRedirect(reverse("payments:checkout", args=(order.id,)))

        except (KeyError, ValueError) as e:
            return render(
                request,
                "payments/detail.html",
                {
                    "product": product,
                    "error_message": str(e),
                },
            )

    else:
        return render(request, "payments/detail.html", {"product":product})


def checkout(request, order_id):
    try:
        order = Order.objects.get(pk=order_id)

        output = "ciaone"
        return HttpResponse(output + f"${order.amount}")
        # return render(request, "payments/detail.html", {"order":order})
    except Order.DoesNotExist:
        raise Http404("Order does not exist")


# # Create your views here.
# def MyTemplateView(request):
#     pass
#
#
# class MyTemplateView(TemplateView):
#     template_name = "my_template.html"
#
#
# class MyModelDetailView(ListView):
#     model = Product
#
#
# class MyModelDetailView(DetailView):
#     model = Product