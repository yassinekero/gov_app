import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:gov/models/Equipe.dart';
import 'package:gov/models/Role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  int? id;
  final String matricule;
  final String name;
  final String? img;
   String? email;
  final String? phone;
  final Role? role;
  String? password;

  User(
      { this.id,
        required this.matricule,
        required this.name,
         this.img,
         this.email,
          this.phone,
        this.password,
        required this.created_at,
          this.updated_at,
        required  this.equipe_id,
        required  this.role_key,  this.role,});

  DateTime created_at;

  DateTime? updated_at;

   int? equipe_id;
   Equipe? equipe;
   String role_key;


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/*
CREATE TABLE IF NOT EXISTS `gov_db`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `matricule` VARCHAR(45) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `img` VARCHAR(255) NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `equipe_id` INT NULL,
  `role_key` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_equipe1_idx` (`equipe_id` ASC) VISIBLE,
  INDEX `fk_user_role1_idx` (`role_key` ASC) VISIBLE,
  UNIQUE INDEX `matricule_UNIQUE` (`matricule` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_user_equipe1`
    FOREIGN KEY (`equipe_id`)
    REFERENCES `gov_db`.`equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`role_key`)
    REFERENCES `gov_db`.`role` (`key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
* */