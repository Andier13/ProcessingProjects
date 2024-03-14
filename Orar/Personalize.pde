color Background  = color(127, 255, 255);
color HeaderCell  = color(255, 160, 122);
color DefaultCell = color(255, 255, 255);
color CurrentCell = color(255, 150, 150);
color NextCell    = color(85,  255, 160);
String[][] orar = {
  {"Ora", "Luni",           "Marți",         "Miercuri",     "Joi",          "Vineri"      },
  {"---", "Lb. franceză",   "Lb. română",    "Fizică",       "Istorie",      "Lb. română"  },
  {"---", "Geografie",      "Matematică",    "Matematică",   "Lb. engleză",  "Matematică"  },
  {"---", "Filosofie",      "Lb. engleză",   "Informatică",  "Matematică",   "Lb. franceză"},
  {"---", "Informatică",    "Fizică",        "Informatică",  "Biologie",     "Diriginție"  },  
  {"---", "Fizică",         "Religie",       "Lb. română",   "TIC",          "Matematică"  },
  {"---", "Informatică",    "Chimie",        "Ed. fizică",   "Biologie",     "Lb. română"  }
};
int inceputulOrelor = time(8, 0);
int durataOra = 40;
int durataPauza = 10;
