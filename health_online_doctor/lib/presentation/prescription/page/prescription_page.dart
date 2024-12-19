import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/common/bloc/button/button_state.dart';
import 'package:health_online_doctor/common/bloc/button/button_state_cubit.dart';
import 'package:health_online_doctor/data/prescription/models/prescription_medicine_post.dart';
import 'package:health_online_doctor/data/prescription/models/prescription_post.dart';
import 'package:health_online_doctor/domain/appointment/entity/appointment_entity.dart';
import 'package:health_online_doctor/domain/prescription/entity/medical_find_entity.dart';
import 'package:health_online_doctor/domain/prescription/usecase/add_prescription_usecase.dart';
import 'package:health_online_doctor/presentation/dashboard/page/dashboard_page.dart';

import '../bloc/get_medical_cubit.dart';
import '../bloc/get_medical_state.dart';

class PrescriptionPage extends StatefulWidget {
  final AppointmentEntity appointment;

  PrescriptionPage(this.appointment);

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  List<Map<String, TextEditingController>> _fields = [];
  TextEditingController _diagnosisController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  int _fieldCount = 1;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void onAdd(BuildContext context) {
    try {
      String diagnosis = _diagnosisController.text ?? "";
      if (diagnosis == "" && _fields.length == 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('vui lòng điền field chẩn đoán và kê ít nhất 1 thuốc')));
        return;
      } else {
        List<PrescriptionMedicinePost> medicines = [];
        for (Map<String, TextEditingController> field in _fields) {
          String medicalName = field['medicalName']?.text ?? '';
          int quantity = int.parse(field['quantity']!.text);
          String dosage = field['dosage']?.text ?? '';
          String unit = field['medicalUnit']?.text ?? '';
          String id = field['medicalId']?.text ?? '';
          if (medicalName != '' &&
              quantity != 0 &&
              dosage != '' &&
              unit != '' &&
              id != '') {

            PrescriptionMedicinePost medicinePost = PrescriptionMedicinePost(
                idMedicine: id, dosage: dosage, quantity: quantity);
            medicines.add(medicinePost);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('vui lòng điền hết các field thuốc đã tạo')));
            return;
          }
          PrescriptionPost prescriptionPost = PrescriptionPost(
              idAppointment: widget.appointment.id,
              diagnosis: _diagnosisController.text,
              note: _noteController.text,
              prescriptionMedicineList: medicines);
          context.read<ButtonStateCubit>().execute(
              usecase: AddPrescriptionUseCase(), params: prescriptionPost);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text(e.toString())));
    }
  }

  OverlayEntry _createOverlay(
      List<MedicalFindEntity> suggestions,
      TextEditingController controller,
      TextEditingController controllerId,
      TextEditingController controllerUnit) {
    return OverlayEntry(
      builder: (context) => CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: const Offset(0, 40),
        // Điều chỉnh khoảng cách dưới TextField
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 200.0, // Giới hạn chiều cao tối đa của menu
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index].name),
                  onTap: () {
                    controller.text = suggestions[index].name;
                    controllerId.text = suggestions[index].id;
                    _removeOverlay();
                    setState(() {
                      controllerUnit.text = suggestions[index].unit;
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay(
      List<MedicalFindEntity> suggestions,
      TextEditingController controller,
      TextEditingController controllerId,
      TextEditingController controllerUnit) {
    _removeOverlay();
    _overlayEntry =
        _createOverlay(suggestions, controller, controllerId, controllerUnit);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void _addFields() {
    setState(() {
      _fields.add({
        'medicalName': TextEditingController(),
        'medicalId': TextEditingController(),
        'medicalUnit': TextEditingController(),
        'quantity': TextEditingController(),
        'dosage': TextEditingController(),
      });
      _fieldCount++;
    });
  }

  void _minusFields(int index) {
    setState(() {
      _fields.removeAt(index);
      _fieldCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Prescription for ${widget.appointment.victimName}')),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => GetMedicalCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => ButtonStateCubit(),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (BuildContext context, ButtonState state) {
              if (state is ButtonLoadingState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Center(
                  child: CircularProgressIndicator(),
                )));
              }
              if (state is ButtonSuccessState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("add Success")));
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => DashboardPage()));
              }
              if (state is ButtonFailureState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage)));
              }
            },
            child: Column(
              children: [
                _patientDescription(),
                const SizedBox(height: 10),
                _input(),
                const SizedBox(height: 10),
                _keThuocText(),
                const SizedBox(height: 10),
                _listView(),
                const SizedBox(height: 10),
                _buttonAddField(),
                const SizedBox(height: 10),
                _addPrescription(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listView() {
    return Expanded(
      child: Builder(builder: (context) {
        return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: _fields.length,
            itemBuilder: (context, index) {
              return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text((index + 1).toString() + "."),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 7,
                            child: CompositedTransformTarget(
                              link: _layerLink,
                              child: TextField(
                                controller: _fields[index]['medicalName'],
                                decoration: const InputDecoration(
                                  labelText: 'Nhập tên thuốc',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    context
                                        .read<GetMedicalCubit>()
                                        .onFinding(value);
                                  } else {
                                    _removeOverlay();
                                  }
                                },
                              ),
                            ),
                          ),
                          BlocListener<GetMedicalCubit, GetMedicalState>(
                            listener: (context, state) {
                              if (state is GetMedicalSuccess &&
                                  state.medicals.isNotEmpty) {
                                _showOverlay(
                                    state.medicals,
                                    _fields[index]['medicalName']!,
                                    _fields[index]['medicalId']!,
                                    _fields[index]['medicalUnit']!);
                              } else {
                                _removeOverlay();
                              }
                            },
                            child:
                                const SizedBox(), // Không hiển thị UI từ BlocBuilder
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _fields[index]['quantity'],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'số lượng',
                                  hintText: '0',
                                  suffixText:
                                      _fields[index]['medicalUnit']?.text ??
                                          ' '),
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _fields[index]['dosage'],
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Liều lượng'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: GestureDetector(
                              onTap: () => _minusFields(index),
                              child: Container(
                                height: 20,
                                width: 20,
                                color: Colors.red,
                                child: const Icon(
                                  CupertinoIcons.minus,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ));
            });
      }),
    );
  }

  Widget _patientDescription() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
        ),
        Text("Bệnh nhân:    Phan văn A"),
        SizedBox(
          width: 520,
        ),
        Text('Tuổi: 19'),
      ],
    );
  }

  Widget _input() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Chẩn đoán: '),
        Container(
          width: 500,
          height: 35,
          child: TextField(
            controller: _diagnosisController,
            style: const TextStyle(
              fontSize: 15,
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ),
        const SizedBox(
          width: 100,
        ),
        const Text('Ghi chú: '),
        Container(
          width: 500,
          height: 35,
          child: TextField(
            controller: _noteController,
            style: const TextStyle(
              fontSize: 15,
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _keThuocText() {
    return const Align(
        alignment: Alignment.topCenter,
        child: Text(
          'Kê thuốc',
          style: TextStyle(fontSize: 34),
        ));
  }

  Widget _buttonAddField() {
    return FloatingActionButton(
      onPressed: _addFields,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

  Widget _addPrescription(BuildContext) {
    return Builder(builder: (context) {
      return ElevatedButton(
          onPressed: () {
            onAdd(context);
          },
          child: const Text('Kê đơn'));
    });
  }
}
