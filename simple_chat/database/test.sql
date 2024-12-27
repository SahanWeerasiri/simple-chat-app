use simple_chat;

CALL create_account("Lahiru","Sahan","SahanSahan"); -- Done
CALL create_account("Akindu","Akindu","Akinduaki"); -- Done

CALL sign_in("Sahan","SahanSahan",@res);  -- Done
CALL sign_out(1);  -- Done

CALL get_all_contacts(1);  -- Done
CALL get_my_contacts(1);  -- Done

CALL send_request(1,2);  -- Done
CALL show_my_request(1);  -- Done
CALL response_request(2,1,'Rejected');  -- Done

CALL send_request(2,1);  -- Done
CALL show_my_request(1);  -- Done
CALL show_their_request(1);  -- Done
CALL response_request(1,2,'Accepted'); -- Done


