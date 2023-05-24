// change the domain name if you want
const String domainName = "http://192.168.1.13:4000";

const String apiVersion = "/api/v1/";

const String apiBase = domainName + apiVersion;

const String apiRequiestOtp = "${apiBase}customer/sendOtp";
const String apiVarifyOtp = "${apiBase}customer/verifyOtp";
const String apiSignup = "${apiBase}customer/signup";
const String apiReadUser = "${apiBase}customer/getProfile";
const String apiUpdateUser = "${apiBase}customer/editProfile";
const String apiChangePasswordUser = "${apiBase}customer/changePassword";

//file upload
const String apiFileUpload = "${apiBase}customer/fileUpload";
//branch
const String apiListBranch = "${apiBase}customer/listServiceStation";
//category
const String apiListCategory = "${apiBase}customer/listCategory";
//service
const String apiListService = "${apiBase}customer/listService";
const String apiListExtraService = "${apiBase}customer/listAddOnService";

//Banner
const String apiListBanner = "${apiBase}customer/listBanner";
//car brand
const String apiListCarBrand = "${apiBase}customer/listCarBrand";
//car model
const String apiListCarModel = "${apiBase}customer/listCarModel";
//car variant
const String apiListCarVariant = "${apiBase}customer/listCarVariant";
//service mode
const String apiListServiceMode = "${apiBase}customer/listServiceMode";
//spare category
const String apiListSpareCategory = "${apiBase}customer/listSpareCategory";
const String apiSpareCategory = "${apiBase}customer/getSpareCategory";
//spare
const String apiListActiveSpare = "${apiBase}customer/listSpare";
//spare
const String apiListActivePackage = "${apiBase}customer/listPackage";
//vehicle
const String apiListActiveVehicle = "${apiBase}customer/listVehicle";
const String apiAddVehicle = "${apiBase}customer/addVehicle";
//address
const String apiListActiveAddress = "${apiBase}customer/listAddress";
const String apiAddAddress = "${apiBase}customer/addAddress";
const String apiEditAddress = "${apiBase}customer/editAddress";
const String apiDeleteAddress = "${apiBase}customer/deleteAddress";
//wallet
const String apiGetWallet = "${apiBase}customer/getWallet";
const String apiRedeemWallet = "${apiBase}customer/checkWallet";
//coupon
const String apiGetCoupon = "${apiBase}customer/getCoupon";
const String apiRedeemCoupon = "${apiBase}customer/couponAvailabilityCheck";
//payment
const String apiPaymentCheckout = "${apiBase}customer/checkout";
const String apiPaymentVerify = "${apiBase}customer/verifyPayment";

//Booking
const String apiAddBooking = "${apiBase}customer/addBooking";
const String apiGetBooking = "${apiBase}customer/listBooking";

//TimeSlot
const String apiGetTimeSlot = "${apiBase}customer/listDefaultTimeSlot";
