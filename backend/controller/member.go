package controller

import (
	"backend/handle"
	"backend/model"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
)

func AllData(m *handle.MemberData) func(c *gin.Context) {
	return func(c *gin.Context) {
		c.JSON(200, m.AllData())
	}
}

func AddData(m *handle.MemberData) func(c *gin.Context) {
	return func(c *gin.Context) {
		validate := validator.New()
		validate.RegisterValidation("is_frank", ValidateFrank)
		var v model.Member
		err := c.ShouldBindJSON(&v)
		if err != nil {
			c.JSON(400, gin.H{
				"message": err.Error(),
			})
			return
		}
		err = validate.Struct(v)
		if err != nil {
			c.JSON(400, gin.H{
				"message": err.Error(),
			})
			return
		}
		m.AddData(v)
		c.JSON(200, v)
	}
}

func ValidateFrank(field validator.FieldLevel) bool {
	return strings.Contains(field.Field().String(), "frank")
}
