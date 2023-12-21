import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Pagedejeux extends StatefulWidget {
 String player1;
 String player2;
  Pagedejeux({super.key,  required this.player1, required this.player2});

  @override
  State<Pagedejeux> createState() => _PagedejeuxState();
}

class _PagedejeuxState extends State<Pagedejeux> {
  late List<List<String>> _list;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;
  @override
  void initState() {
    super.initState();
    _list = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  void _recomencerjeux() {
    setState(() {
      _list = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_list[row][col] != "" || _gameOver) {
      return;
    }
    setState(() {
      _list[row][col] = _currentPlayer;
      if (_list[row][0] == _currentPlayer &&
          _list[row][1] == _currentPlayer &&
          _list[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_list[0][col] == _currentPlayer &&
          _list[1][col] == _currentPlayer &&
          _list[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_list[0][0] == _currentPlayer &&
          _list[1][1] == _currentPlayer &&
          _list[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_list[0][2] == _currentPlayer &&
          _list[1][1] == _currentPlayer &&
          _list[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }

      _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      if (!_list.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = "ce une revanger";
      }
      if (_winner != "") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Jouer Encor",
          title: _winner == "X"
              ? widget.player1 + "Won!"
              : _winner == "O"
                  ? widget.player2 + "Won!"
                  : "ce une revanger",
          btnOkOnPress: () {
            _recomencerjeux();
          },
        )..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.black87,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Tour de : ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        _currentPlayer == "X"
                            ? "${widget.player1}($_currentPlayer)"
                            : "${widget.player2}($_currentPlayer)",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: _currentPlayer == "X"
                                ? const Color.fromARGB(255, 96, 134, 238)
                                : const Color.fromARGB(255, 115, 212, 24)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () => _makeMove(row, col),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            _list[row][col],
                            style: TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                              color: _list[row][col] == "X"
                                  ? Colors.red
                                  : const Color.fromARGB(255, 115, 212, 24),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: _recomencerjeux,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: const Text(
                        "Comencer",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 27,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: const Text(
                        "Recomencer",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
