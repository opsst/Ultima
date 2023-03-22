package main

import (
	"backend/controller"
	"backend/handle"
	"backend/model"
	"encoding/json"
	"io/ioutil"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/assert/v2"
)

func TestAddData(t *testing.T) {
	routeTest := gin.Default()

	m := handle.NewMember()

	routeTest.GET("/member", controller.AllData(m))

	routeTest.POST("/member", controller.AddData(m))
	t.Run("Get Data", func(t *testing.T) {
		req := httptest.NewRequest("GET", "/member", nil)
		res := httptest.NewRecorder()

		routeTest.ServeHTTP(res, req)

		response := res.Result()
		body, _ := ioutil.ReadAll(response.Body)

		result := model.Member{}
		_ = json.Unmarshal(body, &result)

		expect := model.Member{}

		assert.Equal(t, expect, result)
	})
	t.Run("Add Data", func(t *testing.T) {

		data := `{ "name": "frank","phone": 841539354,"email":"frank@mail.com"}`
		req := httptest.NewRequest("POST", "/member", strings.NewReader(data))
		res := httptest.NewRecorder()

		routeTest.ServeHTTP(res, req)
		response := res.Result()
		body, _ := ioutil.ReadAll(response.Body)

		result := model.Member{}
		_ = json.Unmarshal(body, &result)

		expect := model.Member{
			Name:  "frank",
			Phone: 841539354,
			Email: "frank@mail.com",
		}
		assert.Equal(t, expect, result)

	})
}
