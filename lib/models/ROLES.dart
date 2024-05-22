 enum ROLES{
  RCI,
   DUO,
   DPX,
   TECH,
   TECH_HABILITE,
   ADMIN,
   AFF;

   static ROLES getRoleByKey(String key){
     switch(key){
       case "rci":
         return ROLES.RCI;
       case "duo":
         return ROLES.DUO;
       case "dpx":
         return ROLES.DPX;
       case "tech":
         return ROLES.TECH;
       case "admin":
         return ROLES.ADMIN;
       case "tech_habilite":
         return ROLES.TECH_HABILITE;
     }
     return ROLES.AFF;
 }


}