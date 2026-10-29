Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C89606A331
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hkGraF5h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F18C1123E4;
	Thu, 29 Oct 2026 15:31:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4581123E4;
 Thu, 29 Oct 2026 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793287909; x=1824823909;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nOQE72RMtwCDmIencX2D2pZVmpuKaPfgdzbxnxlhzPc=;
 b=hkGraF5hwyeqUSgSBUT+blb1+CTOgSM6pM+BsqTLdbS4PzJk0dmwmvns
 lbk8F67ObEy7K+UeKogfVFDN+XImZlAj6lbs5aINSIYxVxLrosc6IyaK2
 8LZrMo2utu1h2AwVZcACIBSVbMcGOM/iz/e0+8FrxLRqruHaLgaMNEvTN
 +qPHNSzhyzXat5P32mJptXb/RrrwC1cDP/n+HsoZnRgGZRF1Vy5OwQXmr
 zm7vF/SE4SStNHVr0Q25uX3wQmHWE9FX4NB7PHLwjc9Y+6H5H022W9I5y
 6exAmA2j3M4rZfMyXwkDyYF4rsybfB3ib1h+NFBo65YrDWBp4zdx6zAHu w==;
X-CSE-ConnectionGUID: DPYoP3RTSx+StCpjw+Pmfw==
X-CSE-MsgGUID: /dy6IsVORb+knLMLiW5DPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1920231"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1920231"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 08:31:39 -0700
X-CSE-ConnectionGUID: soekDp6nQFC1khxjTXcEtA==
X-CSE-MsgGUID: aLyCZfp+R1Gu/J4PhhfbKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5306474"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 08:31:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 08:31:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 08:31:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 08:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAa1d/dJqZcZWdLa54oGEcpz/+Y/0peZcQPeswLV7f4JWZqGwGTG3+7NUizPAR0BpihUtED31BXFdfCtGKcgM1fpEbmN2fajbbVVImWXYZ6WjLJlB91FDFYg/75qOF5mepjEfi9JBl9DCbc/2PwOi0EoUmney1o4tFkHJ19gOEaGdsFwwxxFj4gDQ8BHK1/uz20SCXQQJIXbNGDcVXES568xcMfFhiXp353zXiT5+UkSWU9Gp++YjKG6NNSAse3nG6ok5Hok5fvAked8KiZ7D5FyQzVxyBZO3uZYnKXVbJ+SQnyNS6pfBUUu1SlhRCeXY0cvY+Mvj9WVlx8Alzjg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SmoXiuHtnYKm4qWJHxqwngVZP2JSsqbzuKPOLeTEDQ=;
 b=N7aZcMPVfQOE1t+v7WCUXnrDQLzB+1X2oRgaFy1g3xmubc6Tf0rR0mSKt7NdvDHQC7cDFj9fJ2ZFlSnA4fxV7752LBypKob+uks+fYEcaFxyJ3mzClGagmeBEMweBzf0mBGvxiUGyiB9kkO3/SxyRJi8DZLndcbEpQmfS4svVjU2kesW/BMYrA+Rr4TV4c/j9dd62nzK+aa0n2bIaIo/AwC5yH2+fzYvlMV7zP15MDJShvLTTCVXt1kSb+mH25cCvkFLEcUF21nXKiwmVZdC77uSjvMtNaKNsZcxYArbtag2FMT6n/nnWOIzQTnWFLVuIty0cES5SeLNBJOOVEIksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS7PR11MB7858.namprd11.prod.outlook.com (2603:10b6:8:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 15:31:35 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 15:31:35 +0000
Date: Thu, 29 Oct 2026 08:31:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Daniel Colascione <dancol@dancol.org>
CC: <intel-xe@lists.freedesktop.org>, Thomas Hellstrom
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH] drm/xe/ggtt: Cut GGTT initialization from 900 ms to
 37 ms
Message-ID: <auNm1b7dXfpiOSs6@gsse-cloud1.jf.intel.com>
References: <87v76m1l9k.fsf@dancol.org>
 <auNjXNXpokRw+buB@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auNjXNXpokRw+buB@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0364.namprd04.prod.outlook.com
 (2603:10b6:303:81::9) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS7PR11MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df1f0cb-28fe-495c-0d50-08df35d1b79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006|261028144727099003|261022075727099003|10067099003|261022113327099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 45v8QgkLx0onQSd2zdouvvagNor/KNmM5JSuks1X83XpOAgZmQtztFEkHJc4Z4X7a7TUkR/za8z3o9cvkLdxKAwliOI0lxbhJL2fRvSy9oee+r9vZwhlAOdBk+I/vCm7enNgpfsCN8QwjuNrpdAXKXaczVCvmZc6awp/wJgOoL2+pCx/7rQH9vQ9ByeM0SuL5xuRhBiGU0/djBQOtgQdXDX1DL+pMDEVNY3ckq3S1sN1y6jhIGIDsrsXGUF899ukYX7oN4dk/37NfaEEmC44yJjYT76ZByif7zPceIJ2L0oT3JtODtskSAK2DD3USyziDURG+hjKAiINJltyWEhpMq8W8yWH/mmpt20l4fUV6xFm6D+qbRixRpsKXuU863thxtUCEp/kFBztbm31jkFRAnVzmTMhNRMMcn646kCJOMoZ+JdYR2/nAhFtCmyeFszOysVVF09B8TOLX2ZCETyt2gTVXD/ABFK6w84WhFeXAKkmD00RflX67cjx8O/hg2Y3IE7q6+flJRmRdUjpxBvGW1Rv/2tgDm30DwO2wKqjp3+5FGg0omaE6rCCXBC4D+TbS5N1Vl9kBDNkkG60KnOAWioBxHWEo3IVSKiU3CKhKJd7PMgvGmPMOJTigTjP1LU/CunihR8hAWEVliCUJI0uyT2wkZb0zX+LFb0uq/lUBgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006)(261028144727099003)(261022075727099003)(10067099003)(261022113327099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5eRkjtil1aFQmbldiD55tcyQc8WFpzhY7Ohd7Xb0soqOWD7HDRIY3Q+m11V?=
 =?us-ascii?Q?i+zxw/bmtcfg/XFYRyzMphWfvNon7KQNN3Wtagpe9Ogza5ZX2iXOqEWnZwQu?=
 =?us-ascii?Q?10p+VUPyQKD2cQn7M1d0reDDWB/izEDFehx7Z8fdb5s+8MhQvXUYgr2z/Ka8?=
 =?us-ascii?Q?217jraUZsWnHPXvx8fdc2z8RN5KXmhtQ6hdXrgSHZs1yn5MuW2bjh+l/H4AX?=
 =?us-ascii?Q?2u3clsydSCLeGQGGas0psmvmy6Ap5FQIEwHdWPKKjVG05uRWFJpQviMbwE8Q?=
 =?us-ascii?Q?bTsgFofGRmn1uSW6lK1RZ2agXD4Rs7tV4pURGqrdjWHqD8VqXa0dnQs+fPsC?=
 =?us-ascii?Q?K6g/XqQyjVpQTJKxL77WRRhcmlKA+XFLQVXFScU4AGddbeohn9uBYRkBuiQk?=
 =?us-ascii?Q?Dlz3sH2hFv5gTrLnGy8A2h6n2lClIkWj2eKIkmnwhbYfnJZhfcgVyTOtR5fR?=
 =?us-ascii?Q?bUsCEzvOyEZoZirpNSpCX+F4wlrEcSh/IaBmRtSfQmln1ivRSN73Zl4OJEIq?=
 =?us-ascii?Q?15zl5dhSowpUSnQRR6v8ueHR3u9QKyEXQuuvNrC/AagVu6eLAb0tyl9GNKvd?=
 =?us-ascii?Q?joDQphWqo7Yt8HoYtLDkLoEO5/mshqTcloKBPj5qtbQ+7vL8SfKaxcnKafiE?=
 =?us-ascii?Q?4PHnBySvieJ07CoATWsYpFRBBYl41/vEuFj3+cyWU5nlJroyLda/X7S3pefL?=
 =?us-ascii?Q?UXbSf+sSKfplLSMudtEHg/1gb7Ga2dV696ufJjSW9TIQDbvq65gsmkZiGgwZ?=
 =?us-ascii?Q?jjp8QyJjjpwDI79KUqrWOYCOlbj8d90u6bYg014S4slYYUcBmgpMUHU2sfc+?=
 =?us-ascii?Q?unN4orMsNyL8MrzE6JeRaf+QLS4mKl2XwYmpw3BgTZj9SxjUuIpyC30m0Os5?=
 =?us-ascii?Q?b1ckPLg0or/DpTrP8k1YLoRLsEsckZW8h3C0Bjm6wsIilvNuvCqi2f6ApAao?=
 =?us-ascii?Q?6trXwMhQgTkfgCiSevVQJLuzyo40Eioss9TBgRP8PBmlo2uck/fnWJKKdXhg?=
 =?us-ascii?Q?70D7nTbjMGABIJR6wy5R1vPSl5gVZqNGpn5dKs7ztCI7mdkdnxiHZJVeumpz?=
 =?us-ascii?Q?CSWVhTAv9z7+zhO1h61iaMFTGOBgMmjZKtqrNtXLp9uMj16Ffus08RL4f3SH?=
 =?us-ascii?Q?rDIsrMr0w7lIFUFtFhvvR4Q4zbKjkSIxHeTTU6ZNRqoOUXA4AkiFxhGBPzJw?=
 =?us-ascii?Q?p15LF9IAdm4NS0LCl0bNJmfIrWCnuygvGwou2fF+2VT3KgKvEHD//EjjcmId?=
 =?us-ascii?Q?NH32UvZQpQZDSWaGt8rD0Yx9V8YHmWTiGfdtAaIgMAGLaP0s7h0dLW3T4MFx?=
 =?us-ascii?Q?etWI12iMKGb9Y2DE7siuXzW//DWFK6swsiLhL5IN2VTplzQDrOzDb26U1HGi?=
 =?us-ascii?Q?xvgNwxRSdq4q9sJ6X6hRNk4H6PGzS9XMzxxMtgaXuVZAlBm2mj/q8221s7ov?=
 =?us-ascii?Q?wrLOw9sfeNvln+vvdgUFJG0D+JGeHy6oW9Jb+KbUq193FPvqN9G4DGdZ1MYH?=
 =?us-ascii?Q?C28IW2u/b7swFfvbuGtGD1BcoB9eoF+wIQPibFt9CS+Z8IXptBOfICRvvPsS?=
 =?us-ascii?Q?O177Bx9GohD2aot1Pg1oPS1X1wnVqkVD/ZRemH2ZwQyL9WnaqVX000PVGlxH?=
 =?us-ascii?Q?2ZKrcY7R4seO9EgrjBKNOe4gtDcIVfs9QUuIRBnyD4TB+P5coZ8cyO2yrJ/g?=
 =?us-ascii?Q?ZsFuvAmPcyjwK3UD6D8qPMXZ1PeruTqNukARPqTPDvG7Yoq9zLO9zLM8bRcP?=
 =?us-ascii?Q?tZKVeSU6Pw=3D=3D?=
X-Exchange-RoutingPolicyChecked: l342cmQh2AXVJ0qpCwoofqz0JcqYuqmR7pvUZOl3VSMPnSIaMNma3yasJ3ZrYiLBYPK4vuJtEgmeeiXLnAi4k8L6zqIY2ZXoL2XC4osxWnLn6LefRQSbQUeDpxK8WmhAkpGy4I15NdSodVIr3Pg40lar5PN1pm4gqQ92gDOWndzRULFiVp8ms7n7ZVRcmCzwiBm6uwmbmsmWRq5dygW1PvTJSY1KGElcIIXoFBbelI4Js3aFFmF+AMaMC08iH8adFtXCuxyAfs/lNQqYXsVh/niOpZBWQzIClLILHS1ckjM6wKOpW5jd2JRTGmPErNJMI9TcvyIAdJ6nbJhTdzQfRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df1f0cb-28fe-495c-0d50-08df35d1b79f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:31:35.6382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1QNZDUGrU88nT/vBXi5A8t0U79GbVN7HE7ZZavgEoz8XX29bSkEhlMTj7yYCDK3tb+aGjaY9p1vKwOJMIFIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7858
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:16:44AM -0700, Matthew Brost wrote:

Sorry double reply, just had another thought...

> On Tue, Oct 27, 2026 at 09:50:31PM -0700, Daniel Colascione wrote:
> 
> Thanks for this - I have wondered why when I probe Xe it takes a
> noticable amount of time - I suspect this is why. 
> 
> > We initialize the GGTT GPU page tables on startup. On my LNL, doing
> > this one PTE at a time through the BAR takes about 900 ms and involves
> > a million small writes.
> > 
> > Use the GPU's copy engine to fill the PTEs in batches. We build
> > MI_UPDATE_GTT commands in normal memory, then send them to the GPU for
> > execution. This way, we avoid the per-PTE MMIO write and do the PTE fill
> > in 36.77 ms, ~24x faster.
> > 
> > The new path is enabled by default. xe.ggtt_init_gpu=0 uses the old
> > CPU-driven path.
> > 
> > LNL-only because I can test only LNL. Might it work elsewhere?
> > 
> 
> It should work anywhere.
> 
> > Signed-off-by: Daniel Colascione <dancol@dancol.org>
> > ---
> >  drivers/gpu/drm/xe/instructions/xe_mi_commands.h |   2 +
> >  drivers/gpu/drm/xe/xe_ggtt.c                     | 128 +++++++++++++++++++++--
> >  drivers/gpu/drm/xe/xe_ggtt.h                     |   1 +
> >  drivers/gpu/drm/xe/xe_gt.c                       |   3 +-
> >  drivers/gpu/drm/xe/xe_module.c                   |   5 +
> >  drivers/gpu/drm/xe/xe_module.h                   |   1 +
> >  6 files changed, 130 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
> > index 835ef75bbeb1..04bd4225adef 100644
> > --- a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
> > +++ b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
> > @@ -62,6 +62,8 @@
> >  #define   MI_LRI_FORCE_POSTED		REG_BIT(12)
> >  #define   MI_LRI_LEN(x)			(((x) & 0xff) + 1)
> >  
> > +#define MI_UPDATE_GTT			__MI_INSTR(0x23)
> > +
> >  #define MI_STORE_REGISTER_MEM		(__MI_INSTR(0x24) | XE_INSTR_NUM_DW(4))
> >  #define   MI_SRM_USE_GGTT		REG_BIT(22)
> >  #define   MI_SRM_ADD_CS_OFFSET		REG_BIT(19)
> > diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
> > index 773777afc68a..3737d085ae68 100644
> > --- a/drivers/gpu/drm/xe/xe_ggtt.c
> > +++ b/drivers/gpu/drm/xe/xe_ggtt.c
> > @@ -15,20 +15,25 @@
> >  #include <drm/intel/i915_drm.h>
> >  #include <generated/xe_wa_oob.h>
> >  
> > +#include "instructions/xe_mi_commands.h"
> >  #include "regs/xe_gt_regs.h"
> >  #include "regs/xe_gtt_defs.h"
> >  #include "regs/xe_regs.h"
> >  #include "xe_assert.h"
> > +#include "xe_bb.h"
> >  #include "xe_bo.h"
> > +#include "xe_exec_queue.h"
> >  #include "xe_gt.h"
> >  #include "xe_gt_printk.h"
> >  #include "xe_gt_types.h"
> >  #include "xe_log.h"
> >  #include "xe_map.h"
> >  #include "xe_mmio.h"
> > +#include "xe_module.h"
> >  #include "xe_pat.h"
> >  #include "xe_pm.h"
> >  #include "xe_res_cursor.h"
> > +#include "xe_sched_job.h"
> >  #include "xe_sriov.h"
> >  #include "xe_tile_printk.h"
> >  #include "xe_tile_sriov_vf.h"
> > @@ -384,9 +389,9 @@ static void dev_fini_ggtt(void *arg)
> >   * @ggtt: the &xe_ggtt to be initialized
> >   *
> >   * It allows to create new mappings usable by the GuC.
> > - * Mappings are not usable by the HW engines, as it doesn't have scratch nor
> > - * initial clear done to it yet. That will happen in the regular, non-early
> > - * GGTT initialization.
> > + * HW engines may only access explicitly mapped bootstrap buffers until the
> > + * remaining holes have been cleared. Normally xe_ggtt_init() does this;
> > + * the GPU clear finishes this work in xe_ggtt_init_late().
> >   *
> >   * Return: 0 on success or a negative error code on failure.
> >   */
> > @@ -456,18 +461,119 @@ ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
> >  static void xe_ggtt_invalidate(struct xe_ggtt *ggtt);
> >  static void xe_ggtt_invalidate_engine(struct xe_ggtt *ggtt);
> >  
> > -static void xe_ggtt_initial_clear(struct xe_ggtt *ggtt)
> > +static bool ggtt_use_gpu(struct xe_device *xe)
> >  {
> > +	return xe_modparam.ggtt_init_gpu && xe->info.platform == XE_LUNARLAKE;
> 
> Per below (last reply) - let's just turn this everywhere in platform
> config.
> 
> > +}
> > +
> > +/*
> > + * MI_UPDATE_GTT takes at most 511 inline PTEs (ACM PRM, Vol. 2a,
> > + * pp. 1096-1097). Limit batches to 512K to fit the kernel batch pool.
> > + */
> > +#define GGTT_INIT_PTES_PER_PACKET	511
> > +#define GGTT_INIT_BATCH_DWORDS	(128 * (2 + 2 * GGTT_INIT_PTES_PER_PACKET))
> > +
> > +static int ggtt_clear_gpu(struct xe_exec_queue *q, struct xe_bb *bb,
> > +			  u64 pte, u64 start, u64 end)
> 
> s/ggtt_clear_gpu/xe_ggtt_clear_gpu
> 
> > +{
> > +	while (start < end) {
> > +		struct xe_sched_job *job;
> > +		int err;
> > +
> > +		bb->len = 0;
> > +		while (start < end && bb->len < GGTT_INIT_BATCH_DWORDS) {
> > +			u32 count = min_t(u64, (end - start) >> XE_PTE_SHIFT,
> > +					  GGTT_INIT_PTES_PER_PACKET);
> > +
> > +			bb->cs[bb->len++] = MI_UPDATE_GTT | (2 * count);
> > +			bb->cs[bb->len++] = start;
> > +			memset64((u64 *)&bb->cs[bb->len], pte, count);
> > +			bb->len += 2 * count;
> > +			start += (u64)count << XE_PTE_SHIFT;
> > +		}
> > +
> > +		job = xe_bb_create_job(q, bb);
> > +		if (IS_ERR(job))
> > +			return PTR_ERR(job);
> > +
> > +		xe_sched_job_arm(job);
> > +		xe_sched_job_get(job);
> > +		xe_sched_job_push(job);
> > +
> > +		dma_fence_wait(&job->drm.s_fence->finished, false);
> 
> You can pipeline this function.
> 
> i.e., generate fences in a loop and only wait on the last one.
> 
> This is fairly common pattern, xe_svm_copy is an example of function
> with loop which issues a bunch of jobs and only waits on the very last
> fence.
> 
> > +		err = dma_fence_get_status(&job->drm.s_fence->finished);
> > +		xe_sched_job_put(job);
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int xe_ggtt_initial_clear(struct xe_ggtt *ggtt, struct xe_hw_engine *hwe)
> > +{
> > +	struct xe_device *xe = tile_to_xe(ggtt->tile);
> > +	struct xe_exec_queue *q = NULL;
> > +	struct xe_bb *bb = NULL;
> >  	struct drm_mm_node *hole;
> > -	u64 start, end;
> > +	u16 pat_index = xe_cache_pat_idx(xe, XE_CACHE_WB);
> > +	u64 start, end, pte = 0;
> > +	int err = 0;
> > +
> > +	if (hwe) {
> > +		q = xe_exec_queue_create(xe, NULL, BIT(hwe->logical_instance), 1,
> > +					 hwe, EXEC_QUEUE_FLAG_KERNEL, 0);
> 
> Can we use migration queue (xe_migrate.c)? We'd probably need a bit of
> layering rework to allow another layer like GGTT to safely use this
> queue but that seems better to keep a single isolated kernel queue.
> 
> > +		if (IS_ERR(q))
> > +			return PTR_ERR(q);
> > +
> > +		bb = xe_bb_new(hwe->gt, GGTT_INIT_BATCH_DWORDS, false);
> > +		if (IS_ERR(bb)) {
> > +			err = PTR_ERR(bb);
> > +			goto put_queue;
> > +		}
> > +	}
> >  
> > -	/* Display may have allocated inside ggtt, so be careful with clearing here */
> > +	if (ggtt->scratch)
> > +		pte = xe_bo_addr(ggtt->scratch, 0, XE_PAGE_SIZE) |
> > +		      ggtt->pt_ops->pte_encode_flags(ggtt->scratch, pat_index);
> > +
> > +	/* Preserve boot mappings and exclude allocator changes until completion. */
> >  	mutex_lock(&ggtt->lock);
> 
> CI and Sashiko correctly complain that 'ggtt->lock' is tainted with
> reclaim and ggtt_clear_gpu will be a malloc for the GPU job.
> 
> I'm actually questioning if this taint is actually valid. afiak we never
> shrink or evict anything GGTT mapped (i.e., that memory is always
> pinned). So I think we can just drop the taint - I'd do this in a
> standalone patch. 
> 
> > -	drm_mm_for_each_hole(hole, &ggtt->mm, start, end)
> > -		xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
> > +	drm_mm_for_each_hole(hole, &ggtt->mm, start, end) {
> > +		if (q)
> > +			err = ggtt_clear_gpu(q, bb, pte, ggtt->start + start, ggtt->start + end);
> > +		else
> > +			xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
> > +		if (err)
> > +			goto unlock;
> > +	}
> >  
> >  	xe_ggtt_invalidate(ggtt);
> > +unlock:
> >  	mutex_unlock(&ggtt->lock);
> > +	xe_bb_free(bb, NULL);
> > +put_queue:
> > +	if (q)
> > +		xe_exec_queue_put(q);
> > +	return err;
> > +}
> > +
> > +/**
> > + * xe_ggtt_init_late - Finish deferred GGTT initialization after GuC startup
> > + * @ggtt: GGTT to initialize
> > + *
> > + * All default contexts must be recorded before waiting for a GPU clear with
> > + * the GGTT mutex held, so reset recovery need not allocate context mappings.
> > + *
> > + * Return: 0 on success or a negative error code on failure.
> > + */
> > +int xe_ggtt_init_late(struct xe_ggtt *ggtt)
> > +{
> > +	if (!ggtt_use_gpu(tile_to_xe(ggtt->tile)))
> > +		return 0;
> > +
> > +	return xe_ggtt_initial_clear(ggtt, xe_gt_hw_engine(ggtt->tile->primary_gt,
> > +							XE_ENGINE_CLASS_COPY, 0, false));
> >  }
> >  
> >  static void ggtt_node_fini(struct xe_ggtt_node *node)
> > @@ -536,6 +642,9 @@ void xe_ggtt_node_remove(struct xe_ggtt_node *node, bool invalidate)
> >   * xe_ggtt_init - Regular non-early GGTT initialization
> >   * @ggtt: the &xe_ggtt to be initialized
> >   *
> > + * Allocate the scratch page if needed and clear unused entries, or defer
> > + * the clear to xe_ggtt_init_late() when GPU initialization is enabled.
> > + *
> >   * Return: 0 on success or a negative error code on failure.
> >   */
> >  int xe_ggtt_init(struct xe_ggtt *ggtt)
> > @@ -572,7 +681,8 @@ int xe_ggtt_init(struct xe_ggtt *ggtt)
> >  			      xe_bo_size(ggtt->scratch));
> >  	}
> >  
> > -	xe_ggtt_initial_clear(ggtt);
> > +	if (!ggtt_use_gpu(xe))
> > +		xe_ggtt_initial_clear(ggtt, NULL);

Hmm, so this defers GGTT clears to after we use GGTT memory for queues /
jobs.

The fact this works points to GGTT scratch most likely not actually
being needed but that is pretty hard to reason 100% correctly.

I wonder if a better solution is completely drop the GGTT clear and BO
which sets XE_BO_FLAG_GGTT just allocates guard page at the end (again
with a config to enable this which is on by default until we can reason
this isn't needed).

A lot to take in here. Let us know if you want to continue driving this,
or I can try to find an engineer at Intel to own it. A reduction from
900 ms to 37 ms is a compelling result, and this clearly needs to be
reworked.

Matt

> >  
> >  	return devm_add_action_or_reset(xe->drm.dev, ggtt_fini, ggtt);
> >  err:
> > diff --git a/drivers/gpu/drm/xe/xe_ggtt.h b/drivers/gpu/drm/xe/xe_ggtt.h
> > index c864cc975a69..cae8600d7142 100644
> > --- a/drivers/gpu/drm/xe/xe_ggtt.h
> > +++ b/drivers/gpu/drm/xe/xe_ggtt.h
> > @@ -17,6 +17,7 @@ struct xe_ggtt *xe_ggtt_alloc(struct xe_tile *tile);
> >  int xe_ggtt_init_early(struct xe_ggtt *ggtt);
> >  int xe_ggtt_init_kunit(struct xe_ggtt *ggtt, u32 reserved, u32 size);
> >  int xe_ggtt_init(struct xe_ggtt *ggtt);
> > +int xe_ggtt_init_late(struct xe_ggtt *ggtt);
> >  
> >  void xe_ggtt_shift_nodes(struct xe_ggtt *ggtt, u64 new_base);
> >  u64 xe_ggtt_start(struct xe_ggtt *ggtt);
> > diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> > index 45fb074812a2..d1c14a02de66 100644
> > --- a/drivers/gpu/drm/xe/xe_gt.c
> > +++ b/drivers/gpu/drm/xe/xe_gt.c
> > @@ -686,7 +686,8 @@ static int gt_init_with_all_forcewake(struct xe_gt *gt)
> >  	if (err)
> >  		return err;
> >  
> > -	return 0;
> > +	return xe_gt_is_main_type(gt) ?
> > +		xe_ggtt_init_late(gt_to_tile(gt)->mem.ggtt) : 0;
> >  }
> >  
> >  static void xe_gt_fini(void *arg)
> > diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> > index 897724cb5cfb..44cc0107cf53 100644
> > --- a/drivers/gpu/drm/xe/xe_module.c
> > +++ b/drivers/gpu/drm/xe/xe_module.c
> > @@ -22,6 +22,7 @@
> >  #include "xe_sched_job.h"
> >  
> >  struct xe_modparam xe_modparam = {
> > +	.ggtt_init_gpu =		true,
> 
> I'd make this platform param in xe_pci.c and turn it on for every
> platform which supports the required GPU instructions (likely every Xe
> supported platform). We can let this soak in for a couple months in our
> CI before getting into a kernel release to ensure everything is
> functional and then perhaps rip out the non-GPU clear code.
> 
> Matt
> 
> >  	.probe_display =	XE_DEFAULT_PROBE_DISPLAY,
> >  	.guc_log_level =	XE_DEFAULT_GUC_LOG_LEVEL,
> >  	.force_probe =		XE_DEFAULT_FORCE_PROBE,
> > @@ -34,6 +35,10 @@ struct xe_modparam xe_modparam = {
> >  	/* the rest are 0 by default */
> >  };
> >  
> > +module_param_named(ggtt_init_gpu, xe_modparam.ggtt_init_gpu, bool, 0444);
> > +MODULE_PARM_DESC(ggtt_init_gpu,
> > +		 "GPU GGTT initialization on Lunar Lake (default: true)");
> > +
> >  module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size, uint, 0600);
> >  MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size in MiB, must be power of 2 "
> >  		 "[default=" __stringify(XE_DEFAULT_SVM_NOTIFIER_SIZE) "]");
> > diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
> > index 6272d9e41207..8aa91822c35c 100644
> > --- a/drivers/gpu/drm/xe/xe_module.h
> > +++ b/drivers/gpu/drm/xe/xe_module.h
> > @@ -12,6 +12,7 @@ struct work_struct;
> >  
> >  /* Module modprobe variables */
> >  struct xe_modparam {
> > +	bool ggtt_init_gpu;
> >  	bool probe_display;
> >  	int force_vram_bar_size;
> >  	int guc_log_level;
