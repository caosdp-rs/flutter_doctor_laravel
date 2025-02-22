import 'package:doctor_flutter_laravel/components/button.dart';
import 'package:doctor_flutter_laravel/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_appbar.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  // for favortite button
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    //get arguments passed from doctor card
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: FaIcon(
                isFav ? Icons.favorite_rounded : Icons.favorite_outline,
                color: Colors.red),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          //pass doctor details here
          AboutDoctor(
            doctor: doctor,
          ),
          DetailBody(doctor: doctor),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Button(
              width: double.infinity,
              title: 'Book Appointment',
              onPressed: () {
                Navigator.of(context).pushNamed('booking_page',
                    arguments: {"doctor_id": doctor['doc_id']});
              },
              disable: false,
            ),
          )
        ],
      )),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key, required this.doctor}) : super(key: key);
  final Map<dynamic, dynamic> doctor;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65.0,
            backgroundImage: NetworkImage(
                "http://192.168.0.112:8000${doctor['doctor_profile']}"),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            'Dr. ${doctor['doctor_name']}',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'MBBS ( International Medical University Malaysia),MRCP Royal College of dkORoyal College of dkO(Royal College of dkO)',
              style: TextStyle(color: Colors.grey, fontSize: 15),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Sarawak General Hospital',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key, required this.doctor}) : super(key: key);
  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
        padding: const EdgeInsets.all(5),
        //margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Config.spaceSmall,
            DoctorInfo(
              patients: doctor['patients'],
              exp: doctor['experience'],
            ),
            Config.spaceMedium,
            const Text(
              'About Doctor',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Config.spaceSmall,
            Text(
              'Dr. ${doctor['doctor_name']} tem experiência ${doctor['category']}',
              style: const TextStyle(fontWeight: FontWeight.w500, height: 1.5),
              softWrap: true,
              textAlign: TextAlign.justify,
            )
            //doctor exp, patient and rating
          ],
        ));
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key? key, required this.patients, required this.exp})
      : super(key: key);
  final int patients;
  final int exp;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InfoCard(
          label: 'Pacientes',
          value: '$patients',
        ),
        const SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Experiência',
          value: '$exp',
        ),
        const SizedBox(
          width: 15,
        ),
        const InfoCard(
          label: 'Rating',
          value: '4.6',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label, required this.value})
      : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Config.primaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Column(children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        )
      ]),
    ));
  }
}
