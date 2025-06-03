'the classic game Drug Wars
'ported and updated by rm
'originally ported from the TI basic verion found here https://gist.github.com/mattmanning/1002653

UpdateDate$ = "20250603"

'game start
Start:
CLS
Print ""
PrintC "Drug Wars",1
Print ""
PrintC "A GAME BASED ON",1
Print ""
PrintC "THE NEW YORK DRUG MARKET",1
Print ""
PrintC "PicoCalc version by rm",1
TempString$ = "Updated " + UpdateDate$
PrintC TempString$,1
Print ""
PrintC "Based on the game by",1
PrintC "John E. Dell",1

'set global variables
CashWallet% = 2000
CashDebt% = 5000
CashBank% = 0
NumDay = 1
NumGuns = 0
TrenchCoke% = 0
TrenchHeroin% = 0
TrenchAcid% = 0
TrenchWeed% = 0
TrenchSpeed% = 0
TrenchLudes% = 0
TrenchTotal% = 100
CalcTrenchSpace 'calculate available trenchcoat space
Health% = 50
Location = 0 '0 = Bronx, 1 = Ghetto, 2 Central Park, 3 = Manhatten, 4 = Coney Island, 5 = Brooklyn

'instructions/intro
Print ""
PrintC "Instructions?",1
PrintC "[Y]es/[N]o",0
Input Confirm$
  Select Case Confirm$
    Case "y", "Y"
      CLS
   Print ""
      PrintC "This is a game of buying and selling.",1
      PrintC "Your goal is to pay off your debt to",1
      PrintC "the loan shark and then make as much",1
      PrintC "money as possible in a 1 month period.",1
      Print ""
      PrintC "Watch out for the police",1
      PrintC "if you deal too heavily!",1
      AnyKey
      CLS
   Print ""
      PrintC "Prices for drugs are:",1
      PrintC "Coke: 15000-28000",1
      PrintC "Heroin: 5000-12000",1
      PrintC "Acid: 1000-4200",1
      PrintC "Weed: 300-720",1
      PrintC "Speed: 70-220",1
      PrintC "Ludes: 10-50",1
      AnyKey
      CLS
   Print ""
      PrintC "The number next to each name in the",1
      PrintC "price list is how many units of each",1
      PrintC "drug you have.",1
      Print ""
      PrintC "The bank pays 6% interest a day.",1
      PrintC "The loan shark charges 10% a day.",1
      PrintC "Both are in the Bronx.",1
      AnyKey
    End Select

MainLoop:
Randomize Timer 'seed the random number generator with the current timer value
StreetCoke% = Int(Rnd*12000+16000)
StreetHeroin% = Int(Rnd*7000+5000)
StreetAcid% = Int(Rnd*34+10)*100
StreetWeed% = Int(Rnd*42+33)*10
StreetSpeed% = Int(Rnd*15+7)*10
StreetLudes% = Int(Rnd*4+1)*10
RandomEvent = Int(Rnd*23)

CLS
Print ""
Select Case RandomEvent
Case 1 'cheap ludes
  PrintC "Rival dealers are selling cheap ludes!",1
  StreetLudes% = 1 + Int(Rnd*3)
  AnyKey
Case 2 'cheap weed
  PrintC "Weed prices have bottomed out!",1
  StreetWeed% = 100 + Int(Rnd*25)
  AnyKey
Case 3 'cheap heroin
  PrintC "Pigs are selling cheap heroin",1
  PrintC "from last week's raid!",1
  StreetHeroin% = Int(Rnd*1150+850)
  AnyKey
Case 4, 5 'expensive heroin
  PrintC "Addicts are buying heroin",1
  PrintC "at outrageous prices!",1
  StreetHeroin% = Int(Rnd*25000+18000)
  AnyKey
Case 6, 7
  PrintC "Pigs made a big coke bust!",1
  PrintC "Prices are outrageous!",1
  StreetCoke% = Int(Rnd*60000+80000)
  AnyKey
Case 8
  If NumGuns < 1 Then
    MuggedAmount = CashWallet%-Int((CashWallet%/3)*2)-Int(Rnd*50)
    PrintC "You were mugged on the subway!",1
    TempString$ = "They took " + Str$(MuggedAmount) + " dollars."
    PrintC TempString$,1
    PrintC "Better get some protection.",1
    CashWallet% = CashWallet% - MuggedAmount
    AnyKey
  EndIf
Case 9 To 12 'cops!
  If TrenchSpace < 60 Then CopChase
Case 13 'buy trenchcoat space
  If CashWallet% > 200 Then
    PrintC "Will you buy a new trenchcoat",1
    PrintC "with more pockets for $200?",1
    PrintC "[Y]es/[N]o",0
    Input Confirm$
    Select Case Confirm$
      Case "y", "Y"
        TrenchTotal% = TrenchTotal% + 10
        CalcTrenchSpace
        CashWallet% = CashWallet%-200
    End Select
    EndIf
  EndIf
Case 14 'bogus weed
  PrintC "There's some weed here that smells",1
  PrintC "like good stuff! Will you smoke it?",1
  PrintC "[Y]es/[N]o",0
  Input Confirm$
  Print ""
    Select Case Confirm$
      Case "y", "Y"
        DrugChance = Cint(Rnd*2)
        If DrugChance < 2 Then
          PrintC "You hallucinate on the wildest trip of",1
          PrintC "your life, stumble on to the subway",1
          PrintC "tracks and get CREAMED by a train.",1
          Print ""
          PrintC "JUST SAY NO TO DRUGS.",1
          AnyKey
          GoTo EndGame
        Else
          PrintC "You smoke some good shit that makes",1
          PrintC "you see through time and space.",1
          PrintC "You shake hands with god and",1
          PrintC "high five the devil.",1
          Print ""
          PrintC "Woah",0
          EllipseAnim
          AnyKey
        EndIf
      End Select
Case 15 'buy a gun
  If CashWallet% > 500 And TrenchSpace > 10 Then
    GunChance = Cint(Rnd*2)
    If GunChance=0 Then TempGun$ = "Beretta"
    If GunChance=1 Then TempGun$ = "Saturday Night Special"
    If GunChance=2 Then TempGun$ = ".44 Magnum"
    TempString$ = "Will you buy a " + TempGun$
    PrintC TempString$,1
    PrintC "for 400 dollars?",1
    PrintC "[Y]es/[N]o",0
    Input Confirm$
    Print ""
    Select Case Confirm$
      Case "y", "Y"
        NumGuns = NumGuns + 1
        CashWallet% = CashWallet%-400
        TrenchTotal% = TrenchTotal%-5
        CalcTrenchSpace
    End Select
    EndIf
  EndIf
Case 16 'found some drugs
  F = Cint((Rnd*7+1))
  If TrenchSpace > F Then
    DrugFind = Cint(Rnd*5)
    Select Case DrugFind
      Case 0
        TempDrug$ = "coke"
        TrenchCoke% = TrenchCoke% + F
      Case 1
        TempDrug$ = "heroin"
        TrenchHeroin% = TrenchHeroin% + F
      Case 2
        TempDrug$ = "acid"
        TrenchAcid% = TrenchAcid% + F
      Case 3
        TempDrug$ = "weed"
        TrenchWeed% = TrenchWeed% + F
      Case 4
        TempDrug$ = "speed"
        TrenchSpeed% = TrenchSpeed% + F
      Case 5
        TempDrug$ = "ludes"
        TrenchLudes% = TrenchLudes% + F
    End Select
    TempString$ = "You found " + Str$(F) + " units of " + TempDrug$
    PrintC TempString$,1
    PrintC "on a dead dude in the subway!",1
    CalcTrenchSpace
    AnyKey
  EndIf
Case 17 'cheap acid
  PrintC "The market has been flooded with",1
  PrintC "cheap homemade acid!",1
  StreetAcid% = Cint(Rnd*550+250)
  AnyKey
Case Else
End Select

MainMenu: 'main loop
If NumDay > 31 Then GoTo EndGame 'game ends after 31 days

CLS
Print ""
PrintC "Drug Wars",1
Print ""
Select Case Location
  Case 0
    TempLoc$ = "Bronx"
  Case 1
    TempLoc$ = "Ghetto"
  Case 2
    TempLoc$ = "Central Park"
  Case 3
    TempLoc$ = "Manhatten"
  Case 4
    TempLoc$ = "Coney Island"
  Case 5
    TempLoc$ = "Brooklyn"
End Select
TempString$ = "Day: " + Str$(NumDay) + "     " + "Location: " + TempLoc$
PrintC TempString$,1
Print ""
PrintC "Prices:",1
TempString$ = "Coke [" + Str$(TrenchCoke%) + "]: " + Str$(StreetCoke%) + "    " + "Heroin [" + Str$(TrenchHeroin%) + "]: " + Str$(StreetHeroin%)
PrintC TempString$,1
TempString$ = "Acid [" + Str$(TrenchAcid%) + "]: " + Str$(StreetAcid%) + "    " + "Weed [" + Str$(TrenchWeed%) + "]: " + Str$(StreetWeed%)
PrintC TempString$,1
TempString$ = "Speed [" + Str$(TrenchSpeed%) + "]: " + Str$(StreetSpeed%) + "   " + "Ludes [" + Str$(TrenchLudes%) + "]: " + Str$(StreetLudes%)
PrintC TempString$,1
Print ""
PrintC "Stats:",1
TempString$ = "Trenchcoat: " + Str$(TrenchSpace) + "   " + "Guns: " + Str$(NumGuns)
PrintC TempString$,1
TempString$ = "Health: " + Str$(Health%) + "   " + "Wallet: " + Str$(Cint(CashWallet%))
PrintC TempString$,1
TempString$ = "Debt: " + Str$(Cint(CashDebt%)) + "   " + "Bank: " + Str$(Cint(CashBank%))
PrintC TempString$,1
Print ""

MainChoice:
PrintC "[B]uy, [S]ell, [J]et",1
PrintC "[L]oan Shark, [V]isit Bank",0
Input ActionChoice$
Print ""
Select Case ActionChoice$
  Case "b", "B"
    If TrenchSpace < 1 Then
      PrintC "Your trenchcoat is full!",1
      AnyKey
      GoTo MainMenu
    Else
      BuyChoice:
      PrintC "Buy which drugs?",1
      PrintC "[C]ocaine, [H]eroin, [A]cid",1
      PrintC "[W]eed, [S]peed, [L]udes",0
      Input DrugChoice$
      Print ""
      Select Case DrugChoice$
        Case "c", "C"
          BuyAbility = Int(CashWallet%/StreetCoke%)
          If BuyAbility < 1 Then
            PrintC "You can't afford any!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          TempString$ = "You can afford " + Str$(BuyAbility) + " units of coke."
          PrintC TempString$,1
          PrintC "How many do you want to buy",0
          Input BuyInput
          Print ""
          If BuyInput > TrenchSpace Then
            PrintC "You don't have enough space!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          If (StreetCoke% * BuyInput) > CashWallet% Then
            PrintC "You can't afford that many!",1
            Anykey
            GoTo BuyChoice
          Else
            TempString$ = "You bought " + Str$(BuyInput) + " units of coke"
            PrintC TempString$,1
            TempString$ = "for " + Str$(Cint(BuyInput*StreetCoke%)) + " dollars."
            PrintC TempString$,1
            TrenchCoke% = TrenchCoke% + BuyInput
            CalcTrenchSpace
            CashWallet% = CashWallet% - (StreetCoke%*BuyInput)
            AnyKey
          EndIf
        Case "h", "H"
          BuyAbility = Int(CashWallet%/StreetHeroin%)
          If BuyAbility < 1 Then
            PrintC "You can't afford any!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          TempString$ = "You can afford " + Str$(BuyAbility) + " units of heroin."
          PrintC TempString$,1
          PrintC "How many do you want to buy",0
          Input BuyInput
          Print ""
          If BuyInput > TrenchSpace Then
            PrintC "You don't have enough space!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          If (StreetHeroin% * BuyInput) > CashWallet% Then
            PrintC "You can't afford that many!",1
            Anykey
            GoTo BuyChoice
          Else
            TempString$ = "You bought " + Str$(BuyInput) + " units of heroin"
            PrintC TempString$,1
            TempString$ = "for " + Str$(Cint(BuyInput*StreetHeroin%)) + " dollars."
            PrintC TempString$,1
            TrenchHeroin% = TrenchHeroin% + BuyInput
            CalcTrenchSpace
            CashWallet% = CashWallet% - (StreetHeroin%*BuyInput)
            AnyKey
          EndIf
        Case "a", "A"
          BuyAbility = Int(CashWallet%/StreetAcid%)
          If BuyAbility < 1 Then
            PrintC "You can't afford any!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          TempString$ = "You can afford " + Str$(BuyAbility) + " units of acid."
          PrintC TempString$,1
          PrintC "How many do you want to buy",0
          Input BuyInput
          Print ""
          If BuyInput > TrenchSpace Then
            PrintC "You don't have enough space!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          If (StreetAcid% * BuyInput) > CashWallet% Then
            PrintC "You can't afford that many!",1
            Anykey
            GoTo BuyChoice
          Else
            TempString$ = "You bought " + Str$(BuyInput) + " units of acid"
            PrintC TempString$,1
            TempString$ = "for " + Str$(Cint(BuyInput*StreetAcid%)) + " dollars."
            PrintC TempString$,1
            TrenchAcid% = TrenchAcid% + BuyInput
            CalcTrenchSpace
            CashWallet% = CashWallet% - (StreetAcid%*BuyInput)
            AnyKey
          EndIf
        Case "w", "W"
          BuyAbility = Int(CashWallet%/StreetWeed%)
          If BuyAbility < 1 Then
            PrintC "You can't afford any!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          TempString$ = "You can afford " + Str$(BuyAbility) + " units of weed."
          PrintC TempString$,1
          PrintC "How many do you want to buy",0
          Input BuyInput
          Print ""
          If BuyInput > TrenchSpace Then
            PrintC "You don't have enough space!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          If (StreetWeed% * BuyInput) > CashWallet% Then
            PrintC "You can't afford that many!",1
            Anykey
            GoTo BuyChoice
          Else
            TempString$ = "You bought "+ Str$(BuyInput) + " units of weed"
            PrintC TempString$,1
            TempString$ = "for " + Str$(Cint(BuyInput*StreetWeed%)) + " dollars."
            PrintC TempString$,1
            TrenchWeed% = TrenchWeed% + BuyInput
            CalcTrenchSpace
            CashWallet% = CashWallet% - (StreetWeed%*BuyInput)
            AnyKey
          EndIf
        Case "s", "S"
          BuyAbility = Int(CashWallet%/StreetSpeed%)
          If BuyAbility < 1 Then
            PrintC "You can't afford any!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          TempString$ = "You can afford " + Str$(BuyAbility) + " units of speed."
          PrintC TempString$,1
          PrintC "How many do you want to buy",0
          Input BuyInput
          Print ""
          If BuyInput > TrenchSpace Then
            PrintC "You don't have enough space!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          If (StreetSpeed% * BuyInput) > CashWallet% Then
            PrintC "You can't afford that many!",1
            Anykey
            GoTo BuyChoice
          Else
            TempString$ = "You bought " + Str$(BuyInput) + " units of speed"
            PrintC TempString$,1
            TempString$ = "for " + Str$(Cint(BuyInput*StreetSpeed%)) + " dollars."
            PrintC TempString$,1
            TrenchSpeed% = TrenchSpeed% + BuyInput
            CalcTrenchSpace
            CashWallet% = CashWallet% - (StreetSpeed%*BuyInput)
            AnyKey
          EndIf
        Case "l", "L"
          BuyAbility = Int(CashWallet%/StreetLudes%)
          If BuyAbility < 1 Then
            PrintC "You can't afford any!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          TempString$ = "You can afford " + Str$(BuyAbility) + " units of ludes."
          PrintC TempString$,1
          PrintC "How many do you want to buy",0
          Input BuyInput
          Print ""
          If BuyInput > TrenchSpace Then
            PrintC "You don't have enough space!",1
            AnyKey
            GoTo BuyChoice
          EndIf
          If (StreetLudes% * BuyInput) > CashWallet% Then
            Print "You can't afford that many!",1
            Anykey
            GoTo BuyChoice
          Else
            TempString$ = "You bought " + Str$(BuyInput) + " units of ludes"
            PrintC TempString$,1
            TempString$ = "for " + Str$(Cint(BuyInput*StreetLudes%)) + " dollars."
            PrintC TempString$,1
            TrenchLudes% = TrenchLudes% + BuyInput
            CalcTrenchSpace
            CashWallet% = CashWallet% - (StreetLudes%*BuyInput)
            AnyKey
          EndIf
        Case Else
          GoTo MainMenu
        End Select
    EndIf
  Case "s", "S"
    SellChoice:
    PrintC "Sell which drugs?",1
    PrintC "[C]ocaine, [H]eroin, [A]cid",1
    PrintC "[W]eed, [S]peed, [L]udes",0
    Input DrugChoice$
    Print ""
    Select Case DrugChoice$
      Case "c", "C"
        If TrenchCoke% < 1 Then
          PrintC "You don't have any coke!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "You have " + Str$(TrenchCoke%) + " units of coke to sell."
          PrintC TempString$,1
          PrintC "How many units to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "Ha ha, jokester. Use real numbers!",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrenchCoke% Then
            PrintC "You don't have that many units to sell!",1
            AnyKey
            GoTo SellChoice
          Else
            TrenchCoke% = TrenchCoke% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetCoke%)
            CalcTrenchSpace
            TempString$ = "You sold " + Str$(SellInput) + " units of coke for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetCoke%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "h", "H"
        If TrenchHeroin% < 1 Then
          PrintC "You don't have any heroin!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "You have " + Str$(TrenchHeroin%) + " units of heroin to sell."
          PrintC TempString$,1
          PrintC "How many units to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "Real funny. Use real numbers!",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrenchHeroin% Then
            PrintC "You don't have that many units to sell!",1
            AnyKey
            GoTo SellChoice
          Else
            TrenchHeroin% = TrenchHeroin% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetHeroin%)
            CalcTrenchSpace
            TempString$ = "You sold " + Str$(SellInput) + " units of heroin for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetHeroin%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "a", "A"
        If TrenchAcid% < 1 Then
          PrintC "You don't have any acid!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "You have " + Str$(TrenchAcid%) + " units of acid to sell."
          PrintC TempString$,1
          PrintC "How many units to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "OK, wise guy. Use real numbers!",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrenchAcid% Then
            PrintC "You don't have that many units to sell!",1
            AnyKey
            GoTo SellChoice
          Else
            TrenchAcid% = TrenchAcid% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetAcid%)
            CalcTrenchSpace
            TempString$ = "You sold " + Str$(SellInput) + " units of acid for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetAcid%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "w", "W"
        If TrenchWeed% < 1 Then
          PrintC "You don't have any weed!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "You have " + Str$(TrenchWeed%) + " units of weed to sell."
          PrintC TempString$,1
          PrintC "How many units to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "Get real! Use real numbers!",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrenchWeed% Then
            PrintC "You don't have that many units to sell!",1
            AnyKey
            GoTo SellChoice
          Else
            TrenchWeed% = TrenchWeed% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetWeed%)
            CalcTrenchSpace
            TempString$ = "You sold " + Str$(SellInput) + " units of weed for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetWeed%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "s", "S"
        If TrenchSpeed% < 1 Then
          PrintC "You don't have any speed!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "You have " + Str$(TrenchSpeed%) + " units of speed to sell."
          PrintC TempString$,1
          PrintC "How many units to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "Listen, bud! Use real numbers!",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrenchSpeed% Then
            PrintC "You don't have that many units to sell!",1
            AnyKey
            GoTo SellChoice
          Else
            TrenchSpeed% = TrenchSpeed% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetSpeed%)
            CalcTrenchSpace
            TempString$ = "You sold " + Str$(SellInput) + " units of speed for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetSpeed%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "l", "L"
        If TrenchLudes% < 1 Then
          PrintC "You don't have any ludes!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "You have " + Str$(TrenchLudes%) + " units of ludes to sell."
          PrintC TempString$,1
          PrintC "How many units to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "Real funny! Use real numbers!",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrenchLudes% Then
            PrintC "You don't have that many units to sell!",1
            AnyKey
            GoTo SellChoice
          Else
            TrenchLudes% = TrenchLudes% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetLudes%)
            CalcTrenchSpace
            TempString$ = "You sold " + Str$(SellInput) + " units of ludes for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetLudes%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
    End Select
  Case "j", "J" 'travelling advances the day by one as well as calculates interest on debt and bank account
    SubwaySelect:
    PrintC "Where to, dude?",1
    PrintC "[1] Bronx        [2] Ghetto    ",1
    PrintC "[3] Central Park [4] Manhatten ",1
    PrintC "[5] Coney Island [6] Brooklyn  ",0
    Input Destination
    Print ""
    If Location = Destination - 1 Then
      PrintC "You're already there, man!",1
      Print ""
      GoTo SubwaySelect
    EndIf
    If (Destination < 7) And (Destination > 0) Then
      Location = Destination - 1
      NumDay = NumDay + 1
      CashDebt% = CashDebt% * 1.1 '10% increase in debt daily
      CashBank% = CashBank% * 1.06 '6% increase in bank account daily
      GoTo MainLoop
    EndIf
  Case "l", "L"
    If Location <> 0 Then
      PrintC "The loan shark only deals in the Bronx!",1
      GoTo MainMenu
    Else
      LoanMenu:
      PrintC "Loan Shark",1
      TempString$ = "Debt: " + Str$(Int(CashDebt%)) + "   " + "Wallet: " + Str$(Int(CashWallet%))
      PrintC TempString$,1
      Print ""
      PrintC "[R]epay, [B]orrow",0
      Input LoanChoice$
      Print ""
      Select Case LoanChoice$
        Case "r", "R"
          PrintC "Repay how much",0
          Input LoanInput
          If LoanInput > CashDebt% Then LoanInput = CashDebt%
          ElseIf LoanInput < 0 Then
            PrintC "Oh you're a funny one!",1
            AnyKey
            GoTo MainMenu
          EndIf
          If LoanInput > CashWallet% Then
            PrintC "You're too poor!",1
            PrintC "Go make some money, chump!",1
            AnyKey
            GoTo MainMenu
          EndIf
          Print ""
          CashWallet% = CashWallet% - LoanInput
          CashDebt% = CashDebt% - LoanInput
          TempString$ = "You paid " + Str$(Int(LoanInput)) + " dollars on your debt"
          PrintC TempString$,1
          If CashDebt% = 0 Then PrintC "and your debt is paid off!",1
          If CashDebt% > 0 Then
            TempString$ = "and you have " + Str$(Int(CashDebt%))
            PrintC TempString$,1
            PrintC " dollars left to pay off.",1
          EndIf
          AnyKey
          GoTo MainMenu
        Case "b", "B"
          Print ""
          PrintC "Borrow how much",1
          PrintC "",0
          Input LoanInput
          If LoanInput > 5000 Then
            PrintC "You think he's crazy, man?!",1
            AnyKey
            GoTo LoanMenu
          Else If LoanInput < 1 Then
            PrintC "Ha ha, funny guy.",1
            PrintC "Come back when you're serious.",1
            AnyKey
            GoTo MainMenu
          Else
            Print ""
            CashDebt% = CashDebt% + LoanInput
            TempString$ = "You borrowed " + Str$(Int(LoanInput)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        Case Else
          GoTo MainMenu
      End Select
  Case "v", "V"
    If Location <> 0 Then
      PrintC "The bank in the Bronx!",1
      GoTo MainMenu
    Else
      BankMenu:
      Print ""
      PrintC "Bronx Bank",1
      TempString$ = "Bank Account: " + Str$(Int(CashBank%)) + "   " + "Wallet: " + Str$(Int(CashWallet%))
      PrintC TempString$,1
      Print ""
      PrintC "[D]eposit, [W]ithdraw",0
      Input BankChoice$
      Select Case BankChoice$
        Case "d", "D"
          Print ""
          PrintC "Deposit how much",0
          Input BankInput
          If BankInput > CashWallet% Then
            PrintC "You don't have that much cash!",1
            AnyKey
            GoTo BankMenu
          ElseIf BankInput <= 0 Then
            PrintC "Hey, no funny business!",1
            AnyKey
            GoTo BankMenu
          Else
            Print ""
            TempString$ = "You deposited " + Str$(Int(BankInput))
            PrintC TempString$,1
            PrintC "dollars into your account.",1
            CashWallet% = CashWallet% - BankInput
            CashBank% = CashBank% + BankInput
            AnyKey
            GoTo MainMenu
          EndIf
        Case "w", "W"
          Print ""
          PrintC "Withdraw how much",0
          Input BankInput
          If BankInput > CashBank% Then
            PrintC "You don't have that much saved up!",1
            AnyKey
            GoTo BankMenu
          ElseIf BankInput <= 0 Then
            PrintC "C'mon, be serious!",1
            AnyKey
            GoTo BankMenu
          Else
            TempString$ = "You withdrew " + Str$(Int(BankInput)) + " dollars",1
            PrintC TempString$,1
            PrintC "from your account.",1
            CashWallet% = CashWallet% + BankInput
            CashBank% = CashBank% - BankInput
            AnyKey
            GoTo MainMenu
        Case Else
          GoTo MainMenu
      End Select
  Case "q", "Q"
    PrintC "Are you sure you wanna quit?",1
    PrintC "[Y]es/[N]o",0
    Input Confirm$
    Select Case Confirm$
      Case "y", "Y"
        GoTo EndGame
      Case Else
        GoTo MainMenu
    End Select
  Case Else
    GoTo MainMenu
End Select

GoTo MainMenu

EndGame:
CLS
PrintC "Game Over!",1
FinalScore = (CashBank% + CashWallet% - CashDebt%)
If FinalScore < 0 Then FinalScore = 0
If FinalScore > 0 Then
  FinalScore = Sqr(FinalScore / 1000)
  If FinalScore>100 Then FinalScore = 100
EndIf
TempString$ = "You scored " + Str$(Int(FinalScore)) + " out of 100!"
PrintC TempString$,1
Print ""
PrintC "Play again?",1
PrintC "[Y]es/[N]o",0
Input Confirm$
  Select Case Confirm$
    Case "y", "Y"
      GoTo Start
    Case Else
      Print ""
      PrintC "Thanks for playing!",1
      Print ""
      PrintC "Remember",0
      EllipseAnim
      Print ""
      PrintC "WATCH YOUR BACK",1
      Pause 600
      Print ""
      PrintC "Have a nice day!",1
      Print ""
      End
  End Select

'sub/function declarations
Sub AnyKey 'press any key to continue!
Print ""
PrintC "Press any key to continue",1
Print ""
Do While Inkey$ = ""  : Loop
End Sub

Sub SeeDoctor 'get patched up
If (Health% < 50) And (CashWallet% > 1200) Then
    PrintC "You are hurt! Will you pay 1000",1
    PrintC "dollars for a doctor to sew you up?",1
    PrintC "([Y]es/[N]o)",0
    Input Confirm$
    Select Case Confirm$
      Case "y","Y"
        CashWallet% = CashWallet% - 1000
        Health% = 50
    End Select
  EndIf
End Sub

Sub PrintC InputText$, NewLine 'print centred text
  DisplayWidth = 320 'width of display
  LineLength = Len(InputText$)
  If NewLine = 0 Then Print @((DisplayWidth/2)-(4*LineLength)) InputText$;
  If NewLine = 1 Then Print @((DisplayWidth/2)-(4*LineLength)) InputText$
End Sub

Sub CalcTrenchSpace 'calculate trenchcoat space
  TrenchSpace = TrenchTotal%-TrenchCoke%-TrenchHeroin%-TrenchAcid%-TrenchWeed%-TrenchSpeed%-TrenchLudes%
End Sub

Sub EllipseAnim 'ellipses animation to add "excitement"
  Pause 200
  Print ".";
  Pause 200
  Print ".";
  Pause 200
  Print "."
End Sub

Sub CopChase
NumCops = 14 - RandomEvent
    TempString$ = "Officer hardass and " + Str$(NumCops-1) + " of his deputies"
    PrintC TempString$,1
    PrintC "are after you!",1
    AnyKey
    FightStatus = 1

    Do While FightStatus = 1
      ChaseStart:
      Print ""
      PrintC "You are being chased!",1
      TempString$ = "Guns: " + Str$(NumGuns)
      PrintC TempString$,1
      TempString$ = "Health: " + Str$(Health%)
      PrintC TempString$,1
      TempString$ = "Number of pigs: " + Str$(NumCops)
      PrintC TempString$,1
      PrintC "[F]ight/[R]un",0
      Input Confirm$
      Print ""
      Select Case Confirm$
        Case "f", "F"
          If NumGuns < 1 Then
            PrintC "You don't have any guns,",1
            PrintC "you have to run!",1
            GoTo ChaseStart
          EndIf
          If NumGuns > 0 Then ChanceShot = Int(Rnd*2)
          If NumGuns > 1 Then RoundLimit% = 1
          Else
            RoundLimit% = 0
          EndIf
          For Rounds = 0 To RoundLimit%
            If NumCops > 0 Then
              PrintC "Shooting",0
              EllipseAnim
              Select Case ChanceShot
                Case 0
                  PrintC "You missed!",1
                Case 1
                  PrintC "You killed one!",1
                  NumCops = NumCops - 1
              End Select
            EndIf
          Next Rounds
          If NumCops > 0 Then CopShoot
          If NumCops < 1 Then FightStatus = 0
        EndIf
      Case "r", "R"
        ChanceEscape = Cint(Rnd*1) 'tryto run away
        PrintC "Running",0
        EllipseAnim
        Print ""
        Select Case ChanceEscape
          Case 0
            PrintC "Pigs are still chasing you!",1
            CopShoot
          Case 1
            PrintC "You got away!",1
            AnyKey
            SeeDoctor
            FightStatus = 0
            GoTo MainMenu
        End Select
    End Select
    If NumCops <= 0 Then
      PrintC "You killed all of them!",1
      Print ""
      CashFound% = Cint(Rnd*1250+750)
      CashWallet% = CashWallet% + CashFound%
      TempString$ = "You found " + Str$(CashFound%) + " dollars"
      PrintC TempString$,1
      PrintC "on Officer Hardass' carcass!",1
      AnyKey
      FightStatus = 0
    EndIf
    Loop
  SeeDoctor
End Sub

Sub CopShoot 'cops shoot at you
  ShotChance = Cint(Rnd*1)
  PrintC "They're firing at you!",0
  EllipseAnim
  Select Case ShotChance
    Case 0
      PrintC "They missed!",1
    Case 1
      PrintC "They hit you!",1
      Health% = Health% - ((1+Int(Rnd*4)) * NumCops)
      If Health% <= 0 Then
        PrintC "You've been killed!",1
        AnyKey
        GoTo EndGame
      EndIf
  End Select
End Sub
