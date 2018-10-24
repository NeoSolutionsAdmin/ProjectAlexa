using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ConnectionDispensario.Conexiones;

namespace ConnectionDispensario.Modelos
{
    public class Somatometria
    {
        public int Id;
        public int IdUsuario;
        public int IdPaciente;
        public DateTime FechaHora=DateTime.Now;
        public decimal? Peso=null;
        public decimal? Talla=null;
        public int? PASistolica=null;
        public int? PADiastolica=null;
        public decimal? IMC=null;
        public decimal? Colesterol = null;
        public Somatometria(int p_IdPaciente,int p_IdUsuario, DateTime p_FechaHora)
        {
            IdPaciente = p_IdPaciente;
            IdUsuario = p_IdUsuario;
            FechaHora = p_FechaHora;
        }
        public Somatometria(DataRow p_dr)
        {
            if (!p_dr.IsNull("Id")) Id = int.Parse(p_dr["Id"].ToString());

            if (!p_dr.IsNull("IdUsuario")) IdUsuario = int.Parse(p_dr["IdUsuario"].ToString());

            if(!p_dr.IsNull("IdPaciente")) IdPaciente = int.Parse(p_dr["IdPaciente"].ToString());

            if(!p_dr.IsNull("FechaHora")) FechaHora = DateTime.Parse(p_dr["FechaHora"].ToString());

            if (!p_dr.IsNull("Peso")) Peso = decimal.Parse(p_dr["Peso"].ToString());

            if (!p_dr.IsNull("Talla")) Talla = decimal.Parse(p_dr["Talla"].ToString());

            if (!p_dr.IsNull("PASistolica")) PASistolica = int.Parse(p_dr["PASistolica"].ToString());

            if (!p_dr.IsNull("PADiastolica")) PADiastolica = int.Parse(p_dr["PADiastolica"].ToString());

            if (!p_dr.IsNull("IMC")) IMC = decimal.Parse(p_dr["IMC"].ToString());
            if (!p_dr.IsNull("Colesterol")) Colesterol = decimal.Parse(p_dr["Colesterol"].ToString());
        }

        public void CreateNewSomatometria()
        {
            Con_Somatometria temp = new Con_Somatometria();
            temp.CreateSomatometria(IdPaciente);
            

        }

        public void UpdateSomatometria()
        {
            Con_Somatometria Temp = new Con_Somatometria();
            Temp.UpdateSomatometria(IdPaciente, IdUsuario, FechaHora, Peso, Talla, PASistolica, PADiastolica, IMC,Colesterol);
        }

        public static Somatometria GetSomatometriaByIdPaciente(int IdPaciente)
        {
            Conexiones.Con_Somatometria Con = new Conexiones.Con_Somatometria();
            DataRow Temp;
            Temp = Con.SomatometriaExist(IdPaciente);
            if (Temp != null)
            {
                return new Somatometria(Temp);
            }
            else
            {
                return null;
            }

        }
    }
}
