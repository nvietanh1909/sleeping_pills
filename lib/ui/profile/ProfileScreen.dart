import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isEditing = false;

  // Giả sử đây là thông tin người dùng ban đầu
  String _userName = 'Nguyễn Việt Anh';
  String _userEmail = 'vietanh@example.com';

  @override
  void initState() {
    super.initState();
    _nameController.text = _userName;
    _emailController.text = _userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 13, 5, 59),
              Color.fromARGB(255, 17, 17, 39),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // Hình ảnh đại diện người dùng với khoảng cách từ trên
            SizedBox(height: 40), // Khoảng cách từ trên
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.jpg'), // Đặt ảnh đại diện
              ),
            ),
            SizedBox(height: 20),

            // About Me
            _buildSectionHeader('About Me'),
            _buildInfoRow('Name:', _userName),
            _buildInfoRow('Email:', _userEmail),

            SizedBox(height: 30),

            // Sleep Settings
            _buildSectionHeader('Sleep Settings'),
            ListTile(
              title: Text('Sleep Goal', style: TextStyle(color: Colors.white)),
              subtitle: Text('8 hours', style: TextStyle(color: Colors.white70)),
              trailing: Icon(Icons.edit, color: Colors.deepPurple),
              onTap: () {
                // Thực hiện hành động khi nhấn vào Sleep Goal
              },
            ),
            ListTile(
              title: Text('Sleep Quality', style: TextStyle(color: Colors.white)),
              subtitle: Text('Good', style: TextStyle(color: Colors.white70)),
              trailing: Icon(Icons.edit, color: Colors.deepPurple),
              onTap: () {
                // Thực hiện hành động khi nhấn vào Sleep Quality
              },
            ),

            SizedBox(height: 30),

            // General Settings
            _buildSectionHeader('General Settings'),
            ListTile(
              title: Text('Notifications', style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Thực hiện hành động thay đổi notifications
                },
                activeColor: Colors.deepPurple,
              ),
            ),
            ListTile(
              title: Text('Privacy Settings', style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
              onTap: () {
                // Thực hiện hành động khi nhấn vào Privacy Settings
              },
            ),

            SizedBox(height: 30),

            // Language
            _buildSectionHeader('Language'),
            ListTile(
              title: Text('English', style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
              onTap: () {
                // Thực hiện hành động thay đổi ngôn ngữ
              },
            ),

            SizedBox(height: 30),

            // Button Edit Profile
            _isEditing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _saveChanges,
                        child: Text('Save Changes'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _cancelEditing,
                        child: Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: _startEditing,
                    child: Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Màu chữ gần trắng
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Bắt đầu chỉnh sửa thông tin
  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  // Hủy chỉnh sửa
  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _nameController.text = _userName;
      _emailController.text = _userEmail;
    });
  }

  // Lưu thay đổi
  void _saveChanges() {
    setState(() {
      _userName = _nameController.text;
      _userEmail = _emailController.text;
      _isEditing = false;
    });
  }
}
