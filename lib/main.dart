import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
home: Sorting(),
));
}
class Sorting extends StatefulWidget {
  const Sorting({Key? key}) : super(key: key);

  @override
  State<Sorting> createState() => _SortingState();
}

class _SortingState extends State<Sorting> {

  List<int> _num=[];
  int _size = 500;
  _rand(){
    _num=[];
    for(int i=0;i<_size;++i){
      _num.add(Random().nextInt(_size));
    }
    setState(() {
    });
  }

  _bubble() async{
    for(int i=0;i<_num.length;++i){
      for(int j=0;j<_num.length-1-i;++j){
        if(_num[j]>_num[j+1]){
          int temp = _num[j];
          _num[j]= _num[j+1];
          _num[j+1]=temp;
        }
      }
         await Future.delayed(Duration(microseconds: 3000));
        setState(() {});
    }
  }

  _selection() async{
    int min=0;
    for(int i=0;i<_num.length-1;i++){
      min=i;
      for(int j=i+1;j<_num.length;j++){
        if(_num[j]<_num[min]){
          min=j;}}
          int temp1 = _num[i];
          _num[i]= _num[min];
          _num[min]=temp1;
      await Future.delayed(Duration(microseconds: 3000));
      setState(() {});
    }
  }

  void _quicksort(int first,int last) async{
  int i, j, pivot, temp;
  if(first<last){
  pivot=first;
  i=first;
  j=last;
  await Future.delayed(Duration(microseconds: 1500));
  setState(() {});
  while(i<j){
  while(_num[i]<=_num[pivot]&&i<last){
  i++;
  await Future.delayed(Duration(microseconds: 1500));
  setState(() {});}
  while(_num[j]>_num[pivot]){

    await Future.delayed(Duration(microseconds: 1500));
    setState(() {});
  j--;}
  if(i<j){
  temp=_num[i];
  _num[i]=_num[j];
  _num[j]=temp;}}
  temp=_num[pivot];
  _num[pivot]=_num[j];
  _num[j]=temp;
  _quicksort(first,j-1);
  _quicksort(j+1,last);
  await Future.delayed(Duration(microseconds: 1500));
  setState(() {});}}

  _shell()async{
    for (int gap = _num.length ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < _num.length; i += 1) {
        int temp = _num[i];
        int j;
        for (j = i; j >= gap && _num[j - gap] > temp; j -= gap) _num[j] = _num[j - gap];
        _num[j] = temp;
        await Future.delayed(Duration(microseconds: 1500));
        setState(() {});
      }
    }
  }

  void _heapify( int n,int i) async{
  int largest = i;
  int l = 2 * i + 1;
  int r = 2 * i + 2;
  if (l < n && _num[l] > _num[largest])
  largest = l;
  if (r < n && _num[r] > _num[largest])
  largest = r;
  if (largest != i) {
    int temp1 =_num[largest];
  _num[largest]=_num[i];
  _num[i]=temp1;
  _heapify( n,largest);
    await Future.delayed(Duration(microseconds: 1500));
    setState(() {});
  }
  }
  void _heapSort () async{
  for (int i = (_size ~/ 2) - 1; i >= 0; i--){
  _heapify(_size,i);
  await Future.delayed(Duration(microseconds: 1500));
  setState(() {});}
  for (int i = _size- 1; i > 0; i--) {
    int temp =_num[0];
    _num[0]=_num[i];
    _num[i]=temp;
  _heapify(i,0);
    await Future.delayed(Duration(microseconds: 1500));
    setState(() {});
  }}

  _insertion() async{
    int  key=0, j=0;
    for(int i=1;i<_num.length;++i){
      key=_num[i];
      j=i-1;
      while( j>=0 && _num[j]>key) {
        _num[j + 1] = _num[j];
        j = j - 1;
      }
        _num[j + 1] = key;
      await Future.delayed(Duration(microseconds: 3000));
      setState(() {});
    }
  }

  @override
  void initState(){
    super.initState();
    _rand();
  }

  @override
  Widget build(BuildContext context) {
    int counter=0;
    String dropdownValue = 'bubble';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Sorting Visualizer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),),
        actions: [
        DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.menu,color: Colors.lightBlueAccent,),
        elevation: 16,
        style: const TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold),
        underline: Container(
          height: 1.5,
          color: Colors.white,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            if(newValue=='bubble') {_bubble();}
            else if (newValue=='insertion') {_insertion();}
            else if(newValue=='selection'){_selection();}
            else if(newValue=='quick'){_quicksort(0,_num.length-1);}
            else if(newValue=='heap'){_heapSort();}
            else if(newValue=='shell'){_shell();}
          });
        },
        items: <String>['bubble', 'insertion', 'selection','quick','heap','shell']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        ),
        ],
      ),
      body: Container(
        child: Row(
          children: _num.map((int nums){
            counter++;
            return CustomPaint(
              painter: BarPainter(
                width: MediaQuery.of(context).size.width/_size,
                value: nums,
                index: counter,
              ),
            );
          }).toList(),

        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
              child: FlatButton(onPressed: _rand,
                 color: Colors.lightBlueAccent,
                 child: Text("RANDOMIZE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

          )),
        ],
      ),
      );
  }
}

class BarPainter extends CustomPainter{
  final double width;
  final int value;
  final int index;

  BarPainter({ required this.width ,required this.value ,required this.index });

  @override
  void paint(Canvas canvas, Size size){
    Paint paint = Paint();
    paint.color=Colors.lightBlueAccent;
    paint.strokeCap=StrokeCap.square;
    paint.strokeWidth=5.0;
    canvas.drawLine(Offset(index*width,0),Offset(index*width,value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}
