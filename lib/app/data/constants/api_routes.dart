// change the domain name if you want
const String domainName = "http://192.168.1.10:4000";

const String apiVersion = "/api/v1/";

const String apiBase = domainName + apiVersion;


const String apiSignin = "${apiBase}users/login";
const String apiSignup = "${apiBase}users/signup";
const String apiReadUser = "${apiBase}users/getProfile";
const String apiUpdateUser = "${apiBase}users/editProfile";
const String apiChangePasswordUser = "${apiBase}users/changePassword";

//file upload
const String apiFileUpload = "${apiBase}users/fileUpload";
//branch
const String apiListBranch = "${apiBase}users/listServiceStation";
//category
const String apiListCategory = "${apiBase}users/listCategory";
//service
const String apiListService = "${apiBase}users/listService";

//Banner
const String apiListBanner = "${apiBase}users/listBanner";
//car brand
const String apiListCarBrand = "${apiBase}users/listCarBrand";
//car model
const String apiListCarModel = "${apiBase}users/listCarModel";
//car variant
const String apiListCarVariant = "${apiBase}users/listCarVariant";
//service mode
const String apiListServiceMode = "${apiBase}users/listServiceMode";
//spare category
const String apiListActiveSpareCategory = "${apiBase}users/listSpareCategory";
//spare 
const String apiListActiveSpare = "${apiBase}users/listSpare";
//spare 
const String apiListActivePackage = "${apiBase}users/listPackage";
//vehicle 
const String apiListActiveVehicle = "${apiBase}customer/listVehicle";
const String apiAddVehicle = "${apiBase}customer/addVehicle";
