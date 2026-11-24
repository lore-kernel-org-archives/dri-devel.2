Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3E606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OfsvWrxC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kQuTeQwn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92CD10F0C2;
	Tue, 24 Nov 2026 20:46:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DD310E8C0;
 Tue, 24 Nov 2026 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795553162; x=1827089162;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=pz3l3pghbg4wtWJNMroWV3GukyCb1a7+/QnZNcO2GM4=;
 b=OfsvWrxCJZYba4U6YAJ1lpe+44vTu2/GyhQbchDozg1Dhg4PVR3B3R5u
 raYcYneTW9aaN3K61G040CtzFnitsPVUZp6VoiTBOnJmEromm6gCgPmCr
 aYSsBcfm3Jr872h3Vu2g3Wobz7V+D4GIP6uSwWYSN327qDiCn8hPvbPM0
 Ueb4irnQUN9wvuv2aQYqEzZjzpAFaXWoSVjcg/uSy/KdssxkMF91g3Gf5
 HOpu1kCQ79QOQ2s0HRraeRoqgG+ZJT71FBpINo1sR0gEmIm1fiZi95Td4
 CjlOzscKK9SekMA74XRhdywEjbuB2UCbnfb8eiPos1ibn3DWKrYGeEpTk g==;
X-CSE-ConnectionGUID: lFyavQFXTziEx1S6t7W5SA==
X-CSE-MsgGUID: NGRt7Nn6QpS6FWsYOO1dPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4313522"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4313522"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:46:01 -0800
X-CSE-ConnectionGUID: IadIGiJUQxi2aVGwqHg4UA==
X-CSE-MsgGUID: +AzzfendSkG1vvYSzNZ1Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11682570"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:46:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:46:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:46:00 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:46:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN8mgeh6et4ZwbuQrT8tfLarNH33rjIdA3zQpS68RVaGkS48RZyzXRNat+lY4osaVUE5eD4jOUQ6JCVAVLs6+8mJLarbcCN4P8o/XUUrE49sJ4MNk0VrNPAUOjt2bxHWSwOJI1tPf1wrfdfJtIfWSCf4i/yrATWbta1mjibF6ZCZAIoeObcKR/mlkJxlRN/9nMfi/mkCcFqywmlkiM9X2/imHwsi/JXhy9R14umJoKbHgrHY/9TINRv7TnSic88lRCbRl0H8cNN0QCnS/32scxrnWZ757DVOB4qDYTo5UjWYPWj0dgbRf5v5aysrqwYT+RSDXGUpAc3h52eSJy7NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxXgKoL0f6rcti18Oo6PIYty1AJ8FBf7OraJIBCxl6c=;
 b=zHEwG9Avhup7ZmCi7pCgK18culmUekwq/DrShSESyHySZobQtIVxmvaBTc9+EMPrEN7pPqthQXNk/KElxOqSA8OO1R+jeFWtaCAD/reKbrDsG1NEfs3jmv5fhwpY4jtDpqSiaJQ98OxmW+oizSp0IouEj8w6KTDl1MrlX105RhmjM3fXnPkYLOtgyNs17I0/hrGu4TRuO8y2EOsSrGsqgRijubynLHyQDN51/70GrXyRWrwaWW7fI/sgUkMHs2cZDmAM/dWO305Q2n8k9X/aAHQsV8uxfYSTG5H3pN22tNiSzN5kcdebsOxNrQyRqjwQhVCIWY6+30Q/VKs5iGvezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxXgKoL0f6rcti18Oo6PIYty1AJ8FBf7OraJIBCxl6c=;
 b=kQuTeQwn9P1lox3ghhYPS1L68r9XvLVZgiCA5DAe3Ftm2uCgGggeztJVEXkiO+fJ7nni29Go9LNiffdq9Vuxs1VeXIgXCLNUwc0jcdt67lqdfFOyj94rBFqjzrJTidFeabnpomw1nJ+Z4T1KD4LTt+99dmNiwp7Fhg0RDn1WAXo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ5PPFBBB839A03.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::84d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 20:45:49 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:45:49 +0000
Date: Tue, 24 Nov 2026 12:45:46 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 26/33] drm/xe: Add tracepoint for xe_gem_create_ioctl
Message-ID: <awX3eprbWIJop/Mm@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-27-matthew.brost@intel.com>
 <avQbUZVNm9jzIhbA@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avQbUZVNm9jzIhbA@nvishwa1-desk>
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ5PPFBBB839A03:EE_
X-MS-Office365-Filtering-Correlation-Id: 01afc78b-dc47-46a5-e02d-08df4a6bebf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|4143699003|11063799006|56012099006|261028144727099003|261009223027099003|261102123227099003|261021121427099003|10067099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: qFZ1Y1cfWuStDve7NB9sF2KmWN9jR/SIhWnNzW7+q3EWGRnpk5Q1bLPxFwOChGmZCgJ209l+PHDmsqtTeZBpuk4/K+1PaPgEYfRLCL63NDD+Lgh5KmcS1ocBVoJbR5PIhGkvkx5/LgJ00XrXP1RTPXt9YvV7Y0OBWLABKYy2je9bSq1iXga10nsvp+pUUMOBm+RK5a2xsEBn4nytHHYkaV1PW5auuqGPoASpWxU23SobJVoUmncqEhO/zivHmjIqzUiZkKQMKr/RXlPMvMbibqTGg9T5jtC4gapHOVUcKw4qLf4Jy//2g3vy7J9L65MSIZjtExS0OeZemNmhqsbVxZiUs+FQt+2C9PgGc2qHVqiUUYKU3gIhYU9OgJ80+/yVyu69UUA64m5nG51xOeBpPYK+S0iEiMM70kMIKHeq2eA1l5Rrr3IUzi8j4yjAt+cO3C51v99zNUEBZqCMnhJHcyDwqY9wl48ttbJoV9NntiwGfX2jbh6xpMguPSCPTOzSY0S5fkvcwltvAJpMfJcvob4nYtGtfAQ9w0YgmIbZfPLteDOIz+LNW7fI7qTjpL6wCf5NU9M5OtmQERE93tk8/LQrh/K53qICNs4eljEFJoRpVIWsoLs4jX06ebABO6K1/BA1vQRpJMWPgwmRtVOFrcljXvNsM19SnmgtToFSqXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QHzWoYhIDxtUeX4m96OmgpAbEf5sTkwRv0zUVabaL7zWMqo+zUhBPnggHt?=
 =?iso-8859-1?Q?Ggew60JF2FSf2o+zCG4ovlwsbhaG6mM+ZZK4dIPsbVXd1yH+Q3/7PGIN0K?=
 =?iso-8859-1?Q?iBeqC9c4E3daM9mhxpGv+Qkpl9l5yBW2+WHplkHQLEUp6IJrCtrPPLpRys?=
 =?iso-8859-1?Q?oRvtb/BaLx616aCRN/eFO7WSo2xEOHvMMzaCh5+aqQFjkA5xZsSOOITh1V?=
 =?iso-8859-1?Q?Iq3AI3hm47+NPjT14U2rZnF7UhHDdDSBB3FRv5vWon2SBh5tyLYlR5W6Fj?=
 =?iso-8859-1?Q?KUGLtZmihKCOwsD3BVLPM+2zJXXWo0Ltb8P/Xws52RYwCBzfU+D4U9Y9nN?=
 =?iso-8859-1?Q?15Zk/9Vww0pf5y1zXPYDP9uZhbdqF1+HmKgSOnUjuOh0yY2Uugmj9JB9rG?=
 =?iso-8859-1?Q?fQFjgIsOZ87lPXjVgHvNvh1mgRQ3n/FDvlv4+RMCFdk6cPNImUiE2BIs34?=
 =?iso-8859-1?Q?LvI+GpKwrKoqVcITh7NE1brqMA+Ohy5ktFheyparHRHG066vT+lr9ssxyH?=
 =?iso-8859-1?Q?sZeYhnfqMQSQTUNJbHD9edmGX7FoDuL6M1VG/tyf0xc9pbK/TS3ToKJoU7?=
 =?iso-8859-1?Q?ewj1mgJmtTixzDxKt+njBGF9S9VZQeNM2+TLN3NVd4xXEYVzpeomVNa3A8?=
 =?iso-8859-1?Q?DdvCklbTkirRwfe6Nxcq5I/LZEmW6yPNjeOGjicgchul1SUz/tuTIzjwqM?=
 =?iso-8859-1?Q?maZ/E8h9XZqO8dFSt3Dy7lYq3DhExZmm2DUWVFQsmj98pfDgFNCeAYw8oA?=
 =?iso-8859-1?Q?u/N+ylMdEU2xw14qwMQ3G5s6I69LvETIjn1hZZBGZ9glxpTd+sMDcII1Uh?=
 =?iso-8859-1?Q?sx+vZ+kMUMAWoISYFuH7GYZXJsltvBuIUaFuk03N+7/+NC2W+/wcyTOcSq?=
 =?iso-8859-1?Q?g9j4b5tt/LM5h3vgln1sUbLHZ94EspCgSKbV/Edc4Jl64CQLMuF2hZWMDL?=
 =?iso-8859-1?Q?fEbBialz/4ZjYT4/Vzoxv4qzOtrcG5TGWoiPNNJAzYNumEDx2/ZgJoNQTo?=
 =?iso-8859-1?Q?8C6t7J4EGpilf0897Ea/bmVm8kfFwiROPFotDcvEP4DqW0V8G/ySEZ7Fa2?=
 =?iso-8859-1?Q?sOt9n7Y0Hju9zYGf/AtIqT8YUu667AM7Snyp2uyOhBZ/W0U6JoVbAIMz7w?=
 =?iso-8859-1?Q?W8Yp5fi3+ortOHrilDK/oPjquj8hxsyK1jYp6SRl6VNH34jgMsSSKFqeeD?=
 =?iso-8859-1?Q?WunZyIP6PdJ0jTRBGVRYGKrMFLIf2lcoa6AvfZgURtxAp5hYGhxRf8dI/D?=
 =?iso-8859-1?Q?BO/ZP3xrk9BMqw1vPZ8/cyUX0SRt0LM9U8Eu8plDfWTpo9RZ63Wkmah60Y?=
 =?iso-8859-1?Q?VWNCHA4GheiR4QiM7DG9X82+4SBSbT+78RdpbgdgUVuPCbeQDTF19/n4qP?=
 =?iso-8859-1?Q?QuKhTaZZuNYWwI/c9uV6oLZY0cWsT7NY6uQJ5fWHSRzhGunGFVGpVC6Ukn?=
 =?iso-8859-1?Q?zUAvb+gVZ/j5SKbexnFNp6QKqr10ueZMPJcKravpXZOF30xxGGPAmGfZP2?=
 =?iso-8859-1?Q?hoRuqFH4nSMLwgAtuPVfNkS6uuMDq4aa2r8T2gtE+NzgFgv/1I73LZ/gTI?=
 =?iso-8859-1?Q?gxuqSHLyrkYFDUnYB3NLiZo/1Asbeb9Jp3j3j0GwJzN+NwT50T//aGLS8L?=
 =?iso-8859-1?Q?ZO9SE+PJ3tETMPw7mcPlmXSF2n1FAI64+RgpSVQJWh31yVlqKDePCDK/bn?=
 =?iso-8859-1?Q?gbDWjatfhHGfs/Qq7vTJaqR+ottavLe6DbB0/PyvapPFR8zdJqkr4FL0TM?=
 =?iso-8859-1?Q?QI/SoIneGsZocOSP0ZQJOyVES8J8qvmI8jkOYa2Rx6eaJU913W0ZEEbCSq?=
 =?iso-8859-1?Q?ZDaui72RenNNjsUBGmisDUIjagAjMYI=3D?=
X-Exchange-RoutingPolicyChecked: UiiA7TXN+y3b8yCrxr5fEhEirBiBvFMxu6y4e6+ThCndNZoVKON3a2VruzpomuB8RE84mPZJZZMU7YYSxVoTThZrmYFirVX0qO7RjBtervIR04RBr6rjm7kLQi9JPm0mSiGMVepwUTY8r+EXnhGudCSAL2b5NsTBXF66YGShPEZoupVe6S2lTzFjLkE4ogYneZotwXZasLG9lVrsRe2+16Vltp2A06ewqAtO5yGH3Y+ZMppeybwMatZav3kX7epuPnOaEmEBolJzpafpUEscpGvJ/OoQmgqUDpGAMLriav8ikDtbCwIeK3QRcauzYXhb99mknI1vokrO1f9r1FLj9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01afc78b-dc47-46a5-e02d-08df4a6bebf1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:45:49.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKppGwrTrmoboFPujIHorNTwwuXyPDxIqgy5n0Ad6d5H7KuOr6oRok1q6HiTYRiaOoAZdN1N/joHY+W2t150bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBBB839A03
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:37:53PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:12PM -0700, Matthew Brost wrote:
> > Add a xe_gem_create_ioctl tracepoint to help profile GEM creation, in
> > particular the cost of populating a BO while holding the dma-resv lock
> > versus the total IOCTL cost. This is useful for evaluating the
> > out-of-lock preallocation path, which aims to shrink the time spent
> > under the lock.
> > 
> > The tracepoint records the BO size, the requested placement mask, the
> > CPU caching mode, the VM asid (0 when no VM is bound), the total time
> > spent in the IOCTL, and the time spent under the dma-resv lock (the
> > xe_validation_guard region where the lock is held).
> > 
> > The asid is captured at VM lookup time rather than at trace emission,
> > since the VM reference is dropped before the tracepoint fires.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > v3:
> > - Guard lock_ns against an unset lock_start and use div_u64() in the
> >   tracepoint (Sashiko)
> > ---
> > drivers/gpu/drm/xe/xe_bo.c       | 17 +++++++++++++++++
> > drivers/gpu/drm/xe/xe_trace_bo.h | 31 +++++++++++++++++++++++++++++++
> > 2 files changed, 48 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index a646a72122d4..caf5aa0bab53 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -3953,6 +3953,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 	bool have_prealloc = false;
> > 	unsigned int bo_flags;
> > 	u32 handle;
> > +	ktime_t ioctl_start = ktime_get();
> > +	ktime_t lock_start = ktime_set(0, 0);
> > +	u64 lock_ns = 0;
> > +	u32 asid = 0;
> > 	int err;
> > 
> > 	if (XE_IOCTL_DBG(xe, args->pad[0] || args->pad[1] || args->pad[2]) ||
> > @@ -4031,6 +4035,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 		vm = xe_vm_lookup(xef, args->vm_id);
> > 		if (XE_IOCTL_DBG(xe, !vm))
> > 			return -ENOENT;
> > +		asid = vm->usm.asid;
> > 	}
> > 
> > 	/*
> > @@ -4100,6 +4105,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 			if (err)
> > 				break;
> > 		}
> > +
> > +		if (lock_start == ktime_set(0, 0))
> > +			lock_start = ktime_get();
> > +
> > 		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
> > 				       bo_flags, have_prealloc ? &prealloc : NULL,
> > 				       &exec);
> > @@ -4110,6 +4119,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 			break;
> > 		}
> > 	}
> > +	if (lock_start != ktime_set(0, 0))
> > +		lock_ns = ktime_to_ns(ktime_sub(ktime_get(), lock_start));
> > 	if (have_prealloc)
> > 		ttm_pool_prealloc_fini(&xe->ttm.pool, &prealloc);
> > 	if (err)
> > @@ -4140,6 +4151,12 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
> > 	if (vm)
> > 		xe_vm_put(vm);
> > 
> > +	trace_xe_gem_create_ioctl(xe, args->size, args->placement,
> > +				  args->cpu_caching, asid,
> > +				  div_u64(ktime_to_ns(ktime_sub(ktime_get(),
> > +							ioctl_start)), 1000),
> > +				  div_u64(lock_ns, 1000));
> > +
> 
> Will prealloc time (prealloc_us) also useful to print in the trace message?
> 

I think it roughly implied ioctl_us - lock_us == prealloc_us.

Matt

> Niranjana
> > 	return err;
> > }
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
> > index b159d37d39a1..63db37edadc2 100644
> > --- a/drivers/gpu/drm/xe/xe_trace_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
> > @@ -144,6 +144,37 @@ TRACE_EVENT(xe_bo_defrag_one,
> > 		      __entry->ret)
> > );
> > 
> > +TRACE_EVENT(xe_gem_create_ioctl,
> > +	    TP_PROTO(struct xe_device *xe, u64 size, u32 placement,
> > +		     u16 caching, u32 asid, u64 ioctl_us, u64 lock_us),
> > +	    TP_ARGS(xe, size, placement, caching, asid, ioctl_us, lock_us),
> > +
> > +	    TP_STRUCT__entry(
> > +		     __string(dev, dev_name(xe->drm.dev))
> > +		     __field(u64, size)
> > +		     __field(u32, placement)
> > +		     __field(u16, caching)
> > +		     __field(u32, asid)
> > +		     __field(u64, ioctl_us)
> > +		     __field(u64, lock_us)
> > +		     ),
> > +
> > +	    TP_fast_assign(
> > +		   __assign_str(dev);
> > +		   __entry->size = size;
> > +		   __entry->placement = placement;
> > +		   __entry->caching = caching;
> > +		   __entry->asid = asid;
> > +		   __entry->ioctl_us = ioctl_us;
> > +		   __entry->lock_us = lock_us;
> > +		   ),
> > +
> > +	    TP_printk("dev=%s, size=%llu, placement=0x%x, caching=%u, asid=%u, ioctl_us=%llu, lock_us=%llu",
> > +		      __get_str(dev), __entry->size, __entry->placement,
> > +		      __entry->caching, __entry->asid, __entry->ioctl_us,
> > +		      __entry->lock_us)
> > +);
> > +
> > DECLARE_EVENT_CLASS(xe_vma,
> > 		    TP_PROTO(struct xe_vma *vma),
> > 		    TP_ARGS(vma),
> > -- 
> > 2.34.1
> > 
