import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'Apiprovider.dart';

class Weatherscreen extends ConsumerWidget {
  

  const Weatherscreen({super.key, required String location, });

  Color getColor(String condition) {
    if (condition == 'Clear') {
      return const Color.fromRGBO(255, 255, 255, 1);
    } else if (condition == 'Partly Cloudy') {
      return const Color.fromRGBO(0, 0, 0, 1);
    } else if (condition == 'Mist') {
      return const Color.fromRGBO(128, 128, 128, 1);
    } else {
      return const Color.fromARGB(255, 84, 142, 169);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouter.of(context).state.pathParameters['location'] ?? 'london';
    final weatherAsyncValue = ref.watch(weatherProvider(location));

    return Scaffold(
      body: weatherAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (weatherModel) {
          final currentData = weatherModel.current;
          final locationData = weatherModel.location;
          // final bgColor = getColor(currentData?.condition?.text ?? "Clear");

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(102, 93, 172, 228),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(208, 217, 224, 1),
                                spreadRadius: 2,
                                blurRadius: 2,
                              ),
                            ],
                            border: Border.all(
                              width: 0.5,
                              color: const Color.fromARGB(255, 157, 205, 230),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70, top: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          locationData?.name ?? 'Weather Not Found',
                          style: GoogleFonts.abrilFatface(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    locationData?.region ?? '',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(110, 183, 252, 1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color.fromRGBO(120, 166, 210, 1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(192, 206, 218, 1),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        RotationTransition(
                          turns: const AlwaysStoppedAnimation(10 / 360),
                          child: Image.network(
                            "https:${currentData?.condition?.icon ?? ''}",
                            // height: 150,
                            // width: 150,
                          ),
                        ),
                        // const SizedBox(height: 20),
                        Text(
                          currentData?.condition?.text ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${currentData?.tempC ?? 'N/A'} °C",
                          style: GoogleFonts.inter(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Lat | ${locationData?.lat ?? 'N/A'}°",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "Lon  | ${locationData?.lon ?? 'N/A'}°",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: EdgeInsets.only(left: 30),
                        //     ),
                        //     Icon(Icons.wind_power_outlined),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //    "Wind   |  ${currentData?.windkph ?? 'N/A'} km/h",
                        //       style: GoogleFonts.montserrat(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: EdgeInsets.only(left: 30),
                        //     ),
                        //     Icon(Icons.water_drop),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Hum   |  ${currentData?.humidity ?? 'N/A'} %",
                        //       style: GoogleFonts.montserrat(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
