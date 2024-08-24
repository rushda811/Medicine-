from django.db import models

# Create your models here.
class login_table(models.Model):
    username=models.CharField(max_length=20)
    password=models.CharField(max_length=20)
    type=models.CharField(max_length=20)


class user_table(models.Model):
    LOGIN=models.ForeignKey(login_table,on_delete=models.CASCADE)
    firstname=models.CharField(max_length=50)
    lastname = models.CharField(max_length=50)
    phone_no= models.BigIntegerField()
    email = models.CharField(max_length=50)
    address = models.CharField(max_length=100)
    gender = models.CharField(max_length=50)


class medicine_table(models.Model):
    name=models.CharField(max_length=50)
    image = models.FileField()
    price = models.IntegerField()
    stock = models.IntegerField()
    details = models.CharField(max_length=100)
    mnf_date = models.DateField()
    exp_date = models.DateField()

class distributor_table(models.Model):
    LOGIN = models.ForeignKey(login_table, on_delete=models.CASCADE)
    firstname = models.CharField(max_length=50)
    lastname = models.CharField(max_length=50)
    phone_no = models.BigIntegerField()
    email = models.CharField(max_length=50)
    address = models.CharField(max_length=100)
    gender = models.CharField(max_length=50)
    post=models.CharField(max_length=90)
    pin=models.IntegerField()
    proof_id = models.FileField()



class distributor_stock_table(models.Model):
    DISTRIBUTOR = models.ForeignKey(distributor_table, on_delete=models.CASCADE)
    MEDICINE = models.ForeignKey(medicine_table,on_delete=models.CASCADE)
    stock=models.IntegerField()




class pharmacy_table(models.Model):
    LOGIN = models.ForeignKey(login_table, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    phone_no = models.BigIntegerField()
    email = models.CharField(max_length=50)
    location = models.CharField(max_length=100)
    pin = models.IntegerField()
    proof_id = models.FileField()
    post=models.CharField(max_length=20)

class distributorrequest_table(models.Model):
    LOGIN = models.ForeignKey(distributor_table, on_delete=models.CASCADE)
    MEDICINE = models.ForeignKey(medicine_table, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    date = models.DateField()
    status = models.CharField(max_length=100)

class distributor_medicine_table(models.Model):
    REQUEST = models.ForeignKey(distributorrequest_table, on_delete=models.CASCADE)
    MEDICINE = models.ForeignKey(medicine_table, on_delete=models.CASCADE)
    status = models.CharField(max_length=15)


class pharmacyrequest_table(models.Model):
    PHAARMACY = models.ForeignKey(pharmacy_table, on_delete=models.CASCADE)
    DISTRIBUTOR = models.ForeignKey(distributor_table, on_delete=models.CASCADE)
    MEDICINE = models.ForeignKey(medicine_table, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    date = models.DateField()
    status = models.CharField(max_length=50)


class pharmacy_medicine_table(models.Model):
    PHAARMACY = models.ForeignKey(pharmacyrequest_table, on_delete=models.CASCADE)
    MEDICINE = models.ForeignKey(distributor_medicine_table, on_delete=models.CASCADE)
    status=models.CharField(max_length=15)



class pharmacy_stock_table(models.Model):
    PHAARMACY = models.ForeignKey(pharmacy_table, on_delete=models.CASCADE)
    MEDICINE = models.ForeignKey(medicine_table,on_delete=models.CASCADE)
    stock=models.IntegerField()


class orders_table(models.Model):
    username=models.CharField(max_length=20)
    phone_no = models.BigIntegerField()
    total = models.IntegerField()
    date = models.DateField()
    email = models.CharField(max_length=50)
    status = models.CharField(max_length=500)

class order_details(models.Model):
    order_id=models.ForeignKey(orders_table, on_delete=models.CASCADE)
    medicine_id=models.ForeignKey(medicine_table, on_delete=models.CASCADE)
    quantity = models.IntegerField()

class order_medicine_details(models.Model):
    order_id=models.ForeignKey(orders_table, on_delete=models.CASCADE)
    medicine_id=models.ForeignKey(distributor_medicine_table, on_delete=models.CASCADE)
