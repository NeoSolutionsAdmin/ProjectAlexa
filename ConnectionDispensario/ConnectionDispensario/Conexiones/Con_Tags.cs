using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using ConnectionDispensario.Modelos;

namespace ConnectionDispensario.Conexiones
{
    class Con_Tags
    {
        QTACustomizado QTA = new QTACustomizado();

        public bool AgregarTag(Tag p_tag)
        {
            int c = QTA.Insert_Tag(p_tag.NOMBRE, p_tag.ICONO);
            if (c > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool BorrarTag(int IdTag)
        {
            int c = QTA.Delete_Tag(IdTag);
            if (c > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public DataTable GetTagByTagName(string name)
        {
            DispensarioACDataSet.GetTagByTagNameDataTable DT =
                new DispensarioACDataSet.GetTagByTagNameDataTable();
            DispensarioACDataSetTableAdapters.GetTagByTagNameTableAdapter TA =
                new DispensarioACDataSetTableAdapters.GetTagByTagNameTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());

            TA.Fill(DT, name);

            if (DT != null && DT.Rows.Count > 0) return DT;
            else return null;
        }

        public DataTable GetTagById(int idTag)
        {
            DispensarioACDataSet.Select_TagByIdDataTable DT = new DispensarioACDataSet.Select_TagByIdDataTable();
            DispensarioACDataSetTableAdapters.Select_TagByIdTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_TagByIdTableAdapter();

            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT, idTag);

            if (DT != null && DT.Rows.Count > 0) return DT;
            else return null;
        }

        public DataTable GetCharsDiscriminados()
        {
            DispensarioACDataSet.GetCharsDiscriminadosDataTable DT =
                new DispensarioACDataSet.GetCharsDiscriminadosDataTable();
            DispensarioACDataSetTableAdapters.GetCharsDiscriminadosTableAdapter TA =
                new DispensarioACDataSetTableAdapters.GetCharsDiscriminadosTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());

            TA.Fill(DT);

            if (DT != null && DT.Rows.Count > 0) return DT;
            else return null;
        }

    }
}
