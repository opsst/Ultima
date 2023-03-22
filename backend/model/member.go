package model

type Member struct {
	Name  string `json:"name" binding:"required" validate:"is_frank"`
	Phone int    `json:"phone" binding:"required"`
	Email string `json:"email" binding:"required,email"`
}
