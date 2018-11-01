using DotNetNuke.Entities.Users;
using DotNetNuke.Security.Roles;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Modelos.Reporting
{
    public class C3Item
    {
        int ID;
        string Servicio;
        int CodigoServicio;
        int HsDeAtencion;
        int Menor1M;
        int Menor1F;
        int año1M;
        int año1F;
        int año2a4M;
        int año2a4F;
        int año5a9M;
        int año5a9F;
        int año10a14M;
        int año10a14F;
        int año15a49M;
        int año15a49F;
        int año50M;
        int año50F;
        int ControlEmbarazo;

        public string Servicio1 { get => Servicio; set => Servicio = value; }
        public int CodigoServicio1 { get => CodigoServicio; set => CodigoServicio = value; }
        public int HsDeAtencion1 { get => HsDeAtencion; set => HsDeAtencion = value; }
        public int Menor1M1 { get => Menor1M; set => Menor1M = value; }
        public int Menor1F1 { get => Menor1F; set => Menor1F = value; }
        public int Año1M { get => año1M; set => año1M = value; }
        public int Año1F { get => año1F; set => año1F = value; }
        public int Año2a4M { get => año2a4M; set => año2a4M = value; }
        public int Año2a4F { get => año2a4F; set => año2a4F = value; }
        public int Año5a9M { get => año5a9M; set => año5a9M = value; }
        public int Año5a9F { get => año5a9F; set => año5a9F = value; }
        public int Año10a14M { get => año10a14M; set => año10a14M = value; }
        public int Año10a14F { get => año10a14F; set => año10a14F = value; }
        public int Año15a49M { get => año15a49M; set => año15a49M = value; }
        public int Año15a49F { get => año15a49F; set => año15a49F = value; }
        public int Año50M { get => año50M; set => año50M = value; }
        public int Año50F { get => año50F; set => año50F = value; }
        public int ControlEmbarazo1 { get => ControlEmbarazo; set => ControlEmbarazo = value; }
        public int ID1 { get => ID; set => ID = value; }
    }
    public class C3
    {
        
        private List<C3Item> myItems;
        public C3() { }

        public List<C3Item> MyItems { get => myItems; set => myItems = value; }

        public List<C3Item> GetC3()
        {
            List<int> C1Registradas = new List<int>();
            DateTime Start = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            DateTime End = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month)).AddHours(23);
            List<C3Item> ItemsC3 = new List<C3Item>();

            System.Collections.ArrayList Users = DotNetNuke.Entities.Users.UserController.GetUsers(0);
            RoleController RC = new RoleController();
            IList<RoleInfo> RoleList = RC.GetRoles(0);
            int rolfounded = 0;
            for (int a = 0; a < RoleList.Count; a++)
            {
                if (RoleList[a].RoleName.ToLower().Contains("servicio"))
                {
                    char[] m = { ':' };
                    ItemsC3.Add(new C3Item());
                    rolfounded++;
                    ItemsC3[ItemsC3.Count - 1].ID1 = rolfounded;
                    ItemsC3[ItemsC3.Count - 1].Servicio1 = RoleList[a].RoleName.Split(m)[1].ToUpper();
                    if (RoleList[a].RoleName.ToLower().Contains("clinica")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 100;
                    if (RoleList[a].RoleName.ToLower().Contains("pediatria")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 101;
                    if (RoleList[a].RoleName.ToLower().Contains("ginecologia")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 285;
                    if (RoleList[a].RoleName.ToLower().Contains("psicologia")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 550;
                    if (RoleList[a].RoleName.ToLower().Contains("social")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 15;
                    if (RoleList[a].RoleName.ToLower().Contains("nutricion")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 57;
                    if (RoleList[a].RoleName.ToLower().Contains("kinesiologia")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 675;
                    if (RoleList[a].RoleName.ToLower().Contains("cardiologia")) ItemsC3[ItemsC3.Count - 1].CodigoServicio1 = 285;

                }
            }

            for (int a = 0; a < Users.Count; a++)
            {
                for (int b = 0; b < ItemsC3.Count; b++)
                {
                    UserInfo UI = (UserInfo)Users[a];
                    if (UI.IsInRole("servicio:"+ItemsC3[b].Servicio1))
                    {
                        C1 c1 = new C1();
                        List<C1Item> ListaDeC1 = c1.GetC1(Start, End, UI.UserID, "Finalizado");
                        if (ListaDeC1 != null)
                        {
                            for (int c = 0; c < ListaDeC1.Count; c++)
                            {
                                if (ListaDeC1[c].Menor1m == "X") ItemsC3[b].Menor1M1++;
                                if (ListaDeC1[c].Menor1f == "X") ItemsC3[b].Menor1F1++;
                                if (ListaDeC1[c].Ano1m == "X") ItemsC3[b].Año1M++;
                                if (ListaDeC1[c].Ano1f == "X") ItemsC3[b].Año1F++;
                                if (ListaDeC1[c].Ano2a4m == "X") ItemsC3[b].Año2a4M++;
                                if (ListaDeC1[c].Ano2a4f == "X") ItemsC3[b].Año2a4F++;
                                if (ListaDeC1[c].Ano5a9m == "X") ItemsC3[b].Año5a9M++;
                                if (ListaDeC1[c].Ano5a9f == "X") ItemsC3[b].Año5a9F++;
                                if (ListaDeC1[c].Ano10a14m == "X") ItemsC3[b].Año10a14M++;
                                if (ListaDeC1[c].Ano10a14f == "X") ItemsC3[b].Año10a14F++;
                                if (ListaDeC1[c].Ano15a49m == "X") ItemsC3[b].Año15a49M++;
                                if (ListaDeC1[c].Ano15a49f == "X") ItemsC3[b].Año15a49F++;
                                if (ListaDeC1[c].Ano50ymasm == "X") ItemsC3[b].Año50M++;
                                if (ListaDeC1[c].Ano50ymasf == "X") ItemsC3[b].Año50F++;
                                if (ListaDeC1[c].Controlembarazo == "X") ItemsC3[b].ControlEmbarazo1++;
                                ConnectionDispensario.Conexiones.Con_Turno ConT = new Conexiones.Con_Turno();
                                DataTable DT = ConT.GetallC1(UI.UserID);
                                if (DT != null)
                                {
                                    for (int d = 0; d < DT.Rows.Count; d++)
                                    {
                                        int UserIDC1 = int.Parse(DT.Rows[d]["UserId"].ToString());
                                        int CantidadHorasC1 = int.Parse(DT.Rows[d]["CantidadHoras"].ToString());
                                        int IdC1 = int.Parse(DT.Rows[d]["Id"].ToString());
                                        DateTime FechaC1 = DateTime.Parse(DT.Rows[d]["fechaC1"].ToString());

                                        bool foundit = false;

                                        for (int e = 0; e < C1Registradas.Count; e++)
                                        {
                                            if (C1Registradas[e] == IdC1)
                                            {
                                                foundit = true;
                                                break;
                                            }
                                        }
                                        if (foundit == false) C1Registradas.Add(IdC1);

                                        if (UserIDC1 == UI.UserID && foundit==false)
                                        {
                                            
                                            if (DateTime.Now.Month == FechaC1.Month)
                                            {
                                                ItemsC3[b].HsDeAtencion1 += CantidadHorasC1;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return ItemsC3;
        }

    }
}
