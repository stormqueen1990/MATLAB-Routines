function Z=escal(A)

% Esta função é um script-file que permite a aplicação de operações 
% elementares sobre as linhas de uma matriz.
% Como default, a função utiliza o formato racional.
% Digita-se Z=escal(A)
% Input:  A, matriz de ordem m por n;
% Output: Z, matriz obtida de A através das operações definidas pelo 
%            usuário.


 format rat
[m,n]=size(A); i=1:m;
ANT=A;
menu=...
['    ***** Escolha a operação:                                                          ';
 '    Opção 01:   Li = k*Li                                                              ';
 '     (Substituir a linha i pelo produto da linha i por um escalar k não nulo)          ';
 '    Opção 02:   Lij                                                                    ';
 '     (Trocar de posição as linhas i e j)                                               ';
 '    Opção 03:   Lj = Lj + k*Li                                                         ';
 '     (Substituir a linha j pela soma da linha j com a linha i previamente              ';
 '      multiplicada por um escalar k não nulo)                                          ';
 '    Opção 04:   Desfazer a última operação.                                            ';
 '    Opção 05:   Mudar o formato racional <--> decimal.                                 ';
 '    Opção 00:   Interromper o ESCAL.                                                   ';];
mat='A matriz inicial é: ';
r='Apresentamos a rotina ESCAL. Faça bom uso!!!';
ans=A;

while 1
 
  disp('      ');
  fprintf('\t'); disp(r);
  fprintf('\t'); disp(mat); disp('  ');
  format compact, disp(ans);
  format loose
  disp('       ');
  disp(menu);
  
  op=input('    Digite o número da opção escolhida >>>>>>>>  ');

  if op==01 | op==1;
    k=input('    Qual o escalar que devo utilizar ?     ');
    Li=input('    Qual a linha que será modificada ?     ');
    if k==0 | Li~=abs(fix(Li)) | Li>m | Li<=0
      disp('    Verifique o escalar ou número de linha. Um dos parâmetros está incorreto!')
      disp('    Digite ENTER para seguir.');
      pause
     else  
      ANT=A;
      A(Li,:)=k*A(Li,:);
      mat='A matriz intermediária é:  ';
      r=['Operação concluída, confira: ' num2str(k) ' * Linha '  num2str(Li) '.'];
      ans=A;
     end
  end
  
  if op==02 | op==2;
    mat='A matriz intermediária é: '; 
    disp('   ');disp('    Digite o número das linhas que devo trocar:');
    Li=input('    linha    ');
    Lj=input('    com a linha    ');
    if Li>m | Lj>m
      disp('    Engano! Número de linhas incorretos!');
      disp('    Digite ENTER para seguir.');
      pause
      r='     ';
     else
      ANT=A;
      T=A(Li,:); A(Li,:)=A(Lj,:); A(Lj,:)=T;
      r=['Operação concluída, confira: Linha ' num2str(Li) ' <===> Linha ' num2str(Lj) '.'];
      ans=A;
    end
  end

  if op==03 | op==3;
    mat='A matriz intermediária é: ';
    k=input('    Qual o escalar que devo utilizar ?           ');
    Li=input('    Qual a linha que devo multiplicar por k ?    ');
    Lj=input('    Qual a linha que será substituída ?          ')  ;
    if k==0 | Li>m | Lj>m   % ver testes para número de linhas
      disp('    Verifique o escalar e os números das linhas, houve engano!');
      disp('    Digite ENTER para seguir.');
      pause 
      r='      ';
     else
      ANT=A;
      A(Lj,:)=k*A(Li,:)+A(Lj,:);
      r=['Operação concluída, confira: Linha ' num2str(Lj) ' = Linha ' num2str(Lj) ' + ' num2str(k) ' * Linha ' num2str(Li) '.'];
      ans=A;
    end
  end

  if op==04 | op==4;
    mat='A matriz intermediária é: ';
    r='Operação "desfeita" ! ';
    ans=ANT;
    A=ans;
  end

  if op==05 | op==5;
    mat='A matriz intermediária é: ';
    f=input('    Escolha 1 para formato racional ou 2 para formato decimal (4 casas):   ');
    if f==1
      format rat
     elseif f==2
      format short
    end
    r='Mudança de formato: ';
  end
  
  if op==0 | op==0;
    mat='A matriz final é:  ';
    r='Saindo do ESCAL !';   
   
    disp('      ');
    fprintf('\t'); disp(r);
    disp('       ');
    fprintf('\t'); disp(mat);
    Z=A;    
    return;
  end
end
