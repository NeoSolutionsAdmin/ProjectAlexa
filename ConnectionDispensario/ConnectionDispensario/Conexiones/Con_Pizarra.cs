using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Conexiones
{
    public class Con_Pizarra
    {
        QTACustomizado QTA = new QTACustomizado();

        //                                              //
        //      Pertenecientes a la tabla de POSTS      //
        //                                              //
        // Pasó a ser estático y devolver un Data Row - 26/02/2019 - 1:01 - Losha
        public static DataRow Insert_Post(string TituloPost, int IdProfesional, string FechaCreacion, int IdPaciente, string Estado)
        {
            DispensarioACDataSetTableAdapters.Insert_PostTableAdapter TA = new DispensarioACDataSetTableAdapters.Insert_PostTableAdapter();
            DispensarioACDataSet.Insert_PostDataTable DT = new DispensarioACDataSet.Insert_PostDataTable();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "losha");
            TA.Fill(DT, TituloPost, IdProfesional, FechaCreacion, IdPaciente, Estado);

            if (DT != null && DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }

        }

        public DataTable SearchPacientesConPosts()
        {
            DispensarioACDataSetTableAdapters.Get_PacientesWithPostsPizarraTableAdapter TA = new DispensarioACDataSetTableAdapters.Get_PacientesWithPostsPizarraTableAdapter();
            DispensarioACDataSet.Get_PacientesWithPostsPizarraDataTable DT = new DispensarioACDataSet.Get_PacientesWithPostsPizarraDataTable();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "losha");
            TA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }
        
        public bool Update_PostStatus(int IdPost, string Estado)
        {
            int c = QTA.Update_PostStatus(IdPost, Estado);
            if (c > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public DataTable Select_PostsByIdPaciente(int IdPaciente)
        {
            DispensarioACDataSetTableAdapters.Select_PostByIdPacienteTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_PostByIdPacienteTableAdapter();
            DispensarioACDataSet.Select_PostByIdPacienteDataTable DT = new DispensarioACDataSet.Select_PostByIdPacienteDataTable();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT, IdPaciente);

            if (DT != null && DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }


        //                                                      //
        //      Pertenecientes a la tabla de COMENTARIOS        //
        //                                                      //
        // Pasó a ser estático y devolver un Data Row - 03/03/2019 - 15:04 - Losha
        public static DataRow Insertar_ComentarioPizarra(int IdPost, string Comentario, int IdProfesional, string FechaCreacion)
        {
            DispensarioACDataSetTableAdapters.Insertar_ComentarioPizarraTableAdapter TA = new DispensarioACDataSetTableAdapters.Insertar_ComentarioPizarraTableAdapter();
            DispensarioACDataSet.Insertar_ComentarioPizarraDataTable DT = new DispensarioACDataSet.Insertar_ComentarioPizarraDataTable();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "losha");
            TA.Fill(DT, IdPost, Comentario, IdProfesional, FechaCreacion);

            if (DT != null && DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }
        }

        public DataTable Select_ComentariosByIdPost(int IdPost)
        {
            DispensarioACDataSetTableAdapters.Select_ComentariosByIdPostTableAdapter TA = new DispensarioACDataSetTableAdapters.Select_ComentariosByIdPostTableAdapter();
            DispensarioACDataSet.Select_ComentariosByIdPostDataTable DT = new DispensarioACDataSet.Select_ComentariosByIdPostDataTable();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, this.ToString());
            TA.Fill(DT, IdPost);

            if (DT != null && DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }
    }
}
