from datetime import datetime

import qrcode
from django.contrib import auth
from django.contrib.auth.decorators import login_required
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse
from django.shortcuts import render, redirect
from web3 import Web3, HTTPProvider
# truffle development blockchain address
blockchain_address = 'http://127.0.0.1:7545'
# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))
# Set the default account (so we don't need to set the "from" for every transaction call)
web3.eth.defaultAccount = web3.eth.accounts[0]
compiled_contract_path = r"C:\Users\fathi\PycharmProjects\medicine_authentication\node_modules\.bin\build\contracts\Structreq.json"
# Deployed contract address (see `migrate` command output: `contract address`)
deployed_contract_address = '0xAB585F2AdccB3c4986a57c56efd9b28f5f777684'
# Create your views here.
from med_app.models import *
def main(request):
    return render(request,'loginindex.html')
def logout(request):
    auth.logout(request)
    return render(request,'loginindex.HTML')
def logincode(request):
    try:
        uname=request.POST['textfield']
        pswrd=request.POST['textfield2']
        ob=login_table.objects.get(username=uname,password=pswrd)
        if ob.type == 'admin':
            request.session['lid']=ob.id
            ob1=auth.authenticate(username='admin',password='123')
            if ob1 is not None:
                auth.login(request,ob1)
            return HttpResponse('''<script>window.location="/ADMINHOME"</script>''')
        elif ob.type == 'pharmacy':
            ob1 = auth.authenticate(username='admin', password='123')
            if ob1 is not None:
                auth.login(request, ob1)
            request.session['lid']=ob.id
            return HttpResponse('''<script>;window.location="/PHARMACYHOME"</script>''')

        elif ob.type == 'distributor':
            ob1 = auth.authenticate(username='admin', password='123')
            if ob1 is not None:
                auth.login(request, ob1)
            request.session['lid'] = ob.id
            return HttpResponse('''<script>window.location="/DISTRIBUTORHOME"</script>''')
        else:
            return HttpResponse('''<script> alert("invalid username or password");window.location="/"</script>''')
    except Exception as e:
        print(e)
        return HttpResponse('''<script> alert("invalid username or password");window.location="/"</script>''')

@login_required(login_url='/')
def ACCEPTREJECTDISTRIBUTOR(request):
    ob=distributor_table.objects.all()
    return render(request,'ADMIN/ACCEPTREJECT DISTRIBUTOR.HTML',{'val':ob})

@login_required(login_url='/')

def ACCEPTREJECTDISTRIBUTOR_REQUEST(request):
    ob=distributorrequest_table.objects.filter(status='pending')
    return render(request,'ADMIN/ACCEPTREJECT_REQUEST.HTML',{'val':ob})
@login_required(login_url='/')

def Accept_dis_req(request,id):
    ob=distributorrequest_table.objects.get(id=id)
    ob.status="accepted"
    ob.save()

    med=ob.MEDICINE
    q=int(ob.quantity)
    dis=ob.LOGIN


    with open(
            r'C:\Users\fathi\PycharmProjects\medicine_authentication\node_modules\.bin\build\contracts\Structreq.json') as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
    contract = web3.eth.contract(address='0xBDbAD63D2BD89b9E92b9839Ac53EC9D57Aeed355', abi=contract_abi)
    for i in range(q):
        obpq=distributor_medicine_table()
        obpq.MEDICINE=med
        obpq.REQUEST=ob
        obpq.status='available'
        obpq.save()
        ob1 = qrcode.QRCode(
            version=1,  # The QRcode version (1-40), higher is a larger code.
            error_correction=qrcode.constants.ERROR_CORRECT_L,  # Error correction level (L, M, Q, H).
            box_size=10,  # The size of each box in the QRcode.
            border=4,  # The border size around the QRcode.
        )
        # Add data to the QRcode
        ob1.add_data(str(obpq.id))
        ob1.make(fit=True)

        # Create a PIL (Python Imaging Library) image from the QRcode data
        ob1 = ob1.make_image(fill_color="black", back_color="white")
        # Save the image to a file or display it
        ob1.save("media/QRcode/"+str(obpq.id)+".png")
        blocknumber = web3.eth.get_block_number()
        message2 = contract.functions.addreq(blocknumber + 1, str(request.session['lid']),str(ob.LOGIN.id),str(obpq.id), str(ob.quantity),
                                              str(datetime.today()), 'distributer request'
                                              ).transact()


    obs=distributor_stock_table.objects.filter(DISTRIBUTOR__id=ob.LOGIN.id,MEDICINE__id=ob.MEDICINE.id)
    if len(obs)>0:
        obs = obs[0]
        obs.stock=int(obs.stock)+int(ob.quantity)
        obs.save()
    else:
        obs=distributor_stock_table()
        obs.DISTRIBUTOR=ob.LOGIN
        obs.MEDICINE=ob.MEDICINE
        obs.stock=ob.quantity
        obs.save()
        # ACCEPTREJECTDISTRIBUTOR_REQUEST
    return HttpResponse('''<script> ;window.location="/ACCEPTREJECTDISTRIBUTOR_REQUEST"</script>''')
@login_required(login_url='/')
def reject_dis_req(request,id):
    ob = distributorrequest_table.objects.get(id=id)
    ob.status = "rejected"
    ob.save()
    return HttpResponse('''<script> ;window.location="/ACCEPTREJECTDISTRIBUTOR_REQUEST"</script>''')
@login_required(login_url='/')
def ACCEPTREJECTDISTRIBUTOR_search(request):
    name=request.POST['textfield']
    ob=distributor_table.objects.filter(firstname__icontains=name)
    return render(request,'ADMIN/ACCEPTREJECT DISTRIBUTOR.HTML',{'val':ob})
@login_required(login_url='/')
def ADDMANAGEMEDICINE_search(request):
    name=request.POST['textfield']
    ob=medicine_table.objects.filter(name__icontains=name)
    return render(request,'ADMIN/ADD MANAGE MEDICINE.HTML',{'val':ob})
@login_required(login_url='/')
def BLOCKUNBLOCKDISTRUBUTOR_search(request):
    name = request.POST['textfield']
    ob=distributor_table.objects.filter(firstname__icontains=name)
    return render(request,'ADMIN/BLOCKUNBLOCK DISTRUBUTOR.html',{'val':ob})
@login_required(login_url='/')
def ACCEPTREJECTPHARMACY_search(request):
    name = request.POST['textfield']
    ob = pharmacy_table.objects.filter(name__icontains=name)
    return render(request, 'ADMIN/ACCEPTREJECT PHARMACY.HTML', {'val': ob})
@login_required(login_url='/')
def DISTRIBUTORSENDREQUEST_search(request):
    name = request.POST['textfield']
    ob=medicine_table.objects.filter(name__icontains=name)
    return render(request, 'DISTRIBUTOR/DISTRIBUTOR SEND REQUEST.HTML', {'val': ob})
@login_required(login_url='/')
def DISTRIBUTORPACCEPTREJECT_search(request):
    name = request.POST['textfield']
    ob=pharmacyrequest_table.objects.filter(MEDICINE__name__icontains=name)
    return render(request, 'DISTRIBUTOR/DISTRIBUTOR PACCEPT REJECT.HTML', {'val': ob})
@login_required(login_url='/')
def VIEWDISTRIBUTOR_search(request):
    name = request.POST['textfield']
    ob= distributor_table.objects.filter(firstname__icontains=name)
    return render(request, 'PHARMACY/VIEW DISTRIBUTOR.HTML', {'val': ob})
@login_required(login_url='/')
def  PHARMACYSENDREQUEST_search(request):
    name = request.POST['textfield']
    ob=medicine_table.objects.filter(name__icontains=name)
    return render(request, 'PHARMACY/VIEW DISTRIBUTOR.HTML', {'val': ob})
@login_required(login_url='/')
def ADDANDMANAGEBILL_search(request):
    NAME=request.POST['textfield']
    ob=pharmacyrequest_table.objects.filter(MEDICINE__name__icontains=NAME,status='Accepted')
    return render(request,'PHARMACY/ADD AND MANAGE BILL.HTML',{'val':ob})
@login_required(login_url='/')
def CHECKMEDICINE_search(request):
    name = request.POST['textfield']
    ob=medicine_table.objects.filter(name__icontains=name)
    return render(request, 'PHARMACY/CHECK MEDICINE.HTML', {'val': ob})
@login_required(login_url='/')
def Accept_dis(request,id):
    ob=login_table.objects.get(id=id)
    ob.type='distributor'
    ob.save()
    return HttpResponse('''<script> ;window.location="/ACCEPTREJECTDISTRIBUTOR"</script>''')
@login_required(login_url='/')
def reject_dis(request,id):
    ob = login_table.objects.get(id=id)
    ob.type = 'rejected'
    ob.save()
    return HttpResponse('''<script> ;window.location="/ACCEPTREJECTDISTRIBUTOR"</script>''')
def DISTRIBUTORNREGISTERATION(request):
    return render(request,'distributorregindex.html')
def PHARMACYREGISTERATION(request):
    return render(request,'pharmacyregindex.html')
@login_required(login_url='/')
def ACCEPTREJECTPHARMACY(request):
    ob = pharmacy_table.objects.all()
    return render(request,'ADMIN/ACCEPTREJECT PHARMACY.HTML',{'val':ob})
@login_required(login_url='/')
def Acceptp_dis(request,id):
    ob=login_table.objects.get(id=id)
    ob.type='pharmacy'
    ob.save()
    return HttpResponse('''<script> ;window.location="/ACCEPTREJECTPHARMACY"</script>''')
@login_required(login_url='/')
def rejectp_dis(request,id):
    ob = login_table.objects.get(id=id)
    ob.type = 'rejected'
    ob.save()
    return HttpResponse('''<script> ;window.location="/ACCEPTREJECTPHARMACY"</script>''')

@login_required(login_url='/')
def ADDMANAGEMEDICINE(request):
    ob=medicine_table.objects.all()
    return render(request,'ADMIN/ADD MANAGE MEDICINE.HTML',{'val':ob})


@login_required(login_url='/')
def ADDMEDICINE(request):
    return render(request,'ADMIN/ADDMEDICINE.HTML')
@login_required(login_url='/')
def delete_med(request,id):
    ob=medicine_table.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script> ;window.location="/ADDMANAGEMEDICINE#footer"</script>''')



@login_required(login_url='/')
def medcode(request):
    name=request.POST['textfield']
    img = request.FILES['file']
    fs = FileSystemStorage()
    fsave = fs.save(img.name, img)
    price=request.POST['textfield2']
    quantity=request.POST['textfield3']
    mnfdate=request.POST['textfield4']
    expdate=request.POST['textfield5']
    details = request.POST['textarea']
    ob=medicine_table()
    ob.name=name
    ob.image=fsave
    ob.price=price
    ob.stock=quantity
    ob.mnf_date=mnfdate
    ob.exp_date=expdate
    ob.details=details
    ob.save()


    # qr code


    # ob1 = qrcode.QRCode(
    #     version=1,  # The QRcode version (1-40), higher is a larger code.
    #     error_correction=qrcode.constants.ERROR_CORRECT_L,  # Error correction level (L, M, Q, H).
    #     box_size=10,  # The size of each box in the QRcode.
    #     border=4,  # The border size around the QRcode.
    # )
    # # Add data to the QRcode
    # ob1.add_data(ob.id)
    # ob1.make(fit=True)
    #
    # # Create a PIL (Python Imaging Library) image from the QRcode data
    # ob1 = ob1.make_image(fill_color="black", back_color="white")
    # # Save the image to a file or display it
    # ob1.save("media/QRcode/"+str(ob.id)+".png")
    return HttpResponse('''<script> ;window.location="/ADDMANAGEMEDICINE"</script>''')
@login_required(login_url='/')
def EDITMEDICINE(request,id):
    request.session['EMid']=id
    ob=medicine_table.objects.get(id=id)
    return render(request,'ADMIN/EDIT MEDICINE.HTML',{'val':ob ,'md':str(ob.mnf_date),'ed':str(ob.exp_date)})


@login_required(login_url='/')
def edit_medcode(request):
    try:
        name=request.POST['textfield']
        img = request.FILES['file']
        fs = FileSystemStorage()
        fsave = fs.save(img.name, img)
        price=request.POST['textfield2']
        quantity=request.POST['textfield3']
        mnfdate=request.POST['textfield4']
        expdate=request.POST['textfield5']
        details = request.POST['textarea']

        ob=medicine_table.objects.get(id=request.session['EMid'])
        ob.name=name
        ob.image=fsave
        ob.price=price
        ob.stock=quantity
        ob.mnf_date=mnfdate
        ob.exp_date=expdate
        ob.details=details
        ob.save()
        return HttpResponse('''<script> ;window.location="/ADDMANAGEMEDICINE"</script>''')
    except:
        name = request.POST['textfield']
        # img = request.FILES['file']
        # fs = FileSystemStorage()
        # fsave = fs.save(img.name, img)
        price = request.POST['textfield2']
        quantity = request.POST['textfield3']
        mnfdate = request.POST['textfield4']
        expdate = request.POST['textfield5']
        details = request.POST['textarea']

        ob = medicine_table.objects.get(id=request.session['EMid'])
        ob.name = name
        # ob.image = fsave
        ob.price = price
        ob.stock = quantity
        ob.mnf_date = mnfdate
        ob.exp_date = expdate
        ob.details = details
        ob.save()
        return HttpResponse('''<script> ;window.location="/ADDMANAGEMEDICINE"</script>''')

@login_required(login_url='/')

def ADMINHOME(request):
    return render(request,'ADMIN/ADMIN HOME.HTML')
@login_required(login_url='/')
def BLOCKUNBLOCKDISTRUBUTOR(request):
    ob=distributor_table.objects.all()
    return render(request,'ADMIN/BLOCKUNBLOCK DISTRUBUTOR.html',{'val':ob})
@login_required(login_url='/')
def blockd_dis(request,id):
    ob=login_table.objects.get(id=id)
    ob.type='blocked'
    ob.save()
    return HttpResponse('''<script> ;window.location="/BLOCKUNBLOCKDISTRUBUTOR"</script>''')
@login_required(login_url='/')
def unblockd_dis(request,id):
    ob = login_table.objects.get(id=id)
    ob.type = 'distributor'
    ob.save()
    return HttpResponse('''<script> ;window.location="/BLOCKUNBLOCKDISTRUBUTOR"</script>''')

@login_required(login_url='/')

def DISTRIBUTORHOME(request):
    return render(request,'DISTRIBUTOR/DISTRIBUTOR HOME.HTML')


@login_required(login_url='/')
def DISTRIBUTORPACCEPTREJECT(request):
    ob=pharmacyrequest_table.objects.filter(DISTRIBUTOR__LOGIN__id=request.session['lid'])
    return render(request,'DISTRIBUTOR/DISTRIBUTOR PACCEPT REJECT.HTML',{'val':ob})
@login_required(login_url='/')
def acceptpd_dis(request,id):
    ob=pharmacyrequest_table.objects.get(id=id)
    ob.status='Accepted'


    qty=ob.quantity
    obb=distributor_medicine_table.objects.filter(REQUEST__LOGIN__LOGIN__id=request.session['lid'],status='available',MEDICINE__id=ob.MEDICINE.id).order_by("id")
    if len(obb)<qty:
        ob.status = 'Rejected'
        ob.save()
        return HttpResponse('''<script>alert("Rejected");window.location="/DISTRIBUTORPACCEPTREJECT"</script>''')
    else:
        ob.status = 'Accepted'
        ob.save()
    with open(
            r'C:\Users\fathi\PycharmProjects\medicine_authentication\node_modules\.bin\build\contracts\Structreq.json') as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
    for i in range(qty):
        obb[i].status="na"
        obb[i].save()
        obp=pharmacy_medicine_table()
        obp.PHAARMACY = ob
        obp.MEDICINE = obb[i]
        obp.status='available'
        obp.save()


        contract = web3.eth.contract(address='0xBDbAD63D2BD89b9E92b9839Ac53EC9D57Aeed355', abi=contract_abi)
        blocknumber = web3.eth.get_block_number()
        message2 = contract.functions.addreq(blocknumber + 1, str(request.session['lid']), str(ob.PHAARMACY.id),
                                             str(obb[i].id), str(ob.quantity),
                                             str(datetime.today()), 'pharmacy request'
                                             ).transact()
    obs = pharmacy_stock_table.objects.filter(PHAARMACY__id=ob.PHAARMACY.id, MEDICINE__id=ob.MEDICINE.id)
    if len(obs) > 0:
        obs = obs[0]
        obs.stock = int(obs.stock) + int(ob.quantity)
        obs.save()
    else:
        obs = pharmacy_stock_table()
        obs.PHAARMACY = pharmacy_table.objects.get(id=ob.PHAARMACY.id)
        obs.MEDICINE = medicine_table.objects.get(id=ob.MEDICINE.id)
        obs.stock = ob.quantity
        obs.save()
    return HttpResponse('''<script>alert("Accepted");window.location="/DISTRIBUTORPACCEPTREJECT"</script>''')
@login_required(login_url='/')
def rejectpd_dis(request,id):
    ob = pharmacyrequest_table.objects.get(id=id)
    ob.status = 'rejected'
    ob.save()
    return HttpResponse('''<script>alert("rejected");window.location="/DISTRIBUTORPACCEPTREJECT"</script>''')

@login_required(login_url='/')
def DISTRIBUTORSENDREQUEST(request):
    ob=medicine_table.objects.all()
    return render(request,'DISTRIBUTOR/DISTRIBUTOR SEND REQUEST.HTML',{'val':ob})
@login_required(login_url='/')
def drequest(request):
    ob=distributorrequest_table.objects.filter(LOGIN__LOGIN__id=request.session['lid'])


    return render(request,'DISTRIBUTOR/DISTRIBUTOR_request.HTML',{"val":ob})
@login_required(login_url='/')
def dSENDREQUEST(request,id):
    request.session['md_id'] = id

    return render(request,'DISTRIBUTOR/SEND REQUEST2.HTML')
@login_required(login_url='/')
def send_req_post(request):

    qty=request.POST['textfield']
    obj =distributorrequest_table()
    obj.LOGIN=distributor_table.objects.get(LOGIN__id=request.session['lid'])
    obj.MEDICINE=medicine_table.objects.get(id=request.session['md_id'])
    obj.quantity=qty
    obj.date = datetime.today()
    obj.status = "pending"
    obj.save()
    return HttpResponse('''<script> ;window.location="/DISTRIBUTORSENDREQUEST"</script>''')
@login_required(login_url='/')
def DISTRIBUTORSTOCKUPDATE(request):
    ob=distributorrequest_table.objects.values('MEDICINE_id').distinct()
    lst=[]
    for i in ob:
        obb=medicine_table.objects.filter(id=i['MEDICINE_id'])
        for k in obb:
            lst.append(k.id)
    res=medicine_table.objects.filter(id__in=lst)
    return render(request,'DISTRIBUTOR/DISTRIBUTOR STOCK UPDATE.HTML',{'val':res})
@login_required(login_url='/')
def ADDANDMANAGEBILL(request):
    ob=pharmacyrequest_table.objects.filter(status='Accepted',PHAARMACY__LOGIN__id=request.session['lid'])
    return render(request,'PHARMACY/ADD AND MANAGE BILL.HTML',{'val':ob})
@login_required(login_url='/')
def ADDBILL(request,id):
    request.session['mid']=id
    ob=medicine_table.objects.get(id=id)
    return render(request,'PHARMACY/ADD BILL.HTML',{'val':ob})

#
# def add(request):
#     qty=request.POST['textfield']
#     qq=pharmacyrequest_table.objects.filter(MEDICINE__id=request.session['mid'])
#     print("3333333333333333333", qq)
#     tt = int(qq.MEDICINE.price)* int(qty)
#     stock = int(qq.quantity)
#     print(stock,qty,"jjjjjjjjjjjjjjjjjjjjjj")
#     nstk = int(stock) - int(qty)
#     if stock >= int(qty):
#         up=medicine_table.objects.get(id=request.session['mid'])
#         up.quantity=nstk
#         up.save()
#         q=orders_table.objects.filter(USER=user.objects.get(LOGINID__id=request.session['uid']),status='pending')
#         if len(q)==0:
#             qt=order()
#             qt.date=datetime.datetime.today()
#             qt.USER=user.objects.get(LOGINID=request.session['uid'])
#             qt.status='pending'
#             qt.price=tt
#             qt.save()
#             qty1=order_details()
#             qty1.quantity=qty
#             qty1.PRODUCT=product.objects.get(id=request.session['pid'])
#             qty1.ORDER=qt
#             qty1.date = datetime.datetime.today()
#             qty1.save()
#             return HttpResponse('''<script>alert('placed order successfuly');window.location='/hompage'</script>''')
#         else:
#             total = int(q[0].price) + int(tt)
#             qt=order.objects.get(id=q[0].id)
#             qt.price=total
#             qt.save()
#             qty1=order_details.objects.filter(PRODUCT__id=request.session['pid'],ORDER__id=q[0].id)
#             if len(qty1)==0:
#                 qqt=order_details()
#                 qqt.ORDER=q[0]
#                 qqt.PRODUCT=product.objects.get(id=request.session['pid'])
#                 qqt.quantity=qty
#                 qqt.save()
#             else:
#                 qry1=order_details.objects.get(id=qty1[0].id)
#                 quty=int(qty1[0].quantity) + int(qty)
#                 qry1.quantity=quty
#                 qry1.save()
#             return HttpResponse('''<script>alert(' success');window.location='/hompage'</script>''')
#     else:
#         return HttpResponse('''<script>alert('out of stock');window.location='/hompage'</script>''')
#
@login_required(login_url='/')
def add(request):
    quantity=request.POST['textfield']
    btn=request.POST['Submit']
    if btn == "CONTINUE":
        print("=================CONTINUE==================")
        obb=orders_table.objects.filter(status='pending')
        if(len(obb)== 0):
            print("000000000000000000000000000000000000000")
            obj = orders_table()
            obj.username = 0
            obj.phone_no = 0
            obj.email = 0
            obj.total = 0
            obj.date = datetime.today()
            obj.status = 'pending'
            obj.save()
            ob = order_details()
            ob.medicine_id = medicine_table.objects.get(id=request.session['mid'])
            ob.quantity = quantity
            ob.order_id = obj
            ob.save()
            return redirect('/ADDANDMANAGEBILL')
        else:

            print("111111111111111111111111111111111111111111111")
            for i in obb:
                ob = order_details()
                ob.medicine_id = medicine_table.objects.get(id=request.session['mid'])
                ob.quantity = quantity
                ob.order_id = orders_table.objects.get(id=i.id)
                ob.save()
            x = int(ob.medicine_id.price) * int(quantity)
            # total+=x
            print("Price", x, "----------------------------------")
            return redirect('/ADDANDMANAGEBILL')
    else:
        print("=================FINISH==================")
        obb = orders_table.objects.filter(status='pending')
        if len(obb)==0:
            obj = orders_table()
            obj.username = 0
            obj.phone_no = 0
            obj.email = 0
            obj.total = 0
            obj.date = datetime.today()
            obj.status = 'pending'
            obj.save()
            ob = order_details()
            ob.medicine_id = medicine_table.objects.get(id=request.session['mid'])
            ob.quantity = quantity
            ob.order_id = obj
            ob.save()
            oob=order_details.objects.filter(order_id__id=obj.id)
            tot=0
            for i in oob:
                re=int(i.quantity)*int(i.medicine_id.price)
                tot=int(tot)+int(re)
            print(tot, "8888888888888888")
            fob = orders_table.objects.get(id=obj.id)
            fob.total = tot
            fob.save()
            # request.session['fid']=fob.id
            return render(request,'PHARMACY/BILL NOW.HTML',{'tot':int(tot)})
        else:
            for i in obb:
                ob = order_details()
                ob.medicine_id = medicine_table.objects.get(id=request.session['mid'])
                ob.quantity = quantity
                ob.order_id = orders_table.objects.get(id=i.id)
                ob.save()
                oob = order_details.objects.filter(order_id__id=i.id)
                tot = 0
                for i in oob:
                    re = int(i.quantity) * int(i.medicine_id.price)
                    tot = int(tot) + int(re)
                    request.session['ooid']=i.order_id.id
                fob = orders_table.objects.get(id=request.session['ooid'])
                fob.total = tot
                fob.save()
                # request.session['fid'] = orders_table.objects.get(id=i.id)
            print(tot,"8888888888888888")
            return render(request,'PHARMACY/BILL NOW.HTML',{'tot':int(tot)})



@login_required(login_url='/')
def BILLNOW (request):
    return render(request,'PHARMACY/BILL NOW.HTML')
@login_required(login_url='/')
def CHECKMEDICINE (request):
    ob=medicine_table.objects.all()
    return render(request,'PHARMACY/CHECK MEDICINE.HTML',{'val':ob})
@login_required(login_url='/')
def PHARMACYHOME (request):
    return render(request,'PHARMACY/index.html')
@login_required(login_url='/')
def  PHARMACYSENDREQUEST (request):
    ob=medicine_table.objects.all()
    return render(request,'PHARMACY/PHARMACY SEND REQUEST.HTML',{'val':ob})

@login_required(login_url='/')
def SENDREQUEST(request,id):
    request.session['medid']=id
    # ob=distributor_table.objects.filter(LOGIN__type="distributor")
    ob=distributor_medicine_table.objects.filter(MEDICINE__id=id,status='available')

    data = []
    list=[]
    for i in ob:
        if i.REQUEST.LOGIN.id in data:
            pass
        else:
            data.append(i.REQUEST.LOGIN.id)
    print(data)

    for ir in data:
        i=distributor_table.objects.get(id=ir)
        row = {"id": i.id,"name":i.firstname +""+i.lastname }
        list.append(row)
    return render(request, 'PHARMACY/SEND REQUEST.HTML',{'val':list})


@login_required(login_url='/')
def VIEWDISTRIBUTOR(request):
    ob = distributor_table.objects.all()
    return render(request, 'PHARMACY/VIEW DISTRIBUTOR.HTML',{'val':ob})

def disregistercode(request):
    fname = request.POST['textfield']
    lname = request.POST['textfield2']
    gender = request.POST['radiobutton']
    place = request.POST['textarea']
    post = request.POST['textfield3']
    pin = request.POST['textfield4']
    phone = request.POST['textfield5']
    email = request.POST['textfield6']
    address=request.POST['textarea']
    proof_id = request.FILES['file']
    fn=FileSystemStorage()
    fs=fn.save(proof_id.name,proof_id)
    uname = request.POST['textfield7']
    pswrd = request.POST['textfield8']
    ob=login_table()
    ob.username=uname
    ob.password=pswrd
    ob.type='pending'
    ob.save()
    ob1=distributor_table()
    ob1.firstname=fname
    ob1.lastname=lname
    ob1.gender=gender
    ob1.phone_no=phone
    ob1.address=address
    ob1.email=email
    ob1.proof_id=fs
    ob1.pin=pin
    ob1.post=post
    ob1.place=place
    ob1.LOGIN =ob
    ob1.save()
    return HttpResponse('''<script>;window.location="/"</script>''')


def dispharmacycode(request):
    name = request.POST['textfield']
    location = request.POST['textarea']
    post = request.POST['textfield3']
    pin = request.POST['textfield4']
    phone_no = request.POST['textfield5']
    email = request.POST['textfield6']
    proof_id = request.FILES['file']
    fs=FileSystemStorage()
    fsave=fs.save(proof_id.name,proof_id)
    uname = request.POST['textfield7']
    pswrd = request.POST['textfield8']
    ob=login_table()
    ob.username=uname
    ob.password=pswrd
    ob.type='pending'
    ob.save()
    ob1=pharmacy_table()
    ob1.name=name
    ob1.phone_no=phone_no
    ob1.email=email
    ob1.proof_id=fsave
    ob1.pin=pin
    ob1.post=post
    ob1.place=location
    ob1.LOGIN=ob
    ob1.save()
    return HttpResponse('''<script>;window.location="/"</script>''')
@login_required(login_url='/')
def addbillnow(request):
    username = request.POST['textfield2']
    phone_no =request.POST['textfield3']
    email = request.POST['textfield4']

    ob=orders_table.objects.get(status='pending')
    ob.username=username
    ob.phone_no=phone_no
    ob.email=email
    ob.status='finished'
    ob.save()
    ob=order_details.objects.filter(order_id__id=ob.id)
    print("ob",ob)
    print("ob",ob)
    print("ob",ob)
    print("ob",ob)
    with open(
            r'C:\Users\fathi\PycharmProjects\medicine_authentication\node_modules\.bin\build\contracts\Structreq.json') as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
    contract = web3.eth.contract(address='0xBDbAD63D2BD89b9E92b9839Ac53EC9D57Aeed355', abi=contract_abi)
    for i in ob:
        qty=int(i.quantity)
        print(qty,"++++++++++++++++++++++++=")
        print(qty,"++++++++++++++++++++++++=")
        print(qty,"++++++++++++++++++++++++=")
        print(qty,"++++++++++++++++++++++++=")
        print(qty,"++++++++++++++++++++++++=")
        print(qty,"++++++++++++++++++++++++=")
        obpp=pharmacy_medicine_table.objects.filter(PHAARMACY__PHAARMACY__LOGIN__id=request.session['lid'],MEDICINE__MEDICINE__id=i.medicine_id.id,status='available')
        print(obpp,len(obpp),"llllllllllllllllllll")
        if(len(obpp)>=qty):
            for j in range(qty):
                print(j,"++++++++++++++++++++++++++-----------------")
                blocknumber = web3.eth.get_block_number()
                message2 = contract.functions.addreq(blocknumber + 1, str(request.session['lid']), str(i.order_id.username),
                                                     str(obpp[j].MEDICINE.id), str(i.quantity),
                                                     str(datetime.today()), 'pharmacy bill'
                                                     ).transact()


                obpp[j].status="na"
                obpp[j].save()
                print(obpp[j].id,"++++_+_+_+_+)+)++++++")
    return HttpResponse('''<script>;window.location="/PHARMACYHOME"</script>''')
@login_required(login_url='/')
def selcdistri(request):
    qty=request.POST['textfield']
    di=request.POST['select']
    ob=pharmacyrequest_table()
    ob.PHAARMACY=pharmacy_table.objects.get(LOGIN__id=request.session['lid'])
    ob.DISTRIBUTOR=distributor_table.objects.get(id=di)
    ob.MEDICINE=medicine_table.objects.get(id=request.session['medid'])
    ob.quantity=qty
    ob.date=datetime.today()
    ob.status="pending"
    ob.save()
    return HttpResponse('''<script> ;window.location="/PHARMACYSENDREQUEST"</script>''')

def viewstatus(request):
    ob=pharmacyrequest_table.objects.filter(PHAARMACY__LOGIN__id=request.session['lid'])
    return render(request,"PHARMACY/view status.html",{"val":ob})
# ////////////////////////webservice///////////////



from django.core import serializers
import json
from django.http import JsonResponse
def login_server(request):
    print(request.POST)
    un = request.POST['uname']
    pwd = request.POST['pass']
    print(un, pwd)
    try:
        ob = login_table.objects.get(username=un, password=pwd)

        if ob is None:
            data = {"task": "invalid"}
        else:
            print("in user function")
            data = {"task": "valid", "id": ob.id}
        r = json.dumps(data)
        print(r)
        return HttpResponse(r)
    except:
        data = {"task": "invalid"}
        r = json.dumps(data)
        print(r)
        return HttpResponse(r)

def registration(request):
    Fname=request.POST['Fname']
    lname=request.POST['lname']
    phno=request.POST['phno']
    email =request.POST['phno']
    address = request.POST['address']
    gender = request.POST['gndr']
    uname = request.POST['username']
    passwd = request.POST['password']
    lob = login_table()
    lob.username = uname
    lob.password = passwd
    lob.type = 'user'
    lob.save()
    userob = user_table()
    userob.firstname = Fname
    userob.lastname = lname
    userob.phone_no= phno
    userob.email = email
    userob.address= address
    userob.gender= gender
    userob.LOGIN= lob
    userob.save()
    data = {"task": "success"}
    r = json.dumps(data)
    print(r)
    return HttpResponse(r)

def andviewproducts(request):
    print(request.POST)
    b = request.POST['srno']
    # db = Db()
    r = {}
    # qry = "SELECT * FROM `medicine` WHERE id='"+str(b)+"'"
    # res = db.selectOne(qry)
    data = []
    with open(compiled_contract_path) as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
    contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
    blocknumber = web3.eth.get_block_number()
    print(blocknumber)
    sollist=[]
    ulist=[]
    for i in range(blocknumber,43, -1):
        a = web3.eth.get_transaction_by_block(i, 0)
        decoded_input = contract.decode_function_input(a['input'])

        # decoded_input[1]['fid']

        if int(decoded_input[1]['mid']) == int(b):
            # if decoded_input[1]['status']=='distributer request' and decoded_input[1]['status']=='pharmacy request'\
            #         and decoded_input[1]['status']=='pharmacy bill':
                print("ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")
                print(decoded_input[1])
                # mid = decoded_input[1]['mid'].split('#')
                sollist.append(decoded_input[1]['status'])
                ulist.append([decoded_input[1]['fid'],decoded_input[1]['tid'],decoded_input[1]['date']])
                # ob=medicine_table.objects.get(id=b)
                # r['med'] = str(ob.name)
                # r['mf'] = str(ob.mnf_date)
                # r['exp'] = ob.exp_date
                # r['qty'] = ob.stock
                # r['price'] = ob.price
                # # r['info'] = decoded_input[1]['fid']+"------------>"+decoded_input[1]['tid']
                # r['status'] = "ok"
                # sollist.append(r)
                # return JsonResponse(r,safe=False)
        # else:
        #         r['status'] = "none"
        #         r['med'] = 0
        #         r['mf'] = 0
        #         r['exp'] = 0
        #         r['qty'] = 0
        #         r['price'] = 0
                # r['info'] = decoded_input[1]['fid']+"------------>"+decoded_input[1]['tid']
        #         sollist.append(r)
                # return JsonResponse(r,safe=False)
    print(sollist)
    print(ulist)
    print(r, "+===================")
    if len(sollist)==3:
        print("Original","==============")
        obp=pharmacy_table.objects.get(LOGIN__id=ulist[0][0])

        pharmacy=obp.name+" sell to "+ulist[0][1]+" on "+ulist[0][2].split(".")[0]

        obd = distributor_table.objects.get(LOGIN__id=ulist[1][0])

        distributor=obd.firstname+" "+obd.lastname+" sell to "+obp.name+" on "+ulist[1][2].split(".")[0]
        manufracture="manufracture sell to "+obd.firstname+" "+obd.lastname+" on "+ulist[2][2].split(".")[0]
        r={}
        obb=distributor_medicine_table.objects.get(id=b)
        ob = obb.MEDICINE
        r['med'] = str(ob.name)
        r['mf'] = str(ob.mnf_date)
        r['exp'] = ob.exp_date
        r['qty'] = ob.stock
        r['price'] = ob.price

        r['task'] = "Original"
        r['manu'] = manufracture
        r['dis'] = distributor
        r['pha'] = pharmacy
        print(manufracture)
        print(distributor)
        print(pharmacy)
        return JsonResponse(r, safe=False)
    return JsonResponse({"task":"fake"}, safe=False)
