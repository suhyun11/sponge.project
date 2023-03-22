package com.solponge.domain.cart.impl;

import com.solponge.domain.cart.CartItemVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Repository
public class CartItemDAO {

    @Autowired
    private SqlSession sqlSession;

    /**
     * 기본 CRUD 구현
     */

    public String cartItemInsert(CartItemVo cartItemVo) {
        sqlSession.insert("cartItem.insertCartItem", cartItemVo);
        return String.valueOf(cartItemVo.getCART_ITEM_NUM());
    }

    public CartItemVo cartItemFindByNum(int CART_ITEM_NUM) {
        Map<String,Object> param=new HashMap<>();
        param.put("CART_ITEM_NUM",CART_ITEM_NUM);
        CartItemVo cartItem = (CartItemVo) sqlSession.selectOne("cartItem.selectCartItem", param);
        return cartItem;
    }

    public List<CartItemVo> cartITemFindAll(){
        return sqlSession.selectList("cartItem.list");
    }

    public void cartItemUpdate(int CART_ITEM_NUM, CartItemVo cartItemVo){
        Map<String,Object> param=new HashMap<>();
        param.put("CART_ITEM_NUM",CART_ITEM_NUM);
        param.put("CART_ITEM_STOCK",cartItemVo.getCART_ITEM_STOCK());
        sqlSession.update("cartItem.updateCartItem",param);
    }

    public void cartItemDelete(int CART_ITEM_NUM){
        Map<String,Object> param=new HashMap<>();
        param.put("CART_ITEM_NUM",CART_ITEM_NUM);
        sqlSession.delete("cartItem.deleteCartItem",param);
    }

    public void cartItemDeleteFromMember(int MEMBER_NO){
        Map<String,Object> param=new HashMap<>();
        param.put("MEMBER_NO",MEMBER_NO);
        sqlSession.delete("cartItem.deleteCartItemByMember",param);
    }


}
