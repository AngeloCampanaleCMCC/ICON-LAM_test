! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
! Parameter Module File
!
!
! ICON
!
! ---------------------------------------------------------------
! Copyright (C) 2004-2024, DWD, MPI-M, DKRZ, KIT, ETH, MeteoSwiss
! Contact information: icon-model.org
!
! See AUTHORS.TXT for a list of authors
! See LICENSES/ for license information
! SPDX-License-Identifier: GPL-3.0-only  
! ---------------------------------------------------------------

MODULE messy_mecca_kpp_parameters 
  USE mo_kind,                 ONLY: dp

  USE messy_mecca_kpp_precision
  PUBLIC
  SAVE

  !checksum included in the xml file for verification of the mechanism
  CHARACTER(LEN=*), PARAMETER :: KPP_XML_CHECKSUM = 'a7048019e3062f55f0e99c9670a4ed21'


! NSPEC - Number of chemical species
  INTEGER, PARAMETER :: NSPEC = 14 
! NVAR - Number of Variable species
  INTEGER, PARAMETER :: NVAR = 12 
! NVARACT - Number of Active species
  INTEGER, PARAMETER :: NVARACT = 12 
! NFIX - Number of Fixed species
  INTEGER, PARAMETER :: NFIX = 2 
! NREACT - Number of reactions
  INTEGER, PARAMETER :: NREACT = 22 
! NVARST - Starting of variables in conc. vect.
  INTEGER, PARAMETER :: NVARST = 1 
! NFIXST - Starting of fixed in conc. vect.
  INTEGER, PARAMETER :: NFIXST = 13 
! NONZERO - Number of nonzero entries in Jacobian
  INTEGER, PARAMETER :: NONZERO = 58 
! LU_NONZERO - Number of nonzero entries in LU factoriz. of Jacobian
  INTEGER, PARAMETER :: LU_NONZERO = 66 
! CNVAR - (NVAR+1) Number of elements in compressed row format
  INTEGER, PARAMETER :: CNVAR = 13 
! NLOOKAT - Number of species to look at
  INTEGER, PARAMETER :: NLOOKAT = 0 
! NMONITOR - Number of species to monitor
  INTEGER, PARAMETER :: NMONITOR = 0 
! NMASS - Number of atoms to check mass balance
  INTEGER, PARAMETER :: NMASS = 1 

! Index declaration for variable species in C and VAR
!   VAR(ind_spc) = C(ind_spc)

  INTEGER :: ind_N2O = 1 
  INTEGER :: ind_N2O5 = 2 
  INTEGER :: ind_HO2 = 3 
  INTEGER :: ind_H2O = 4 
  INTEGER :: ind_NO = 5 
  INTEGER :: ind_NO3 = 6 
  INTEGER :: ind_HNO3 = 7 
  INTEGER :: ind_O3P = 8 
  INTEGER :: ind_NO2 = 9 
  INTEGER :: ind_OH = 10 
  INTEGER :: ind_O3 = 11 
  INTEGER :: ind_O1D = 12 

! Index declaration for fixed species in C
!   C(ind_spc)

  INTEGER :: ind_O2 = 13 
  INTEGER :: ind_N2 = 14 

! Index declaration for dummy species

  INTEGER :: ind_H = 0 
  INTEGER :: ind_H2 = 0 
  INTEGER :: ind_H2O2 = 0 
  INTEGER :: ind_H2OH2O = 0 
  INTEGER :: ind_N = 0 
  INTEGER :: ind_N2D = 0 
  INTEGER :: ind_NH3 = 0 
  INTEGER :: ind_HONO = 0 
  INTEGER :: ind_HOONO = 0 
  INTEGER :: ind_HNO4 = 0 
  INTEGER :: ind_NH2 = 0 
  INTEGER :: ind_HNO = 0 
  INTEGER :: ind_NHOH = 0 
  INTEGER :: ind_NH2O = 0 
  INTEGER :: ind_NH2OH = 0 
  INTEGER :: ind_CO = 0 
  INTEGER :: ind_CO2 = 0 
  INTEGER :: ind_HCHO = 0 
  INTEGER :: ind_HCOOH = 0 
  INTEGER :: ind_CH2OO = 0 
  INTEGER :: ind_CH3 = 0 
  INTEGER :: ind_CH3O = 0 
  INTEGER :: ind_CH3O2 = 0 
  INTEGER :: ind_HOCH2O2 = 0 
  INTEGER :: ind_CH4 = 0 
  INTEGER :: ind_CH3OH = 0 
  INTEGER :: ind_CH3OOH = 0 
  INTEGER :: ind_HOCH2OOH = 0 
  INTEGER :: ind_HOCH2OH = 0 
  INTEGER :: ind_CH3ONO = 0 
  INTEGER :: ind_CH3NO3 = 0 
  INTEGER :: ind_CH3O2NO2 = 0 
  INTEGER :: ind_HOCH2O2NO2 = 0 
  INTEGER :: ind_LCARBON = 0 
  INTEGER :: ind_HCOCO3 = 0 
  INTEGER :: ind_HCOCO3A = 0 
  INTEGER :: ind_C2H2 = 0 
  INTEGER :: ind_GLYOX = 0 
  INTEGER :: ind_HCOCO2H = 0 
  INTEGER :: ind_CHOOCHO = 0 
  INTEGER :: ind_HCOCO3H = 0 
  INTEGER :: ind_HCOCH2O2 = 0 
  INTEGER :: ind_CH3CO3 = 0 
  INTEGER :: ind_HOCH2CO3 = 0 
  INTEGER :: ind_HOOCH2CO3 = 0 
  INTEGER :: ind_C2H4 = 0 
  INTEGER :: ind_CH3CHO = 0 
  INTEGER :: ind_CH3CO2H = 0 
  INTEGER :: ind_HOCH2CHO = 0 
  INTEGER :: ind_CH3CO3H = 0 
  INTEGER :: ind_HOCH2CO2H = 0 
  INTEGER :: ind_HOCH2CO3H = 0 
  INTEGER :: ind_C2H5O2 = 0 
  INTEGER :: ind_HOCH2CH2O = 0 
  INTEGER :: ind_HOCH2CH2O2 = 0 
  INTEGER :: ind_C2H6 = 0 
  INTEGER :: ind_C2H5OOH = 0 
  INTEGER :: ind_ETHGLY = 0 
  INTEGER :: ind_HYETHO2H = 0 
  INTEGER :: ind_PAN = 0 
  INTEGER :: ind_PHAN = 0 
  INTEGER :: ind_ETHOHNO3 = 0 
  INTEGER :: ind_C33CO = 0 
  INTEGER :: ind_CHOCOCH2O2 = 0 
  INTEGER :: ind_HCOCH2CO3 = 0 
  INTEGER :: ind_ALCOCH2OOH = 0 
  INTEGER :: ind_MGLYOX = 0 
  INTEGER :: ind_HOCH2COCHO = 0 
  INTEGER :: ind_HCOCH2CHO = 0 
  INTEGER :: ind_HOCH2COCO2H = 0 
  INTEGER :: ind_HCOCH2CO2H = 0 
  INTEGER :: ind_HCOCH2CO3H = 0 
  INTEGER :: ind_CH3COCH2O2 = 0 
  INTEGER :: ind_HOC2H4CO3 = 0 
  INTEGER :: ind_C3H6 = 0 
  INTEGER :: ind_CH3COCH3 = 0 
  INTEGER :: ind_ACETOL = 0 
  INTEGER :: ind_HYPERACET = 0 
  INTEGER :: ind_HOC2H4CO2H = 0 
  INTEGER :: ind_HOC2H4CO3H = 0 
  INTEGER :: ind_IC3H7O2 = 0 
  INTEGER :: ind_HYPROPO2 = 0 
  INTEGER :: ind_C3H8 = 0 
  INTEGER :: ind_IC3H7OOH = 0 
  INTEGER :: ind_HYPROPO2H = 0 
  INTEGER :: ind_C3PAN2 = 0 
  INTEGER :: ind_NOA = 0 
  INTEGER :: ind_C3PAN1 = 0 
  INTEGER :: ind_PRONO3BO2 = 0 
  INTEGER :: ind_IC3H7NO3 = 0 
  INTEGER :: ind_PR2O2HNO3 = 0 
  INTEGER :: ind_C312COCO3 = 0 
  INTEGER :: ind_C4CODIAL = 0 
  INTEGER :: ind_CO23C3CHO = 0 
  INTEGER :: ind_C312COCO3H = 0 
  INTEGER :: ind_CO2H3CHO = 0 
  INTEGER :: ind_MACO3 = 0 
  INTEGER :: ind_BIACETO2 = 0 
  INTEGER :: ind_CHOC3COO2 = 0 
  INTEGER :: ind_C44O2 = 0 
  INTEGER :: ind_CO2H3CO3 = 0 
  INTEGER :: ind_MACR = 0 
  INTEGER :: ind_MVK = 0 
  INTEGER :: ind_BIACET = 0 
  INTEGER :: ind_MACO2H = 0 
  INTEGER :: ind_MVKOH = 0 
  INTEGER :: ind_MACO3H = 0 
  INTEGER :: ind_BIACETOH = 0 
  INTEGER :: ind_C413COOOH = 0 
  INTEGER :: ind_BIACETOOH = 0 
  INTEGER :: ind_C44OOH = 0 
  INTEGER :: ind_CO2H3CO3H = 0 
  INTEGER :: ind_MACRO2 = 0 
  INTEGER :: ind_MEK = 0 
  INTEGER :: ind_HO12CO3C4 = 0 
  INTEGER :: ind_MACROH = 0 
  INTEGER :: ind_MACROOH = 0 
  INTEGER :: ind_NC4H10 = 0 
  INTEGER :: ind_C312COPAN = 0 
  INTEGER :: ind_MPAN = 0 
  INTEGER :: ind_LMEKO2 = 0 
  INTEGER :: ind_LHMVKABO2 = 0 
  INTEGER :: ind_LMVKOHABO2 = 0 
  INTEGER :: ind_LMEKOOH = 0 
  INTEGER :: ind_LHMVKABOOH = 0 
  INTEGER :: ind_LMVKOHABOOH = 0 
  INTEGER :: ind_LC4H9O2 = 0 
  INTEGER :: ind_LC4H9OOH = 0 
  INTEGER :: ind_LC4H9NO3 = 0 
  INTEGER :: ind_CHOC3COCO3 = 0 
  INTEGER :: ind_CO23C4CO3 = 0 
  INTEGER :: ind_CO13C4CHO = 0 
  INTEGER :: ind_CO23C4CHO = 0 
  INTEGER :: ind_C513CO = 0 
  INTEGER :: ind_CHOC3COOOH = 0 
  INTEGER :: ind_CO23C4CO3H = 0 
  INTEGER :: ind_C511O2 = 0 
  INTEGER :: ind_C512O2 = 0 
  INTEGER :: ind_C513O2 = 0 
  INTEGER :: ind_C5H8 = 0 
  INTEGER :: ind_HCOC5 = 0 
  INTEGER :: ind_C511OOH = 0 
  INTEGER :: ind_C512OOH = 0 
  INTEGER :: ind_C513OOH = 0 
  INTEGER :: ind_ISOPBO2 = 0 
  INTEGER :: ind_ISOPDO2 = 0 
  INTEGER :: ind_C59O2 = 0 
  INTEGER :: ind_ISOPAOH = 0 
  INTEGER :: ind_ISOPBOH = 0 
  INTEGER :: ind_ISOPDOH = 0 
  INTEGER :: ind_ISOPBOOH = 0 
  INTEGER :: ind_ISOPDOOH = 0 
  INTEGER :: ind_C59OOH = 0 
  INTEGER :: ind_C514OOH = 0 
  INTEGER :: ind_C514O2 = 0 
  INTEGER :: ind_CHOC3COPAN = 0 
  INTEGER :: ind_C5PAN9 = 0 
  INTEGER :: ind_NC4CHO = 0 
  INTEGER :: ind_NISOPO2 = 0 
  INTEGER :: ind_ISOPBNO3 = 0 
  INTEGER :: ind_ISOPDNO3 = 0 
  INTEGER :: ind_NISOPOOH = 0 
  INTEGER :: ind_C514NO3 = 0 
  INTEGER :: ind_LHC4ACCO3 = 0 
  INTEGER :: ind_LHC4ACCHO = 0 
  INTEGER :: ind_LHC4ACCO2H = 0 
  INTEGER :: ind_LHC4ACCO3H = 0 
  INTEGER :: ind_LISOPACO2 = 0 
  INTEGER :: ind_LC578O2 = 0 
  INTEGER :: ind_LISOPACOOH = 0 
  INTEGER :: ind_LC578OOH = 0 
  INTEGER :: ind_LC5PAN1719 = 0 
  INTEGER :: ind_LISOPACNO3 = 0 
  INTEGER :: ind_LNISO3 = 0 
  INTEGER :: ind_LNISOOH = 0 
  INTEGER :: ind_CO235C5CHO = 0 
  INTEGER :: ind_CO235C6O2 = 0 
  INTEGER :: ind_C614CO = 0 
  INTEGER :: ind_CO235C6OOH = 0 
  INTEGER :: ind_C614O2 = 0 
  INTEGER :: ind_C614OOH = 0 
  INTEGER :: ind_C614NO3 = 0 
  INTEGER :: ind_CO235C6CO3 = 0 
  INTEGER :: ind_CO235C6CHO = 0 
  INTEGER :: ind_C235C6CO3H = 0 
  INTEGER :: ind_C716O2 = 0 
  INTEGER :: ind_C716OOH = 0 
  INTEGER :: ind_ROO6R4P = 0 
  INTEGER :: ind_ROO6R5P = 0 
  INTEGER :: ind_ROO6R3O = 0 
  INTEGER :: ind_C721O2 = 0 
  INTEGER :: ind_C722O2 = 0 
  INTEGER :: ind_ROO6R3O2 = 0 
  INTEGER :: ind_ROO6R5O2 = 0 
  INTEGER :: ind_C721OOH = 0 
  INTEGER :: ind_C722OOH = 0 
  INTEGER :: ind_ROO6R3OOH = 0 
  INTEGER :: ind_C7PAN3 = 0 
  INTEGER :: ind_ROO6R3NO3 = 0 
  INTEGER :: ind_C8BCO2 = 0 
  INTEGER :: ind_C721CO3 = 0 
  INTEGER :: ind_C8BCCO = 0 
  INTEGER :: ind_C8BCOOH = 0 
  INTEGER :: ind_C721CHO = 0 
  INTEGER :: ind_NORPINIC = 0 
  INTEGER :: ind_C721CO3H = 0 
  INTEGER :: ind_C85O2 = 0 
  INTEGER :: ind_C89O2 = 0 
  INTEGER :: ind_C811O2 = 0 
  INTEGER :: ind_C86O2 = 0 
  INTEGER :: ind_C812O2 = 0 
  INTEGER :: ind_C813O2 = 0 
  INTEGER :: ind_C8BC = 0 
  INTEGER :: ind_C85OOH = 0 
  INTEGER :: ind_C811OOH = 0 
  INTEGER :: ind_C86OOH = 0 
  INTEGER :: ind_C812OOH = 0 
  INTEGER :: ind_C813OOH = 0 
  INTEGER :: ind_C89OOH = 0 
  INTEGER :: ind_C810OOH = 0 
  INTEGER :: ind_C810O2 = 0 
  INTEGER :: ind_C8BCNO3 = 0 
  INTEGER :: ind_C721PAN = 0 
  INTEGER :: ind_C89NO3 = 0 
  INTEGER :: ind_C810NO3 = 0 
  INTEGER :: ind_C85CO3 = 0 
  INTEGER :: ind_NOPINDCO = 0 
  INTEGER :: ind_C85CO3H = 0 
  INTEGER :: ind_NOPINDO2 = 0 
  INTEGER :: ind_C89CO3 = 0 
  INTEGER :: ind_C811CO3 = 0 
  INTEGER :: ind_NOPINONE = 0 
  INTEGER :: ind_NOPINOO = 0 
  INTEGER :: ind_NORPINAL = 0 
  INTEGER :: ind_C89CO2H = 0 
  INTEGER :: ind_NOPINDOOH = 0 
  INTEGER :: ind_RO6R3P = 0 
  INTEGER :: ind_C89CO3H = 0 
  INTEGER :: ind_PINIC = 0 
  INTEGER :: ind_C811CO3H = 0 
  INTEGER :: ind_C96O2 = 0 
  INTEGER :: ind_C97O2 = 0 
  INTEGER :: ind_C98O2 = 0 
  INTEGER :: ind_C96OOH = 0 
  INTEGER :: ind_C97OOH = 0 
  INTEGER :: ind_C98OOH = 0 
  INTEGER :: ind_C89PAN = 0 
  INTEGER :: ind_C9PAN2 = 0 
  INTEGER :: ind_C811PAN = 0 
  INTEGER :: ind_C96NO3 = 0 
  INTEGER :: ind_C98NO3 = 0 
  INTEGER :: ind_C109CO = 0 
  INTEGER :: ind_PINALO2 = 0 
  INTEGER :: ind_PINALOOH = 0 
  INTEGER :: ind_C109O2 = 0 
  INTEGER :: ind_C96CO3 = 0 
  INTEGER :: ind_C106O2 = 0 
  INTEGER :: ind_APINENE = 0 
  INTEGER :: ind_BPINENE = 0 
  INTEGER :: ind_PINAL = 0 
  INTEGER :: ind_APINAOO = 0 
  INTEGER :: ind_APINBOO = 0 
  INTEGER :: ind_MENTHEN6ONE = 0 
  INTEGER :: ind_PINONIC = 0 
  INTEGER :: ind_C109OOH = 0 
  INTEGER :: ind_PERPINONIC = 0 
  INTEGER :: ind_C106OOH = 0 
  INTEGER :: ind_BPINAO2 = 0 
  INTEGER :: ind_OH2MENTHEN6ONE = 0 
  INTEGER :: ind_RO6R1O2 = 0 
  INTEGER :: ind_ROO6R1O2 = 0 
  INTEGER :: ind_RO6R3O2 = 0 
  INTEGER :: ind_OHMENTHEN6ONEO2 = 0 
  INTEGER :: ind_BPINAOOH = 0 
  INTEGER :: ind_RO6R1OOH = 0 
  INTEGER :: ind_RO6R3OOH = 0 
  INTEGER :: ind_ROO6R1OOH = 0 
  INTEGER :: ind_PINALNO3 = 0 
  INTEGER :: ind_C10PAN2 = 0 
  INTEGER :: ind_C106NO3 = 0 
  INTEGER :: ind_BPINANO3 = 0 
  INTEGER :: ind_RO6R1NO3 = 0 
  INTEGER :: ind_RO6R3NO3 = 0 
  INTEGER :: ind_ROO6R1NO3 = 0 
  INTEGER :: ind_LAPINABO2 = 0 
  INTEGER :: ind_LAPINABOOH = 0 
  INTEGER :: ind_LNAPINABO2 = 0 
  INTEGER :: ind_LNBPINABO2 = 0 
  INTEGER :: ind_LAPINABNO3 = 0 
  INTEGER :: ind_LNAPINABOOH = 0 
  INTEGER :: ind_LNBPINABOOH = 0 
  INTEGER :: ind_Cl = 0 
  INTEGER :: ind_Cl2 = 0 
  INTEGER :: ind_ClO = 0 
  INTEGER :: ind_HCl = 0 
  INTEGER :: ind_HOCl = 0 
  INTEGER :: ind_Cl2O2 = 0 
  INTEGER :: ind_OClO = 0 
  INTEGER :: ind_ClNO2 = 0 
  INTEGER :: ind_ClNO3 = 0 
  INTEGER :: ind_CCl4 = 0 
  INTEGER :: ind_CH3Cl = 0 
  INTEGER :: ind_CH3CCl3 = 0 
  INTEGER :: ind_CF2Cl2 = 0 
  INTEGER :: ind_CFCl3 = 0 
  INTEGER :: ind_Br = 0 
  INTEGER :: ind_Br2 = 0 
  INTEGER :: ind_BrO = 0 
  INTEGER :: ind_HBr = 0 
  INTEGER :: ind_HOBr = 0 
  INTEGER :: ind_BrNO2 = 0 
  INTEGER :: ind_BrNO3 = 0 
  INTEGER :: ind_BrCl = 0 
  INTEGER :: ind_CH3Br = 0 
  INTEGER :: ind_CF3Br = 0 
  INTEGER :: ind_CF2ClBr = 0 
  INTEGER :: ind_CHCl2Br = 0 
  INTEGER :: ind_CHClBr2 = 0 
  INTEGER :: ind_CH2ClBr = 0 
  INTEGER :: ind_CH2Br2 = 0 
  INTEGER :: ind_CHBr3 = 0 
  INTEGER :: ind_I = 0 
  INTEGER :: ind_I2 = 0 
  INTEGER :: ind_IO = 0 
  INTEGER :: ind_OIO = 0 
  INTEGER :: ind_I2O2 = 0 
  INTEGER :: ind_HI = 0 
  INTEGER :: ind_HOI = 0 
  INTEGER :: ind_HIO3 = 0 
  INTEGER :: ind_INO2 = 0 
  INTEGER :: ind_INO3 = 0 
  INTEGER :: ind_CH3I = 0 
  INTEGER :: ind_CH2I2 = 0 
  INTEGER :: ind_C3H7I = 0 
  INTEGER :: ind_ICl = 0 
  INTEGER :: ind_CH2ClI = 0 
  INTEGER :: ind_IBr = 0 
  INTEGER :: ind_S = 0 
  INTEGER :: ind_SO = 0 
  INTEGER :: ind_SO2 = 0 
  INTEGER :: ind_SO3 = 0 
  INTEGER :: ind_SH = 0 
  INTEGER :: ind_H2SO4 = 0 
  INTEGER :: ind_CH3SO3H = 0 
  INTEGER :: ind_DMS = 0 
  INTEGER :: ind_DMSO = 0 
  INTEGER :: ind_CH3SO2 = 0 
  INTEGER :: ind_CH3SO3 = 0 
  INTEGER :: ind_OCS = 0 
  INTEGER :: ind_SF6 = 0 
  INTEGER :: ind_Hg = 0 
  INTEGER :: ind_HgO = 0 
  INTEGER :: ind_HgCl = 0 
  INTEGER :: ind_HgCl2 = 0 
  INTEGER :: ind_HgBr = 0 
  INTEGER :: ind_HgBr2 = 0 
  INTEGER :: ind_ClHgBr = 0 
  INTEGER :: ind_BrHgOBr = 0 
  INTEGER :: ind_ClHgOBr = 0 
  INTEGER :: ind_NO3m_cs = 0 
  INTEGER :: ind_Hp_cs = 0 
  INTEGER :: ind_RGM_cs = 0 
  INTEGER :: ind_IPART = 0 
  INTEGER :: ind_Dummy = 0 
  INTEGER :: ind_O3s = 0 
  INTEGER :: ind_LO3s = 0 
  INTEGER :: ind_LHOC3H6O2 = 0 
  INTEGER :: ind_LHOC3H6OOH = 0 
  INTEGER :: ind_ISO2 = 0 
  INTEGER :: ind_ISON = 0 
  INTEGER :: ind_ISOOH = 0 
  INTEGER :: ind_MVKO2 = 0 
  INTEGER :: ind_MVKOOH = 0 
  INTEGER :: ind_NACA = 0 
  INTEGER :: ind_Op = 0 
  INTEGER :: ind_O2p = 0 
  INTEGER :: ind_Np = 0 
  INTEGER :: ind_N2p = 0 
  INTEGER :: ind_NOp = 0 
  INTEGER :: ind_Hp = 0 
  INTEGER :: ind_em = 0 
  INTEGER :: ind_kJmol = 0 
  INTEGER :: ind_RH2O = 0 
  INTEGER :: ind_RNOy = 0 
  INTEGER :: ind_RCly = 0 
  INTEGER :: ind_RBr = 0 
  INTEGER :: ind_CFCl3_c = 0 
  INTEGER :: ind_CF2Cl2_c = 0 
  INTEGER :: ind_N2O_c = 0 
  INTEGER :: ind_CH3CCl3_c = 0 
  INTEGER :: ind_CF2ClBr_c = 0 
  INTEGER :: ind_CF3Br_c = 0 
  INTEGER :: ind_LTERP = 0 
  INTEGER :: ind_LALK4 = 0 
  INTEGER :: ind_LALK5 = 0 
  INTEGER :: ind_LARO1 = 0 
  INTEGER :: ind_LARO2 = 0 
  INTEGER :: ind_LOLE1 = 0 
  INTEGER :: ind_LOLE2 = 0 
  INTEGER :: ind_LfPOG01 = 0 
  INTEGER :: ind_LfPOG02 = 0 
  INTEGER :: ind_LfPOG03 = 0 
  INTEGER :: ind_LfPOG04 = 0 
  INTEGER :: ind_LbbPOG01 = 0 
  INTEGER :: ind_LbbPOG02 = 0 
  INTEGER :: ind_LbbPOG03 = 0 
  INTEGER :: ind_LbbPOG04 = 0 
  INTEGER :: ind_LfSOGsv01 = 0 
  INTEGER :: ind_LbbSOGsv01 = 0 
  INTEGER :: ind_LfSOGiv01 = 0 
  INTEGER :: ind_LfSOGiv02 = 0 
  INTEGER :: ind_LfSOGiv03 = 0 
  INTEGER :: ind_LbbSOGiv01 = 0 
  INTEGER :: ind_LbbSOGiv02 = 0 
  INTEGER :: ind_LbbSOGiv03 = 0 
  INTEGER :: ind_LbSOGv01 = 0 
  INTEGER :: ind_LbSOGv02 = 0 
  INTEGER :: ind_LbSOGv03 = 0 
  INTEGER :: ind_LbSOGv04 = 0 
  INTEGER :: ind_LbOSOGv01 = 0 
  INTEGER :: ind_LbOSOGv02 = 0 
  INTEGER :: ind_LbOSOGv03 = 0 
  INTEGER :: ind_LaSOGv01 = 0 
  INTEGER :: ind_LaSOGv02 = 0 
  INTEGER :: ind_LaSOGv03 = 0 
  INTEGER :: ind_LaSOGv04 = 0 
  INTEGER :: ind_LaOSOGv01 = 0 
  INTEGER :: ind_LaOSOGv02 = 0 
  INTEGER :: ind_LaOSOGv03 = 0 
  INTEGER :: ind_ETH = 0 
  INTEGER :: ind_HC3 = 0 
  INTEGER :: ind_HC5 = 0 
  INTEGER :: ind_HC8 = 0 
  INTEGER :: ind_OL2 = 0 
  INTEGER :: ind_OLT = 0 
  INTEGER :: ind_OLI = 0 
  INTEGER :: ind_ISO = 0 
  INTEGER :: ind_TOL = 0 
  INTEGER :: ind_XYL = 0 
  INTEGER :: ind_CSL = 0 
  INTEGER :: ind_ALD = 0 
  INTEGER :: ind_KET = 0 
  INTEGER :: ind_GLY = 0 
  INTEGER :: ind_MGLY = 0 
  INTEGER :: ind_DCB = 0 
  INTEGER :: ind_PAN_ka = 0 
  INTEGER :: ind_TPAN = 0 
  INTEGER :: ind_ONIT = 0 
  INTEGER :: ind_OP1 = 0 
  INTEGER :: ind_OP2 = 0 
  INTEGER :: ind_PAA = 0 
  INTEGER :: ind_ORA1 = 0 
  INTEGER :: ind_ORA2 = 0 
  INTEGER :: ind_ETHP = 0 
  INTEGER :: ind_HC3P = 0 
  INTEGER :: ind_HC5P = 0 
  INTEGER :: ind_HC8P = 0 
  INTEGER :: ind_OL2P = 0 
  INTEGER :: ind_OLTP = 0 
  INTEGER :: ind_OLIP = 0 
  INTEGER :: ind_TOLP = 0 
  INTEGER :: ind_XYLP = 0 
  INTEGER :: ind_ACO3 = 0 
  INTEGER :: ind_KETP = 0 
  INTEGER :: ind_TCO3 = 0 
  INTEGER :: ind_OLN = 0 
  INTEGER :: ind_XNO2 = 0 
  INTEGER :: ind_XO2 = 0 
  INTEGER :: ind_API = 0 
  INTEGER :: ind_LIM = 0 
  INTEGER :: ind_MACR_Ka = 0 
  INTEGER :: ind_MPAN_Ka = 0 
  INTEGER :: ind_HACE = 0 
  INTEGER :: ind_NALD = 0 
  INTEGER :: ind_ISOP = 0 
  INTEGER :: ind_APIP = 0 
  INTEGER :: ind_LIMP = 0 
  INTEGER :: ind_MACP = 0 
  INTEGER :: ind_ISHP = 0 
  INTEGER :: ind_MAHP = 0 
  INTEGER :: ind_CS1 = 0 
  INTEGER :: ind_CS10 = 0 
  INTEGER :: ind_CS100 = 0 
  INTEGER :: ind_CS1000 = 0 
  INTEGER :: ind_O2_a01 = 0 
  INTEGER :: ind_O3_a01 = 0 
  INTEGER :: ind_OH_a01 = 0 
  INTEGER :: ind_HO2_a01 = 0 
  INTEGER :: ind_H2O_a01 = 0 
  INTEGER :: ind_H2O2_a01 = 0 
  INTEGER :: ind_NH3_a01 = 0 
  INTEGER :: ind_NO_a01 = 0 
  INTEGER :: ind_NO2_a01 = 0 
  INTEGER :: ind_NO3_a01 = 0 
  INTEGER :: ind_HONO_a01 = 0 
  INTEGER :: ind_HNO3_a01 = 0 
  INTEGER :: ind_HNO4_a01 = 0 
  INTEGER :: ind_N2O5_a01 = 0 
  INTEGER :: ind_CH3OH_a01 = 0 
  INTEGER :: ind_HCOOH_a01 = 0 
  INTEGER :: ind_HCHO_a01 = 0 
  INTEGER :: ind_CH3O2_a01 = 0 
  INTEGER :: ind_CH3OOH_a01 = 0 
  INTEGER :: ind_CO2_a01 = 0 
  INTEGER :: ind_CH3CO2H_a01 = 0 
  INTEGER :: ind_PAN_a01 = 0 
  INTEGER :: ind_C2H5O2_a01 = 0 
  INTEGER :: ind_CH3CHO_a01 = 0 
  INTEGER :: ind_CH3COCH3_a01 = 0 
  INTEGER :: ind_Cl_a01 = 0 
  INTEGER :: ind_Cl2_a01 = 0 
  INTEGER :: ind_HCl_a01 = 0 
  INTEGER :: ind_HOCl_a01 = 0 
  INTEGER :: ind_Br_a01 = 0 
  INTEGER :: ind_Br2_a01 = 0 
  INTEGER :: ind_HBr_a01 = 0 
  INTEGER :: ind_HOBr_a01 = 0 
  INTEGER :: ind_BrCl_a01 = 0 
  INTEGER :: ind_I2_a01 = 0 
  INTEGER :: ind_IO_a01 = 0 
  INTEGER :: ind_HI_a01 = 0 
  INTEGER :: ind_HOI_a01 = 0 
  INTEGER :: ind_ICl_a01 = 0 
  INTEGER :: ind_IBr_a01 = 0 
  INTEGER :: ind_HIO3_a01 = 0 
  INTEGER :: ind_SO2_a01 = 0 
  INTEGER :: ind_H2SO4_a01 = 0 
  INTEGER :: ind_DMS_a01 = 0 
  INTEGER :: ind_DMSO_a01 = 0 
  INTEGER :: ind_Hg_a01 = 0 
  INTEGER :: ind_HgO_a01 = 0 
  INTEGER :: ind_HgOH_a01 = 0 
  INTEGER :: ind_HgOHOH_a01 = 0 
  INTEGER :: ind_HgOHCl_a01 = 0 
  INTEGER :: ind_HgCl2_a01 = 0 
  INTEGER :: ind_HgBr2_a01 = 0 
  INTEGER :: ind_HgSO3_a01 = 0 
  INTEGER :: ind_ClHgBr_a01 = 0 
  INTEGER :: ind_BrHgOBr_a01 = 0 
  INTEGER :: ind_ClHgOBr_a01 = 0 
  INTEGER :: ind_O2m_a01 = 0 
  INTEGER :: ind_OHm_a01 = 0 
  INTEGER :: ind_Hp_a01 = 0 
  INTEGER :: ind_NH4p_a01 = 0 
  INTEGER :: ind_NO2m_a01 = 0 
  INTEGER :: ind_NO3m_a01 = 0 
  INTEGER :: ind_NO4m_a01 = 0 
  INTEGER :: ind_CO3m_a01 = 0 
  INTEGER :: ind_HCOOm_a01 = 0 
  INTEGER :: ind_HCO3m_a01 = 0 
  INTEGER :: ind_CH3COOm_a01 = 0 
  INTEGER :: ind_Clm_a01 = 0 
  INTEGER :: ind_Cl2m_a01 = 0 
  INTEGER :: ind_ClOm_a01 = 0 
  INTEGER :: ind_ClOHm_a01 = 0 
  INTEGER :: ind_Brm_a01 = 0 
  INTEGER :: ind_Br2m_a01 = 0 
  INTEGER :: ind_BrOm_a01 = 0 
  INTEGER :: ind_BrOHm_a01 = 0 
  INTEGER :: ind_BrCl2m_a01 = 0 
  INTEGER :: ind_Br2Clm_a01 = 0 
  INTEGER :: ind_Im_a01 = 0 
  INTEGER :: ind_IO2m_a01 = 0 
  INTEGER :: ind_IO3m_a01 = 0 
  INTEGER :: ind_ICl2m_a01 = 0 
  INTEGER :: ind_IClBrm_a01 = 0 
  INTEGER :: ind_IBr2m_a01 = 0 
  INTEGER :: ind_SO3m_a01 = 0 
  INTEGER :: ind_SO3mm_a01 = 0 
  INTEGER :: ind_SO4m_a01 = 0 
  INTEGER :: ind_SO4mm_a01 = 0 
  INTEGER :: ind_SO5m_a01 = 0 
  INTEGER :: ind_HSO3m_a01 = 0 
  INTEGER :: ind_HSO4m_a01 = 0 
  INTEGER :: ind_HSO5m_a01 = 0 
  INTEGER :: ind_CH3SO3m_a01 = 0 
  INTEGER :: ind_CH2OHSO3m_a01 = 0 
  INTEGER :: ind_Hgp_a01 = 0 
  INTEGER :: ind_Hgpp_a01 = 0 
  INTEGER :: ind_HgOHp_a01 = 0 
  INTEGER :: ind_HgClp_a01 = 0 
  INTEGER :: ind_HgCl3m_a01 = 0 
  INTEGER :: ind_HgCl4mm_a01 = 0 
  INTEGER :: ind_HgBrp_a01 = 0 
  INTEGER :: ind_HgBr3m_a01 = 0 
  INTEGER :: ind_HgBr4mm_a01 = 0 
  INTEGER :: ind_HgSO32mm_a01 = 0 
  INTEGER :: ind_D1O_a01 = 0 
  INTEGER :: ind_D2O_a01 = 0 
  INTEGER :: ind_DAHp_a01 = 0 
  INTEGER :: ind_DA_a01 = 0 
  INTEGER :: ind_DAm_a01 = 0 
  INTEGER :: ind_DGtAi_a01 = 0 
  INTEGER :: ind_DGtAs_a01 = 0 
  INTEGER :: ind_PROD1_a01 = 0 
  INTEGER :: ind_PROD2_a01 = 0 
  INTEGER :: ind_Nap_a01 = 0 

! Index declaration for fixed species in FIX
!    FIX(indf_spc) = C(ind_spc) = C(NVAR+indf_spc)

  INTEGER, PARAMETER :: indf_O2 = 1 
  INTEGER, PARAMETER :: indf_N2 = 2 

 END MODULE messy_mecca_kpp_parameters 
