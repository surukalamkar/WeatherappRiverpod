// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Apiprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController inputLocationController = TextEditingController();
  String location = 'London';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenheight = MediaQuery.of(context).size.height;

    final weatherAsyncValue = ref.watch(weatherProvider(location));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(52, 147, 195, 1),
              Color.fromRGBO(255, 255, 255, 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: screenWidth * 0.88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.8),
                            Color.fromRGBO(83, 81, 81, 1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(255, 190, 219, 226),
                        ),
                      ),
                      child: TextField(
                        controller: inputLocationController,
                        onSubmitted: (value) {
                          setState(() {
                            location = inputLocationController.text;
                            inputLocationController.clear();
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Location',
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 1, 19, 26)),
                          icon: Icon(
                            Icons.search,
                            color: Color.fromRGBO(1, 20, 31, 0.902),
                          ),
                        ),
                        keyboardAppearance: Brightness.dark,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                // Show weather data based on async value
                weatherAsyncValue.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                  data: (weatherModel) {
                    return GestureDetector(
                      onTap: () {
                        context.go('/Weather_Screen/$location');
                        // Handle navigation to the detailed weather screen if needed
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(102, 93, 172, 228),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(141, 132, 132, 1),
                                spreadRadius: 3,
                                blurRadius: 4),
                          ],
                          border: Border.all(
                            width: 0.4,
                            color: const Color.fromARGB(255, 227, 229, 231),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 20),
                              child: SizedBox(
                                width: screenWidth * 0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      weatherModel.location?.name ??
                                          'Weather Not Found',
                                      style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "${weatherModel.location?.region}",
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "${weatherModel.location?.country}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 5,top: 30),
                                child: Column(
                                  children: [
                                    Text(
                                      "${weatherModel.current?.tempC ?? 'N/A'} °C",
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 35),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 110,
                ),
                const Image(
                  image: AssetImage("assets/W.png"),
                  height: 250,
                  width: 290,
                ),
                Text(
                  "Weather",
                  style: GoogleFonts.abrilFatface(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
