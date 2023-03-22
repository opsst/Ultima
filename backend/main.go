package main

import (
	"backend/controller"
	"backend/handle"
	"strings"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.Use(MyAuth)

	m := handle.NewMember()

	r.GET("/member", controller.AllData(m))

	r.POST("/member", controller.AddData(m))

	r.Run(":8088") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}

func MyAuth(c *gin.Context) {

	token := c.GetHeader("Authorization")
	auth := strings.Split(token, " ")
	if len(auth) != 2 || auth[0] != "Bearer" {
		c.AbortWithStatusJSON(401, gin.H{"error": "Authorization Failed"})
		return
	}
	if auth[1] != "SecretToken" {
		c.AbortWithStatusJSON(401, gin.H{"error": "Invalid API Token"})
		return
	}
	c.Next()
}
