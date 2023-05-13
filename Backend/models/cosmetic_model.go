package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Cosmetic struct {
	Id          primitive.ObjectID `json:"id,omitempty"`
	Title       string             `json:"title,omitempty" validate:"required"`
	Description string             `json:"description,omitempty" validate:"required"`
}
