Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71060606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YoJ28uQf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB78610E083;
	Mon,  2 Nov 2026 18:42:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DF310E083
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793644942; x=1825180942;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=iYSBK1FDiQs5rhMdYU2yuriul0pejlJRYpG+FTm8pSc=;
 b=YoJ28uQfVGwFQn/xLQ/bZJ+dzgNcverLyZ/orm+1bfwocYGlmKMZyzMV
 hIU+Jpx49YPNlTTDsJHx9rf8pmq6hz0JUWAx2zvxz7Qbu3iDteY5H6mqN
 Tj9TpnGF4myrkwC7T355kS/1TDbL4TOUdLFc3LTKVDYEbNkwZ641oi7Ya
 c2JC+BG5pOPkBcWnUWjPDT4zjryQFm4livXQtVHRiSgn7TuNurfIfRo8n
 KcFU2qBj3aWGd7VEPGaJTux1T/bxIdPYYeo/LF8YkgRem4AXPMUdY7CB2
 mz++ydGY2nknkEfWayTYqyqkThkAHQ5zgEdigce94znb6EPU+9YLLLnW3 A==;
X-CSE-ConnectionGUID: I2+XmTD0RUu6yDfdZDrm/A==
X-CSE-MsgGUID: 6WL+CAnWSPWN58gi7TgCKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2254323"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2254323"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 10:42:07 -0800
X-CSE-ConnectionGUID: NXfdh5pGTJWD4zirrDp2NA==
X-CSE-MsgGUID: ksh1zP5vRVSJc3lnIrah4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6353002"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 10:42:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 10:42:06 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 10:42:06 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 10:42:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Po2m3gbmxXYPtnWhfOBqy86Uu8c/zSvlx8bqqiK+wZEcxKkJQj/tJcNigsAX4TK6HO9nTOPxFd0Ch4jyzVoZtrOdoJZB2mBJeP5MO0QkMynruX+rMKqywCVENU5fTGoHilNYyLqmpegbo+byb+r4GO2hpZ4+Jpx6yewwK2V0vjGDXyprSUU23g2P4ykgfOhhn9v5NL3ftBgWJFgh8asZCSTVOBjOHFvgHA7t29ethhQ7i+weEgTqFIWYMbG45lNs1EeqlG2BCmznooYa4nT5CQCoJMGPUbCpCnm98MzlFGJuCUy5cVLNZ8dzg0CGHZYpc/H86AhCqbTVA8GTkAT7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPCWLyMRstbvm1bbtln24zFnRgC8UXhSCMWqMfm117o=;
 b=k5/+Wyl9Q9KYHjalrkLEhcov7VmeOOmLso5cOedWUekt08PWLQ0BIoZM0LdbQ04eY5nkMckCKbOIR0lyeNN9IppDaUQsObd2slOgOD+GBgdlg6r68hmZRppFbDOqQtbPR9gSkEGlPCd34DgQ28Qiy3ew/sdYRFcZollRMgF2KFsWVeaHxFjBSP2WrvVN7GBwT8Q/yGER1tFbWErTUbaLKooM0jFocUof45B3Xt5dhYFsNTSIqCMr67LMHB/AvlsfN++3wDTsPoz23k5UaLDKxcXb04noE5o7fNWwG0dvA3gIQ9p0/P1sIWyUu8uPO+NG3A53eVLntV3c/G+wX852+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS6PR11MB830241.namprd11.prod.outlook.com (2603:10b6:8:46b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:41:59 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:41:58 +0000
Date: Mon, 2 Nov 2026 13:41:52 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Danilo Krummrich <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
CC: <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>,
 <linux-next@vger.kernel.org>
Subject: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <aujZcJBUyQ7iX_PM@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS6PR11MB830241:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5dee44-f1b1-49c7-f485-08df3910f9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|261021123027099003|261021121427099003|5023799004|11063799006|56012099006|261028144727099003|261026121527099003|261022105027099003|261022115727099003|261026140227099003|261022075727099003|261009223027099003|921020|10067099003|18002099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info: aQcAVVbm4yBEnUJ0Rsg4u22Q0vs1X3Dm4mBNR0Xqr+DSkzZlqgWa9oyVbWI66DDRuuPwgoqizJTlDgt5Bk6hu4Xwsu934+Tdbbom7qQczMLF5tKs7aKzHI9ZMsmhJP2bbYQd4F6/2TkeEw3042QFqzrASyLaf2hjYgSq3HCN9b0kfKUITc/oQU6q7U69CQgbUwkvlJ7pIK/x7oAX4EvXrX6Y/l21EH3vTrp1cYClTggabXAX8xPPNwZ5MmrCJ/7fI1OrAQRf/RqpBADAVXKAhb5w0t2OyAWGLKetpti4aDwDStvDNHcp0xqO+PJPEsOs+oYKr0r95weQlEyrSau8TozuxB0P/el6PbKYiOXzoNEyyzn7u1s2EVJYzaOUcIW9MwcWVKbL1pqrBehut2SfY5eiVG7smpy0Ttf11/9JA3sjqjAH7tfshRcqgLTdDy9RN+9kHaH1Or33E8gMrwjT6zV/5cvsRIUvpg/h+rZyUXwQbRzddHHYDKtMXbcTYjqdZvCKnZkQA36fV1rFjBp5cQILCbaKjX4eWde3ykeMgVJKY+KbaSGZjqxsjIv9c+CslONRKY+QL5zXYPyZeaaGBhVEV6TVtPzKQWGpA23Ih82EndYTu5JU9id0RVCk1ngOfYzYgVejzVayJ0cjVBI3xGOph2o4dVMRc1XtPJaZgN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(261021123027099003)(261021121427099003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261022105027099003)(261022115727099003)(261026140227099003)(261022075727099003)(261009223027099003)(921020)(10067099003)(18002099003)(261102123227099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAx6DgERlPwiJbsZZ9AOv6iZpeymY3/Bo/7qCM7y/sjpjW1y4s5sLqB+AseE?=
 =?us-ascii?Q?xvy6CGF8Ma1x8YqcRLo8nOnbj/GvJGVQWaJOEvNMDTQbWYUBI81JuLpM9siG?=
 =?us-ascii?Q?79cs2KYVDFD/q7054tYJKG0KuHpn1rlJIq2233fQygnQtFL9bJHfI/Q9U/23?=
 =?us-ascii?Q?+NBKm/Oe2J+/MPnp+pmnqx1GvNnfWnNbi9tHpNYPoayohP1jMBX6d/Pf0Faz?=
 =?us-ascii?Q?HKwgjP8pRz8pT5UynheyINFaoDQEzm4f8gjRYBK1DKEmWDrO6wleB4fLMqDv?=
 =?us-ascii?Q?tE7kw4qvaykmbp5f6fAAtWzvXgWGTvsy+x3eDw0eRt0s2/3j2UDseJFFv9fQ?=
 =?us-ascii?Q?ohIWRlpEKVz63gVubAevF4w9fLuoiNahErWkBu79sp1Xl9LudBgL03TzMDJ6?=
 =?us-ascii?Q?/2K3lFwxWkW2daZXnPIEuFk9ic1RHRLRNsM5hB7wRmNjWke2b597hhXf/1U3?=
 =?us-ascii?Q?sfIaZ4QsI804AUgNzF9WL8w3lcG04Z80O8Dw/CHPxxf1up3S07yDdg9T2KDM?=
 =?us-ascii?Q?3DO6gNEsAbZX7ZkGWOpSLKAQ/x/QCW7bBcF4/mrLxKtNvEh0ATIWPfGhxAcv?=
 =?us-ascii?Q?TzTHvvHsi98zQAZEjoAaJgy7tefSth1F/Ka7nAHKB2zid1beL1oB0RTKRu1t?=
 =?us-ascii?Q?ROCg59knJN9YOREw66iLlJtFddVm1SBe2w/ha5Dg6RR5UCp9m3WJnNrD9Uhk?=
 =?us-ascii?Q?s2n/RQp1L/ahf4w26m+I9grtEuYFVLQMQm4FbaRME0RY4rNw8Fejeq2cZPgO?=
 =?us-ascii?Q?g+3Bm0qpELU+jzEohlBIcmf4kJGJPIR056qulfeWiZsZsVqSJ1VdOtm18OxK?=
 =?us-ascii?Q?bh+fLxyxEo6lmrwv7fsTZ/xkdr+jEYZJ00Y+bVi+zyyhT09qsT9pBJtgEC2f?=
 =?us-ascii?Q?TpEfLiNRey89d5oyH8OsgTd4PSPD33j6TXm4FVtAAZnd4XFQW9Lq0RlUaYjc?=
 =?us-ascii?Q?xrUSGq8USUil0g4UWiY/JuyCd63n0CNhCAE1HiWx/IFTvDQ3tZ5Pj2NgEhsj?=
 =?us-ascii?Q?Ma16jO6OBSLfIJsrN+ZAnwGshH7bf18J7DrA8n3QzMl38gypznttoHtfo2NA?=
 =?us-ascii?Q?ls0qx6Iup9YK9rUI7UBYJLSHSt05f2intg1PmuUHCePtl7goaMPM/VPVtXbB?=
 =?us-ascii?Q?hrWgGOZccLJ+BUv9YG9DHju+gAnm1yvifPtAmWTFH6bBx5dciGCkqliBXYyX?=
 =?us-ascii?Q?W/Ny7SxWgFiLsY0TOmbgPcvx0Yy/klMenTU27pVD8BfnvaXPATCLynnrFgdG?=
 =?us-ascii?Q?3T2UoMdA9kxbxXAxf8u0XsPbaKg+JN9CYSinZaDpKsE1IxR7n/hcJ02fUOd+?=
 =?us-ascii?Q?56AZaxmPLa5ApRrDOfjXvgSLO4mkninVru617TGMB6D51ds1Qaho0dlpHOJw?=
 =?us-ascii?Q?3h/MsBzrK6K+HXh+g5T4oYxUqieDDIdd9U3DhLvEsJ/DbuImC5znKgBcJbGq?=
 =?us-ascii?Q?stlb3GADoRmmSYxgmLqvSbv3FpXh15UQ4i3Yc4KW7aRdTQAt5JW0KNkbuVr7?=
 =?us-ascii?Q?z/uWVRPZY3d2zrdh7LZrHPsjiETh4+m73O1DjXdDbc/cTMOmSHFSqPYkmGCv?=
 =?us-ascii?Q?o7IpKlS1995VY6njMQPjclxrwXjxVxrD1yVIxs9R6PlRLpF1x8oihCRBTaZ1?=
 =?us-ascii?Q?Wm/OYwRILhAvMRAuA8slhcHVKZHPc5xoYp3BqrHEj6NFGkeiArXEbOTQ21NH?=
 =?us-ascii?Q?ebHAg9RtkxKOWFuMYpVuCRzZ5KHtuLK6D0y9X/025FKa3HyFfC6mklbN8jn4?=
 =?us-ascii?Q?F2htrd5oQQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: hq5j2KjU9MgGNCBhhX2ep1ZqcgcPaw4KDVyIGUSPLfPEZA2ktXM9PW+/mRK35aOrHYKUNhutDv6m8qt79gHZJFj5p6Gtld2QX61VoFtbDz7TrxhLF+rQBWobnLHCF36IRucsfY5doJINEzZzxuQWZciG9bZQl+aRP1sL5HMd32BR9qdaAn1izP5oI/tlxmdJJ24KR5iOvSxwm8kjoJNq4VR6qEvRq6E4WOsP3JW32hIJNTlShl9JyEYVa76UYkO2BiRQwz/nDAkh6/Almw5Jvr8C4onk8rOcMbqV2y1KgRgqE3MgiB7023Xpi1fcA+01bWk5I3jDEf0k+3uRaT2kLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5dee44-f1b1-49c7-f485-08df3910f9ee
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:41:58.8480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVJZ78oXYomQYiIeiNCYWQvy8FIkGyYDgZ8YQFo/piG5WJFG1gTmxCuqgwH83xDtfWBFhcEujQt3JS1fg//RAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB830241
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

We'd like to replace most of the DRM trees in linux-next with a single
branch:

  https://gitlab.freedesktop.org/drm/tip.git#drm-for-linux-next

It replaces these entries:

  drm/drm-next, drm/drm-fixes
  drm-misc/for-linux-next, drm-misc/for-linux-next-fixes
  drm-intel/for-linux-next, drm-intel/for-linux-next-fixes
  drm-xe/drm-xe-next
  drm-rust/for-linux-next, drm-rust/for-linux-next-fixes
  amdgpu (agd5f/linux.git#drm-next)

drm-exynos, drm-msm, drm-msm-fixes, drm-msm-lumag, drm-nova and etnaviv
are not part of it and stay as they are.

The main reason is to reduce the conflict pain that Mark constantly faces.
All of them should be handled already when we are rebuilding drm-tip.

During this work, I realized that drm-xe is a big culprit for leaking
future work without a blackout date from -rc6 to <next>-rc1.
So, another quick solution would be to get a drm-xe for-linux-next like
the other domains are doing. However, I still believe that this unified
one will make Mark's life much easier anyway.

The unified branch is rebuilt by dim together with drm-tip. It has all the DRM
-fixes, drm-next, -next-fixes and driver -next branches merged, with
the conflicts between them already resolved on our side. From -rc6
until -rc1 (per Linus' tree) the driver -next branches are left out, so
nothing for the following merge window lands early.

It contains the DRM fixes too, so it would go where "drm" is today.

During the past weeks I have confirmed that the drm blackout period
works well on this new branch.

The dim changes:

  d875049d2b29 dim: build a unified drm-for-linux-next branch
  3009867cd318 dim: keep -next branches out of drm-for-linux-next during the freeze
  https://gitlab.freedesktop.org/drm/maintainer-tools/-/commits/master

AMD:
Alex, Christian: linux-next takes amdgpu from
agd5f/linux.git#drm-next today, which differs from drm-amdgpu-next in
drm-tip. Is drm-amdgpu-next fine for linux-next?

All other maintainers, please ack if you are okay with this approach.

Mark, you're in Cc for visibility only. Once we have all the acks, I'll
send you the formal request. After linux-next switches, we stop
updating the old for-linux-next* branches (patch below).

Thanks,
Rodrigo.

---
dim: stop updating the per-repo for-linux-next branches

linux-next now pulls the unified drm-for-linux-next branch instead.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 dim | 53 -----------------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/dim b/dim
index e3f616b..b3ed8f7 100755
--- a/dim
+++ b/dim
@@ -658,52 +658,6 @@ function dim_range_diff
 	fi
 }
 
-# update for-linux-next* branches
-function update_linux_next # branch next next-fixes fixes [for-linux-next] [for-linux-next-fixes]
-{
-	local branch linux_next linux_next_fixes linux_fixes for_linux_next for_linux_next_fixes repo remote
-
-	cd $DIM_PREFIX/drm-tip
-	branch=$1
-	linux_next=$2
-	linux_next_fixes=$3
-	linux_fixes=$4
-	for_linux_next=${5:-for-linux-next}
-	for_linux_next_fixes=${6:-for-linux-next-fixes}
-
-	repo=$(branch_to_repo $branch)
-
-	if [[ $repo != $(branch_to_repo $linux_next) ]] ; then
-		return
-	fi
-
-	remote=$(repo_to_remote $repo)
-
-	git_fetch_helper $remote
-
-	if [ -n "$for_linux_next_fixes" ] ; then
-		echo -n "Pushing $linux_fixes to $for_linux_next_fixes... "
-		git_push $remote +$remote/$linux_fixes:$for_linux_next_fixes
-		echo "$DONE_OR_SKIP"
-	fi
-
-	if git merge-base --is-ancestor $remote/$linux_next_fixes $remote/$linux_fixes ; then
-		# -fixes has caught up to dinf, i.e. we're out of the merge
-		# window. Push the next queue.
-		echo -n "Out of merge window. Pushing $linux_next to $for_linux_next... "
-		git_push $remote +$remote/$linux_next:$for_linux_next
-		echo "$DONE_OR_SKIP"
-	else
-		# dinf is ahead of -fixes, i.e. drm-next has already closed for
-		# the next merge window and we've started to gather new fixes
-		# for the current -next cycle. Push dinf
-
-		echo -n "Pushing $linux_next_fixes to $for_linux_next... "
-		git_push $remote +$remote/$linux_next_fixes:$for_linux_next
-		echo "$DONE_OR_SKIP"
-	fi
-}
-
 function check_conflicts # tree
 {
 	if git diff | grep -q '\(<<<<<<<\|=======\|>>>>>>>\||||||||\)' ; then
@@ -1192,13 +1146,6 @@ function dim_push_branch
 
 	git_push $remote $branch "$@"
 
-	update_linux_next $branch drm-intel-next drm-intel-next-fixes drm-intel-fixes
-	update_linux_next $branch drm-intel-gt-next drm-intel-next-fixes drm-intel-fixes \
-		for-linux-next-gt "" # no for-linux-next-gt-fixes for now
-	update_linux_next $branch drm-misc-next drm-misc-next-fixes drm-misc-fixes
-	update_linux_next $branch drm-rust-next drm-rust-next-fixes drm-rust-fixes
-	update_linux_next $branch drm-amd-next drm-amd-next-fixes drm-amd-fixes
-
 	dim_rebuild_tip
 }
 
