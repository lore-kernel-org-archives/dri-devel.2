Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED6606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hldUIHa4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67797112C0E;
	Fri,  6 Nov 2026 02:38:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7911128CA;
 Fri,  6 Nov 2026 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793932693; x=1825468693;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UU22P3CSQogrWjdInlkccVrYn06Uri7u9eAiPToXXkU=;
 b=hldUIHa4ZClzhniJxGBF/rxXvhBWbFXUprNTnyWqAiuCi5egKKboamgX
 +Gyfana1hws/ggtT5Hybnk8fyDocbSmN1cuOY8BytRJ25/NEWhePWMIQD
 aFYVRFeOQnV9ip436KvMP0aKJ+50JvTZO+aCmmoTqYYPUk/W8QdaVyJle
 xeptZyykEM4DqNl06vu58OL0HNGQvV4MCUDu+a9Kh/l1SKTq4Eoqqm9br
 //w/E0M6l9TS/0csz6EIYFbFAp/PYfReKchtcuXy2JgE0uAyHwGLu2lKB
 tDv3lg/i8hEl0JXpAXYpj7yVuRSVLeS9LtPNPPog9V4dqxrSOyc/+VslK A==;
X-CSE-ConnectionGUID: /jRQw8wHRIW5JqBOhkR1aQ==
X-CSE-MsgGUID: AlIXYFBoRDKOOBbkfGF0hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2841326"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2841326"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:38:12 -0800
X-CSE-ConnectionGUID: JH2U65yVR9yu/j71+RCAwg==
X-CSE-MsgGUID: pGsf0/F7To+vP7eHEPMG1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7073376"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:38:11 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:38:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:38:10 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:38:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/udOJF42ymQORTmx05sFlMhWgqyd+7XjAZCkKVEIp4eY5k3gmzscGfxdwDjKZ3O6y67J+MibM0VMrgwOh4q2zFFBds8Pl2io3/FsD9MBcuAfpmw5FcXlL6Fdb4qpOo/40BfAK5SzH1oLNVwN29hh8IdwASIkbPn/2zv1PPFajerT5yAk4JLI7nRIKCnj9azqTmCRk6xXfgayf38Qwe9/hxmelRxBdqCSC8H1wpRuoLA54eC0J+tY9iO0z8biBt2JDwNMcJg8qqzeYhrp1tXhvy7IwvGHs2zCeBI4axzr7Z0Aqsdzsfll3HfnVqmItXTy+kNwgIFicbFYOkuoeljmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmX6Nf6kzJLzPFZh7PtM28HfwpEZktGy8N8+71YDK2g=;
 b=f54RJ9ktLOQDD0cIPawOqTQMb3ZUOhE3zeNNUIHgiGnfJJvL0y2vVjVUIw4W40Bu7T/nRy5lLRp0Mpsw+xTvoLM9ScQKu6yim/u1VYuccI1GjoWSnNmVGRFleRELm6+OtX29QeqGV1kjxs2lskUuzsMyzhQ2oq2OZdzs2cA4xTHwWIg9G1dfvnX5mJh9HZ83rSIKh7wvctNC/FuNS7ju8jwYPScW9Mby8tOuCV3p664VWe2SStj+u4Nc5CRRkXY4mJjDIoVKMwKpsaAugehYhe0WlPmQFDhpr1FfG3JJqe/W0uMGJghskoYk3yTSdtRVOQwQYoJc2JCpmtFhg8K02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA3PR11MB569431.namprd11.prod.outlook.com (2603:10b6:806:53f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:38:03 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 02:38:02 +0000
Date: Thu, 5 Nov 2026 18:38:00 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <dim-tools@lists.freedesktop.org>
Subject: Re: [PULL] drm-xe-fixes
Message-ID: <au09iOI78yeru3BK@gsse-cloud1.jf.intel.com>
References: <au06WTroGBQ/Gqbt@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au06WTroGBQ/Gqbt@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0380.namprd04.prod.outlook.com
 (2603:10b6:303:81::25) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA3PR11MB569431:EE_
X-MS-Office365-Filtering-Correlation-Id: 079b985c-c09c-4c81-57a0-08df3baefaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|23010399003|376014|22082099003|18002099003|6133799003|10067099003|3023799007|56012099006|11063799006|5023799004|261026121527099003|261028144727099003|261009220027099003|261009221227099003|261009221727099003|261021121427099003|261026140227099003|261021123027099003|261102123227099003|261022075727099003|261009223327099003|261009223027099003|261022105027099003|261022115727099003|261022113327099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: rejhpK07lkX7xh+oDjoQ1Wgfs0kpbXfshXJ2v6smt8pkvvOnwfuYL2fJb8LYGBoIm8vJCxKhZ0fdYrp822s2nf4o2R1suVwXEsTApIBUhukPn4mIpGidZOMAz6SzX6PcDvILVSI0k41O9WXbQVjVsEQF+ecHTEtXwSnbgsG3bJJtMA0f+2IwW6yLKlOiud3eD4FyorPeUJVyZ2/hTAjc9Sr1REuZ/yXwGgSx5pyt6lT9nZFRzpYLKb4aY6CeqXn8V1dIjdtzRnmKmErPXb74jJkMHS0enB2QT6KXSULd1GQqVLNMtPF5MdKcG02PwrjhM7MSRPNJ82ZYpH1cKUi/eGeYoy5KglIgKCzl8ZFph77+L4hatnMF9t5+1OaxMR3aJcru49257v7UC1W7ADA4gTxhWKoLQ0rDAicoTqnZukMc0EKUGmE2pEXM7kpAT8YcNzRXqCUUuOgoA/5KrTxODaawbl6I+lNlPxbQHlQ+euK7zO25BivOxSYINRjYW1Ann4eWjKigDJB01ZupGzvjCQarnbaLxnUuOGN0trUZ1YQ0xc4NwDSu5bjE7zh+3wc5nsr6pp+BpPXZFHoFqBcqkx9dmcJh6jXytSDAy8uoXhB935185U9OOwdlBBJRkj+J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(56012099006)(11063799006)(5023799004)(261026121527099003)(261028144727099003)(261009220027099003)(261009221227099003)(261009221727099003)(261021121427099003)(261026140227099003)(261021123027099003)(261102123227099003)(261022075727099003)(261009223327099003)(261009223027099003)(261022105027099003)(261022115727099003)(261022113327099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FDCMjsBsMDOfzCNlB3crNc61T6wToyngwUAJbTBTce2nc8SxCiwOuV3a9L?=
 =?iso-8859-1?Q?DJL555E4GSIigyq2YDcOmjbPo9UzcyLfl3DU1Y3W+uObhK/yB9ZRMIpPxs?=
 =?iso-8859-1?Q?58AfwGXCoENGpQR7pzMTu9N/LN/mYm+fL0emDbyilyAHoSiebEJeMz9uu/?=
 =?iso-8859-1?Q?dPJoFcBhzgJeJpwYEToEONMsTk1x27lVdplaKDm1lMWTj5XVzx2yttD0DL?=
 =?iso-8859-1?Q?tYPYZ9c3OPpgBRrsr4zLCEgryYsITrJXAcDjvPGqdhZ2bi10sqgRNDwkiL?=
 =?iso-8859-1?Q?Aj5VRe20/xN/ut5rdqZpQ/+8wP+cfjvaxZVXv1OrzFUZ73mXxqoxIqRurt?=
 =?iso-8859-1?Q?8tSO76fj8SyUfhzI9sJlK4o+xpEGcded9sH/PmrvD+X0S14rGOTF6r62pn?=
 =?iso-8859-1?Q?Rf9wJcqBE8mXACt6XpdzB5Pn2cQZpyAuC3buPVkjjcFc90f821i0mlU/Fp?=
 =?iso-8859-1?Q?g6nC+kdBnNkwE7jGXY/+qr8OSlMktCNiacOcXuEd7heBuOpOWPXttPuSOI?=
 =?iso-8859-1?Q?wplUSNq2kFqF9bHYP4Y+SmvQ3BqMjKFeMHGeecFo9FE/KT7E/mgn1DMosB?=
 =?iso-8859-1?Q?vGAccB5S3hqUeyrLhiQYTH79LgVINGvHxrzcOszve/I+/AttWgETIyXt7L?=
 =?iso-8859-1?Q?R8qIjcb1Q5GZHjh2h4ulrXdeHD4tx6S5/ZfmqmB2hhV7Fm/uhBWDofz0Wf?=
 =?iso-8859-1?Q?0JtaCdHaOCRRYpqZ00EbVRmrGlil8u7+f88oaiO1ay2FI+KcHALEH/tTYF?=
 =?iso-8859-1?Q?nSLbDPJmGwKmfYUR36fQkzja+JBaFeqv8UefClVTevHDGS2qsROpa3jdec?=
 =?iso-8859-1?Q?ZDjMnL4SpBvx5ZPmzvdjv3z3ascLMhdCzEUTr4/TwBdKygBe4CBnp7ILf0?=
 =?iso-8859-1?Q?drf+3gRmBSeswvb2CPHw3ScwS1aIqhlQ//PXgJ4LjbdSnvZC0Cuim85s/e?=
 =?iso-8859-1?Q?YgZyoifMhdu3eGl9ZjbQ3zjCB+7Zb/Mt2in5RP76hGE8/W+PLo4vItEWY7?=
 =?iso-8859-1?Q?yzI0txRc5Cz5ldkj5MaKTynysKfw7UExNcOxHRXuaDYfC0U4qnZkb0ynTI?=
 =?iso-8859-1?Q?nowzSjHFGjjRbB8N0w/asU6xo7WexL9QsjOJrA+zOIuFUKH5mPUdi1dESc?=
 =?iso-8859-1?Q?UkcnZZ3acHnWWhfOROPNvrBqVdgx92bs5ptLDtC5sz/I08Ll4EVnE/spjk?=
 =?iso-8859-1?Q?QHEiAfMjbTz4zVriShLj410t/e6Q4VbA5E7dVlwxa59eQzPchkY/03EU7U?=
 =?iso-8859-1?Q?0Rkiugco624AI2LAScGfOD6QxGzA0zLwjfefQsv6sbx0bXMorL1ld9fXln?=
 =?iso-8859-1?Q?4XGI/JUdN/LKSFpK1PLB4GRJH7+jOYGTH7rvgHi84tzrkTdoYMOX+gohT1?=
 =?iso-8859-1?Q?m6pmcsIdWA3J1BgaGas3u1QrBR/EXN2qrpEypvmII0IElrJi2zi2fR78tP?=
 =?iso-8859-1?Q?aSkidqSi59gpIyxwFYEzAmRpMufRCxWMmAEEF1PVUTbIA5YlEtbn5BgEEd?=
 =?iso-8859-1?Q?5Bp1RUF2lWZhPRt7CLyh3uOQsumiNGlDxA+rAD9PeojPL34Ag6Qzc8yE2z?=
 =?iso-8859-1?Q?Mmp/Ma/DxcUI6sBGw3Gt5XXsvkta4ZluSxUBAiRb+kBS/xj51OlXrnVRfO?=
 =?iso-8859-1?Q?5rmwcj7Q2x+2JZkGKhDaJ281tLbzlWiKC8JjlH2UR/gWLojvfZrNaykmzN?=
 =?iso-8859-1?Q?v/YK+NwTurAxrk/h2s9OGhcdLBYoxaUbQSsNpS0ys0yeXdAIqPGGQN3Rzt?=
 =?iso-8859-1?Q?jCIHeNDBuBCmA9ClYZEtih0vEOGPrQkFe4Cz8Q9D4OWOLVpOFdjaHOE8zJ?=
 =?iso-8859-1?Q?62N+64GyaQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: TN6sfqnQAeUIygSF8/GCif59wsQU0SLJnkgxKtDI9CVV8YICXmXOI3Nn8H2xgz3CtSb5/eApkirie2z9KdDJtn1ZW9J8CLPs4guwp0XwO4K0dEd5S0Pjn1J6AhU/lSLofF9iUG07A1EkCg7IznFchBa7s6InpbmVEV0onUII+OS4x3vzL5hA1MW/DXaPejw4RV5mt66e4ukSS2CSi+pjg+91LpJ+Ymx1x1x8hY5pt7GYdeswzh8o4ntdS7xwqAm0cKniLN4d/pxEjPR8OyAfV9Z2Y9XU8KuVmuMVSM5G1qNA5NvA2abZxSBt8WlnxgPdSoc203lNch7ZNxXQeeI+Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 079b985c-c09c-4c81-57a0-08df3baefaa2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:38:02.6629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pkIOhyRMU7nqZ/nOJn1ddJ4szI4LwIaqNIGC//S3/xU4usoAVNhrqTFSsNqd4lddt1fdbqMPPhzZqUceoWdYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB569431
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 06:24:25PM -0800, Matthew Brost wrote:
> Dave, Sima,
> 

Something isn't right here... See below.

> Here is this week's PR for drm-xe-fixes. Apologies for the sheer number
> of patches. I got caught up in various internal fires before rc1 was
> released and dropped the ball on getting out interim fixes PRs.
> 
> Honestly, there's nothing particularly interesting here: some hwmon
> work, a bit of GuC submission backend rework, VRAM offline fixes, and a
> bunch of other small fixes.
> 
> I hope everything after this PR settles down in the cycle.
> 
> Matt 
> 
> drm-xe-fixes-2026-11-05:
> Driver Changes:
> - VRAM offlining fixes (Tejas)
> - ras: Fix sysctrl and drm-ras discrepancy (Roper)
> - pat: Return error from xe_pat_init_early() on unknown (Roper)
> - Prevent VF memory IRQ from accessing a torn-down engine (Piotr)
> - guc: Protect timeout handling from device unplug (Satya)
> - gt: Disable GT reset worker before engine teardown (Satya)
> - Various hwmon fixes (Karthik)
> - tuning: Restrict Anyhit NULL-query tuning to render engines (Nitin)
> - gsc: Fix NVL-S GSC compatibility number (Daniele)
> - Don't abort the shrinker walk on -EBUSY (Thomas)
> - Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng)
> - lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen)
> - Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo)
> - madvise: use already clamped pat_index (Auld)
> - Various wedging fixes (Raag)
> - Rebind BOs evicted before the first LR queue (Arvind)
> - Toggle the D3Cold enable flag at runtime resume (Vinay)
> - Access GT MMIO after pcode init (Vinay)
> - xe_late_bind_fw: Fix firmware leak on missing manifest entry (Badal)
> - svm: Preserve default PAT index when resetting VMA attributes (Arvind)
> - Unwrap sync fences before adding them as job dependencies (Junjia)
> - Schedule disable G2H fixes (Jagmeet)
> The following changes since commit 9b6f2eabc8371dea951c244f4aa9e013f36de9f8:
> 
>   Merge tag 'rtc-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux (2026-11-01 08:41:03 -0800)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-11-05
> 
> for you to fetch changes up to 28f45837549a0558c5dbe19a78c0717fc7d774ee:
> 
>   drm/xe/guc: Do not attribute a TDR disable to a pending suspend (2026-11-05 10:59:35 -0800)
> 
> ----------------------------------------------------------------
> Driver Changes:
> - VRAM offlining fixes (Tejas)
> - ras: Fix sysctrl and drm-ras discrepancy (Roper)
> - pat: Return error from xe_pat_init_early() on unknown (Roper)
> - Prevent VF memory IRQ from accessing a torn-down engine (Piotr)
> - guc: Protect timeout handling from device unplug (Satya)
> - gt: Disable GT reset worker before engine teardown (Satya)
> - Various hwmon fixes (Karthik)
> - tuning: Restrict Anyhit NULL-query tuning to render engines (Nitin)
> - gsc: Fix NVL-S GSC compatibility number (Daniele)
> - Don't abort the shrinker walk on -EBUSY (Thomas)
> - Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng)
> - lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen)
> - Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo)
> - madvise: use already clamped pat_index (Auld)
> - Various wedging fixes (Raag)
> - Rebind BOs evicted before the first LR queue (Arvind)
> - Toggle the D3Cold enable flag at runtime resume (Vinay)
> - Access GT MMIO after pcode init (Vinay)
> - xe_late_bind_fw: Fix firmware leak on missing manifest entry (Badal)
> - svm: Preserve default PAT index when resetting VMA attributes (Arvind)
> - Unwrap sync fences before adding them as job dependencies (Junjia)
> - Schedule disable G2H fixes (Jagmeet)
> 
> ----------------------------------------------------------------
> Arvind Yadav (2):
>       drm/xe: Rebind BOs evicted before the first LR queue
>       drm/xe/svm: Preserve default PAT index when resetting VMA attributes
> 
> Avi Weiss (3):
>       init/bootconfig: pass init arguments in documented order
>       irqchip/riscv-imsic: Report successful hardware retrigger
>       irqchip/irq-msi-lib: Free wired MSI descriptors

^^^ These shouldn't be in here.

> 
> Badal Nilawar (1):
>       drm/xe/xe_late_bind_fw: Fix firmware leak on missing manifest entry
> 
> Chen, Junjia (1):
>       drm/xe: Unwrap sync fences before adding them as job dependencies
> 
> Daniele Ceraolo Spurio (1):
>       drm/xe/gsc: Fix NVL-S GSC compatibility number
> 
> Dnyaneshwar Bhadane (1):
>       drm/xe/pat: Return error from xe_pat_init_early() on unknown platform
> 
> Helen Koike (1):
>       drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2
> 
> Hui Su (2):
>       hrtimer: Add cleanup class for on-stack timers
>       sched/idle: Use hrtimer cleanup class in play_idle_precise()
> 
> Hung-Jui Lin (2):
>       posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers
>       selftests: timers: Add a test for disarmed SIGEV_NONE timers
> 
> Hungyu Lin (3):
>       posix-timers: Accept NULL clock_getres() output in stubs
>       timers/itimer: Keep a nonzero value at CPU timer expiry
>       time/namespace: Fix overflow when converting absolute deadlines
>

^^^ Nor these.
 
> Jagmeet Randhawa (2):
>       drm/xe/guc: Fix race around q->guc->suspend_pending access
>       drm/xe/guc: Do not attribute a TDR disable to a pending suspend
> 
> Karl Mehltretter (1):
>       clocksource: Prevent immediate watchdog rerun after a delay
> 
> Karthik Poosa (5):
>       drm/xe/hwmon: Fix pcode power limit handling
>       drm/xe/hwmon: Decode mailbox temperature as sign-magnitude
>       drm/xe/hwmon: Fix thermal sensor data handling
>       drm/xe/hwmon: Add helpers to validate thermal sensor readings
>       drm/xe/hwmon: Handle unavailable memory controller sensors
> 
> Linus Torvalds (1):
>       Linux 7.4-rc1
> 
> Matthew Auld (1):
>       drm/xe/madvise: use already clamped pat_index
> 
> Nitin Gote (1):
>       drm/xe/tuning: Restrict Anyhit NULL-query tuning to render engines
> 
> Peng Wang (1):
>       tick/nohz: Reevaluate the tick for kicks flushed outside hardirq
> 
> Raag Jadav (8):
>       drm/xe/ras: Fix sysctrl and drm-ras discrepancy
>       drm/xe/gt: Use GT ordered workqueue for wedging
>       drm/xe: Drop xe_device_set_wedged_method()
>       drm/xe/hw_error: Guard csc_hw_error_work() with runtime PM
>       drm/xe: Move xe_device_wedged_fini() registration to xe_device_probe_early()
>       drm/xe: Make xe_device_declare_wedged() IRQ safe
>       drm/xe/pci_error: Flush GT wedge worker before bus reset
>       drm/xe/amc: Guard xe_amc_work() with runtime PM
> 
> Rodrigo Vivi (1):
>       drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m
> 
> Satyanarayana K V P (3):
>       drm/xe: Prevent VF memory IRQ from accessing a torn-down engine
>       drm/xe/guc: Protect timeout handling from device unplug
>       drm/xe/gt: Disable GT reset worker before engine teardown
> 
> Shuicheng Lin (1):
>       drm/xe: Mark xe_vma_ops_alloc() noinline for error injection
> 
> Stian Halseth (1):
>       sched/cputime: Don't warn when the tick period starts after idle exit
> 
> Tejas Upadhyay (3):
>       drm/xe: Re-validate external pin under resv lock before VRAM purge
>       drm/xe: Drop RCU list handling for VRAM bad-page tracking, use mgr->lock
>       drm/xe: Keep VRAM fault injection within the usable range
> 
> Thomas Hellström (1):
>       drm/xe: Don't abort the shrinker walk on -EBUSY
> 
> Thomas Weißschuh (1):
>       vdso/gettimeofday: Correct the read of tz_minuteswest and tz_dsttime
> 
> Vinay Belgaumkar (2):
>       drm/xe: Toggle the D3Cold enable flag at runtime resume
>       drm/xe: Access GT MMIO after pcode init
> 
>  Makefile                                      |   4 +-
>  drivers/gpu/drm/xe/regs/xe_lrc_layout.h       |   3 +
>  drivers/gpu/drm/xe/xe_amc.c                   |  10 +-
>  drivers/gpu/drm/xe/xe_configfs.h              |   2 +-
>  drivers/gpu/drm/xe/xe_device.c                |  60 ++++-----
>  drivers/gpu/drm/xe/xe_device.h                |   7 +-
>  drivers/gpu/drm/xe/xe_device_types.h          |   4 +
>  drivers/gpu/drm/xe/xe_drm_ras.c               |  17 ++-
>  drivers/gpu/drm/xe/xe_gpu_scheduler_types.h   |   5 +-
>  drivers/gpu/drm/xe/xe_gsc.c                   |   3 +-
>  drivers/gpu/drm/xe/xe_gt.c                    |  63 +++++++--
>  drivers/gpu/drm/xe/xe_gt_sriov_vf.c           |   2 +-
>  drivers/gpu/drm/xe/xe_gt_types.h              |   9 ++
>  drivers/gpu/drm/xe/xe_guc.c                   |   1 -
>  drivers/gpu/drm/xe/xe_guc_exec_queue_types.h  |   5 +-
>  drivers/gpu/drm/xe/xe_guc_submit.c            | 119 +++++++++++------
>  drivers/gpu/drm/xe/xe_hw_engine.c             |  17 ++-
>  drivers/gpu/drm/xe/xe_hw_error.c              |   2 +
>  drivers/gpu/drm/xe/xe_hwmon.c                 | 180 +++++++++++++++++++-------
>  drivers/gpu/drm/xe/xe_irq.c                   |   3 +
>  drivers/gpu/drm/xe/xe_late_bind_fw.c          |  15 ++-
>  drivers/gpu/drm/xe/xe_lrc.c                   |   8 +-
>  drivers/gpu/drm/xe/xe_memirq.c                |   3 +
>  drivers/gpu/drm/xe/xe_mert.c                  |   6 +-
>  drivers/gpu/drm/xe/xe_pat.c                   |  11 +-
>  drivers/gpu/drm/xe/xe_pat.h                   |   4 +-
>  drivers/gpu/drm/xe/xe_pci.c                   |   5 +
>  drivers/gpu/drm/xe/xe_pci_error.c             |   6 +-
>  drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
>  drivers/gpu/drm/xe/xe_pm.c                    |  12 +-
>  drivers/gpu/drm/xe/xe_ras.c                   |   3 +-
>  drivers/gpu/drm/xe/xe_shrinker.c              |   3 +
>  drivers/gpu/drm/xe/xe_survivability_mode.c    |   3 +-
>  drivers/gpu/drm/xe/xe_svm.c                   |   1 +
>  drivers/gpu/drm/xe/xe_sync.c                  |  33 ++++-
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c          |  53 +++++---
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h    |   2 -
>  drivers/gpu/drm/xe/xe_tuning.c                |   2 +-
>  drivers/gpu/drm/xe/xe_uc_fw.c                 |   2 +-
>  drivers/gpu/drm/xe/xe_vm.c                    |  11 +-
>  drivers/gpu/drm/xe/xe_vm_madvise.c            |   5 +-

From here.

>  drivers/irqchip/irq-msi-lib.c                 |   1 +
>  drivers/irqchip/irq-riscv-imsic-platform.c    |   2 +-
>  include/linux/hrtimer.h                       |  24 ++++
>  init/main.c                                   |   6 +-
>  kernel/sched/cputime.c                        |   7 +-
>  kernel/sched/idle.c                           |  16 ++-
>  kernel/time/clocksource.c                     |   2 +-
>  kernel/time/hrtimer.c                         |   8 +-
>  kernel/time/itimer.c                          |   2 +-
>  kernel/time/namespace.c                       |   2 +-
>  kernel/time/posix-stubs.c                     |   4 +-
>  kernel/time/posix-timers.c                    |  25 ++--
>  kernel/time/tick-sched.c                      |  14 +-
>  lib/vdso/gettimeofday.c                       |   4 +-
>  tools/testing/selftests/timers/posix_timers.c |  43 +++++-

To here, none of these changes should be in the PR.

Likewise any patches outside of the Xe.

git log --oneline

28f45837549a (HEAD -> drm-xe-fixes, tag: drm-xe-fixes-2026-11-05, drm-xe/drm-xe-fixes) drm/xe/guc: Do not attribute a TDR disable to a pending suspend
e7c8b62109c7 drm/xe/guc: Fix race around q->guc->suspend_pending access
939d920f9c70 drm/xe: Unwrap sync fences before adding them as job dependencies
a24487839cc3 drm/xe/svm: Preserve default PAT index when resetting VMA attributes
312fee63c57f drm/xe/xe_late_bind_fw: Fix firmware leak on missing manifest entry
d47fcff6c767 drm/xe: Access GT MMIO after pcode init
1c99caf885f7 drm/xe: Toggle the D3Cold enable flag at runtime resume
21470ecd0a19 drm/xe: Rebind BOs evicted before the first LR queue
0fdcd13699a9 drm/xe/amc: Guard xe_amc_work() with runtime PM
a301eb5b7b63 drm/xe/pci_error: Flush GT wedge worker before bus reset
ad72ddb3f15b drm/xe: Make xe_device_declare_wedged() IRQ safe
639da0b801b0 drm/xe: Move xe_device_wedged_fini() registration to xe_device_probe_early()
9c3afa74fa0d drm/xe/hw_error: Guard csc_hw_error_work() with runtime PM
b3b0ad6a2553 drm/xe: Drop xe_device_set_wedged_method()
750fb10debac drm/xe/gt: Use GT ordered workqueue for wedging
b10bcae5403e drm/xe/madvise: use already clamped pat_index
c90f458b52a8 drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m
e1a79c4aaf1d drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2
8b7a23117e76 drm/xe: Mark xe_vma_ops_alloc() noinline for error injection
e559f21cfca8 drm/xe: Don't abort the shrinker walk on -EBUSY
26af34880599 drm/xe/gsc: Fix NVL-S GSC compatibility number
92826c371eec drm/xe/tuning: Restrict Anyhit NULL-query tuning to render engines
eff932fb8eab drm/xe/hwmon: Handle unavailable memory controller sensors
ee7d4140ec97 drm/xe/hwmon: Add helpers to validate thermal sensor readings
1419f5de86df drm/xe/hwmon: Fix thermal sensor data handling
aaa2fd00fa34 drm/xe/hwmon: Decode mailbox temperature as sign-magnitude
4a7a7ff7658b drm/xe/hwmon: Fix pcode power limit handling
cfbd691b5b86 drm/xe/gt: Disable GT reset worker before engine teardown
aa051ca944bc drm/xe/guc: Protect timeout handling from device unplug
fca111d764e7 drm/xe: Prevent VF memory IRQ from accessing a torn-down engine
18c95d9f0ab5 drm/xe/pat: Return error from xe_pat_init_early() on unknown platform
6b1f342801f2 drm/xe/ras: Fix sysctrl and drm-ras discrepancy
25c0b35c9328 drm/xe: Keep VRAM fault injection within the usable range
2d8322088050 drm/xe: Drop RCU list handling for VRAM bad-page tracking, use mgr->lock
bac6deafcd2b drm/xe: Re-validate external pin under resv lock before VRAM purge
8f26dd9c8361 Linux 7.4-rc1
d746ff288e9c sched/cputime: Don't warn when the tick period starts after idle exit
cf8dc3b3ec11 clocksource: Prevent immediate watchdog rerun after a delay
...

I'm not sure why patches below bac6deafcd2b are in this PR?

I did have to force-push drm-xe-fixes today, likewise had to force the
PR generation as patches which were not Xe's complained about a missing
SoB.

Not sure what is going here. If you need to drop this PR, I can sync
with my fellow Intel maintainers and try again after rc2. Again apologie.

Matt

>  56 files changed, 631 insertions(+), 234 deletions(-)
