'the classic game Drug Wars
'ported and updated by rm
'rewritten by lilcrossfaded

UpdateDate$ = "20250603"
RewriteDate$ = "20250819"

'game start
Start:
CLS
Print ""
PrintC "drug wars",1
Print ""
PrintC "a game based on",1
Print ""
PrintC "the TEXAS drug market",1
Print ""
PrintC "PicoCalc version by rm",1
TempString$ = "updated " + UpdateDate$
PrintC TempString$,1
Print ""
PrintC "rewrite by lilcrossfaded"
TempString$ = "rewritten " + RewriteDate$
PrintC TempString$,1
Print ""
PrintC "based on the game by",1
PrintC "john e. dell",1

'set global variables
CashWallet% = 2000
CashDebt% = 5000
CashBank% = 0
NumDay = 1
NumGuns = 0
TrunkMolly% = 0
TrunkLean% = 0
TrunkTabs% = 0
TrunkTrees% = 0
TrunkAddies% = 0
TrunkBars% = 0
TrunkTotal% = 100
ClacTrunkSpace 'calculate available trunk space
Health% = 50
Location = 0 '0 = Alief, 1 = The Galleria, 2 = Hermann Park, 3 = Third Ward, 4 = The Heights, 5 = Montrose

'instructions/intro
Print ""
PrintC "instructions?",1
PrintC "[y]es, [n]o",0
Input Confirm$
	Select case Confirm$
		Case "y", "Y"
			CLS
		Print ""
			PrintC "this is a game of buying and selling.",1
			PrintC "your goal is to pay off your debt to",1
			PrintC "The Plug and then make as much",1
			PrintC "money as possible in a 1 month period.",1
			Print ""
			PrintC "watch out for Them Boys",1
			PrintC "if you hustling hard!",1
			AnyKey
			CLS
		Print ""
			PrintC "prices for drugs are:",1
			PrintC "Molly: 15000-28000",1
			PrintC "Lean: 5000-12000",1
			PrintC "Tabs: 1000-4200",1
			PrintC "Trees: 300-720",1
			PrintC "Addies: 70-220",1
			PrintC "Bars: 10-50",1
			AnyKey
			CLS
		Print ""
			PrintC "the number next to each name in the",1
			PrintC "price list is how many units of each",1
			PrintC "drug you have.",1
			Print ""
			PrintC "The Bank pays 6% interest a day.",1
			PrintC "The Plug charges 10% interest a day.",1
			PrintC "both are in Alief",1
			AnyKey
		End Select

MainLoop:
Randomize Timer 'seed the rando number generator with the current timer value
StreetMolly% = Int(Rnd*12000+16000)
StreetLean% = Int(Rnd*7000+5000)
StreetTabs% = Int(Rnd*34+10)*100
StreetTrees% = Int(Rnd*42+33)*10
StreetAddies% = Int(Rnd*15+7)*10
StreetBars% = Int(Rnd*4+1)*10
RandomEvent = Int(Rnd*23)

CLS
Print ""
Select Case RandomEvent
Case 1 'cheap Bars
	PrintC "rival dealers are selling cheap Bars!",1
	StreetBars% = 1 + Int(Rnd*3)
	AnyKey
Case 2 'cheap Trees
	PrintC "the price of Trees low as hell!",1
	StreetTrees% = 100 + Int(Rnd*25)
	AnyKey
Case 3 'cheap lean
	PrintC "Them Boys are selling cheap Lean",1
	PrintC "from last week's raid!",1
	StreetLean% = Int(Rnd*1150+850)
	AnyKey
Case 4, 5 'expensive lean
	PrintC "fiends are buying Lean",1
	PrintC "at outrageous prices!",1
	StreetLean% = Int(Rnd*25000+18000)
	AnyKey
Case 6, 7 'expensive Molly
	PrintC "Them Boys raided some niggas.",1
	PrintC "Molly prices higher than a bitch!",1
	StreetMolly%. Int(Rnd*60000+80000)
	AnyKey
Case 8 'robbery
	If NumGuns < 1 Then
		RobberyAmount = CashWallet%-Int((CashWallet%/3)*2)-Int(Rnd*50)
		PrintC "Some niggas broke into your whip!",1
		TempString$ = "they took " + Str$(RobberyAmount) + "dollars."
		PrintC TempString$,1
		PrintC "don't let them catch you lacking again.",1
		CashWallet% = CashWallet% - RobberyAmount
		AnyKey
	EndIf
Case 9 To 12 'cops!
	If TrunkSpace < 60 Then CopChase
Case 13 'buy trunk space
	If CashWallet% > 200 Then
		PrintC "will you buy a new car",1
		PrintC "with more Trunk Space for $200?",1
		PrintC "[y]es, [n]o",0
		Input Confirm$
		Select Case Confirm$
			Case "y", "Y"
				TrunkTotal% = TrunkTotal% + 10
				CalcTrunkSpace
				CashWallet% = CashWallet%-200
		End Select
		EndIF
	EndIF
Case 14 'bogus weed
	PrintC "there's some LoudTM around here...",1
	PrintC "will you smoke it?",1
	PrintC "[y]es, [n]o",0
	Input Confirm$
	Print ""
		Select Case Confirm$
			Case "y", "Y"
				DrugChance = Cint(Rnd*2)
				If DrugChance < 2 Then
					PrintC "you hallucinate on the wildest trip of",1
					PrintC "your life. you try to drive to the corner store,",1
					PrintC "but run a red light and get t-boned...",1
					Print ""
					PrintC "that's some dumb shit bruh...",1
					AnyKey
					GoTo EndGame
				Else
					PrintC "you try to hit the blunt,",1
					PrintC "but it hits you back.",1
					PrintC "you see the riiples of the universe,",1
					PrintC "and accidentally astral project.",1
					Print ""
					PrintC "holy shit",0
					EllipseAnim
					AnyKey
				EndIf
		End Select
Case 15 'buy a gun
	If CashWallet% > 500 And TrunkSpace > 10 Then
		GunChance = Cint(Rnd*2)
		If GunChance=0 Then TempGun$ = "That Nine"
		If GunChance=1 Then TempGun$ = "A Switch"
		If GunChance=2 Then TempGun$ = "Lil Uzi"
		TempString$ = "will you buy a " + TempGun$
		PrintC TempString$,1
		PrintC "for 400 dollars?",1
		PrintC "[y]es, [n]o",0
		Input Confirm$
		Print ""
		Select Case Confirm$
			Case "y", "Y"
				NumGuns = NumGuns + 1
				CashWallet% = CashWallet%-400
				TrunkTotal% = TrunkTotal%-5
				CalcTrunkSpace
		End Select
	EndIf
Case 16 'found some drugs
	F = Cint((Rnd*7+1))
	If TrunkSpace > F Then
		DrugFind = Cint(Rnd*5)
		Select Case DrugFind
			Case 0
				TempDrug$ = "Molly"
				TrunkMolly% = TrunkMolly% + F
			Case 1
				TempDrug$ = "Lean"
				TrunkLean% = TrunkLean% + F
			Case 2
				TempDrug$ = "Tabs"
				TrunkTabs% = TrunkTabs% + F
			Case 3
				TempDrug$ = "Trees"
				TrunkTrees% = TrunkTrees% + F
			Case 4
				TempDrug$ = "Addies"
				TrunkAddies% = TrunkAddies% + F
			Case 5
				TempDrug$ = "Bars"
				TrunkBars% = TrunkBars% + F
			End Select
			TempString$ = "you found " + Str$(F) + " units of " + TempDrug$
			PrintC TempString$,1
			PrintC "in a random parking garage!",1
			CalcTrunkSpace
			AnyKey
	EndIf
Case 17 'cheap Tabs
	PrintC "the market has been flooded with",1
	PrintC "cheap homemade Tabs!",1
	StreetTabs% = Cint(Rnd*550+250)
	AnyKey
Case Else
End Select

MainMenu: 'main loop
If NumDay > 31 Then GoTo EndGame 'game ends after 31 days

CLS
Print ""
PrintC "drug wars",1
Print ""
Select Case Location
	Case 0
		TempLoc$ = "Alief"
	Case 1
		TempLoc$ = "The Galleria"
	Case 2
		TempLoc$ = "Hermann Park"
	Case 3
		TempLoc$ = "Third Ward"
	Case 4
		TempLoc$ = "The Heights"
	Case 5
		TempLoc$ = "Montrose"
End Select
TempString$ = "Day: " + Str$(NumDay) + "     " + "Location: " + TempLoc$
PrintC TempString$,1
Print ""
PrintC "prices: ",1
TempString$ = "Molly [" + Str$(TrunkMolly%) + "]: " + Str$(StreetMolly%) + "    " + "Lean [" + Str$(TrunkLean%) + "]: " + Str$(StreetLean%)
PrintC TempString$,1
TempString$ = "Tabs [" + Str$(TrunkTabs%) + "]: " + Str$(StreetTabs%) + "    " + "Trees [" + Str$(TrunkTrees%) + "]: " + Str$(StreetTrees%)
PrintC TempString$,1
TempString$ = "Addies [" + Str$(TrunkAddies%) + "]: " + Str$(StreetAddies%) + "   " + "Bars [" + Str$(TrunkBars%) + "]: " + Str$(StreetBars%)
PrintC TempString$,1
Print ""
PrintC "stats:",1
TempString$ = "Trunk: " + Str$(TrunkSpace) + "   " + "Guns: " + Str$(NumGuns)
PrintC TempString$,1
TempString$ = "Health: " + Str$(Health%) + "   " + "Wallet: " + Str$(Cint(CashWallet%))
PrintC TempString$,1
TempString$ = "Debt: " + Str$(Cint(CashDebt%)) + "   " + "Bank: " + Str$(Cint(CashBank%))
PrintC TempString$,1
Print ""

MainChoice:
PrintC "[b]uy, [s]ell, [d]ip",1
PrintC "The [P]lug, [V]isit Bank",0
Input ActionChoise$
Print ""
Select Case ActionChoice$
	Case "b", "B"
		If TrunkSpace < 1 Then
		PrintC "your trunk is full!",1
		AnyKey
		GoTo MainMenu
	Else
		BuyChoice:
		PrintC "what you looking for?",1
		PrintC "[M]olly, [L]ean, [T]abs",1
		PrintC "T[r]ees, [A]ddies, [B]ars",0
		Input DrugChoice$
		Print ""
		Select Case DrugChoice$
			Case "m", "M" 'buying Molly
				BuyAbility = Int(CashWallet%/StreetMolly%)
				If BuyAbility < 1 Then
					PrintC "your broke ass can't afford any...",1
					AnyKey
					GoTo BuyChoice
				EndIf
				TempString$ = "you can afford " + Str$(BuyAbility) + " grams of Molly."
				PrintC TempString$,1
				PrintC "how many you want?",0
				Input BuyInput
				Print ""
				If BuyInput > TrunkSpace Then
					PrintC "your trunk too full!",1
					AnyKey
					GoTo BuyChoice
				EndIf
				If (StreetMolly% * BuyInput) > CashWallet% Then
					PrintC "eyes bigger than your pockets homie...",1
					AnyKey
					GoTo BuyChoice
				Else
					TempString$ = "you bought " + Str$(BuyInput) + " grams of Molly"
					PrintC TempString$,1
					TempString$ = "for " + Str$(Cint(BuyInput*StreetMolly%)) + " dollars."
					PrintC TempString$,1
					TrunkMolly% = TrunkMolly% + BuyInput
					CalcTrunkSpace
					CashWallet% = CashWallet% - (StreetMolly%*BuyInput)
					AnyKey
				EndIf
			Case "l", "L" 'buying lean
				BuyAbility = Int(CashWallet%/StreetLean%)
				If BuyAbility < 1 Then
					PrintC "your broke ass can't afford any...",1
					AnyKey
					GoTo BuyChoice
				EndIf
				TempString$ = "you can afford " + Str$(BuyAbility) + " pints of Lean."
				PrintC TempString$,1
				PrintC "how many you want?",0
				Input BuyInput
				Print ""
				If BuyInput > TrunkSpace Then
					PrintC "your trunk too full!",1
					AnyKey
					GoTo BuyChoice
				EndIf
				If (StreetLean% * BuyInput) > CashWallet% Then
					PrintC "eyes bigger than your pockets homie...",1
					AnyKey
					GoTo BuyChoice
				Else
					TempString$ = "you bought " + Str$(BuyInput) + " pints of Lean"
					PrintC TempString$,1
					TempString$ = "for " + Str$(Cint(BuyInput*StreetLean%)) + " dollars."
					PrintC TempString$,1
					TrunkLean% = TrunkLean% + BuyInput
					CalcTrunkSpace
					CashWallet% = CashWallet% - (StreetLean%*BuyInput)
					AnyKey
				EndIf
			Case "t", "T" 'buying Tabs
				BuyAbility = Int(CashWallet%/StreetTabs%)
				If BuyAbility < 1 Then
					PrintC "your broke ass can't afford any...",1
					AnyKey
					GoTo BuyChoice
				EndIf
				TempString$ = "you can afford " + Str$(BuyAbility) + " sheets."
				PrintC TempString$,1
				PrintC "how many you want?",0
				Input BuyInput
				Print ""
				If BuyInput > TrunkSpace Then
					PrintC "your trunk too full!",1
					AnyKey
					GoTo BuyChoice
				EndIf
				If (StreetTabs% * BuyInput) > CashWallet% Then
					PrintC "eyes bigger than your pockets homie...",1
					AnyKey
					GoTo BuyChoice
				Else
					TempString$ = "you bought " + Str$(BuyInput) + " sheets"
					PrintC TempString$,1
					TempString$ = "for " + Str$(Cint(BuyInput*StreetTabs%)) + " dollars."
					PrintC TempString$,1
					TrunkTabs% = TrunkTabs% + BuyInput
					CalcTrunkSpace
					CashWallet% = CashWallet% - (StreetTabs%*BuyInput)
					AnyKey
				EndIf
			Case "r", "R" 'buying Trees
				BuyAbility = Int(CashWallet%/StreetTrees%)
				If BuyAbility < 1 Then
					PrintC "your broke ass can't afford any...",1
					AnyKey
					GoTo BuyChoice
				EndIf
				TempString$ = "you can afford " + Str$(BuyAbility) + " zips."
				PrintC TempString$,1
				PrintC "how many you want?",0
				Input BuyInput
				Print ""
				If BuyInput > TrunkSpace Then
					PrintC "your trunk too full!",1
					AnyKey
					GoTo BuyChoice
				EndIf
				If (StreetTrees% * BuyInput) > CashWallet% Then
					PrintC "eyes bigger than your pockets homie...",1
					AnyKey
					GoTo BuyChoice
				Else
					TempString$ = "you bought " + Str$(BuyInput) + " zips"
					PrintC TempString$,1
					TempString$ = "for " + Str$(Cint(BuyInput*StreetTrees%)) + " dollars."
					PrintC TempString$,1
					TrunkTrees% = TrunkTrees% + BuyInput
					CalcTrunkSpace
					CashWallet% = CashWallet% - (StreetTrees%*BuyInput)
					AnyKey
				EndIf
			Case "a", "A" 'buying Addies
				BuyAbility = Int(CashWallet%/StreetAddies%)
				If BuyAbility < 1 Then
					PrintC "your broke ass can't afford any...",1
					AnyKey
					GoTo BuyChoice
				EndIf
				TempString$ = "you can afford " + Str$(BuyAbility) + " pills."
				PrintC TempString$,1
				PrintC "how many you want?",0
				Input BuyInput
				Print ""
				If BuyInput > TrunkSpace Then
					PrintC "your trunk too full!",1
					AnyKey
					GoTo BuyChoice
				EndIf
				If (StreetTrees% * BuyInput) > CashWallet% Then
					PrintC "eyes bigger than your pockets homie...",1
					AnyKey
					GoTo BuyChoice
				Else
					TempString$ = "you bought " + Str$(BuyInput) + " pills"
					PrintC TempString$,1
					TempString$ = "for " + Str$(Cint(BuyInput*StreetAddies%)) + " dollars."
					PrintC TempString$,1
					TrunkAddies% = TrunkAddies% + BuyInput
					CalcTrunkSpace
					CashWallet% = CashWallet% - (StreetAddies%*BuyInput)
					AnyKey
				EndIf
			Case "b", "B" 'buying Bars
				BuyAbility = Int(CashWallet%/StreetBars%)
				If BuyAbility < 1 Then
					PrintC "your broke ass can't afford any...",1
					AnyKey
					GoTo BuyChoice
				EndIf
				TempString$ = "you can afford " + Str$(BuyAbility) + " pills."
				PrintC TempString$,1
				PrintC "how many you want?",0
				Input BuyInput
				Print ""
				If BuyInput > TrunkSpace Then
					PrintC "your trunk too full!",1
					AnyKey
					GoTo BuyChoice
				EndIf
				If (StreetBars% * BuyInput) > CashWallet% Then
					PrintC "eyes bigger than your pockets homie...",1
					AnyKey
					GoTo BuyChoice
				Else
					TempString$ = "you bought " + Str$(BuyInput) + " pills"
					PrintC TempString$,1
					TempString$ = "for " + Str$(Cint(BuyInput*StreetBars%)) + " dollars."
					PrintC TempString$,1
					TrunkBars% = TrunkBars% + BuyInput
					CalcTrunkSpace
					CashWallet% = CashWallet% - (StreetBars%*BuyInput)
					AnyKey
				EndIf
			Case Else
				GoTo MainMenu
			End Select
		Case "s", "S" 'selling
			SellChoice:
			PrintC "what you holding?",1
			PrintC "[M]olly, [L]ean, [T]abs",1
			PrintC "T[r]ees, [A]ddies, [B]ars",0
			Input DrugChoice$
			Print ""
			Select Case DrugChoice$
				Case "m", "M"
        If TrunkMolly% < 1 Then
          PrintC "you don't have any Molly!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "you have " + Str$(TrunkMolly%) + " grams of Molly to sell."
          PrintC TempString$,1
          PrintC "how many grams to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "use real numbers, dumbass...",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrunkMolly% Then
            PrintC "pick a smaller number bruh...",1
            AnyKey
            GoTo SellChoice
          Else
            TrunkMolly% = TrunkMolly% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetMolly%)
            CalcTrunkSpace
            TempString$ = "you sold " + Str$(SellInput) + " grams of Molly for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetMolly%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "l", "L"
        If TrunkLean% < 1 Then
          PrintC "you don't have any Lean!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "you have " + Str$(TrunkLean%) + " pints of Lean to sell."
          PrintC TempString$,1
          PrintC "how many pints to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "use real numbers, dumbass...",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrunkLean% Then
            PrintC "pick a smaller number bruh...",1
            AnyKey
            GoTo SellChoice
          Else
            TrunkLean% = TrunkLean% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetLean%)
            CalcTrunkSpace
            TempString$ = "you sold " + Str$(SellInput) + " pints of Lean for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetLean%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "t", "T"
        If TrunkTabs% < 1 Then
          PrintC "you don't have any Tabs!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "you have " + Str$(TrunkTabs%) + " sheets to sell."
          PrintC TempString$,1
          PrintC "how many sheets to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "use real numbers, dumbass...",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrunkTabs% Then
            PrintC "pick a smaller number bruh...",1
            AnyKey
            GoTo SellChoice
          Else
            TrunkTabs% = TrunkTabs% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetTabs%)
            CalcTrunkSpace
            TempString$ = "you sold " + Str$(SellInput) + " sheets for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetTabs%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "r", "R"
        If TrunkTrees% < 1 Then
          PrintC "you don't have any Tree!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "you have " + Str$(TrunkTrees%) + " zips to sell."
          PrintC TempString$,1
          PrintC "how many zips to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "use real numbers, dumbass...",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrunkTrees% Then
            PrintC "pick a smaller number bruh...",1
            AnyKey
            GoTo SellChoice
          Else
            TrunkTrees% = TrunkTrees% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetTrees%)
            CalcTrunkSpace
            TempString$ = "you sold " + Str$(SellInput) + " zips for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetTrees%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "a", "A"
        If TrunkAddies% < 1 Then
          PrintC "you don't have any Addies!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "you have " + Str$(TrunkAddies%) + " pills to sell."
          PrintC TempString$,1
          PrintC "how many pills to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "use real numbers, dumbass...",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrunkAddies% Then
            PrintC "pick a smaller number bruh...",1
            AnyKey
            GoTo SellChoice
          Else
            TrunkAddies% = TrunkAddies% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetAddies%)
            CalcTrunkSpace
            TempString$ = "you sold " + Str$(SellInput) + " pills for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetAddies%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      Case "b", "B"
        If TrunkBars% < 1 Then
          PrintC "you don't have any Bars!",1
          AnyKey
          GoTo SellChoice
        Else
          TempString$ = "you have " + Str$(TrunkBars%) + " pills to sell."
          PrintC TempString$,1
          PrintC "how many pills to sell",0
          Input SellInput
          Print ""
          If SellInput < 1 Then
            PrintC "use real numbers, dumbass...",1
            AnyKey
            GoTo SellChoice
          ElseIf SellInput > TrunkBars% Then
            PrintC "pick a smaller number bruh...",1
            AnyKey
            GoTo SellChoice
          Else
            TrunkBars% = TrunkBars% - SellInput
            CashWallet% = CashWallet% + (SellInput * StreetBars%)
            CalcTrunkSpace
            TempString$ = "you sold " + Str$(SellInput) + " pills for"
            PrintC TempString$,1
            TempString$ = Str$(Cint(SellInput * StreetBars%)) + " dollars."
            PrintC TempString$,1
            AnyKey
          EndIf
        EndIf
      End Select
	Case "d", "D" 'travelling advancs the day by one as well as calculates interest on debt and bank account
		HighwaySelect:
		PrintC "where ya headed patna?",1
		PrintC "[1] Alief        [2] The Galleria ",1
		PrintC "[3] Hermann Park [4] Third Ward   ",1
		PrintC "[5] The Heights  [6] Montrose     ",1
		Input Destination
		Print ""
		If Location = Destination - 1 Then
			PrintC "that's where you at right now",1
			Print ""
			GoTo HighwaySelect
		EndIf
		If (Destination < 7) And (Destination > 0) Then
			Location = Destionationo - 1
			NumDay = NumDay + 1
			CashDebt% = CashDebt% * 1.1 '10% increase in debt daily
			CashBank% = Cashbank% * 1.06 '6% increase in bank account daily
			GoTo MainLoop
		EndIf
	Case "l", "L"
		If Location <> 0 Then
			PrintC "The Plug stays in Alief.",1
			GoTo MainMenu
		Else
			LoanMenu:
				PrintC "The Plug",1
				TempString$ = "Debt: " + Str$(Int(CashDebt%)) + "   " + "Wallet: " + Str$(Int(CashWallet%))
				PrintC TempString$,1
				Print ""
				PrintC "[r]epay, [b]orrow",0
				Input LoanChoice$
				Print ""
				Select Case LoanChoice$
				  Case "r", "R"
				    PrintC "repay how much",0
				    Input LoanInput
				    If LoanInput > CashDebt% Then LoanInput = CashDebt%
				    ElseIf LoanInput < 0 Then
				      PrintC "oh you got jokes!",1
				      AnyKey
				      GoTo MainMenu
				    EndIF
				    If LoanInput > CashWallet% Then
				      PrintC "broke ass..."
				      PrintC "get ya money up homie."
				      AnyKey
				      GoTo MainMenu
			      EndIf
			      Print ""
			      CashWallet% = CashWallet% - LoanInput
			      CashDebt% = CashDebt% - LoanInpuy
			      TempString$ = "you paid " + Str$(Int(LoanInput)) + "dollars on your debt"
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
			      PrintC "borrow how much",1
			      PrintC "",0
			      Input LoanInput
			      If LoanInput > 5000 Then
			        PrintC "you bout wild as hell boy!",1
			        AnyKey
			        GoTo MainMenu
		        Else If LoanInput < 1 Then
		          PrintC "oh, you got jokes...",1
		          PrintC "come back when your money's up.",1
		          AnyKey
		          GoTo MainMenu
	          Else
	            Print ""
	            CashDebt% = CashDebt% + LoanInput
	            TempString$ = "you borrowed " + Str$(Int(LoanInput)) + " dollars."
	            PrintC TempString$,1
	            AnyKey
            EndIf
          Case Else
            GoTo MainMenu
          End Select
        Case "v", "V"
          If Location <> 0 Then
            PrintC "the bank is in Alief.",1
            GoTo MainMenu
          Else
            BankMenu:
            Print ""
            PrintC "Bank of Alief",1
            TempString$ = "bank account: " + Str$(Int(CashBank%)) + "   " + "wallet: " + Str$(Int(CashWallet%))
            PrintC TempString$,1
            Print ""
            PrintC "[d]eposit, [w]ithdraw",0
            Input BankChoice$
            Select Case BankChoice$
              Case "d", "D"
              Print ""
              PrintC "deposit how much",0
              Input BankInput
              If BankInput > CashWallet% Then
              PrintC "count again, you don't have that much.",1
              AnyKey
              GoTo BankMenu
            ElseIf BankInput <= 0 Then
              PrintC "quit playing bruh",1
              AnyKey
              GoTo BankMenu
            Else
              Print ""
              TempString$ = "you deposited " + Str$(Int(BankInput))
              PrintC TempString$,1
              PrintC "dollars into your account.",1
              CashWallet% = CashWallet% - BankInput
              CashBank% = CashBank% + BankInput
              AnyKey
              GoTo MainMenu
            EndIf
          Case "w", "W"
            Print ""
            PrintC "withdraw how much",0
            Input BankInput
            If BankInput > CashBank% Then
              PrintC "empty ass bank account....",1
              AnyKey
              GoTo BankMenu
            Else
              TempString$ = "you withdrew " + Str$(Int(BankInput)) + " dollars",1
              PrintC TempString$,1
              PrintC "from your account.",1
              CashWallet% = Cashwallet% + BankInput
              CashBank% = CashBank% - BankInput
		          Anykey
		          GoTo MainMenu
	          Case Else
	            GoTo MainMenu
          End Select
        Case "q", "Q"
          PrintC "are you sure you wanna quit?",1
          PrintC "[y]es, [n]o",0
          Input Confirm$
          Select Case Confirm$
            Case "y", "Y"
              GoTo EndGame
            Case Else
              GoTo MainMenu
          End Select
          
          GoTo MainMenu
          
          EndGame:
          CLS
          PrintC "GAME OVER",1
          FinalScore = (CashBank% + CashWallet% - CashDebt%)
          If FinalScore < 0 Then FinalScore = 0
          If FinalScore > 0 Then
            FinalScore = Sqr(FinalScore / 1000)
            If FinalScore>100 Then FinalScore = 100
          EndIf
          TempString$ = "you scored " + Str$(Int(FinalScore)) + " out of 100!"
          PrintC TempString$,1
          Print ""
          PrintC "play again?",1
          PrintC "[y]es, [n]o",0
          Input Confirm$
            Select Case Confirm$
              Case "y", "Y"
                GoTo Start
              Case Else
                Print ""
                PrintC "thanks for playing",1
                Print ""
                Print "Remember",0
                EllipseAnim
                Print ""
                PrintC "WATCH YOUR BACK",1
                Pause 600
                Print ""
                Print "fuck nigga",1
                Pause 600
                Print ""
                PrintC ";)",1
                Print ""
                End
              End Select
              
            
          'sub/function declarations
          Sub AnyKey 'press any key to continue
          Print ""
          Do While InKey$ = "" : Loop
          End Sub
          
          Sub SeeDcotor 'get patched up
          If (Health% < 50) And (CashWallet% > 1200) Then
            PrintC "you're hurt! is it worth 1000",1
            PrintC "dollars to get sewn up?",1
            PrintC "([y]es, [n]o)",0
            Input Confirm$
            Select Case Confirm$
              Case "y", "Y"
                CashWallet% = CashWallet% - 1000
                Health% = 50
            End Select
          EndIf
        End Sub
        
        Sub PrintC InputText$, Newline 'print centered text
          DisplayWidth = 320 'width of display
          LineLength = Len(InputText$)
          If NewLine = 0 Then Print @((DisplayWidth/2)-(4*LineLength)) InputText$;
          If NewLine = 1 Then Print @((DisplayWidth/2)-(4*LineLength)) InputText$
        End Sub
        
        Sub CalcTrunkSpace 'calculate trunk space
          TrunkSpace = TrunkTotal%-TrunkMolly%-TrunkLean%-TrunkTabs%-TrunkTrees%-TrunkAddies%-TrunkBars%
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
          TempString$ = "officer hardass and " + Str$(NumCops-1) + " of his piggies"
          PrintC TempString$,1
          PrintC "are on your ass!",1
          AnyKey
          FightStatus = 1
          
          Do While FightStatus = 1
            ChaseStart:
            Print ""
            PrintC "they're behind you!",1
            TempString$ = "guns: " + Str$(NumGuns)
            PrintC TempString$,1
            TempString$ = "health: " + Str$(Health%)
            PrintC TempString$,1
            TempString$ = "number of pigs: " + Str$(NumCops)
            PrintC TempString$,1
            PrintC "[f]ight, [r]un",0
            Input Confirm$
            Print ""
            Select Case Confirm$
              Case "f", "F"
                If NumGuns < 1 Then
                  PrintC "you lacking baby...",1
                  PrintC "you gotta dip tf out!",1
                  GoTo ChaseStart
                EndIf
                If NumGuns > 0 Then ChanceShot = Int(Rnd*2)
                If NumGuns > 1 Then RoundLimit% = 1
                Else
                  RoundLimit% = 0
                EndIF
                For Rounds = 0 To RoundLimit%
                  If NumCops > 0 Then
                    PrintC "*gunshot noises*",0
                    EllipseAnim
                    Select Caese ChanceShot
                      Case 0
                        PrintC "aim better nigga!",1
                      Case 1
                        PrintC "put that boy on a t-shirt!",1
                        NumCops = NumCops - 1
                    End Select
                  EndIf
                Next Rounds
                  If NumCops > 0 Then CopShoot
                  If NumCops < 1 Then FightStatus = 0
                EndIf
              Case "r", "R"
                ChanceEscape = Cint(Rnd*1) 'try to run away
                PrintC "let's duck off real quick",0
                EllipseAnim
                Print ""
                Select Case ChanceEscape
                  Case 0
                    PrintC "they still on you!",1
                    CopShoot
                  Case 1
                    PrintC "slid out smooth as fuck!",1
                    AnyKey
                    SeeDoctor
                    FightStatus = 0
                    GoTo MainMenu
                  End Select
                End Select
              If NumCops <= 0 Then
                PrintC "ngl, that felt like over kill...",1
                Print ""
                CashFound% = Cint(Rnd*1250+750)
                CashWallet% = CashWallet% + CashFound%
                TempString$ = "you found " + Str$(CashFound%) + " dollars"
                PrintC TempString$,1
                PrintC "on that boy dead body!",1
                AnyKey
                FightStatus = 0
              EndIf
              Loop
            SeeDoctor
          End Sub
          
          Sub CopShoot 'cops shoot at you
            ShorChance = Cint(Rnd*1)
            PrintC "they firing at you!",0
            EllipseAnim
            Select Case ShotChance
              Case 0
                PrintC "they missed!",1
              Case 1
                PrintC "they got you!",1
                Health% = Health% - ((1+Int(Rnd*4)) * NumCops)
                If Health% <= 0 Then
                  PrintC "they took you out bruh",1
                  AnyKey
                  GoTo EndGame
                EndIf
              End Select
            End Sub
