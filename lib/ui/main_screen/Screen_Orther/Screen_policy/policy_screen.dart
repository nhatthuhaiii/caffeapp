import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class policy_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chính Sách The Coffee House'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Giới thiệu chung'),
            _buildText('Khi khách hàng truy cập vào ứng dụng The Coffee House, website order.thecoffeehouse.com hoặc đặt hàng qua hotline 18006936 của The Coffee House có nghĩa là khách hàng đã đồng ý với các điều khoản này. The Coffee House có quyền thay đổi, chỉnh sửa, thêm hoặc lược bỏ bất kỳ phần nào trong Điều khoản sử dụng này vào bất cứ lúc nào. Các thay đổi có hiệu lực ngay khi '
                'được đăng trên trang web, ứng dụng mà không cần thông báo trước. Khi khách hàng tiếp tục sử dụn'
                'g dịch vụ giao hàng của The Coffee House, sau khi các thay đổi về Điều khoản này '
                'được đăng tải, có nghĩa là khách hàng chấp nhận với những thay đổi đó.Khách hàng vui lòng kiểm tra thường xuyên các quy định và điều khoản dưới đây để cập nhật những thay đổi của chúng tôi.'),

            _buildSectionTitle('Chính sách Tài khoản Người dùng'),
            _buildText('Khách hàng cam kết và cung cấp thông tin chính xác nhằm mục đích'
                ' nhận được phục vụ tốt nhất từ The Coffee HouseMỗi số điện thoại chỉ tạo được'
                ' một (01) tài khoản cho mục đích sử dụng cá nhân.Để đảm bảo quyền lợi, khách hàng'
                ' không chia sẻ thông tin tài khoản (tên truy cập và mật khẩu) '
                'cho người khác sử dụng tài khoản The Coffee House, hoặc chuyển nhượng tài '
                'khoản cho bất kỳ ai khác mà chưa thông qua The Coffee House.The Coffee House có quyền khóa tài khoản hoặc khóa một phần tính năng của tài khoản (như tính năng Đặt hàng/ Tích điểm..) của khách hàng khi The Coffee House phát hiện khách hàng vi phạm điều khoản hoặc chính sách của công ty hoặc có hành vi mua hàng không trung thực điển hình như:Tạo các đơn hàng ảo, hoặc đánh giá ảo.Không nhận đơn hàng đã đặt mà không cung cấp lý do chính đáng.Có dấu hiệu lừa đảo hoặc lạm dụng các mã giảm giá và chương trình khuyến mãi để trục lợiCác trường hợp khác mà hệ thống của The Coffee House phát hiện được. Tùy từng trường hợp, The Coffee House sẽ có biện pháp xử lý thích hợp, bao gồm khóa tài khoản mà không cần thông báo trước.Tài khoản bị khóa  hoặc khóa một phần tính năng sẽ được cấp lại sau khi hoàn thành quá trình xác minh qua các chứng từ/thông tin khách hàng cung cấp chứng minh việc mua hàng (hóa đơn, hình ảnh sản phẩm đã mua,..) và có sự đồng thuận giữa khách hàng và The Coffee House.        '),

            _buildSectionTitle('Giới thiệu về các loại dịch vụ'),
            _buildText('Dịch vụ “Giao hàng”: là dịch vụ mà khách hàng đặt sản phẩm ngay tại nhà và được The Coffee House giao hàng tận nơi.Sau khi khách hàng đặt hàng thành công, The Coffee House sẽ thực hiện đơn hàng và giao hàng đến địa chỉ mà khách hàng đã chọn.Dịch vụ “Mang đi” (tại ứng dụng The Coffee House): là dịch vụ mà khách hàng có thể đặt món trước và đến The Coffee House nhận sản phẩm mang đi.Sau khi chọn hình thức "Mang Đi" và đặt hàng thành công, khách hàng chủ động đến Cửa hàng The Coffee House đã chọn trên đơn hàng để nhận sản phẩm.'),

            _buildSectionTitle('Chính sách sử dụng dịch vụ'),
            _buildText('Khách hàng được quyền chủ động chọn loại dịch vụ để sử dụng khi bắt đầu đặt đơn hàng.Với đơn hàng của dịch vụ "Giao hàng" và "Mang đi", khách hàng vui lòng không sử dụng tại Cửa hàng.The Coffee House có quyền từ chối hỗ trợ giao hàng với đơn hàng của dịch vụ “Mang đi”.'),

            _buildSectionTitle('Chấp nhận đơn hàng và giá cả'),
            _buildText('Tất cả các đơn hàng sau khi được Xác nhận đặt hàng sẽ được The Coffee House xử lý tự động và thực hiện đơn hàng. Trong một số trường hợp, The Coffee House sẽ chủ động liên hệ khách hàng để xác nhận lại thông tin đơn hàng qua cuộc gọi nếu các thông tin trên đơn hàng của khách hàng cung cấp chưa đầy đủ.The Coffee House có quyền từ chối hoặc hủy bỏ đơn hàng của khách hàng vì bất kỳ lý do gì liên quan đến lỗi kỹ thuật, hệ thống một cách khách quan sau khi đã liên hệ thông báo với khách hàng. Trường hợp liên hệ 3 lần liên tục không thành công trong vòng 30 phút, chúng tôi sẽ tự động hủy đơn hàng của quý khách. The Coffee House rất tiếc vì chưa thể hoàn thành đơn hàng của quý khách trong trường hợp này.The Coffee House cam kết sẽ cung cấp thông tin giá cả chính xác nhất cho khách hàng. Tuy nhiên, đôi lúc vẫn có sai sót xảy ra, ví dụ như trường hợp giá sản phẩm không hiển thị chính xác trên trang web hoặc sai giá, tùy theo từng trường hợp chúng tôi sẽ liên hệ hướng dẫn xử lý hoặc thông báo hủy đơn hàng đó cho khách hàng.'),

            _buildSectionTitle('Phương thức thanh toán'),
            _buildText('Khách hàng được quyền lựa chọn hình thức thanh toán phù hợp với nhu cầu, The Coffee House cung cấp các phương thức thanh toán cho đơn hàng như sau:Thanh toán tiền mặt (COD): khách hàng thanh toán khi nhận hàng.Thanh toán trực tuyến bằng thẻ nội địa (ATM), thẻ quốc tế (Visa, master…) qua cổng thanh toánThanh toán trực tuyến bằng các ví điện tử như Momo, Zalo Pay, Shopee Pay...(*) Riêng đối với đơn hàng được đặt qua hotline 18006936, The Coffee House chỉ cung cấp phương thức thanh toán tiền mặt (COD).'),



           ]
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
      ),
    );
  }

  Widget _buildText(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}