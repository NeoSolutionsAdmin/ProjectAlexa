using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Conexiones
{
    public class Con_Somatometria
    {
        QTACustomizado QTA = new QTACustomizado();

        public Con_Somatometria() { }

        public bool UpdateSomatometria(
            int p_IdPaciente,
            int p_IdUsuario,
            DateTime p_FechaHora,
            decimal? p_Peso,
            decimal? p_Talla,
            int? p_PASistolica,
            int? p_PADiastolica,
            decimal? p_IMC,
            decimal? p_Colesterol)
        {
            if (QTA.Update_SomatometriaByIdPaciente(
                p_IdPaciente,
                p_IdUsuario,
                Utils.Conversiones.SQL_To_FullString_DateTime(p_FechaHora),
                p_Peso,
                p_Talla,
                p_PASistolica,
                p_PADiastolica,
                p_IMC,
                p_Colesterol
                ) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        public System.Data.DataRow SomatometriaExist(int IdPaciente)
        {
            DispensarioACDataSet.Select_SomatometriaByIdPacienteDataTable DT = new DispensarioACDataSet.Select_SomatometriaByIdPacienteDataTable();
            DispensarioACDataSetTableAdapters.Select_SomatometriaByIdPacienteTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_SomatometriaByIdPacienteTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT, IdPaciente);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }
        }

        public DataRow CreateSomatometria(int IdPaciente)
        {
            QTA.Insert_SomatometriaByIdPaciente(IdPaciente);
            return SomatometriaExist(IdPaciente);
        }
        

    }
}
