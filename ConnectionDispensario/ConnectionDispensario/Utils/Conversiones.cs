﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Utils
{
    public static class Conversiones
    {


        public static string SQL_To_FullString_DateTime(DateTime p) 
        {
            string day = p.Day.ToString();
            string month = p.Month.ToString();
            string year = p.Year.ToString();
            string hour = p.Hour.ToString();
            string minutes = p.Minute.ToString();
            string seconds = p.Second.ToString();

            day = day.Length == 1 ? "0" + day : day;
            month = month.Length == 1 ? "0" + month : month;
            hour = hour.Length == 1 ? "0" + hour : hour;
            minutes = minutes.Length == 1 ? "0" + minutes : minutes;
            seconds = seconds.Length == 1 ? "0" + seconds : seconds;

            string completeSTR = year + "-" + month + "-" + day + " " + hour + ":" + minutes +":" + seconds;
            return completeSTR;
        }

        public static string SQL_To_String_DateTime(DateTime p) 
        {
            string day = p.Day.ToString();
            string month = p.Month.ToString();
                string year = p.Year.ToString();
                string completeSTR = year + "-" + month + "-" + day;
                return completeSTR;
        }

        public static int getAge(DateTime Birthday)
        {
            try
            {
                // Save today's date.
                DateTime today = DateTime.Now;
                // Calculate the age.
                int age = today.AddYears(-Birthday.Year).Year;
                // Do stuff with it.
                DateTime B = Birthday.AddYears(age);
                if (B > today)
                {
                    age = age - 1;
                }
                return age;
            } catch (Exception)
            {
                
                return 0;
            }
        }
    }
}
