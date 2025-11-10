import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jago_volunteer_scanner/screens/widgets/detailed_members_modal.dart';
import 'package:jago_volunteer_scanner/screens/widgets/member_card.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  // I removed the userId and am using hardcoded data from the image
  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // This makes the status bar icons (like time, wifi) white
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            // Use SingleChildScrollView to allow content to scroll
            child: Column(
              children: [
                _buildProfileInfo(),
                _buildDetailsCard(),
                _buildMembersSection(context),
                // Add padding at the bottom so content isn't hidden
                // by the bottom navigation bar
                const SizedBox(height: 100),
              ],
            ),
          ),
          _buildHeader(context),
        ],
      ),
      // Use bottomNavigationBar for the sticky button at the bottom
      bottomNavigationBar: _buildCheckInButton(context),
    );
  }

  // --- Helper Widgets ---

  /// Builds the top section with the background image, back button,
  /// and overlapping profile picture.
  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allow the CircleAvatar to overflow
      alignment: Alignment.center,
      children: [
        // 1. Background Image
        Column(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // IMPORTANT: Add 'assets/concert_bg.png' to your pubspec.yaml
                  image: const AssetImage('lib/assets/images/profile_header_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              // Dimming overlay
            ),
          ],
        ),
        // 2. Back Button
        Positioned(
          top: 0,
          left: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
        // 3. Profile Picture (Overlapping)
        Positioned(
          // Position from the top: 240px (header height) - 55px (avatar radius)
          // This centers it on the bottom edge of the header
          top: 240 - 55,
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white, // This creates the white border
            child: CircleAvatar(
              radius: 50,
              // backgroundImage: const AssetImage('assets/profile_pic.png'),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the name and contact info just below the profile picture
  Widget _buildProfileInfo() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 60), // Space for overlapping avatar
      child: Column(
        children: [
          SizedBox(height: 250),
          const Text(
            'Sebin Adolf',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text('sebinadolf15@gmail.com | +9744463317', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  /// Builds the light gray card with key-value details
  Widget _buildDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100], // Very light gray
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildDetailRow('Phone Number', '9744463317'),
            SizedBox(height: 10),
            _buildDetailRow('Parish', 'St.George Church, Malom'),
            SizedBox(height: 10),
            _buildDetailRow('Member Of', 'KCYM'),
            SizedBox(height: 10),
            _buildDetailRow('Vehicle Parked At', 'Slot 23A'),
          ],
        ),
      ),
    );
  }

  /// Helper for a single row in the details card
  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }

  /// Builds the "Members Accompanied" title and horizontal list
  Widget _buildMembersSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Members Accompanied',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                TextButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return DetailedMembersModal();
                    },
                  ),
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150, // Fixed height for the horizontal list
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: const [
                // IMPORTANT: Add these placeholder images to your assets
                MemberCard(
                  name: 'Nevin Mathew',
                  relation: 'Son',
                  // imagePath: 'assets/nevin.png',
                ),
                MemberCard(
                  name: 'Jemima Mat...',
                  relation: 'Wife',
                  // imagePath: 'assets/jemima.png',
                ),
                MemberCard(
                  name: 'Rima Mathew',
                  relation: 'Daughter',
                  // imagePath: 'assets/rima.png',
                ),
                MemberCard(
                  name: 'Rima Mathew',
                  relation: 'Daughter',
                  // imagePath: 'assets/rima.png',
                ),
                MemberCard(
                  name: 'Nevin Mathew',
                  relation: 'Son',
                  // imagePath: 'assets/nevin.png',
                ),
                MemberCard(
                  name: 'Jemima Mat...',
                  relation: 'Wife',
                  // imagePath: 'assets/jemima.png',
                ),
                MemberCard(
                  name: 'Rima Mathew',
                  relation: 'Daughter',
                  // imagePath: 'assets/rima.png',
                ),
                MemberCard(
                  name: 'Rima Mathew',
                  relation: 'Daughter',
                  // imagePath: 'assets/rima.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the sticky green button at the bottom
  Widget _buildCheckInButton(BuildContext context) {
    return Container(
      color: Colors.white, // Match the page background
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: SafeArea(
        // SafeArea for bottom phone controls
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E6050), // Dark green from image
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () {
            // Handle check-in logic
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_forward_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text('Swipe to check-in the participant', style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
