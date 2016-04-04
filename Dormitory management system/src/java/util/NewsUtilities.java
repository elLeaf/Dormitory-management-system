/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import model.News;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author adisorn
 */
public class NewsUtilities {
    
    private Connection conn;
    
    public NewsUtilities(Connection conn) {
        this.conn = conn;
    }
    
    public News getNews(String id) {
        String sql = "select * from NEWS where news_id=?";
        News news = null;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                news = new News();
                news.setNews_id(rs.getString("news_id"));
                news.setNews_title(rs.getString("news_title"));
                news.setNews_detail(rs.getString("news_detail"));
                news.setNews_date(rs.getDate("news_date"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(NewsUtilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return news;
    }
    
}
