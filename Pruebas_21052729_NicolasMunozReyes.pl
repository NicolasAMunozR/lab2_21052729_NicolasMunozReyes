% Caso que debe retornar true:
system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), 
systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), 
systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1, S13), 
systemCd(S13, "./folder2", S14),  file( "ejemplo.txt", "otro archivo", F2), systemAddFile(S14, F2, S15).
% Casos que deben retornar false:
system("newSystem", S1), systemRegister(S1, "user1", S2), systemRegister(S2, "user1", S3).
system("newSystem", S1), systemRegister(S1, "user1", S2), systemRegister(S2, "user2", S3), systemLogin(S3, "user1", S4), systemLogin(S4, "user2", S5).
system("newSystem", S1), systemRegister(S1, "user1", S2), systemLogin(S2, "user1", S3), systemSwitchDrive(S3, "K", S4).

% Script de prueba:

% TDA system
system("E", S1), system("ElProgreso", S2), system("SistemaNuevo", S3), 
% TDA systemAddDrive
systemAddDrive(S3, "C", "OSI", 1000000, S4), systemAddDrive(S4, "D", "No", 20000000000, S5), systemAddDrive(S5, "K", "Si", 10000000000, S6), 
% TDA systemRegister
systemRegister(S6, "User1", S7), 
% TDA systemLogin
systemLogin(S7, "User1", S8), 
% TDA systemRegister
systemRegister(S8, "User2", S9), 
% TDA systemLogout
systemLogout(S9, S10), 
% TDA systemLogin
systemLogin(S10, "User2", S11), 
% TDA systemRegister
systemRegister(S11, "User3", S12),
% TDA systemLogout
systemLogout(S12, S13), 
% TDA systemLogin
systemLogin(S13, "User1", S14), 
% TDA systemLogout
systemLogout(S14, S15), 
% TDA systemLogin
systemLogin(S15, "User1", S16),
% TDA systemSwitchDrive
systemSwitchDrive(S16, "D", S17), systemSwitchDrive(S17, "K", S18), systemSwitchDrive(S18, "C", S19),
% TDA systemMkdir
systemMkdir(S19, "folder1", S20), systemMkdir(S20, "folder2", S21), systemMkdir(S21, "folder3", S22), systemMkdir(S22, "folder4", S23), 
% TDA systemCd
systemCd(S23, "folder1", S24), 
% TDA systemMkdir
systemMkdir(S24, "folder11", S25), 
% TDA systemCd
systemCd(S25, "folder11", S26), 
% TDA systemAddFile
file("foo.txt", "hello world 1", F1), systemAddFile(S26, F1, S27), 
% TDA systemCd
systemCd(S27, "..", S28), 
% TDA systemAddFile
file("foo3.docx", "hello world 2", F2), systemAddFile(S28, F2, S29), file("foo1.txt", "hello world 3", F3), systemAddFile(S29, F3, S30), 
% TDA systemCopy
systemCopy(S30, "foo.txt", "K:/", S31), 
% TDA systemCd
systemCd(S31, "/", S32), 
% TDA systemCopy
systemCopy(S32, "foo.txt", "D:/", S33), systemCopy(S33, "foo1.txt", "K:/", S34),
% TDA systemDel
systemDel(S34, "foo3.docx", S35), systemDel(S35, "foo.txt", S36),  systemDel(S36, "folder2", S37), 
% TDA systemDir
systemDir(S34, ["/?"], Resultado), systemDir(S23, ["/s"], Resultado1), systemDir(S33, ["/s"], Resultado2),
% TDA systemSwitchDrive
systemSwitchDrive(S37, "D", S38), 
% TDA systemMove
systemMove(S38, "foo.txt", "C:/folder3/", S39),
% TDA systemSwitchDrive
systemSwitchDrive(S39, "K", S40), 
% TDA systemMove
systemMove(S40, "foo1.txt", "D:/", S41), systemMove(S41, "foo.txt", "D:/", S42),
% TDA systemSwitchDrive
systemSwitchDrive(S42, "D", S43), 
% TDA systemRen
systemRen(S43, "foo1.txt", "foo1.jpg", S44), systemRen(S44, "foo.txt", "newfoo.txt", S45), 
% TDA systemSwitchDrive
systemSwitchDrive(S45, "C", S46), 
% TDA systemRen
systemRen(S46, "foo.txt", "foo.docx", S47), 
% TDA systemFormat
systemFormat(S47, "C", "OSI1", S48), systemFormat(S48, "D", "No1", S49), systemFormat(S49, "K", "Si1", S50), 
% TDA systemGrep
systemGrep(S47, "world", "foo.docx", Resultado3), systemGrep(S47, "1", "foo.docx", Resultado4), systemGrep(S47, "hello", "foo.docx", Resultado5),
% TDA systemViewTrash
systemViewTrash(S35, Resultado6), systemViewTrash(S36, Resultado7), systemViewTrash(S37, Resultado8),
% TDA systemRestore
systemRestore(S47, "folder1", S51), systemRestore(S51, "folder2", S52), systemRestore(S47, "folder2", S53).  