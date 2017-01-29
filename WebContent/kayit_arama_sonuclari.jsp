<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/sytle.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Kayıt Arama Sonuçları</title>
</head>
<body>
<div id="container">
	<!--MENU BAŞI -->
	<table width="550" border="0">
		<tr>

			<td width="43"><a href="index.jsp"> <img
					src="resimler/anasayfa.png" alt="Kayıt Arama" width="32"
					height="32" border="0">
			</a></td>
			<td width="141"><a href="index.jsp" title="Anasayfa">Anasayfa</a></td>


			<td width="43"><a href="kayit_arama.jsp"> <img
					src="resimler/ara.png" alt="Kayıt Arama" width="32" height="32"
					border="0">
			</a></td>
			<td width="141"><a href="kayit_arama.jsp" title="Kayıt Arama">Kayıt
					Arama</a></td>

			<td width="43"><a href="kayit_girisi.jsp"> <img
					src="resimler/ekle.png" alt="Yeni Kayıt Girişi" width="32"
					height="32" border="0">
			</a></td>
			<td width="141"><a href="kayit_girisi.jsp"
				title="Yeni Kayıt Girişi">Yeni Kayıt Girişi</a></td>
		</tr>
	</table>

	<!--MENU SONU -->

	<h1>Kayıt Arama Sonuçları</h1>

	<table>
		<tr>
			<td><strong>Sıra</strong></td>
			<td><strong>No</strong></td>
			<td><strong>Adı</strong></td>
			<td><strong>Soyadı</strong></td>
			<td><strong>Fakülte</strong></td>
			<td><strong>Bölüm</strong></td>
		</tr>

		<%
			try {
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

				String url = "jdbc:sqlserver://localhost:52633;"
						+ "databaseName=Universite;user=KATERINA;password=1453";

				Connection con = DriverManager.getConnection(url);
				// out.println("Baglandık.");
				Statement stmt = null;
				ResultSet rs = null;

				//KAYITLARI SORGULAMA KOMUTLARI
				// SQL query command
				String NO = request.getParameter("No") + "%";
				String ADI = request.getParameter("Adi") + "%";
				String SOYADI = request.getParameter("Soyadi") + "%";

				String SQL = "SELECT  * FROM Ogrenci " + "WHERE No LIKE '" + NO
						+ "' AND  Adi LIKE '" + ADI + "' AND  Soyadi LIKE '"
						+ SOYADI + "' ";

				stmt = con.createStatement();
				rs = stmt.executeQuery(SQL);
		%>

		<%!int i = 0;
	String renk = "#ffccff";%>

		<%
			while (rs.next()) {

					i = i % 2;
					if (i == 0) {
						renk = "#ffff99";
					} else {
						renk = "#ccffcc";
					}
		%>
		<tr bgcolor="<%out.println(renk);%>">


			<td><%=rs.getInt("Id")%></td>
			<td><%=rs.getString("No")%></td>
			<td><%=rs.getString("Adi")%></td>
			<td><%=rs.getString("Soyadi")%></td>
			<td><%=rs.getString("Fakulte")%></td>
			<td><%=rs.getString("Bolum")%></td>

		</tr>
		<%
			i = i + 1;
		%>

		<%
			}
				con.close();
			} catch (SQLException e) {
				out.println("SQL Hata: " + e.toString());

			} catch (ClassNotFoundException cE) {
				out.println("Sınıfı bulma hatası: " + cE.toString());
			}
		%>
	</table>
	</div>
</body>
</html>