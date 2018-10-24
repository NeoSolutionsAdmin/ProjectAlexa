using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Statics
{
    public class VariableComparativa
    {
        public int variableIndex;
        public int variableValor;
        public int variableDiferencia;

        public VariableComparativa(int ind, int val, int dif)
        {
            variableIndex = ind;
            variableValor = val;
            variableDiferencia = dif;
        }
    }
}
