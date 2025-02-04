import 'dart:developer';

import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart';
import 'package:courier/Map/calculation.dart';
import 'package:courier/Map/calculation.dart';
import 'package:courier/Provider/priceprovider.dart';
import 'package:courier/Screen/schedule.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../Provider/sammeryprovider.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({super.key});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  int currentStep = 1;
  String selectedPackageType = "";
  String selectedPackageSize = "";
  List<String> selectedPackageContents = [];
  int selectedPackageTypeIds = 0;
  int selectedPackageSizeIds = 0;
  double? sizeprice;
  List<int> selectedPackageContentIds = [];
  bool isPackageTypeSelected = false;
  bool isPackageSizeVisible = false;
  bool isPackageContentVisible = false;
  bool isAdditionalProtectionSelected = false;

  CommonViewModel? vm;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<CommonViewModel>().getpackage();
      context.read<CommonViewModel>().getPackageSizes();
      context.read<CommonViewModel>().getPackageContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    final packageData = context.watch<CommonViewModel>().packagelist;
    final packageSizeData = context.watch<CommonViewModel>().packageSizeList;
    final packageContents = context.watch<CommonViewModel>().packagecontent;
    final isLoading = context.watch<CommonViewModel>().contentLoading;

      // Filtering logic
    //  List filteredPackageSizes = selectedPackageTypeIds == 1
    //     ? packageSizeData.where((item) => item.sId == 1 || item.sId == 2).toList()
    //     : packageSizeData;

    // List filteredPackageContents = selectedPackageTypeIds == 1
    //     ? packageContents.where((content) => content.cId == 1 || content.cId == 2).toList()
    //     : packageContents;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          "Send a Package",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildProgressStep("ADDRESS",
                      isActive: currentStep >= 0, isProcessed: currentStep > 0),
                  _buildProgressDivider(),
                  _buildProgressStep("PACKAGE",
                      isActive: currentStep == 1, isProcessed: currentStep > 1),
                  _buildProgressDivider(),
                  _buildProgressStep("SCHEDULE",
                      isActive: currentStep == 2, isProcessed: currentStep > 2),
                  _buildProgressDivider(),
                  _buildProgressStep("SUMMARY", isActive: currentStep == 3),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "Describe Your Package",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: packageData.isEmpty
                    ? [CircularProgressIndicator()]
                    : packageData.map((item) {
                        return _buildPackageType(
                            item.packageName!,
                            Icons.gif_box,
                            selectedPackageType,
                            item.iconUrl,
                            item.pkId!);
                      }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            if (isPackageTypeSelected) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Choose Package Size",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: packageSizeData.isEmpty
                      ? [CircularProgressIndicator()]
                      : packageSizeData.map((item) {
                          return _buildPackageSize(
                              item.size.toString(),
                              item.range ?? '',
                              item.weight_price ?? 0,
                              selectedPackageSize,
                              item.sId!);
                        }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
            if (isPackageContentVisible) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Choose Package Contents",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.only(right: 5,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100]),
                child: Consumer<CommonViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.contentLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.packagecontent.isEmpty) {
                      return const Center(
                          child: Text("No package contents available.",
                              style: TextStyle(color: Colors.grey)));
                    } else {
                      return Column(
                        children: context
                            .watch<CommonViewModel>()
                            .packagecontent
                            .map((content) {
                          return _buildPackageContent(
                              content.content, content.iconUrl, content.cId!);
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff071e30)),
                child: TextButton(
                  onPressed: () async {
                    
 final locationProvider =Provider.of<LocationProvider>(context,listen: false);

                          LatLng pickupLocation =
                              locationProvider.selectedLocation;
                          LatLng deliveryLocation =
                              locationProvider.searchMapLocation;

                          if (pickupLocation.latitude != 0.0 &&
                              deliveryLocation.latitude != 0.0) {
 
                            double distance =
                                locationProvider.calculateDistance(
                                    pickupLocation, deliveryLocation);

                            log("Calculated distance: $distance km");

                            final vm = Provider.of<CommonViewModel>(context,
                                listen: false);
                            vm.fetchPricee(distance); 
                            

                            setState(() {
                              currentStep = 1;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PackagePage()),
                            );
                          }



                    // final vm =
                    //     Provider.of<CommonViewModel>(context, listen: false);
                    // double km = ; // Define the km variable with a value
                    // await vm.fetchPrice(km);

                    // First, check if the necessary fields are filled.
                    if (selectedPackageType.isEmpty ||
                        selectedPackageSize.isEmpty ||
                        selectedPackageContents.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please complete the package description before proceeding.",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // Update the SummaryProvider with selected package details.
                      context.read<SummaryProvider>().setSelectedPackageType(
                          selectedPackageType, selectedPackageTypeIds);
                      context.read<SummaryProvider>().setSelectedPackageSize(
                          selectedPackageSize,
                          selectedPackageSizeIds,
                          sizeprice!);
                      context
                          .read<SummaryProvider>()
                          .setSelectedPackageContents(selectedPackageContents,
                              selectedPackageContentIds);

                      if (currentStep < 4) {
                        currentStep += 1;
                      }

                      // Navigate to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SchedulePage()),
                      );
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),

                    // child: Text(
                    //   "Next",
                    //   style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(String title,
      {bool isActive = false, bool isProcessed = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isProcessed
              ? const Color(0xfff071e30)
              : isActive
                  ? Color(0xfff071e30)
                  : Colors.grey[300],
          child: isProcessed
              ? Icon(Icons.check, size: 15, color: Colors.white)
              : isActive
                  ? Icon(Icons.circle, size: 10, color: Colors.white)
                  : SizedBox(),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
              fontSize: 12,
              color:
                  isActive || isProcessed ? Color(0xfff071e30) : Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProgressDivider() {
    return Expanded(
      child: Divider(
        thickness: 2,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildPackageType(String label, IconData icon, String selectedType,
      String? iconUrl, int package_id) {
    final bool isSelected = label == selectedType;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackageType = label;
          selectedPackageTypeIds = package_id;
          isPackageTypeSelected = true;
          isPackageSizeVisible = true;
          isPackageContentVisible = false;
          selectedPackageContents.clear();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 26),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:
                  isSelected ? Color(0xfff071e30) : Colors.grey[200],
              child: iconUrl != null && iconUrl.isNotEmpty
                  ? Image.network(
                      iconUrl,
                      width: 100,
                      height: 50,
                      fit: BoxFit.cover,
                      color: isSelected ? Colors.white : Colors.black,
                    )
                  : Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageSize(String size, String weightRange, int weight_price,
      String selectedSize, int size_id) {
    final bool isSelected = size == selectedSize;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackageSize = size;
          selectedPackageSizeIds = size_id;
          sizeprice = double.parse(weight_price.toString());
          // context.read<SummaryProvider>().setSelectedWeightPrice(weight_price);
          isPackageContentVisible = true;
        });
      },
      child: Card(
        color: isSelected ? Color.fromARGB(255, 10, 39, 61) : Colors.grey[200],
        elevation: isSelected ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                size,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 4),
              Text(weightRange, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageContent(
      String? content, String? iconUrl, int content_id) {
    final displayContent = content ?? "No content available";
    final displayIconUrl = iconUrl ?? 'default_icon_url';

    final bool isSelected = selectedPackageContents.contains(displayContent);

    return CheckboxListTile(
      activeColor: Colors.black,
      title: Row(
        children: [
          Image.network(
            displayIconUrl,
            width: 50,
            height: 24,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 5),
          Text(displayContent),
        ],
      ),
      value: isSelected,
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            selectedPackageContents.add(displayContent);
            selectedPackageContentIds.add(content_id);
          } else {
            selectedPackageContents.remove(displayContent);
            selectedPackageContentIds.remove(content_id);
          }
        });
      },
    );
  }
}





