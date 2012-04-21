function Z=escal(A)

% Esta fun��o � um script-file que permite a aplica��o de opera��es 
% elementares sobre as linhas de uma matriz.
% Como default, a fun��o utiliza o formato racional.
% Digita-se Z=escal(A)
% Input:  A, matriz de ordem m por n;
% Output: Z, matriz obtida de A atrav�s das opera��es definidas pelo 
%            usu�rio.


 format rat
[m,n]=size(A); i=1:m;
ANT=A;
menu=...
['    ***** Escolha a opera��o:                                                          ';
 '    Op��o 01:   Li = k*Li                                                              ';
 '     (Substituir a linha i pelo produto da linha i por um escalar k n�o nulo)          ';
 '    Op��o 02:   Lij                                                                    ';
 '     (Trocar de posi��o as linhas i e j)                                               ';
 '    Op��o 03:   Lj = Lj + k*Li                                                         ';
 '     (Substituir a linha j pela soma da linha j com a linha i previamente              ';
 '      multiplicada por um escalar k n�o nulo)                                          ';
 '    Op��o 04:   Desfazer a �ltima opera��o.                                            ';
 '    Op��o 05:   Mudar o formato racional <--> decimal.                                 ';
 '    Op��o 00:   Interromper o ESCAL.                                                   ';];
mat='A matriz inicial �: ';
r='Apresentamos a rotina ESCAL. Fa�a bom uso!!!';
ans=A;

while 1
 
  disp('      ');
  fprintf('\t'); disp(r);
  fprintf('\t'); disp(mat); disp('  ');
  format compact, disp(ans);
  format loose
  disp('       ');
  disp(menu);
  
  op=input('    Digite o n�mero da op��o escolhida >>>>>>>>  ');

  if op==01 | op==1;
    k=input('    Qual o escalar que devo utilizar ?     ');
    Li=input('    Qual a linha que ser� modificada ?     ');
    if k==0 | Li~=abs(fix(Li)) | Li>m | Li<=0
      disp('    Verifique o escalar ou n�mero de linha. Um dos par�metros est� incorreto!')
      disp('    Digite ENTER para seguir.');
      pause
     else  
      ANT=A;
      A(Li,:)=k*A(Li,:);
      mat='A matriz intermedi�ria �:  ';
      r=['Opera��o conclu�da, confira: ' num2str(k) ' * Linha '  num2str(Li) '.'];
      ans=A;
     end
  end
  
  if op==02 | op==2;
    mat='A matriz intermedi�ria �: '; 
    disp('   ');disp('    Digite o n�mero das linhas que devo trocar:');
    Li=input('    linha    ');
    Lj=input('    com a linha    ');
    if Li>m | Lj>m
      disp('    Engano! N�mero de linhas incorretos!');
      disp('    Digite ENTER para seguir.');
      pause
      r='     ';
     else
      ANT=A;
      T=A(Li,:); A(Li,:)=A(Lj,:); A(Lj,:)=T;
      r=['Opera��o conclu�da, confira: Linha ' num2str(Li) ' <===> Linha ' num2str(Lj) '.'];
      ans=A;
    end
  end

  if op==03 | op==3;
    mat='A matriz intermedi�ria �: ';
    k=input('    Qual o escalar que devo utilizar ?           ');
    Li=input('    Qual a linha que devo multiplicar por k ?    ');
    Lj=input('    Qual a linha que ser� substitu�da ?          ')  ;
    if k==0 | Li>m | Lj>m   % ver testes para n�mero de linhas
      disp('    Verifique o escalar e os n�meros das linhas, houve engano!');
      disp('    Digite ENTER para seguir.');
      pause 
      r='      ';
     else
      ANT=A;
      A(Lj,:)=k*A(Li,:)+A(Lj,:);
      r=['Opera��o conclu�da, confira: Linha ' num2str(Lj) ' = Linha ' num2str(Lj) ' + ' num2str(k) ' * Linha ' num2str(Li) '.'];
      ans=A;
    end
  end

  if op==04 | op==4;
    mat='A matriz intermedi�ria �: ';
    r='Opera��o "desfeita" ! ';
    ans=ANT;
    A=ans;
  end

  if op==05 | op==5;
    mat='A matriz intermedi�ria �: ';
    f=input('    Escolha 1 para formato racional ou 2 para formato decimal (4 casas):   ');
    if f==1
      format rat
     elseif f==2
      format short
    end
    r='Mudan�a de formato: ';
  end
  
  if op==0 | op==0;
    mat='A matriz final �:  ';
    r='Saindo do ESCAL !';   
   
    disp('      ');
    fprintf('\t'); disp(r);
    disp('       ');
    fprintf('\t'); disp(mat);
    Z=A;    
    return;
  end
end
