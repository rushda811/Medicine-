

import qrcode
for i in range(1,11):
    ob1 = qrcode.QRCode(
                version=1,  # The QRcode version (1-40), higher is a larger code.
                error_correction=qrcode.constants.ERROR_CORRECT_L,  # Error correction level (L, M, Q, H).
                box_size=10,  # The size of each box in the QRcode.
                border=4,  # The border size around the QRcode.
            )
            # Add data to the QRcode
    ob1.add_data(str(i))
    ob1.make(fit=True)

    # Create a PIL (Python Imaging Library) image from the QRcode data
    ob1 = ob1.make_image(fill_color="black", back_color="white")
    # Save the image to a file or display it
    ob1.save(r"C:\Users\fathi\PycharmProjects\medicine_authentication\media\QRcode/"+str(i)+".png")