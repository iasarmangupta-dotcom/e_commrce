import 'package:flutter/material.dart';
import '../../../Data/dummy_data.dart';
import '../../../Data/models/address_model.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int selectedAddressIndex = 0;

  @override
  void initState() {
    super.initState();
    int defaultIdx = DummyData.addresses.indexWhere((a) => a.isDefault);
    if (defaultIdx != -1) {
      selectedAddressIndex = defaultIdx;
    }
  }

  void _showAddAddressDialog() {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final houseCtrl = TextEditingController();
    final streetCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final stateCtrl = TextEditingController();
    final pincodeCtrl = TextEditingController();
    String selectedType = "Home";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Delivery Address",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTextField("Full Name", nameCtrl, Icons.person_outline),
                _buildTextField("Phone Number", phoneCtrl, Icons.phone_outlined,
                    keyboardType: TextInputType.phone),
                _buildTextField("House / Flat No.", houseCtrl, Icons.home_outlined),
                _buildTextField("Street / Area", streetCtrl, Icons.location_on_outlined),
                Row(
                  children: [
                    Expanded(child: _buildTextField("City", cityCtrl, Icons.location_city_outlined)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField("Pincode", pincodeCtrl, Icons.pin_drop_outlined, keyboardType: TextInputType.number)),
                  ],
                ),
                _buildTextField("State", stateCtrl, Icons.map_outlined),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (nameCtrl.text.trim().isNotEmpty && houseCtrl.text.trim().isNotEmpty) {
                        setState(() {
                          DummyData.addresses.add(
                            AddressModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              name: nameCtrl.text.trim(),
                              phone: phoneCtrl.text.trim(),
                              houseNo: houseCtrl.text.trim(),
                              street: streetCtrl.text.trim(),
                              city: cityCtrl.text.trim(),
                              state: stateCtrl.text.trim(),
                              pincode: pincodeCtrl.text.trim(),
                              type: selectedType,
                              isDefault: DummyData.addresses.isEmpty,
                            ),
                          );
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("New address added successfully!")),
                        );
                      }
                    },
                    child: const Text(
                      "Save Address",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController ctrl, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Delivery Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: DummyData.addresses.length,
                itemBuilder: (context, index) {
                  final addr = DummyData.addresses[index];
                  bool isSelected = selectedAddressIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAddressIndex = index;
                        for (var a in DummyData.addresses) {
                          a.isDefault = false;
                        }
                        addr.isDefault = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<int>(
                            value: index,
                            groupValue: selectedAddressIndex,
                            activeColor: Colors.deepOrange,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  selectedAddressIndex = val;
                                  for (var a in DummyData.addresses) {
                                    a.isDefault = false;
                                  }
                                  addr.isDefault = true;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      addr.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        addr.type,
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  addr.fullAddress,
                                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.3),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Phone: ${addr.phone}",
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                            onPressed: () {
                              setState(() {
                                DummyData.addresses.removeAt(index);
                                if (selectedAddressIndex >= DummyData.addresses.length) {
                                  selectedAddressIndex = 0;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: _showAddAddressDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add New Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
