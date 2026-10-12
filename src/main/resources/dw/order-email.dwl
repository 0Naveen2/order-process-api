%dw 2.0
output text/plain
var op = (vars.operation default "CREATE") as String
var orderId = (vars.orderId default vars.orderPayload.orderId default "N/A") as String
var customerName = (vars.orderPayload.customerName default payload.customerName default "Customer") as String
var correlationIdValue = (vars.correlationId default correlationId default "N/A") as String
---
op match {
  case "CREATE" -> 
    "Hello " ++ customerName ++ ",\n\n" ++
    "Thank you for your order!\n\n" ++
    "Order Details:\n" ++
    "----------------------------------------\n" ++
    "Order ID: " ++ orderId ++ "\n" ++
    "Correlation ID: " ++ correlationIdValue ++ "\n" ++
    "Product Code: " ++ (vars.orderPayload.productCode default "N/A") ++ "\n" ++
    "Quantity: " ++ (vars.orderPayload.quantity as String default "0") ++ "\n" ++
    "Unit Price: " ++ (vars.unitPrice as String default "0") ++ " " ++ (vars.orderPayload.currency default "INR") ++ "\n" ++
    "Total Amount: " ++ (vars.calculatedTotal as String default "0") ++ " " ++ (vars.orderPayload.currency default "INR") ++ "\n" ++
    "----------------------------------------\n\n" ++
    "Shipping Address:\n" ++
    (vars.orderPayload.shippingAddressLine1 default "") ++ "\n" ++
    (if (vars.orderPayload.shippingAddressLine2 != null and !isEmpty(vars.orderPayload.shippingAddressLine2)) vars.orderPayload.shippingAddressLine2 ++ "\n" else "") ++
    (vars.orderPayload.shippingCity default "") ++ ", " ++ (vars.orderPayload.shippingState default "") ++ " - " ++ (vars.orderPayload.shippingPostalCode default "") ++ "\n" ++
    (vars.orderPayload.shippingCountry default "") ++ "\n\n" ++
    "We will process your order shortly.\n\n" ++
    "Best regards,\n" ++
    "Order Management Team"

  case "UPDATE" -> 
    "Hello " ++ customerName ++ ",\n\n" ++
    "Your order details for Order ID: " ++ orderId ++ " have been updated successfully.\n\n" ++
    "Correlation ID: " ++ correlationIdValue ++ "\n\n" ++
    "Updated Information:\n" ++
    "----------------------------------------\n" ++
    (if (payload.shippingCity != null) "City: " ++ payload.shippingCity ++ "\n" else "") ++
    (if (payload.shippingState != null) "State: " ++ payload.shippingState ++ "\n" else "") ++
    (if (payload.shippingPostalCode != null) "Postal Code: " ++ payload.shippingPostalCode ++ "\n" else "") ++
    (if (payload.quantity != null) "Quantity: " ++ (payload.quantity as String) ++ "\n" else "") ++
    "----------------------------------------\n\n" ++
    "If you did not request this update, please contact support.\n\n" ++
    "Best regards,\n" ++
    "Order Management Team"

  case "DELETE" -> 
    "Hello " ++ customerName ++ ",\n\n" ++
    "Your order #" ++ orderId ++ " has been successfully deleted from our system.\n\n" ++
    "Correlation ID: " ++ correlationIdValue ++ "\n\n" ++
    "Best regards,\n" ++
    "Order Management Team"

  else -> 
    "Hello " ++ customerName ++ ",\n\n" ++
    "Notification regarding Order #" ++ orderId ++ ".\n\n" ++
    "Correlation ID: " ++ correlationIdValue ++ "\n\n" ++
    "Best regards,\n" ++
    "Order Management Team"
}