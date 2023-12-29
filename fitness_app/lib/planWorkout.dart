import 'package:fitness_app/bloc/plan_bloc.dart';
import 'package:fitness_app/bloc/start_bloc.dart';
import 'package:fitness_app/home_bloc.dart';
import 'package:fitness_app/home_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutPlanPage extends StatefulWidget {
  final String userId; // Add this line

  WorkoutPlanPage({Key? key, required this.userId}) : super(key: key); // Modify constructor

  @override
  _WorkoutPlanPageState createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  String? selectedValue;
  String? initialValue;
  bool isChanged = false;

  final List<String> workoutSplits = [
    'Bodybuilder Split',
    'Push/Pull/Legs Split',
    'Upper/Lower Body Split',
    'Fullbody',
  ];


  final List<String> workoutDetails = [
    'The Bodybuilder Split workout plan is a classic and highly effective approach to bodybuilding and muscle development. By selecting this workout, you will focus on a specific major muscle group each day, allowing for intense and targeted training. This split typically involves working on chest, back, shoulders, arms, and legs on separate days.',
    'The Push/Pull/Legs Split is a versatile and balanced workout routine, widely admired for its structured approach to training. In this program, you will divide your workouts into three distinct categories: push exercises, pull exercises, and leg exercises.',
    'The Upper/Lower Body Split is a balanced and effective training method that divides your workout routine into two distinct parts: one day focusing on the upper body muscles and the next on the lower body. This approach allows for targeted and intense training sessions, with ample recovery time for each muscle group.',
    'The Full Body Workout Plan is a comprehensive and efficient approach to fitness that involves exercising all major muscle groups in a single session. This plan is ideal for individuals seeking to improve overall strength, muscle tone, and cardiovascular health.',
  ];
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) {
        if (state is PlanSuccess) {
          setState(() {
            if (initialValue == null) {
              initialValue = state.split; // Store the initial value
            }
            selectedValue = state.split;
          });
        }
        // Handle other states if necessary
      },
      child: Scaffold(
        appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: _buildDropdown(),
              ),
            ),
            mainSection(),
            if (isChanged) _buildChangePlanButton(),
          ],
          ),
        ),
      ),
      
    );
  }

   Widget _buildChangePlanButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
                    child: Text('CHANGE PLAN', style: GoogleFonts.notoSans(
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                    )),
                    onPressed: () {
                      context.read<PlanBloc>().add(UpdatePlan(userId: widget.userId, split: selectedValue!));
                      Future.delayed(Duration(seconds: 1), () {
                      context.read<DayBloc>().add(DayRequested(id: widget.userId));
                      });

                      BlocListener<DayBloc, DayState>(
                        listener: (context, state) {
                          if (state is DaySuccess) {
                            final newDayValue = state.day;
                            print("newDayValue: $newDayValue");
                            context.read<StartBloc>().add(WorkoutRequested(Day: newDayValue));
                             
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF2FF00),
                      onPrimary: Colors.white,
                      minimumSize: Size(200, 50),
                    ),
                  ),
    );
  }


  Widget _buildDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
          hint: const Row(
            children: [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.black,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Workout Split',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: workoutSplits
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
         onChanged: (value) {
              setState(() {
                selectedValue = value;
                isChanged = initialValue != value; // Check if the value is different from the initial one
              });
            },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 300,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black,
              ),
              color: Color(0xFFF2FF00),
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 300,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Color(0xFFF2FF00),
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
      ),
    );
  }



  Widget mainSection() {
    
    if (selectedValue == null) {
      return Center(child: Text("Select a workout split."));
    } else {
      int index = workoutSplits.indexOf(selectedValue!);
      return Column(
  children: [
    SizedBox(height: 20),
     Text(
      selectedValue!,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    SizedBox(height: 20),
    Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Image.asset('assets/${selectedValue?.replaceAll('/', '')}.png', width: double.infinity, fit: BoxFit.cover),
    ),
    SizedBox(height: 20),
   
    SizedBox(height: 20),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "${workoutDetails[index]} \n\nRemember to complement your workout routine with proper nutrition, hydration, and rest for optimal results. This plan is particularly suitable for those looking to build muscle mass and achieve a bodybuilder-like physique.",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.w200,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ],
);
    }
  }
  // ... (rest of your methods like _buildDropdown and mainSection)
}

void _tryChangePlan() {

}
