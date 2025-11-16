import 'package:flutter/material.dart';

class DetailedMembersModal extends StatelessWidget {
  const DetailedMembersModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Members Accompanied', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              children: List.generate(
                20,
                (index) => Card(
                  color: Colors.grey[100],
                  margin: EdgeInsets.all(0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(child: Icon(Icons.person)),
                          const SizedBox(height: 8.0),
                          Text(
                            'Member ${index + 1}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text('Role'),
                        ],
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () {},
                          customBorder: const CircleBorder(), // Makes the tap ripple circular
                          child: Container(
                            padding: const EdgeInsets.all(4.0), // Small padding around the icon
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Icon(Icons.close, size: 16.0, color: Colors.grey[600]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
