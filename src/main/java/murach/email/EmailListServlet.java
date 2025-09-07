package murach.email;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import murach.business.User;

@WebServlet("/emailList")
public class EmailListServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");

        // Tạo đối tượng User
        User user = new User(firstName, lastName, email);

        // Lưu user vào session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // Lấy danh sách users trong session (nếu chưa có thì tạo mới)
        ArrayList<User> users = (ArrayList<User>) session.getAttribute("users");
        if (users == null) {
            users = new ArrayList<>();
        }
        users.add(user);
        session.setAttribute("users", users);

        // Lưu ngày hiện tại vào request
        request.setAttribute("currentDate", new Date());

        // Điều hướng đến thanks.jsp
        String url = "/thanks.jsp";
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

