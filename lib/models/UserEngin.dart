import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:gov/models/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserEngin.g.dart';

@JsonSerializable()
class UserEngin {
  final int id;

  UserEngin(
      {required this.id,
        required this.voie_engin_id,
        required this.user_id,
        required this.tache,
        required this.composition_id,
        required this.status,
        required this.created_at,
         this.deleted_at,
         this.updated_at,
        required this.user});

  int voie_engin_id;
   int user_id;
   String tache;
   int composition_id;
   bool? status;



  DateTime created_at;
  DateTime? deleted_at;
  DateTime? updated_at;

User user;




  factory UserEngin.fromJson(Map<String, dynamic> json) => _$UserEnginFromJson(json);

  Map<String, dynamic> toJson() => _$UserEnginToJson(this);
}



/*
CREATE TABLE IF NOT EXISTS `gov_db`.`user_engin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `voie_engin_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `tache` VARCHAR(300) NOT NULL,
  `composition_id` INT NOT NULL,
  `status` SMALLINT NULL DEFAULT 0 COMMENT 'null =  prealable\n0    =  affected\n1    =  finished',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_has_engin_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_engin_voie_engin1_idx` (`voie_engin_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_engin_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `gov_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_engin_voie_engin1`
    FOREIGN KEY (`voie_engin_id`)
    REFERENCES `gov_db`.`voie_engin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
* */
