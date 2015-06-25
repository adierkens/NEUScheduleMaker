//
//  Subject.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/17/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation
import UIKit
    
    func iterateEnum<T: Hashable>(_: T.Type) -> GeneratorOf<T> {
        var cast: (Int -> T)!
        switch sizeof(T) {
        case 0: return GeneratorOf(GeneratorOfOne(unsafeBitCast((), T.self)))
        case 1: cast = { unsafeBitCast(UInt8(truncatingBitPattern: $0), T.self) }
        case 2: cast = { unsafeBitCast(UInt16(truncatingBitPattern: $0), T.self) }
        case 4: cast = { unsafeBitCast(UInt32(truncatingBitPattern: $0), T.self) }
        case 8: cast = { unsafeBitCast(UInt64($0), T.self) }
        default: fatalError("cannot be here")
        }
        
        var i = 0
        return GeneratorOf {
            let next = cast(i)
            return next.hashValue == i++ ? next : nil
        }
    }


enum Subject : String {
    case ALL = "ALL";
    case ACCT = "ACCT";
    case AFRS = "AFRS";
    case AFAM = "AFAM";
    case AMSL = "AMSL";
    case ANTH = "ANTH";
    case ARAB = "ARAB";
    case ARCH = "ARCH";
    case ARMY = "ARMY";
    case ARTG = "ARTG";
    case ARTF = "ARTF";
    case ARTE = "ARTE";
    case ARTH = "ARTH";
    case ARTD = "ARTD";
    case ARTS = "ARTS";
    case ASNS = "ASNS";
    case BNSC = "BNSC";
    case BIOC = "BIOC";
    case BIOE = "BIOE";
    case BIOL = "BIOL";
    case BIOT = "BIOT";
    case BUSN = "BUSN";
    case EXSC = "EXSC";
    case CHME = "CHME";
    case CHEM = "CHEM";
    case CHNS = "CHNS";
    case CIVE = "CIVE";
    case COMM = "COMM";
    case CMMN = "CMMN";
    case CS = "CS";
    case CSYE = "CSYE";
    case EEAM = "EEAM";
    case EESC = "EESC";
    case EESH = "EESH";
    case EXED = "EXED";
    case COOP = "COOP";
    case CAEP = "CAEP";
    case CRIM = "CRIM";
    case CLRT = "CLRT";
    case LITR = "LITR";
    case DSCS = "DSCS";
    case DSSH = "DSSH";
    case DEAF = "DEAF";
    case EVRN = "EVRN";
    case ENVR = "ENVR";
    case EEMB = "EEMB";
    case ECON = "ECON";
    case ECNM = "ECNM";
    case EDUC = "EDUC";
    case EECE = "EECE";
    case ENSY = "ENSY";
    case ENGR = "ENGR";
    case ENLR = "ENLR";
    case EMGT = "EMGT";
    case ENGL = "ENGL";
    case ENGH = "ENGH";
    case ENGW = "ENGW";
    case ESLG = "ESLG";
    case ENTR = "ENTR";
    case TECE = "TECE";
    case ENVS = "ENVS";
    case FINA = "FINA";
    case FSEM = "FSEM";
    case FRNH = "FRNH";
    case GAME = "GAME";
    case GSND = "GSND";
    case GE = "GE";
    case GENS = "GENS";
    case GRMN = "GRMN";
    case GBST = "GBST";
    case GREK = "GREK";
    case HINF = "HINF";
    case HLTH = "HLTH";
    case HSCI = "HSCI";
    case HBRW = "HBRW";
    case HIST = "HIST";
    case HSTY = "HSTY";
    case HONR = "HONR";
    case HRMG = "HRMG";
    case HUSV = "HUSV";
    case IE = "IE";
    case IA = "IA";
    case IS = "IS";
    case INFO = "INFO";
    case INTL = "INTL";
    case INTB = "INTB";
    case INTP = "INTP";
    case INLN = "INLN";
    case JPNS = "JPNS";
    case JWSS = "JWSS";
    case JRNL = "JRNL";
    case LARC = "LARC";
    case LANG = "LANG";
    case LACS = "LACS";
    case LW = "LW";
    case LPSC = "LPSC";
    case LING = "LING";
    case MGMT = "MGMT";
    case MISM = "MISM";
    case MGSC = "MGSC";
    case MECN = "MECN";
    case MARS = "MARS";
    case MKTG = "MKTG";
    case MATL = "MATL";
    case MATH = "MATH";
    case MATM = "MATM";
    case MEIE = "MEIE";
    case ME = "ME";
    case CINE = "CINE";
    case MSCR = "MSCR";
    case MUSC = "MUSC";
    case MUSI = "MUSI";
    case MUST = "MUST";
    case NMMD = "NMMD";
    case NAVY = "NAVY";
    case NRSG = "NRSG";
    case OR = "OR";
    case ORGB = "ORGB";
    case PHSC = "PHSC";
    case PMST = "PMST";
    case PHMD = "PHMD";
    case PHIL = "PHIL";
    case PHLS = "PHLS";
    case RELS = "RELS";
    case PT = "PT";
    case PA = "PA";
    case PHYS = "PHYS";
    case POLS = "POLS";
    case PORT = "PORT";
    case PSYC = "PSYS";
    case PPUA = "PPUA";
    case PHTH = "PHTH";
    case RSSN = "RSSN";
    case SMFA = "SMFA";
    case SOCL = "SOCL";
    case SPNS = "SPNS";
    case SLPA = "SLPA";
    case ABRB = "ABRB";
    case ABRS = "ABRS";
    case SCHM = "SCHM";
    case SBSY = "SBSY";
    case SUEN = "SUEN";
    case TELE = "TELE";
    case THTR = "THTR";
    case WMNS = "WMNS";
}