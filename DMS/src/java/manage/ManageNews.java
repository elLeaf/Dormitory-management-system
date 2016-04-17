/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.News;

/**
 *
 * @author anst_
 */
public class ManageNews {
    
    private Connection conn;
    private News news;
    
    public ManageNews(Connection conn) {
        this.conn = conn;
        news = new News();
    }
    
    public boolean setNews(int news_id) {
        boolean result = false;
        String sql = "select * from news where news_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, news_id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                news.setId(rs.getInt("news_id"));
                news.setTitle(rs.getString("news_title"));
                news.setDetail(rs.getString("news_detail"));
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageNews.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public News getNews() {
        return news;
    }
    
    public boolean createNews(News news) {
        boolean result = false;
        String sql = "insert into news values(null, ?, ?, curdate(), ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, news.getTitle());
            pstmt.setString(2, news.getDetail());
            pstmt.setInt(3, news.getEmp_id());
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageNews.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean updateNews(News news) {
        boolean result = false;
        String sql = "update news set news_title=?, news_detail=? where news_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, news.getTitle());
            pstmt.setString(2, news.getDetail());
            pstmt.setInt(3, news.getId());
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageNews.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean deleteNews(int news_id) {
        boolean result = false;
        String sql = "delete from news where news_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, news_id);
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageNews.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
}
