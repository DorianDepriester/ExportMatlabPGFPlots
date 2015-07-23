function  exportPGFPlots( filename, varargin )
%Exporte les données au format ASCII, sous forme de colonnes avec un nom
%propre à chaque colonne, pour PGFPlots.
%   exportPGFPlots('FICHIER', VAR1, 'NOM1', VAR2, 'NOM2', ...) enregistre
%   les vecteurs VAR1, VAR2,.. dans le fichier FICHIER. Le fichier
%   comporte en entête le nom des colonnes (NOM1, NOM2 etc.).

nbcol=(nargin-1)/2;                     % Nombre de colonnes dans le fichier
if ~mod(nbcol,1) == 0                   % Si nbcol n'est pas un entier
    error('Nombre de paramètres incohérent.')
end
M=zeros(max(size(varargin{1})),nbcol);  % Matrice de données
fileID = fopen(filename,'w');
for i=1:nbcol
    %% Mise en forme de la matrice des données
    varId= 2*i-1;
    v= varargin{varId};
    if size(v(:),1)~=size(M,1)
        error('Les vecteurs à enregistrer doivent être de même dimension.')
    end
    M(:,i)= v(:);   % Force le vecteur à être en colonne
    
    %% Mise en forme de l'entête (noms des colonnes)
    strId= 2*i;
    if ~ischar(varargin{strId})
        error('Les noms des colonnes doivent être de type STRING.')
    end
    fprintf(fileID,'%s\t',varargin{strId});
end
fprintf(fileID,'\n');   % Ajout d'un retour chariot à la fin de l'entête
fclose(fileID);

dlmwrite(filename,M,'-append','delimiter','\t')

end

