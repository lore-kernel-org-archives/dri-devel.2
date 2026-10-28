Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C6606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=To7i4bpB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D80C10E713;
	Wed, 28 Oct 2026 22:43:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA6B10E6E7;
 Wed, 28 Oct 2026 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793227411; x=1824763411;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mDJrbw69sFwuOFn1GLUWDxUurAYJZGzXQAJBc3zLraE=;
 b=To7i4bpBOZ5R46Gg1ST4rM/EEPriIq4XtLYTDdZ/mRZhpBd9rOwKOFYA
 qjlAq6o/PcfBIrQLkzRzKir4Z6zYGDEQxEpvI7Hz77yfSb2SlkmAV004w
 bvnKUhQ5rFd7yqHmL6Ca9YRtlOi0oguftvbmy44AfKnZLjeuyab5MlQTI
 b/FJuRSJj1eDHR1dCT7ptVzUhVEN63pFUFPVEXwJ4n1t/ZnHx36yOagy4
 yKVkQ/X48Y3RTGB3scs5Enq7gHb0QRdf2zaPMfU1SuuML3fMrPlIJmbbJ
 ExCMPCBBFcR5va0coeTJR9+r4Gk3He+WTyQ5TNdVRAn7WrljBT0adCxF+ w==;
X-CSE-ConnectionGUID: rd3iSuF5Qcmkb/SO9Ww/vg==
X-CSE-MsgGUID: 6OTti2JuQIax+hRHiASsvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1953727"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1953727"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 15:43:30 -0700
X-CSE-ConnectionGUID: 0YPQJZ3hS0yFRAwzEhC6Og==
X-CSE-MsgGUID: 37qOIcO1T9yqghuFOgsQqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5361138"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 15:43:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 15:43:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 15:43:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 15:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fiutcm3jIKQPYtZl+Q00KjNUKvv9cd3j/Pz6gwQrG6q+WpA9mZlHHAUZZiRHrFaI3hob19Nh1HAcRPk78lod/Od8YfqYFzFsObEFjXVfAHF7jrdCftpb1NrAoz4yzJEWhQBzh6F+wB8ntOf7uUWftSNYUyq31wqLWmHhhhL8qp3Suvo0+ThW0VDJGUUpnzTPoN0x9wfrp5q9w/bSnQqa9Weudb41uV48DYzoNzgMKKyQsnK1JhSNuKjPqbg6outwJSJBmYQrnUXDQ1Pkz63nIq9pFS1l/mgRRorbo3H7BDgawAQPWg5UJUQ0mjqSKe5e6YPjNaVKYauC16iGLUxJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc3BfoD0NNYF+owcKTFqWTE/bDy/KYAcLkLaEETQTgw=;
 b=xy0sM1Z3v0pHrxBVhWqcBqjie5ZbNlViSM6AnYqN0DXJEvXzgbiRtPOuuv4Ra6LqcVBtsWgr+WTfOysvy8wjBHNzMptATqR8B8rAy6vHGw5NXikjDMF9EEgppAW2RkmcbhpPMycW5rQGw3kbu+mfEs8I/dCtDFLleoV0dPJA8MMFXg93uLrPSTGrrm4J9tc+L5PUCChpDny/Ssr+n6222I/cqtBStvkgL8QHw/KigyuTuOI/7XHDWFc2rrT3MTbQEPvgWKwiUvN2C7Tk26cdEYc++RQQInDyeyGtTYD4KEfo91B0CxLIdNH7a6NMc/xe2hGvQ3ZKzJ90wI8sEAp00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CH3PR11MB7392.namprd11.prod.outlook.com (2603:10b6:610:145::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 22:43:27 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 22:43:27 +0000
Date: Wed, 28 Oct 2026 15:43:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <karim.sabar@utexas.edu>
CC: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Rebind VMAs one at a time when a bulk rebind
 fails
Message-ID: <auJ6jZj/P7G+omgH@gsse-cloud1.jf.intel.com>
References: <atl2i1vJoU2QwCbG@gsse-cloud1.jf.intel.com>
 <6ae197b3.d47bf0d2.14cb70.fecd@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ae197b3.d47bf0d2.14cb70.fecd@mx.google.com>
X-ClientProxiedBy: MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::22) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CH3PR11MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: 602d9634-3253-4bc7-ba5c-08df3544e193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|5023799004|11063799006|56012099006|4143699003|261026140227099003|261021121427099003|261021123027099003|10067099003|261026121527099003|261009223027099003|261022075727099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: zVdflyW6IXYzI/EppgfpLNVxAaPHS+fDpZPSV+LNscsr686nGClFBBepgFf1x4fZmM4Gm2FJmmAXGuMyF6JGop8/f1sVU+xSR0hChu138D8MhZvS2YzQxHypAEdv/SiPdRacWK48weRAScPk4xKgS733AalUTXSrXVSxj8Q7lfGvDK0QwURgsIWiM86a7ln2yb7hkcg8cfchDx/GOlrPyTqVQMXulEmgP8nUDeTeL+/4eK3ghbMJwLOd85aCr7us9MbzF9neevfn5DaK5m2w4JnSn0RXMoxIAZWcQ6ebcYkJkRkYqm+Equ47gQpuzQIVFnTp2rPmiapSjmOZQ1m+TKEnaSSMZ4flcStFKMqof7sSVoi54oelXJV8FIiSu5h/QYP53TeYsUi/bSe9WkDsbCzwSRvros8h5LWVHBo4/mhvik0sCAW+pixof3hhTRBAxj/EkZoygJC3X3YO+fx2KogVn0XCI0FaTuSKOLxWm8h5//9/k8KL0QiBYZdmwlaZyb/sWUP7YycPpC0MlWLh8t0qOGE1Obb4MV4qLJriqhaud4QYgHIp0I7B5NTjC6KBxqpI5mBvUeQTJ/C8wkiV2zXhD7UCowTYVDOpRRVWEUpicA6rEIqVKqq2Iby5/j13
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(4143699003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(261026121527099003)(261009223027099003)(261022075727099003)(261022105027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPY4MIpYw0jbC8PEXL38amLYfli4VBsrHLIpTCYZs/zNftj9YB+i1aoGKSSk?=
 =?us-ascii?Q?7463/u61F1eIrdESxbR9RcBAl2nuRu9xlopZNGshJtBv0aj8CkZDZOZspLIh?=
 =?us-ascii?Q?AScqog6tLyCFivj1IeYxJYmewn+Bm1+tjknxP8UUIbaahyLDBxEULz4l/iBy?=
 =?us-ascii?Q?4hVrLrzCY3vszJGxnaW5/di4JAKfosmssJzk/vzotFGGLvQggKfcKQMrQDZ6?=
 =?us-ascii?Q?W4u1N616RGXfJRl/+nbMGERN5pgnPYPMvN9mHxx11vLq5DtThJS+dCV8sEQ1?=
 =?us-ascii?Q?WFcLL1hgegYZzr3tqnJsKk/u8TRkGrGbDxGgPkOYSxIQ2N6iraj9WpN/+YUs?=
 =?us-ascii?Q?USAs9+t8hxDeGsSJBcIHkw+HuL8GVuQS6aM8K0hhwoBtv+r/T0qkQDoQ1il0?=
 =?us-ascii?Q?5krfny3e7SPT1oRBvqcm1rg9E2OqxJYj6WV/TR3Y9h7j0w5IoZwJR1yAp2hY?=
 =?us-ascii?Q?O3EpIav9cwZzW6ceKadSNcXzQ0a1t92cfOF1KbIXx2hBK/kmAM4K6tEc+ZaM?=
 =?us-ascii?Q?mBloL3ldhJjKozekpyb2q1i4Xn53T26zQe+npj3wklN9TcfUWJGBFHmpmBOh?=
 =?us-ascii?Q?TRRHJwKT86TGmhpA3VlfZXbo3Gse0yTBmWfjMSXUFfMEn7lTzchHrVF0dQDi?=
 =?us-ascii?Q?Spdm7s9aHzhq3Ij9he/P8BPhq3z0XvUDZ6Sxw2tXCV9kpnq0Dgc80QugpHFE?=
 =?us-ascii?Q?DxQScj2Uwv+OiwXTzxCPIW9y0QnLYPqDOSnlMKVqoDTDEanUNrAmkOWYX409?=
 =?us-ascii?Q?l7Lp4wLqm1AG1/MhNea41A0rzywMSg/oyYEi+HVUSX8XpxKqWdUkZtj9Eacm?=
 =?us-ascii?Q?cWf5gsY9ACFLqJ/8P/O0eAT/l33ddWVZueM80D0dp6+Hl+adN/QFgRwvzDmv?=
 =?us-ascii?Q?como4kmXNMrmJ1UsSkbHJFZEuHyDcm/UYH3Q73cjQ3/WKMmefJVu6CWyI0/D?=
 =?us-ascii?Q?ALFZxaaIHyxPK1GU9sSXP78LNZPaA6H6nVpejJ59Nd6ex9ti6b0WN6neC88h?=
 =?us-ascii?Q?RsXP/lIhHedJIa1cPt9cVJYe4uVaF1uaUzPNIY26PT7h9IjebBr7L5VjyDmP?=
 =?us-ascii?Q?ZF9Qg/9VuAe0/SsrQnzFI3bstIJlH3O89DnDvC3kj2bzyrxhz7gDNoaUqNFs?=
 =?us-ascii?Q?2vYO/GFtbNwKPKqTeWM8HbhlbBxzIeFRm7LIxK8QmYOktLzqUiSpmeqLsPxR?=
 =?us-ascii?Q?kHky5lnAiXpPu+J59AMkGr9LXiewfkA3j2sfIESH2ycbgXSdBy96I/049B+d?=
 =?us-ascii?Q?cMWNzGR5HbXwtxIYV7YIXIAD5cKRB926hCG0zYBDy/dB1hk0d1A3SMNuJ3Zl?=
 =?us-ascii?Q?KDca+/kMiBl8e/VcQg/Ul3kZAo89aLgi/rpw4MtrJDHfZQXPavU9z7ZZpyRB?=
 =?us-ascii?Q?eXQFtxbWQCGiMCgseo/Hmm73yhdVkIcx+TpC9t/3M8hDMrmlzQ/WsyyrRRko?=
 =?us-ascii?Q?QDAWgEnJ+ca/VrQF9zYp+Xq8CMySFiTIxU28+JYQRgCklnVXXUX+SpkNFmPD?=
 =?us-ascii?Q?f9Y1XChTkh9CMEFvMlwe8KbVkX7rPovYWbbrqqMAs9vqQ1K5BBjkcDam1lwl?=
 =?us-ascii?Q?mrGzwvyQrkk1n/DWiSQhFok895HCDQyDDGb89wEr+Ne4kPF7y1YpjixOh/sb?=
 =?us-ascii?Q?//Mb166YtnQyjMz8nqREegLNirKzbtRHRE+zjNgo0E4fTiBuvvLFMdhg2NVs?=
 =?us-ascii?Q?KLV5Ltv7cWSLSf8Rh3so6/iJP1CvQlHK129wsaUDOoj5S6uItR9xl8/u72f/?=
 =?us-ascii?Q?LMfYnuyF0LsE/mNSai+0Fxhlb8wUa5w=3D?=
X-Exchange-RoutingPolicyChecked: G786/u44PIVMqVlWJtSPTSGg4URP0Dz0hwA6/JG6Y0zgNz7PeErrSInO+KjZXQ2fU0Rkufzag8Hw3yDjJYz0W/NtTnNEnld+vYS3nI8KMc2bfMe68nqMTlOaKICdKRqewjkm3amtLRsD4krEhfj5PtVu1NdqV7XjEwMJOGJQJwIPiJCw+SbyIAW30xuSFGZu7hiTWmqNu13s3SMfQfXOColOlncfkYY+g4jdtH8TQ4fjQ46jQUa67YV2T43nnEY6WO0rZjC5uvrQKrP+GD+SCFeY7Eus82kVkHfKU7ejapXQc/Ci4BBYAaHO0+Z8apMvsny6/TA68m4gAy3TzHFZ2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 602d9634-3253-4bc7-ba5c-08df3544e193
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:43:26.9939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuuqAt3/QYzGwvDgHlkW8m/4sL6hDsnUS6g7fGQK+Ht3xZWS9BIpDnUJYpXg85BMXmMj9E0rF8GLWRI+/AcBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7392
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

On Wed, Oct 28, 2026 at 01:35:29AM -0500, karim.sabar@utexas.edu wrote:
> From: Karim Sabar <karim.sabar@utexas.edu>
> 
> Big games die after every s2idle resume on flat-CCS iGPUs. The exec
> ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.
> 
> On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
> these parts. On resume the first exec rebinds every VMA in one job and
> xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
> Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
> array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed. A
> bind that big can also fail later with -ENOBUFS when it doesn't fit in
> the migrate layer's vm_update_sa.
> 
> When xe_vm_rebind() fails with -ENOMEM or -ENOBUFS, fall back to
> xe_vm_rebind_iterative(). It rebinds each VMA on the rebind list in its
> own job, the same thing Mesa does from userspace when a bind returns
> -ENOBUFS. Each VMA comes off the list once its job is queued which
> means a failure part way through leaves the rest for the next attempt.
> 
> I tested this on a OneXPlayer 3 (Panther Lake) running SteamOS's 7.2.7

Generally don't use I statements in commit messages, I can adjust your
commit message when I merge this (after our CI comes back).

Thanks for the patch:

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> kernel. A small Vulkan program fills a VM with 20,000 or 35,000 64 KiB
> buffers, suspends with rtcwake and submits again after resume. Without
> the fix the first exec after resume returns -ENOMEM over and over and
> Mesa reports the device as lost. With the same fallback loaded into
> xe_vm_validate_rebind() through a test module, the bulk rebind failed
> with -ENOMEM on all four resumes and the fallback rebound 20,024 VMAs
> three times and 35,027 VMAs once with no errors. The program kept
> submitting after every resume and the kernel log stayed clean. The
> patch itself is build tested on drm-xe-fixes with W=1.
> 
> I tracked this down and tested it on my own device. I used an AI
> assistant to help with the debugging and with writing the fallback. I
> ran every test and reviewed the change myself.
> 
> Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Cc: stable@vger.kernel.org # v6.11+
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
> ---
> Hey Matt,
> 
> Sorry for the slow turnaround on this one. I said I'd write it and then
> it sat for a week. Here's the iterative rebind you suggested. When
> xe_vm_rebind() fails with -ENOMEM or -ENOBUFS, xe_vm_validate_rebind()
> now falls back to rebinding one VMA per job.
> 
> I only hooked it into xe_vm_validate_rebind() like you said. The
> preempt rebind worker for LR VMs still calls xe_vm_rebind() directly. I
> left that alone since it's not the path I can reproduce but I'm happy to
> add it there too if you want it covered.
> 
> Thanks for offering to take the error injection and IGT test on your
> side. Also I'm not on the Intel CI allowlist which means CI won't run on
> this one until someone hits retest. Would you mind kicking it off?
> 
> Changes in v2:
> - Fall back to per-VMA rebinds in xe_vm_validate_rebind() instead of
>   switching the op array to kvmalloc (Matt)
> - Link to v1: https://lore.kernel.org/r/6ad8027c.7f7fe2b9.10c6e4.4073@mx.google.com
> 
>  drivers/gpu/drm/xe/xe_vm.c | 49 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 99e42bd29..3cbb305b8 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -370,6 +370,8 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
>  	return 0;
>  }
>  
> +static int xe_vm_rebind_iterative(struct xe_vm *vm);
> +
>  /**
>   * xe_vm_validate_rebind() - Validate buffer objects and rebind vmas
>   * @vm: The vm for which we are rebinding.
> @@ -397,6 +399,8 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
>  			return ret;
>  
>  		ret = xe_vm_rebind(vm, false);
> +		if (ret == -ENOBUFS || ret == -ENOMEM)
> +			ret = xe_vm_rebind_iterative(vm);
>  		if (ret)
>  			return ret;
>  	} while (!list_empty(&vm->gpuvm.evict.list));
> @@ -856,6 +860,51 @@ int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
>  	return err;
>  }
>  
> +static int xe_vm_rebind_iterative(struct xe_vm *vm)
> +{
> +	struct dma_fence *fence;
> +	struct xe_vma *vma, *next;
> +	struct xe_vma_ops vops;
> +	struct xe_vma_op *op, *next_op;
> +	int err = 0, i;
> +
> +	lockdep_assert_held(&vm->lock);
> +	xe_vm_assert_held(vm);
> +
> +	list_for_each_entry_safe(vma, next, &vm->rebind_list,
> +				 combined_links.rebind) {
> +		xe_vma_ops_init(&vops, vm, NULL, NULL, 0);
> +		for (i = 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
> +			vops.pt_update_ops[i].wait_vm_bookkeep = true;
> +
> +		trace_xe_vma_rebind_exec(vma);
> +
> +		err = xe_vm_ops_add_rebind(&vops, vma, vma->tile_present);
> +		if (!err)
> +			err = xe_vma_ops_alloc(&vops, false);
> +		if (!err) {
> +			fence = ops_execute(vm, &vops);
> +			if (IS_ERR(fence)) {
> +				err = PTR_ERR(fence);
> +			} else {
> +				dma_fence_put(fence);
> +				list_del_init(&vma->combined_links.rebind);
> +			}
> +		}
> +
> +		list_for_each_entry_safe(op, next_op, &vops.list, link) {
> +			list_del(&op->link);
> +			kfree(op);
> +		}
> +		xe_vma_ops_fini(&vops);
> +
> +		if (err)
> +			break;
> +	}
> +
> +	return err;
> +}
> +
>  struct dma_fence *xe_vma_rebind(struct xe_vm *vm, struct xe_vma *vma, u8 tile_mask)
>  {
>  	struct dma_fence *fence = NULL;
> 
> base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
