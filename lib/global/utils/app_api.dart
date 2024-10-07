//const String baseUrl = 'https://event-app-backend-cosr.onrender.com/api';
const String baseUrl = 'http://10.0.2.2:9092/api';

const loginUrl = '$baseUrl/users/login';
const signUpUrl = '$baseUrl/users/signup';
const forgotPasswordUrl = '$baseUrl/users/forgotPassword';
const verifyResetCodedUrl = '$baseUrl/users/verifyResetCode';
const resetPasswordUrl = '$baseUrl/users/resetPassword';
const createEventUrl = '$baseUrl/events/create';
const fetchEventUrl = '$baseUrl/events';
const purchaseEventUrl = '$baseUrl/purchases/makePurchase';
const getPurchasesByUserUrl = '$baseUrl/purchases';
