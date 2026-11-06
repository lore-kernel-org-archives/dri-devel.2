Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B41F606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eruJ5nRe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE7010E280;
	Fri,  6 Nov 2026 02:24:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2017610E010;
 Fri,  6 Nov 2026 02:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793931873; x=1825467873;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=g4KD81e8XqmwTra2BGK/rrjDDGUbxWwpSvo5jnx0+OQ=;
 b=eruJ5nRe/75Y5Jzwr78YAClNsDnNjcHtyB6l077Uqf7/e7g45w6OwEBI
 cUy7XH9spUrNJAYSyzv3b3t3z8kb5SazwyGtJpSx9sWsTvN1Fr3lcHZjT
 lttSfOl2z4Q7c2DSdsef+ApaM7ic0TAhDLhssMh9ZsWzdKr8vfBQ9AfMK
 IWvu7Vh1u/yHPoCbAwBPlqOGcOUBTx07uRobnTxB56Ja0PEriHdtsPblf
 m5V1o0uFLr+9YFViAN0UDyCXPBG90oE1YYqq8jkYMXoO9ivmXkHoW+wCH
 1erVeiyKx9rY3laMtwF857HZ+c5qDrdvExrZBv1QttX0hJVjluK/FEtwY A==;
X-CSE-ConnectionGUID: MuOfoCnIS/OMI1xohClDWQ==
X-CSE-MsgGUID: kPetdRx+Q5m6Y7K89T/a1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2655937"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2655937"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:24:32 -0800
X-CSE-ConnectionGUID: SmqoyJ9FQdGvDN6phnrCzw==
X-CSE-MsgGUID: F1z3kuqgQki15SH02NwHoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7290706"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:24:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:24:31 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:24:31 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:24:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IadEvyg5ZT/yiX/qbHTMtX6z9KcFYRviY+je6WT3g2Yi7io3CENrPMFE2vCM2HuFT2JBaBadnv/lzrOnNY4rNlxqA+NpFahHmrE79AL97FFMJSUZdEerunageaITny7fTa8qhz+bJVIUyBb61k75xJA7t7uxbvUnSH/wmjBHQNG+SSPrHrnCI5p1KSPLW8cxiBG1itoFCxdhKlPyy9YZkn38DNw3aNZvGrXhLysDl7GpsIzZO6BFbIPfXl7fUygIn3AoowoWHKC9eGdV/zmI26tKbe221adz5KatXwNevflqFxizRn6nb2zQKJRNU6SxUtdlgNTyOS3uYyh62xkz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24wyUWKRl5ipVXM2bZbwwHGzKPsG7wSKrjFld/fccf4=;
 b=goQNW8Pa3EIwGv/LF3gG4K/WDhNfhgrOZg5EtRfmHiMxgvKw099uCrNyz6qQUZqu1dNuJjqyy0CdAA6hR+oWtNXfqt0U5uLYPsMA8/imoj7ypcO8i78yMOyCmwl71NJ6bQqGxzX0ymLrFfJk/498L8jmNrnrMwGfiaRa8nAMJy9vd0ziCsMCVj9Azj8fNMI8ItZ4+IJlUk5yD6w+ZWVF9NyAFCQrREQDTjLlaf/Q5xD1Do35U08nieMle17rwVf9/6zaYWQXESVvGsEkyjYu1lScO3jl8366/uZyu1s/5pPAPk3uaA76VjSFfSi9KVxfO9Wgxhr8EYpnhgs8DyMF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS0PR11MB6327.namprd11.prod.outlook.com (2603:10b6:8:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:24:28 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 02:24:27 +0000
Date: Thu, 5 Nov 2026 18:24:25 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-fixes
Message-ID: <au06WTroGBQ/Gqbt@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS0PR11MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1bbcfe-f76b-45e8-4cd5-08df3bad14e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|6133799003|10067099003|3023799007|11063799006|5023799004|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261022105027099003|261022113327099003|261021121427099003|56012099006|261009221727099003|261022115727099003|261021123027099003|261009223327099003|261009221227099003|261009220027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: +Z3DuXhLpRyhVn63XPAxJeV7ARCFBT1n+s3CGX5VaB6vWIFLOGFdsm3W5G8QWc96NP64S9Dh0N6YQb9ArsNGlm4btI98WF0sLOifS7QOjCznVY2dWZFCnJZGJpCAhdoAz6zjPOzHlB+VhI/kkuniUp6NVEOhuGkARFdPE1CcznAG10KvXVIJCKoREMs+lygfAlqwtrW3OstqMeYJ7gAu8NSWAMhAv6+DxhaQYXOmYd4yrXAYEICaARfik2ahZBQAWbjx5E63LzWim7Z638Fs3y3dK08myrmvxPzUK37TAV94o2PAq6mHnTTkIsSDvcizyKlLwAxCGMCuRO/9vMgDU9wgjlt4Gvcqoy2Z2mdO0qwwA10DOpK0mb2G1zjspAhqiQKmlEbjHmjcrZxwfZs1XGZC6eeTbtLIu451sH5XqZNfogn83c0PHvy6T+KCZOPnVvoXL1TqVZESMIIHBDocbMFMMkBdt/QtK3MB1HG+F+MtTLW4RRlg1e/h5bLkd3TrixdMP7DpWDeui1osM0lMg7MATPGI8ZRoRZpfpEjGBI8597Nc11G/da2GplIvuMQ5wD++TL3KC3Fy0WZutFpdE4mAOr3vx3mFGIw2vbxG6Tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(10067099003)(3023799007)(11063799006)(5023799004)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022113327099003)(261021121427099003)(56012099006)(261009221727099003)(261022115727099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009220027099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0ruGOaPbKXFB4F4gsjtI9JkHW+kKw3u9MKIf3BDwF7Zman0wO3XrmC4WD8?=
 =?iso-8859-1?Q?kXIV57sP6v4t7T2VuS/kHc2lQBcev4pKszr+zGYYb2ZMUhsvFSzumL3sDn?=
 =?iso-8859-1?Q?Iy63l9Rk8ldm2xO30rSe/54RrsUw7nw5LiZAjEDfwep25xBh/hXtQl13iw?=
 =?iso-8859-1?Q?4NU4wDlyC19o1QDIB6oOr5wD+S18gGwGDNfS30jSVRxYLKYFYsDWIhybAQ?=
 =?iso-8859-1?Q?4SrWpNw84rv2RTVVSHtRkENkCMK/OGeUDIABaBmObWDr+PW3c82VcW4hFm?=
 =?iso-8859-1?Q?gGq+9DGQsOBLuiuluPhevA6LHC2ToBRuCz87sBzZO/rtrbvt/6hw91qrsD?=
 =?iso-8859-1?Q?54Rz/3qoTBozw51ajp74U0WIdAxeLjeiKvJ1tzOGqCEjNCuwY3KxmdweTk?=
 =?iso-8859-1?Q?YCXBsNj1cm5/nkpQKG6Ccph8VOJNs6+hqDawCOec6y0Ie/aH+nqMjqBfkM?=
 =?iso-8859-1?Q?POFkh66GQfGRiGAnNP7SmjFYPMV/1EsURMTzNN1GVrgEJ5AudpoDYk0IId?=
 =?iso-8859-1?Q?HuehsP9aPUyuyWnqDvSXtvgd9X2k6Jyfe7tppEn2J2EBs7unKAKHwiTmTQ?=
 =?iso-8859-1?Q?3fH5ebW19iCt8n4DADPoCJGOH8KSZ7DTUnLv+QveGn9JWNTPojHyAeDXVh?=
 =?iso-8859-1?Q?QO5MU94T4FsWJXYnk1VuW9zD07DTIsGhxEA4bj3ufnucr9LJ1K2EeJ8wiO?=
 =?iso-8859-1?Q?2MlV5E5G/pfAZvGAdIlp7sa7fEd+oveJwLrmlnsJKPYw5a7jiJN0zPbAp8?=
 =?iso-8859-1?Q?Y6SpKHfXN4outHHkeeINyb2xoG5xnI5kuNnxvXgOs1/tr8gyM2t9jlWQ7A?=
 =?iso-8859-1?Q?43jf3g2FbySXWPOchkK3NQCgFXrFRMpPI9wCYNOPv61pd3r8TzWIvfoNmx?=
 =?iso-8859-1?Q?0zuwvRB6uhHcTK1GXmxPaDg9xZakDsg4NrRbqsw4LsqLw5CuynfCTRqhs1?=
 =?iso-8859-1?Q?cM0/wabKitgqJIu4mLKRwdhLak88NZqA/IDS7E2+Erd52zeBRxl2HTQZhH?=
 =?iso-8859-1?Q?mbXrsud1GTh8aQ/xD2A27Gt0rmjk8clzYc13z6SuhiK1t9CIuv0ZRH9rj8?=
 =?iso-8859-1?Q?ZMrlZ0U23YOZ5wXqYtHNKbX9OsX9On4ja8Yh2+enaET0R+mjTbXQWW2fiU?=
 =?iso-8859-1?Q?1aX5yTHLJy9sn7IkXaQo+O78+k02iQO+06+coOG1eM8R2ar+9Vk1Cs/pWe?=
 =?iso-8859-1?Q?21nR2F9s5HowYgQxvHunKTLMsszA8L34ittapiCSTEkUAG9Lr/yGR6lcyT?=
 =?iso-8859-1?Q?JJH0gEOKn+jsxGrGIbGoV6+KXkkeLDHKbZ7tKiNxF+4JZSfMxmb5XapQ1N?=
 =?iso-8859-1?Q?CJ10AEx4/RJglFXxYW9ZOTvW/hE5V/T6XE76D/L9Q2LDumL2ZCuxRTWDn1?=
 =?iso-8859-1?Q?TkIGHNmE9ckQ3eUoWA6afdphtxPqcjX6gpHe2I+rUvguwmJwHKxJcInfAX?=
 =?iso-8859-1?Q?dGOebPY45s7IrZSFsr38Tu4iHrP9PoX1lk6LXTEsGOr7zrqTT45rG9E+AQ?=
 =?iso-8859-1?Q?4M7RHXEYqh4jDVF41TWwBHIA6HuB+GRSHR+8ornk12QFyL12id+haN6iFG?=
 =?iso-8859-1?Q?JX+rF09MZ5ALzVx+QQOMx4m0NLGMJD5+mPP1y/qqdg2SUYf1F/JYoSpzPS?=
 =?iso-8859-1?Q?sBH2kUh/iZ7biqhu32QduK+kkycrfJtSdVdfEmc/HsIRyVihHVAJkGW38j?=
 =?iso-8859-1?Q?IajfOrkud9Li4tSVlAInruihQSls5w5GJBSEAZ+zrimMrWdQxj3ZVGndmG?=
 =?iso-8859-1?Q?v1ExXybfcLBrU2pu9mAuS+qgblE4uLt/4tO6yH3kmcTlZfG5pncpuMnQ3L?=
 =?iso-8859-1?Q?v65IoTGGOA=3D=3D?=
X-Exchange-RoutingPolicyChecked: TmoehBBmEQzhWASUMaZM8xJukdA1nNiDVmBPa+W8IcCWypUrRj140mDPNhAchAf4UcOErt5Ozf0LTCqoVAvsh+qPbloAFYZo+3AvClwuasTxyUXjUWvfIXPeBSz/DmFu/l54bQZqfbwJZPRvweDsRb5YL0sQcDG7h9re/YWVa/azzB4bPZe4DZh4bxzlQ+Z4DM++OKMonO4nVlpLNm9sB1cj6kwiX2lWLCNfVIVtqeAgRoUtIyDrpRiD0kB6sa8KQDPGJVpplV/yMM/Nkfb8GGep6NSF2gJJkHq1poTOQBrNLxIo/3qyfaTMC7iLzSDOC9ijKV8V9dZrYkf8zS+gWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1bbcfe-f76b-45e8-4cd5-08df3bad14e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:24:27.7712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPVlB00QVkXwaFE3Gg40nd0n8fykhn4zpMnNZgIoDyEoaX7u6STkR/V/AhDhqiHiw9xr7xVkDG4JJWLEuxy1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6327
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

Dave, Sima,

Here is this week's PR for drm-xe-fixes. Apologies for the sheer number
of patches. I got caught up in various internal fires before rc1 was
released and dropped the ball on getting out interim fixes PRs.

Honestly, there's nothing particularly interesting here: some hwmon
work, a bit of GuC submission backend rework, VRAM offline fixes, and a
bunch of other small fixes.

I hope everything after this PR settles down in the cycle.

Matt 

drm-xe-fixes-2026-11-05:
Driver Changes:
- VRAM offlining fixes (Tejas)
- ras: Fix sysctrl and drm-ras discrepancy (Roper)
- pat: Return error from xe_pat_init_early() on unknown (Roper)
- Prevent VF memory IRQ from accessing a torn-down engine (Piotr)
- guc: Protect timeout handling from device unplug (Satya)
- gt: Disable GT reset worker before engine teardown (Satya)
- Various hwmon fixes (Karthik)
- tuning: Restrict Anyhit NULL-query tuning to render engines (Nitin)
- gsc: Fix NVL-S GSC compatibility number (Daniele)
- Don't abort the shrinker walk on -EBUSY (Thomas)
- Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng)
- lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen)
- Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo)
- madvise: use already clamped pat_index (Auld)
- Various wedging fixes (Raag)
- Rebind BOs evicted before the first LR queue (Arvind)
- Toggle the D3Cold enable flag at runtime resume (Vinay)
- Access GT MMIO after pcode init (Vinay)
- xe_late_bind_fw: Fix firmware leak on missing manifest entry (Badal)
- svm: Preserve default PAT index when resetting VMA attributes (Arvind)
- Unwrap sync fences before adding them as job dependencies (Junjia)
- Schedule disable G2H fixes (Jagmeet)
The following changes since commit 9b6f2eabc8371dea951c244f4aa9e013f36de9f8:

  Merge tag 'rtc-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux (2026-11-01 08:41:03 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-11-05

for you to fetch changes up to 28f45837549a0558c5dbe19a78c0717fc7d774ee:

  drm/xe/guc: Do not attribute a TDR disable to a pending suspend (2026-11-05 10:59:35 -0800)

----------------------------------------------------------------
Driver Changes:
- VRAM offlining fixes (Tejas)
- ras: Fix sysctrl and drm-ras discrepancy (Roper)
- pat: Return error from xe_pat_init_early() on unknown (Roper)
- Prevent VF memory IRQ from accessing a torn-down engine (Piotr)
- guc: Protect timeout handling from device unplug (Satya)
- gt: Disable GT reset worker before engine teardown (Satya)
- Various hwmon fixes (Karthik)
- tuning: Restrict Anyhit NULL-query tuning to render engines (Nitin)
- gsc: Fix NVL-S GSC compatibility number (Daniele)
- Don't abort the shrinker walk on -EBUSY (Thomas)
- Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng)
- lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen)
- Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo)
- madvise: use already clamped pat_index (Auld)
- Various wedging fixes (Raag)
- Rebind BOs evicted before the first LR queue (Arvind)
- Toggle the D3Cold enable flag at runtime resume (Vinay)
- Access GT MMIO after pcode init (Vinay)
- xe_late_bind_fw: Fix firmware leak on missing manifest entry (Badal)
- svm: Preserve default PAT index when resetting VMA attributes (Arvind)
- Unwrap sync fences before adding them as job dependencies (Junjia)
- Schedule disable G2H fixes (Jagmeet)

----------------------------------------------------------------
Arvind Yadav (2):
      drm/xe: Rebind BOs evicted before the first LR queue
      drm/xe/svm: Preserve default PAT index when resetting VMA attributes

Avi Weiss (3):
      init/bootconfig: pass init arguments in documented order
      irqchip/riscv-imsic: Report successful hardware retrigger
      irqchip/irq-msi-lib: Free wired MSI descriptors

Badal Nilawar (1):
      drm/xe/xe_late_bind_fw: Fix firmware leak on missing manifest entry

Chen, Junjia (1):
      drm/xe: Unwrap sync fences before adding them as job dependencies

Daniele Ceraolo Spurio (1):
      drm/xe/gsc: Fix NVL-S GSC compatibility number

Dnyaneshwar Bhadane (1):
      drm/xe/pat: Return error from xe_pat_init_early() on unknown platform

Helen Koike (1):
      drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2

Hui Su (2):
      hrtimer: Add cleanup class for on-stack timers
      sched/idle: Use hrtimer cleanup class in play_idle_precise()

Hung-Jui Lin (2):
      posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers
      selftests: timers: Add a test for disarmed SIGEV_NONE timers

Hungyu Lin (3):
      posix-timers: Accept NULL clock_getres() output in stubs
      timers/itimer: Keep a nonzero value at CPU timer expiry
      time/namespace: Fix overflow when converting absolute deadlines

Jagmeet Randhawa (2):
      drm/xe/guc: Fix race around q->guc->suspend_pending access
      drm/xe/guc: Do not attribute a TDR disable to a pending suspend

Karl Mehltretter (1):
      clocksource: Prevent immediate watchdog rerun after a delay

Karthik Poosa (5):
      drm/xe/hwmon: Fix pcode power limit handling
      drm/xe/hwmon: Decode mailbox temperature as sign-magnitude
      drm/xe/hwmon: Fix thermal sensor data handling
      drm/xe/hwmon: Add helpers to validate thermal sensor readings
      drm/xe/hwmon: Handle unavailable memory controller sensors

Linus Torvalds (1):
      Linux 7.4-rc1

Matthew Auld (1):
      drm/xe/madvise: use already clamped pat_index

Nitin Gote (1):
      drm/xe/tuning: Restrict Anyhit NULL-query tuning to render engines

Peng Wang (1):
      tick/nohz: Reevaluate the tick for kicks flushed outside hardirq

Raag Jadav (8):
      drm/xe/ras: Fix sysctrl and drm-ras discrepancy
      drm/xe/gt: Use GT ordered workqueue for wedging
      drm/xe: Drop xe_device_set_wedged_method()
      drm/xe/hw_error: Guard csc_hw_error_work() with runtime PM
      drm/xe: Move xe_device_wedged_fini() registration to xe_device_probe_early()
      drm/xe: Make xe_device_declare_wedged() IRQ safe
      drm/xe/pci_error: Flush GT wedge worker before bus reset
      drm/xe/amc: Guard xe_amc_work() with runtime PM

Rodrigo Vivi (1):
      drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m

Satyanarayana K V P (3):
      drm/xe: Prevent VF memory IRQ from accessing a torn-down engine
      drm/xe/guc: Protect timeout handling from device unplug
      drm/xe/gt: Disable GT reset worker before engine teardown

Shuicheng Lin (1):
      drm/xe: Mark xe_vma_ops_alloc() noinline for error injection

Stian Halseth (1):
      sched/cputime: Don't warn when the tick period starts after idle exit

Tejas Upadhyay (3):
      drm/xe: Re-validate external pin under resv lock before VRAM purge
      drm/xe: Drop RCU list handling for VRAM bad-page tracking, use mgr->lock
      drm/xe: Keep VRAM fault injection within the usable range

Thomas Hellström (1):
      drm/xe: Don't abort the shrinker walk on -EBUSY

Thomas Weißschuh (1):
      vdso/gettimeofday: Correct the read of tz_minuteswest and tz_dsttime

Vinay Belgaumkar (2):
      drm/xe: Toggle the D3Cold enable flag at runtime resume
      drm/xe: Access GT MMIO after pcode init

 Makefile                                      |   4 +-
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h       |   3 +
 drivers/gpu/drm/xe/xe_amc.c                   |  10 +-
 drivers/gpu/drm/xe/xe_configfs.h              |   2 +-
 drivers/gpu/drm/xe/xe_device.c                |  60 ++++-----
 drivers/gpu/drm/xe/xe_device.h                |   7 +-
 drivers/gpu/drm/xe/xe_device_types.h          |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  17 ++-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h   |   5 +-
 drivers/gpu/drm/xe/xe_gsc.c                   |   3 +-
 drivers/gpu/drm/xe/xe_gt.c                    |  63 +++++++--
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c           |   2 +-
 drivers/gpu/drm/xe/xe_gt_types.h              |   9 ++
 drivers/gpu/drm/xe/xe_guc.c                   |   1 -
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h  |   5 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            | 119 +++++++++++------
 drivers/gpu/drm/xe/xe_hw_engine.c             |  17 ++-
 drivers/gpu/drm/xe/xe_hw_error.c              |   2 +
 drivers/gpu/drm/xe/xe_hwmon.c                 | 180 +++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_irq.c                   |   3 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c          |  15 ++-
 drivers/gpu/drm/xe/xe_lrc.c                   |   8 +-
 drivers/gpu/drm/xe/xe_memirq.c                |   3 +
 drivers/gpu/drm/xe/xe_mert.c                  |   6 +-
 drivers/gpu/drm/xe/xe_pat.c                   |  11 +-
 drivers/gpu/drm/xe/xe_pat.h                   |   4 +-
 drivers/gpu/drm/xe/xe_pci.c                   |   5 +
 drivers/gpu/drm/xe/xe_pci_error.c             |   6 +-
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_pm.c                    |  12 +-
 drivers/gpu/drm/xe/xe_ras.c                   |   3 +-
 drivers/gpu/drm/xe/xe_shrinker.c              |   3 +
 drivers/gpu/drm/xe/xe_survivability_mode.c    |   3 +-
 drivers/gpu/drm/xe/xe_svm.c                   |   1 +
 drivers/gpu/drm/xe/xe_sync.c                  |  33 ++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c          |  53 +++++---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h    |   2 -
 drivers/gpu/drm/xe/xe_tuning.c                |   2 +-
 drivers/gpu/drm/xe/xe_uc_fw.c                 |   2 +-
 drivers/gpu/drm/xe/xe_vm.c                    |  11 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c            |   5 +-
 drivers/irqchip/irq-msi-lib.c                 |   1 +
 drivers/irqchip/irq-riscv-imsic-platform.c    |   2 +-
 include/linux/hrtimer.h                       |  24 ++++
 init/main.c                                   |   6 +-
 kernel/sched/cputime.c                        |   7 +-
 kernel/sched/idle.c                           |  16 ++-
 kernel/time/clocksource.c                     |   2 +-
 kernel/time/hrtimer.c                         |   8 +-
 kernel/time/itimer.c                          |   2 +-
 kernel/time/namespace.c                       |   2 +-
 kernel/time/posix-stubs.c                     |   4 +-
 kernel/time/posix-timers.c                    |  25 ++--
 kernel/time/tick-sched.c                      |  14 +-
 lib/vdso/gettimeofday.c                       |   4 +-
 tools/testing/selftests/timers/posix_timers.c |  43 +++++-
 56 files changed, 631 insertions(+), 234 deletions(-)
