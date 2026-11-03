Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2306606A33B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y9Jvji3M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F93310F609;
	Tue,  3 Nov 2026 14:33:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAE210F608;
 Tue,  3 Nov 2026 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716425; x=1825252425;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=etVsFrKVeSBKiluvEvFBRLaXSZ5u8hOc2G/VJfI6LEg=;
 b=Y9Jvji3Mkud4XYo6vyKx3anZAeDLS8b4P6qhMWks9O4i3u7FD0oJsmrH
 Eo8RRs0TRSeoRYaRWnpkU6GwNyJ2SexQRq4fSRXzqDdQMQ8von8igVuLi
 4lbp4O36Z4xjJQor35Tmq976ZTQjlo0kgBuq8egukRpdbWU07kHYOXyuy
 0pgz+WyU+Ld0ySAE3qWRUmVXUsFWUafkIgVr//Lggfwc2HKogj00rZPXk
 eoIrhVNHa4v9GLlTVIhRoNg2RrQwe/8qTUZl6QLIW6fZZq+ifP3Aqtkws
 iV/lfKmj9bo60nmph2MDGtDem6BBXOyCzGrUyrZnFM1G7Aotsskh+In0m Q==;
X-CSE-ConnectionGUID: XYYUiVTaSI+w4WfwXb3GgA==
X-CSE-MsgGUID: VD0QbiYWTTqjd/X9I/P87w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2470255"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2470255"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:33:45 -0800
X-CSE-ConnectionGUID: mhbIDJZsQcmprBj0pUanFQ==
X-CSE-MsgGUID: dUhVg5eoTQeLPG384Z/ZaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6802605"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:33:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 06:33:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 06:33:44 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.36)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 06:33:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JglB9/2YRgJLxu3mtImUpMuthjKbnLcxu0LPSi+iSkVwM3jfN15nYwLMk2wGFoOgMEx5441vPs5+b9+LPxhxrBfpGvXJ/9WqucNvsAU9ptvzNgZrMNhGiT17PxnG1toxzIMhc+dOQUcIIxN09Uq5TEttaC8faGvAum50iTUWqc6OVLqiHdLhWAZ+h19BceP3Dv6LV+6qMqVffq3ThgY7E98fYuewQjQwRXBxmawYT+8njWubv8Z6ZKErsozHvKpLSWg5sCBeYbogz0hY4Os8UQdmBPPlI0xAltdcy9tU2NQZapf6NLBXr69arSpcmtDrLkQ+CIR/ObY4eNmItvx0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiKXsDQ04eBZQ0POLyVejSJUeQ9Xz0PWe0GOMYdTq7c=;
 b=DW5Vq0+H+zKB3uA5qHpw9zIFDSFfbhycuO385itE6SUWvQZ5IK51/U2Fv4irXQJbY2hL9sNzatPqNBjJZ69HRiBmCafh29L0fWaSlV2pzszODlcedXRm+c3g42NXp4X3uFSRgCiL7XqcI0p5EdmPISUPRl78MgPsilpHgXGCUwuK0gBCAI99sfVfbLarz0L4XBThS+OJPQUNdCkMiIQH2gdakSwm9bCy3fcmlpSTwZDlTEk22U7vJ+Y66pENus2k1ejm5K8GMJexoLzYzR8fNcUOh3D+dly5/A5hXsjYTmKVO2PycYz0ccwm4VdFs63/h+yDKITZOX8YD2AhR01kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:33:41 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 14:33:40 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH 1/1] drm/xe: Add support for WA 14028250015
In-Reply-To: <10a999d06de867a938a67fbc345e4acda9ddafff.camel@intel.com>
References: <20261029181039.598756-2-alan.previn.teres.alexis@intel.com>
 <874ie2u6jc.fsf@intel.com>
 <10a999d06de867a938a67fbc345e4acda9ddafff.camel@intel.com>
Date: Tue, 3 Nov 2026 11:33:36 -0300
Message-ID: <87zevqougv.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b115af1-fe75-45ce-001d-08df39b7747d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006|261028144727099003|4143699003|11063799006|261026140227099003|261022105027099003|261009223027099003|261026121527099003|261022113327099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: QcHdoB0eKCKpGT/IVhr6iKQPho8ybt5/z96gMSVtng8mj51+LmDXZbEJaFd4nb85p6sdxiNE9JiqKUSVcYCFYq5XpSKIjSJ9tN/FdpmoYMk6DvLZRKkD8qLjcxYfC8a3AoPlE/izFtUOfmBekInQ2R82+3WQIg3uMJVV0u5kXGButEhGvKpwadE9ntKVwz8kgO0W+XBL3zmmCoZ1cNmtq1U2rTI7bhSaQb55GdvUbxml3vKyfy+fYdwoCpa+I6rx1+Zqz892GkE2Q8iVvewCRx0CusE3dVZMV0mFyepzwuUeyh5KwZx6kQ9EdjNeTSOtI+Lmc8Sw28Iw8Wbw689AyUbZ/X4xvZpbYpF020pfTd7fYvys9vR8eoJdvphnzg5TLinRZA30hH66LqkyRfCHGRiwxZubO0a8jKJVq5wp21qe/8Sqe3HsUBxGD+PKvvSmXDBKNoSI5b4n2eeQntkpo4T7ghcHUAM/FgS9pFz0SdQaLJ8vv/u7EFvf3m2qdrbXWAXRH/5T74oRVLVqocaHwF9vIXcFKWYmK/bQpoNAW0lptL+RJxJcc/IUBjKSSY6BekoqydEwktHX8/I66fPcI5BXQ15W+K5XMnXTgwvARH+mxAXFJlb3m1ouSciDm/RfqJoC8vgbEBIF9we0tfAGq5of8zDPQk08LZkYolx5ChA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5095.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(261028144727099003)(4143699003)(11063799006)(261026140227099003)(261022105027099003)(261009223027099003)(261026121527099003)(261022113327099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5RCvrcjPGMAaJLLN3xQBc2yrNNgOTkNkDDMFwQHO1T4Sijk4QwRbeeJlqnyJ?=
 =?us-ascii?Q?pI6wlsT3e/jN6gf0BvVeL5qBL4hnqgPJj+fp/jgAdCfMpTKk2DJDQYSPRqtK?=
 =?us-ascii?Q?P5ZGSsJS9BVB7L35f4CQOe+xN1uuTuM2z8Uxqm5KaJKO/P9HhanmQVWEdsbC?=
 =?us-ascii?Q?s7e6elUi5ZwTVu9FBRltPiYELhadkckgO8v2HMqxgG5ijp5Tx41SyOinmnXH?=
 =?us-ascii?Q?mrdIVEN7c2FmM8EOmNn0D+f0k/L4FDoAIFj7vm3/ulwgKIgFzmf18Tt/7OcK?=
 =?us-ascii?Q?F7iGsYe5xGQPXm0In/4f/QCRKnG6W/r7aZg/+OGUZZMx1+NNg+C7MZlJeFSb?=
 =?us-ascii?Q?InDDU5lheTN3KItVtV/QIzPYGOV0LmxhfoIVsMN1m9k1eHGk6i/nNNak/SNN?=
 =?us-ascii?Q?beAS1yJtcBNPdUWQRl/YpII8y2T2MMCv0AiXNfwkU9hWavW2sRC0H/YF72WF?=
 =?us-ascii?Q?q26xxgn4mFvln+8a8fYbXYY7ZXJN/W0NDHnaGVAqC9ur1gxL8SyQ85l8H7ID?=
 =?us-ascii?Q?QYKOdlvNo3lVtCrvxm+mAql5RK82pf2y9csiJkDVe/QhWS5OD/eQKksYiifG?=
 =?us-ascii?Q?3A72xwPUiR9NkuYNL3WC0R7FXhafMGudypRGmLXE1DRGGGWu1qSZDUJ3M6oT?=
 =?us-ascii?Q?/IAo7HlluLJ5XIEh0t/YRp812enQx2K/UUw9Ux75dtSNOu8f3yhtkX6rIm/g?=
 =?us-ascii?Q?QyDtiBNs46OzXWeUBL09H2BORcIaO4VN1p73H0KXe/udoOAnNq9zsz1wcVcJ?=
 =?us-ascii?Q?q495uecNrTH2kKviibeR/DKG/M+8mZ6FYQaHgbcbAKS8Bg4qusRwaAhLfS8h?=
 =?us-ascii?Q?3ObcykPgG4xynxy+r+5DG3SX1Lrv5P6+tP6K4ocELwLc/LVqCsUEF9TMRKBN?=
 =?us-ascii?Q?m7N3JTmGG5i56K2i/3MYzivI+GxD+6qzA06EE2mFBN8yWuslXMoqWyQ/RTFU?=
 =?us-ascii?Q?OZfKdl5w3pyupOU8Zm5j+IHAMAoZuwLz4lf2exy+Rp90H/E24R5INqahMuf3?=
 =?us-ascii?Q?/5VKa98xyC/1G363cnn5cl0bLBGqQa8TpUv6rx5ynI2Nnf/IaxEzPIYIO4ey?=
 =?us-ascii?Q?FMwaDqciEmoIKgOOIchY1fkGxwLrszWJy8Zbbwozc2rY754VGrWrhH6GiykJ?=
 =?us-ascii?Q?wHJeolxUB/frwZOGG/bR3H5HyBRFoj/+hAecxfkpMCKycIZ3tbUHifct4KK8?=
 =?us-ascii?Q?EnNY7skps5ep6kiaBKb5he5BTM0mHponS80CREWyUKfXm210NT1v1Ee7fESJ?=
 =?us-ascii?Q?D2o90h/ASinUHw25B1Z8fUd3K069bW8KcsvM2Y1b6TcmCn8B6OnG5S4W7RjR?=
 =?us-ascii?Q?B838kRuJfgZEadb2JYpRakFrQbU3+MNpIYbylKUKVDJYlzSFcEroT29ikcNB?=
 =?us-ascii?Q?OalkW6OOs9YtuQndIF2A/2t61H2ELJU+YLkDzmDvtfyHz3dLXu2qvNBg3Nsp?=
 =?us-ascii?Q?6Gy0z1Ub2zf0fGUaqXZiJeyRCA2SsPlv8DuX+MhCmvamS2hQlkp+aEphWnfJ?=
 =?us-ascii?Q?mkIGTGp6RRRqWmrT+xKySIy8e7FGOT/h9TanWD1GWsPdVYjPZBcJ7Tz0L7rT?=
 =?us-ascii?Q?s9dUk1aawwkDcrXAMPEYSfi2wEZJmO5UVqusVrNqtdF4aBdHYgAsUeJ6NV9p?=
 =?us-ascii?Q?P/tbWcKm3vU2ToHh1pbxsbPCtO3o6zNAkuAJRnNCZ/Oh7iVc/dQ050JV9z+/?=
 =?us-ascii?Q?FkLq9TPJ9XQTjJblNV1xMyUzMyafKrKnY6wcqIZsCVEFITxerj6zU2md2tJy?=
 =?us-ascii?Q?7HehJbdM+A=3D=3D?=
X-Exchange-RoutingPolicyChecked: gKMefZDTEbnkg05rOEMFzGGBCmzylFiivyU0vo8B+4eTrm1Md/olko1F4SV4VuFGPBlPWqtqiRBuy3+EoriBPaEj3MJPAD+BIBK+kFhjdkQwH3PBGjtHf5+cHwlpCdHej3LFVAXZ83cdMWjUfJ+NQD5WiiwRpo3MzSbY1NEPSlWl1sQFsZom22ZorD087sNuwb0eAn/krrdNFDhpt3gPsdJkqAmQchRkzDeuc7S9f1BvxdMVx7o68nk0Hq1C+P5q7dOoTDPTPVvOHOKeqBDzK3Av3srUTQHdS8exRaJbxtET62oAM40ZQFu0d7OIoOZe4jnMFPfxI/Ca/1Sw24Pgkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b115af1-fe75-45ce-001d-08df39b7747d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:33:40.7118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7rpMzqv0783yvhGo341zgii+/227JJGrnegUWNFOBj3docYkgOrxyYpYsftsy+8hpv5kVuAh8N5mdxQfdNpGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com> writes:

> [snip]
>
>> Also, on the subject, I would prefer that we stick to the notation
>> Wa_14028250015.
> will fix
> [snip]
>
>> 
>> >  	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
>> >  	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
>> >  	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
>> > +	GUC_WA_KLV_ENABLE_PAGE_RECLAIM_ERROR_COMPLETION					= 0x9012,
>> 
>> Probably better to use the same name as defined by GuC here?
> if u mean the internal spec - sure i can do that but i didnt realize that is the convention here.

I'm not sure if this is the convention though. :-)

I just thought it would make sense to keep the names in sync.  Maybe
Daniele can provide his input here.

--
Gustavo Sousa

> [snip]
>
>> > +	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */
>> > +	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78) &&
>> > +	    gt_to_xe(gt)->info.has_page_reclaim_hw_assist)
>> 
>> Should we really gate this by the has_page_reclaim_hw_assist feature
>> flag?  This flag can be changed at runtime via debugfs.  I would assume
>> that GuC would do the right thing if PRL is not supported on the IP it
>> is running.
>
> yeah - like your idea better - will just always do it.
>
> [snip]
