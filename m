Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C6606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G5eHOc7y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094C2112CA3;
	Fri, 27 Nov 2026 18:08:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8923F112CA3;
 Fri, 27 Nov 2026 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802891; x=1827338891;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hZOWqju66j1fS9vc5cha8KI91kykoDFxUYsd/XnkT4A=;
 b=G5eHOc7y+w9Lbocgajhdg4apduyasvtNaxtj7byZZAIcrjkednGrRVg2
 /8sEJGJ53mGrKgniStB5KMfESmKoze+/GCD/Y199OtAB60Y4HEgaztd2p
 2bf6z1IErv09QXnkQhitJDQKT55t9y0Z4465sT991YKuFqBKwmeSradt+
 rwcKQdJ0TUAAcxIMmagxu+TlzmB1AmOccSz1unLVFCjazIRpk0IXVO8Wn
 PNTcTVdL2rI63002O3iYDPnSqpsn0ltORKn45t0zDuNFO/sWRRUx4ng/j
 M+BgXjc8O86CE0Lj1FbfURieMV+Yulbt/gRC75IJ91l12SsxWJTBVLnC8 w==;
X-CSE-ConnectionGUID: VQoy5E4YRTO6pOy27r2xbg==
X-CSE-MsgGUID: nT78UEoNRV6dV6HYOi//Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4724662"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4724662"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:08:08 -0800
X-CSE-ConnectionGUID: rkfichN4QSCWHipTVDRdZQ==
X-CSE-MsgGUID: CJlFeBO2Rb+OOVWGpe791A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="14461985"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:08:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:08:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:08:05 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:08:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlzerC0Uw2GMuesQo1dOIWAx/ksFE8TA8pGI5JWqBShSIvihHbCJs3h+P9jnsjJvFSirswJ+AeSmotvVm4R+tAE6Q7gEYZFriUvheGnIjGGkAvrZ0D3rof4S31fjlOhpHtNyh34+MBDaCJJU04OjtzPH+9Kam4DQazMBsHYobnrfm/P0DhA2J3POqKuv9m/3dnHsPl20LlibcmkK6T/1FfTf92FS1pataLmNcsaixSMldn53M60pVi7y4WD9k2h9cNL29cd3kX1CXIFl8kFoeeUfj0epb2cx5z+tcTw/GukvuTcQal8IOjrFlfm1m3o1iXeayem9xuzE8HGUCW7pfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDJfURYe0f6FFeX8i5AgbO0CkqRi+UANQizkErZwbsE=;
 b=MWzQZrztX9VpgaGQ+vJWXAPX2+X4aGLAr2QsrDkhF+1VI/ShqsG9vUsAgl/PyMMK7nI4s2DietkF71HQYJ5prfEv5SHZ6LVEXduOjg9I7rnoymyneNiYW+w7vDBa+BQo015Zb8eiJ7J035KDDg6d/q006/8WlJe6EXfXK7XXR2DUQz8ZOlCR5KsHTXrxnfB8yHVujgWMHGoOyVhLlE+PyqiA4In0ZV89sqWAIKGiHiot7SUQiCZc/5OcrtxfINlwUI77iJSbL4jpPRVFZobpxXmb6TY3M2FAoH5vVEInzb4cq5s0y6SJZ7KBmC7FZxeGuHC7wAz4ZEc41R8mX7SHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 18:08:02 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 18:08:02 +0000
Date: Fri, 27 Nov 2026 13:07:59 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Tejas Upadhyay
 <tejas.upadhyay@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v5 2/2] drm/xe: Expose retired VRAM pages via drm-ras
Message-ID: <awnG_8nDRqha_b0g@intel.com>
References: <20261125190249.156217-4-rodrigo.vivi@intel.com>
 <20261125190249.156217-6-rodrigo.vivi@intel.com>
 <7800e7ac-fbba-4724-8170-a31043f9c62b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7800e7ac-fbba-4724-8170-a31043f9c62b@intel.com>
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS0PR11MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: f90664f2-94ed-4b5f-3bc5-08df4cb160b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|18002099003|22082099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: WxvipJWsgLg2WUbECMdsbCYV8nE14ZST/hr6wa4k3UXsfX5gftxOq0ApUce3tLApOPh02ND70CqKbAMAc4dj5I+uhwtr9/HcKLYHfFDP8A3mryBCuTaH/KdFUMOZVFFLZfOYncvv+U22N3PLJ3nBA1U39lOfq+/CUs+TiD+tRBl1n6EFjCO5UpFhpsY/7phpv65P73JEoeVEQSWL0G2DFqdlAhCWcKCd7hFtASF9038erY2AuPV0d95cabK2gZ2sJYAcBSPiLzrCPD740o9GimMwYCGPcxhV2XwAn09+TsxBuFLcflaGUXR64k19sKx9CvMPV1Hi5UqQqcAgLHkL9a2fTZlEhzxHkc9Pnv0fFMc8xRyK1Cv4WqMN+ex4DMqHBPI2tmnQbkql5Icm93iWA2S4+Qp2D/l/798tfg9xWedETI6Ken9M+57tXXLSGLr1CynZorD5CsTA+EnWONQXgbjX6qEEJaB2cAXGYCO7aMwTj3njKdBsBJBlHt7u9NRKkMNQk3d3s8HVMtt8TfJ4olbV2axiwxHChk6+U8/Pjvj0NeWNH3aGaQ/Gtp7CY7rEG4AWggy9SoXAK9Wp5N1o024Wdqofhw514WqIiZ63gmWaBEJmcBTz207hY5lVrrGO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BlWLy/cZlFb6IS6+qVFMn+zDwuo41TpFIffppnoWvQ1uQ7xNQQNEEsVYGaYl?=
 =?us-ascii?Q?TW/8NdiYZMaDlfwnMSNzxmz0BUorhBiWv3nkXCjMERDqEDXrdA9Eh6ZP7FUA?=
 =?us-ascii?Q?XUC1veQRTTFC7C+0lNAn16jcUCEgdg0a84xpWG9+uJFhJSE4OpgkmmFd4w1W?=
 =?us-ascii?Q?V3U/91/Q34ZCHzLCSOVn6O85OwsDEf9PllRWzVxJ/rJ4gCTuz/ochYOqLJQU?=
 =?us-ascii?Q?ycgyNeGFUn+Y/G4tR7klItRJJfG/k6/OYA/huACbbsBAInEydygTNFibO+gX?=
 =?us-ascii?Q?h2d9FmKjbydzw3++xFtt0lNbukkYcvVQNRA5LsslB20wFeJdIkJprEU0odH8?=
 =?us-ascii?Q?pzZo2hZF8UbBH/ShQvZcubjBDBMOupebIj9bCQyyFlNwPlUa3249fgF5u1TS?=
 =?us-ascii?Q?IOq669v8oR0KaROPxB5baYSHC50y8TO0cNKL4aUt+PdXyM7ps+DaDM58Hucu?=
 =?us-ascii?Q?Dg/1cmoX9x8v2TMWFkDqsQKmjS53aNQUDkTqNLFAndK2age8OWMh5hQUlEZY?=
 =?us-ascii?Q?V2yLNRaRx5flSTMdE45p3HAPm6CIFtwBe1Bzl0hKnO3TWmo6uJR339H+6uuN?=
 =?us-ascii?Q?62cEqq015EDD6e/IehqY8p+ccI4PbEvSI3YusMdNusnjWsfjlCvl6eK0+mvF?=
 =?us-ascii?Q?AFSQOKEj1YMswNWa6gc7MxlqP1X8ELhQ96Un8cDuPnL4gNAKrnSSL50D+5o1?=
 =?us-ascii?Q?xb2oXp0VnWCE4Ib7CruqcvJZENd7gqkiHHIhYHFob/r5pEBE7AKSqmiGELcY?=
 =?us-ascii?Q?GLSPgmtkw2IA9iQdMs8PRwP91cdnAGLvWHPOJuG5CeRM2PsZqyR8kLyWIs1I?=
 =?us-ascii?Q?/5LIlyZsUJli7ChztCw4HS5Wm5x3iJrl/qV3FJ0MrEdMABXe22BuweADGVCv?=
 =?us-ascii?Q?zrlTtJD8G1+TOiko+xDO+XKI/9d2XhlcFoCPPvLQv0jQrPNifH1H6LN1hgZ+?=
 =?us-ascii?Q?tPsZjvNxCaIHycx4mwCg8Boh9kYVSTx/m82kdVkBsG2a5tSFZBv17QJUrYT+?=
 =?us-ascii?Q?TUM8Eq7KO1WC3EQY6amTs06HOR9ofC+6uTA+jClXmtVaVoFzQNgsKqiZyBtl?=
 =?us-ascii?Q?/Q7jDonuOk7g58DTAKyiMW3Rh0H76NlHmM1w+Fl8ZSmlQQWiWal1YAI426wY?=
 =?us-ascii?Q?N0PWhX8bNQrmqi4a1xty4Sl1O3aVX02bLCrtdviAKuR2YRLWImPNVvE/QfEN?=
 =?us-ascii?Q?MUd3ee3PiHUaCmsaJ9dzESMusYG5qjIILCXsY8w6qXP6l6nJjaSEmot5E0tn?=
 =?us-ascii?Q?6XKyhV33VHn4iqwX+E0QtoBUwlcpT9S3IJ7g0PTOcYhRhC0A7HoIrN7sZegO?=
 =?us-ascii?Q?Efcoz1Bl8hT/8Ni1Wl/yjjVH8mV6Xelu0zyZPIPBo2r8AVoKvIS9j69LBmVC?=
 =?us-ascii?Q?kxUnXECX2u8XINtTQnW0U1CeU1l8f/lpUxlRNMlTpmO6TAn/1GM36F94nwf5?=
 =?us-ascii?Q?qvd64B8uk6WVUdthkMniWn47RcuHwRUxmB2wiiYihDzjieJbIhSuBASuWqc0?=
 =?us-ascii?Q?OF0KwdIpN8HEUDwHSFxH95VD5MAQ25igwbFBFMyXkRqV5pK1iqRnT/4NDjT5?=
 =?us-ascii?Q?4ODHLefFXYq7LlmIJ8ooMIRSA0RhCAXDglb/o0hrorHPR6eIAgkF9sy6Flcm?=
 =?us-ascii?Q?9xbBh64D7xdz7rEGmTSVb725tMsPObZtC3OPaaTgEEq1o6fKCsxA2t3yZ9v4?=
 =?us-ascii?Q?rUvghVp1IxXKH5lhJZoiEeaz/Dey6Jsn+mlMMOeE8gTrcjVmBDnrFHgl1Lo9?=
 =?us-ascii?Q?ddQp9DxP8g=3D=3D?=
X-Exchange-RoutingPolicyChecked: KfzTbt8c0M5Bp0zLK347DovrfnkiKj88OH/ptzNADvFci+5915src2mgz485Cs5/esGh9SESwwL45bw/31vj8lLkbavFZSOGp2OAhFuydJVOPfMG8alhZXiJspPOKNUeoGK3PNEzlR1OcrXDpNCsuqToZCxifRs8sl909iMz0ISV+/Z4Xb9ey8I6NQRD+0awzqtHPPuf/RuosxNt//SmnnCiJ0TN448SQMiTQBnLzlllWabtpxDfKAg1Q6SEditbBGK+80/qxrd46+fymVnBwzUd7llf5s4YsAPdLT/oKTbHIBXjRAgk7OlMGK0LRuUa/ONxkW/REHAqrCWUTPrd5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f90664f2-94ed-4b5f-3bc5-08df4cb160b0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:08:02.7251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku8o101dyao4/U1Wnl2GBN0SIOr/2Uw1FXndYdszXPlbR6l2kn0Kej27ASoIy+3RP0W8wCvaspExGzZ9zsJTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
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

On Fri, Nov 27, 2026 at 12:48:39PM +0530, Tauro, Riana wrote:
> 
> On 26-11-2026 00:32, Rodrigo Vivi wrote:
> > From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > 
> > Retired VRAM pages are only visible through the vram_bad_pages debugfs
> > file today. Register a drm-ras retired-pages node so userspace gets
> > them, and the maximum number of pages that can be retired, through a
> > stable interface.
> > 
> > The page lists are walked under the VRAM manager lock, and a generation
> > counter on each manager lets drm-ras flag dumps that raced with a page
> > being added, retired or failing its reservation.
> > 
> > v3 (Rodrigo+LLM):
> >   - Use the drm-ras retired-pages node type, which replaces the nested
> >     retired-resources layout (Jakub).
> >   - Walk the lists under mgr->lock instead of RCU, which they are not
> >     protected by, and stop reading the buddy blocks (Sashiko).
> >   - Add a generation counter for interrupted dumps.
> >   - Keep the vram_bad_pages debugfs file for now.
> >   - Remove deprecated Assisted-by tag.
> > 
> > v4 (Rodrigo+LLM):
> >   - Register the node at the end of xe_ras_init(), once the retired page
> >     lists are fetched. That point is only reached with a system
> >     controller, which replaces the XE_CRESCENTISLAND check and keeps the
> >     node off VFs (local Sashiko).
> >   - Report the list generation also when no page is left (local Sashiko).
> > 
> > Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Cc: Riana Tauro <riana.tauro@intel.com>
> > Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_drm_ras.c            | 56 +++++++++++++++++
> >   drivers/gpu/drm/xe/xe_drm_ras.h            |  1 +
> >   drivers/gpu/drm/xe/xe_ras.c                |  4 ++
> >   drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       | 72 +++++++++++++++++++++-
> >   drivers/gpu/drm/xe/xe_ttm_vram_mgr.h       |  3 +
> >   drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |  5 ++
> >   6 files changed, 140 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> > index 86c589437a9f..5382b60bb328 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> > @@ -13,6 +13,7 @@
> >   #include "xe_device_types.h"
> >   #include "xe_drm_ras.h"
> >   #include "xe_ras.h"
> > +#include "xe_ttm_vram_mgr.h"
> >   #include "xe_wedge.h"
> >   static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
> > @@ -272,6 +273,61 @@ static int register_nodes(struct xe_device *xe)
> >   	return ret;
> >   }
> > +static int query_retired_page(struct drm_ras_node *node, u64 cursor,
> > +			      struct drm_ras_retired_page *page)
> > +{
> > +	return xe_ttm_vram_get_retired_page(node->priv, cursor, page);
> > +}
> 
> This patch [PATCH v4 0/2] Protect drm_ras against unplugged or wedged device
> - Raag Jadav
> <https://lore.kernel.org/intel-xe/20261119102344.2053821-1-raag.jadav@intel.com/>adds
> protection against a dev unplug for error counter nodes due to a issue we
> saw while unbind.
> The same needs to be added here.

upcoming v6 adds the unplug protection. I left the wedged check out on
purpose: the counters skip a wedged device because they talk to the
firmware, while the retired pages are driver memory, and still
useful to read after a wedge.

> 
> > +
> > +static int query_retired_pages_info(struct drm_ras_node *node, u64 *max_pages)
> > +{
> > +	*max_pages = xe_ras_get_max_pages(node->priv);
> 
> There could be an issue with firmware reporting incorrect max pages.
> Can we return -EINVAL for max_pages if its 0.
> 
> 
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * xe_drm_ras_register_retired_pages() - Register the retired VRAM pages node
> > + * @xe: xe device instance
> > + *
> > + * Called once the retired page lists are populated.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +int xe_drm_ras_register_retired_pages(struct xe_device *xe)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> > +	struct drm_ras_node *node;
> > +	int ret;
> > +
> > +	if (!xe->info.has_drm_ras)
> > +		return 0;
> > +
> > +	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
> > +	if (!node)
> > +		return -ENOMEM;
> > +
> > +	node->device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
> > +				      pci_domain_nr(pdev->bus), pdev->bus->number,
> > +				      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> > +	if (!node->device_name)
> > +		return -ENOMEM;
> > +
> > +	node->node_name = "vram-retired-pages";
> > +	node->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
> > +	node->query_retired_page = query_retired_page;
> > +	node->query_retired_pages_info = query_retired_pages_info;
> > +	node->priv = xe;
> > +
> > +	ret = drm_ras_node_register(node);
> > +	if (ret) {
> > +		cleanup_node_param(node);
> > +		return ret;
> > +	}
> > +
> > +	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> > +}
> > +
> >   /**
> >    * xe_drm_ras_event() - Report drm-ras error event to userspace
> >    * @xe: xe device structure
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
> > index 723229b2cffb..a6fc2255986d 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras.h
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras.h
> > @@ -13,6 +13,7 @@ struct xe_device;
> >   	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
> >   int xe_drm_ras_init(struct xe_device *xe);
> > +int xe_drm_ras_register_retired_pages(struct xe_device *xe);
> >   void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value);
> >   #endif
> > diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> > index 9b04be3405ca..8e5e2df2c9f7 100644
> > --- a/drivers/gpu/drm/xe/xe_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_ras.c
> > @@ -1508,6 +1508,10 @@ int xe_ras_init(struct xe_device *xe)
> >   	get_offline_list(xe);
> >   	get_offline_queue(xe);
> > +	ret = xe_drm_ras_register_retired_pages(xe);
> > +	if (ret)
> > +		return ret;
> 
> Could we move this into xe_drm_ras_init() and add the sysctrl check there
> too? That way all the initialization stays in one init function.

The node needs the retired page lists, which are only fetched later
in xe_ras_init(), by get_offline_list() and get_offline_queue().
Registering it in xe_drm_ras_init() would expose an incomplete list
in the meantime, so I kept it right after the lists are fetched,
which is also only reached with a system controller.

> 
> We should also add a check to skip registering this node when page
> offlining is disabled.
> 
> Do we really need to fail probe if drm_ras node fails to register?
> 
> Thanks
> Riana
> 
> 
> > +
> >   	/*
> >   	 * During probe, process and log any errors detected by firmware while the driver was not
> >   	 * loaded. Critical errors such as Punit and CSC are reported through Pcode init failure,
> > diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > index 36d47de8b11b..4a7b9ea36211 100644
> > --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > @@ -10,6 +10,7 @@
> >   #include <drm/drm_managed.h>
> >   #include <drm/drm_drv.h>
> >   #include <drm/drm_buddy.h>
> > +#include <drm/drm_ras.h>
> >   #include <uapi/drm/xe_drm.h>
> >   #include <drm/ttm/ttm_placement.h>
> > @@ -240,13 +241,17 @@ static void xe_ttm_vram_retry_queued_pages(struct xe_ttm_vram_mgr *mgr)
> >   					    PAGE_SIZE, PAGE_SIZE, &pos->blocks,
> >   					    GPU_BUDDY_RANGE_ALLOCATION, NULL,
> >   					    &pos->used_visible_size)) {
> > -			pos->status = XE_PAGE_RESERVE_FAIL;
> > +			if (pos->status != XE_PAGE_RESERVE_FAIL) {
> > +				pos->status = XE_PAGE_RESERVE_FAIL;
> > +				mgr->retired_gen++;
> > +			}
> >   			continue;
> >   		}
> >   		--mgr->n_queued_pages;
> >   		list_del(&pos->queued_link);
> >   		++mgr->n_offlined_pages;
> >   		list_add(&pos->offlined_link, &mgr->offlined_pages);
> > +		mgr->retired_gen++;
> >   	}
> >   }
> > @@ -625,6 +630,68 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
> >   	return avail;
> >   }
> > +static void retired_page_update(struct drm_ras_retired_page *page, bool *found,
> > +				u64 cursor, u64 addr, enum drm_ras_retired_page_status status)
> > +{
> > +	if (addr < cursor || (*found && addr >= page->address))
> > +		return;
> > +
> > +	page->address = addr;
> > +	page->status = status;
> > +	*found = true;
> > +}
> > +
> > +/**
> > + * xe_ttm_vram_get_retired_page - Get the next retired VRAM page
> > + * @xe: xe device instance
> > + * @cursor: lowest device address to consider
> > + * @page: filled with the retired page that has the lowest address >= @cursor
> > + *
> > + * Return: 0 on success, -ENOENT if no retired page is at or above @cursor.
> > + */
> > +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
> > +				 struct drm_ras_retired_page *page)
> > +{
> > +	struct xe_ttm_vram_offline_resource *pos;
> > +	struct xe_tile *tile;
> > +	bool found = false;
> > +	u32 gen = 0;
> > +	u8 id;
> > +
> > +	for_each_tile(tile, xe, id) {
> > +		struct xe_vram_region *vr = tile->mem.vram;
> > +		struct ttm_resource_manager *man;
> > +		struct xe_ttm_vram_mgr *mgr;
> > +
> > +		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> > +		if (!man || !vr)
> > +			continue;
> > +		mgr = to_xe_ttm_vram_mgr(man);
> > +
> > +		guard(mutex)(&mgr->lock);
> > +
> > +		gen += mgr->retired_gen;
> > +
> > +		list_for_each_entry(pos, &mgr->offlined_pages, offlined_link)
> > +			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
> > +					    DRM_RAS_RETIRED_PAGE_STATUS_RETIRED);
> > +
> > +		list_for_each_entry(pos, &mgr->queued_pages, queued_link)
> > +			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
> > +					    pos->status == XE_PAGE_RESERVE_FAIL ?
> > +					    DRM_RAS_RETIRED_PAGE_STATUS_FAILED :
> > +					    DRM_RAS_RETIRED_PAGE_STATUS_PENDING);
> > +	}
> > +
> > +	page->generation = gen;
> > +	if (!found)
> > +		return -ENOENT;
> > +
> > +	page->size = PAGE_SIZE;
> > +
> > +	return 0;
> > +}
> > +
> >   static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
> >   {
> >   	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
> > @@ -825,6 +892,7 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
> >   			/* Queue free(to-be-purged) pages */
> >   			++vram_mgr->n_queued_pages;
> >   			list_add(&nentry->queued_link, &vram_mgr->queued_pages);
> > +			vram_mgr->retired_gen++;
> >   		} else {
> >   			/* Immediately offline unoccupied pages */
> >   			/* Queue free(to-be-reserved) pages */
> > @@ -839,10 +907,12 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
> >   					addr, ret);
> >   				++vram_mgr->n_queued_pages;
> >   				list_add(&nentry->queued_link, &vram_mgr->queued_pages);
> > +				vram_mgr->retired_gen++;
> >   				return 0;
> >   			}
> >   			++vram_mgr->n_offlined_pages;
> >   			list_add(&nentry->offlined_link, &vram_mgr->offlined_pages);
> > +			vram_mgr->retired_gen++;
> >   			return ret;
> >   		}
> >   	}
> > diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> > index d77f067d197b..91147385718c 100644
> > --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> > +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> > @@ -9,6 +9,7 @@
> >   #include "xe_ttm_vram_mgr_types.h"
> >   enum dma_data_direction;
> > +struct drm_ras_retired_page;
> >   struct xe_device;
> >   struct xe_tile;
> >   struct xe_vram_region;
> > @@ -33,6 +34,8 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
> >   			  u64 *used, u64 *used_visible);
> >   int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
> >   int xe_ttm_vram_inject_fault(struct xe_device *xe);
> > +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
> > +				 struct drm_ras_retired_page *page);
> >   static inline struct xe_ttm_vram_mgr_resource *
> >   to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
> > diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
> > index 4a2cd27a5b61..6a49ee8b09ef 100644
> > --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
> > +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
> > @@ -27,6 +27,11 @@ struct xe_ttm_vram_mgr {
> >   	struct list_head queued_pages;
> >   	/** @n_queued_pages: Number of queued pages */
> >   	u16 n_queued_pages;
> > +	/**
> > +	 * @retired_gen: Changed whenever @offlined_pages or @queued_pages
> > +	 * change. Protected by @lock.
> > +	 */
> > +	u32 retired_gen;
> >   	/** @visible_size: Probed size of the CPU visible portion */
> >   	u64 visible_size;
> >   	/** @visible_avail: CPU visible portion still unallocated */
