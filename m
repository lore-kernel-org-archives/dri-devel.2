Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE97C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E2810E12C;
	Fri, 18 Sep 2026 22:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qq2H8P4L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8076D10E12C
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789769734; x=1821305734;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5uDRHWV2vpQX5IsyfFvPNzhgjcqmzBKq1oJp+gNiF9s=;
 b=Qq2H8P4Lx1wpUaMGVY5dRw29kQOUAeZVt663tsiQ6yj87m3QvBgb+cz6
 cys6bSlGzds9zkB9Urg9mZJpf+EoY7s8czAhTF3QgvRKQ6RjVzDgQvc4f
 9l0UjGWlKYS+/9r/ChrO20PxFya0++FaG3+YheuyBfnKev4vhKAA8VZJd
 Obl/2eQ2ZrBshdZ0dWeL+48Mdpn9eVZbn90QuLtk7uxYQsDV5iGHqM9pb
 XDI+10Y1cRFGis1HV87N6DhULdkoybg/Zt1eg3YHdMPDD/sn9mfntK7+P
 nbLBVDfMLoT8gm83dCX0X4SV0ZqhwnPpx44UtAqaU2Fh7v1cId16kwwWm A==;
X-CSE-ConnectionGUID: Vyygd8qATfCFLoxAf7o3pw==
X-CSE-MsgGUID: k50GfMFuTOicufFb7/MYPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90435272"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="90435272"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:15:34 -0700
X-CSE-ConnectionGUID: bDRnm1nmSmmRKC9wUi9i+Q==
X-CSE-MsgGUID: DxXzqVouT0i+dbTM5Ki+fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270317086"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:15:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:15:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 15:15:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLsT4YuScMUIbbB5Lg4+Fi3/KdHU+jLyeTiXPLDxsw6k7KA94kq4BbrGOBiz5837d5mQf3/gggDOgShQggQbSQFOg3fw49speWwK8YZqgjjq1TmBwIqv5xS9BlIabntzId4xQZNoznNRSE28tuAIZWq4uKKrJqXaWWyqwzL0Ef6taABlN2K5oBb+XoXEzTFBSi3OAyXI1E0wRN0ydFZfHGQm01MkABYHkfCwDvDmd7BQrkVlenemnSNkDZY7JdECJB6XQD5JuBhNAI99h0O838fXujEUmCQWvA6ZNK5qSxP71Clc3pjb1h5eYhpjrawdwmalOWy463z7JFreXyF2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZVeQDi6IHUejLtQKlhtua+rKymJrkJo8+ULr0ymQBA=;
 b=SWI0zTXgCM074aI7jnR0WCt/C+Wb41iY3mLKE5zPf6ndXyjb4MpdaxkR1bLoQyP69/HHEyRuqZ1JdOGvTosrSlce+e+cchFI4+EUfSuLYEqbIa1sx/r07Ze5TiiuuEZevsUKy4k8hYTtwLx4TdrLAIOsxBncOGzBTHzcBAxyhvjjTI7ecWTKFFCBISWlS7E0/JYNsRxbHfgZVENorcYUTbpw1JrXmENrB6eU56TK8F78w16FsshbMjv2xIFYBVlUrSA0ryEGrnGJ2j38/9X9a5Uv3jzCGHSw6RZ6GkaoncQbcU5mKq09v/v5/TLdqNdYFuqzzE7dC4A5Rw6n24Xb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA3PR11MB245380.namprd11.prod.outlook.com (2603:10b6:806:52d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 22:15:23 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 22:15:22 +0000
Date: Fri, 18 Sep 2026 15:15:20 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Varun Gupta <varun.gupta@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <arvind.yadav@intel.com>, <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v2] drm/pagemap: Prevent CPU stalls during unbounded
 pagemap teardown
Message-ID: <aq23+Efl++F++ako@gsse-cloud1.jf.intel.com>
References: <20260918081320.30389-2-varun.gupta@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918081320.30389-2-varun.gupta@intel.com>
X-ClientProxiedBy: MW4PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:303:87::32) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA3PR11MB245380:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2b61be-cb34-4761-5bce-08df15d2553e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: gOL5xbEuPldykUuc2fsh3p5sWWYkmXFVyGLjPTs71bBR8MH9s+BUvGpwk57Zsm4wEe1j9Xrh+UZC7Coc3FfTO7gnNaqeyM+ctslme8fTLp8pQxWnoIzDH3jAa3Y5t6Z+6kSECgo3LGiinmbtyeVqZmiHKxNRkfkNBdvlkU/11sJj+jY6A8/IfUx18dbLMWrhk9Bt/9ypr5XvEBfqgW9ACYduswpGEgj0K3gxj0RJZjobQTMyXWpjtFMTdj+I9wU1H76bteVt8qB1RFQRpjcO1F6ho12MIJogkcPWCsfjyCi2dPbnqBmCj9EC1fypzUUtvVKxzCs7YbdBTcGSNc3t1T7PF2sDzcntHdv2qibDIJ7KjAuwc9K7jDhPr8vo/BTkzI6fiOo0luVgQmUbxwD4UoB2CVBYOMzN4pLqKKU/6iYgcJHUwppE9s7izsee2QhCY4mzdaPDklO2ZQk82qyfs1Te5bQZI2RBsCddxDqUn0ylbpzI+nXedJB2m4+x1h4l8TTzLkTjbFa9wnE8I8csNI2pxgu7xNC9zPcrxCa5KQAWOYf9uqtNT87a0LWjVcvvCngFLFYK+jAU/UPe1MPUnLNmA+JWnswazpPB4F11IjocxxnsmSNYkFiNuhSRjsfI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uHyDWLt1DqUXcX8ejQX1AgVYgi60ToG6kgeXup+oovAwB+DkLeHOylx0k0?=
 =?iso-8859-1?Q?aqH6yMz++my3ySDVhpEaJMARAbOpL7HcCWln9GOqGtOkcx/pragui6o8mX?=
 =?iso-8859-1?Q?5jUxDBjucBTRwX6IA2QxJucs0DTisT4/CrcWx8jDt53KHL4ECMjU58Rmi8?=
 =?iso-8859-1?Q?ADTxMWNEBdurj4Hr4gyInA+PhFtp0htiKUjXvUYoliw592Y57Hkzyg/XZf?=
 =?iso-8859-1?Q?mIIc8/uDYjnIbK851kmceEHSWBviP/YUNnrUtOZVzrrU4R2N7xn+QdLyj2?=
 =?iso-8859-1?Q?GmqXYBILPwE88Sl8sBYuMvHFez8x1wd0wD4yGvaBiAS7XO6dIz3D9RqRfN?=
 =?iso-8859-1?Q?ayjJ6pRQvDm7EC7nB/3j8htnMrMvhZO/yC8fQv9aQyhcJwGYU8oJdA4nUa?=
 =?iso-8859-1?Q?yiEiIkISJVLluuuYaaMYRQVtoMsshBcXf8JCg0ZpJBtgO19t4ivN5CyCRr?=
 =?iso-8859-1?Q?QFsynRFOvvfKF7j5RqVVFPFhFoWCn5sHmC5Q2JUDARGLMb92bgpmb1d40W?=
 =?iso-8859-1?Q?QU5fpZi1LdWQexyDgJc/lrwFMDI7TiemJe0mTwBSUfg8zHAN2ErGGuM2Up?=
 =?iso-8859-1?Q?uLIV+1B4aqqouZM+0AakbJbxJi4sFmA5psmrVaBpnFp/Iiv5Ua2Iq5m6Zt?=
 =?iso-8859-1?Q?OS2qhegD6smJtnZdICkgdbmZ5sBEkOZxxHeNiPV2UMzvX2Xt2f9v1O47V5?=
 =?iso-8859-1?Q?Y4P+LLBVtsiNJoyJKuYEWAf4OuyjCY4TFAkzD6KYGCV8BwxHyNJ8KZfcDa?=
 =?iso-8859-1?Q?15MZn42u6bxDlzcQR0zgFHllDrxvijCYT4SmNH/0mAxRveCnl31U64glSG?=
 =?iso-8859-1?Q?knTTXyTeIwsOLpMsYHKbehETsd03TgwZVYJeEOCwRno2g5FgN4CyNoWf/A?=
 =?iso-8859-1?Q?vK3MdaSmeRbbNDnOUlvcszKKUUyzeQ7+mwYLrnwa/Z8YMnBg3DyCMMk59R?=
 =?iso-8859-1?Q?EyrweF7sYlcOIiPXNaOklY2dL7BgeSB8GUAyv2tvNueJr5cS3rUiGwM0fw?=
 =?iso-8859-1?Q?6NZLFucgas1LVK0LFJFErGpGsTtt4IMqHqZfDLWoSpqriCyQbXrt2T4Q0Q?=
 =?iso-8859-1?Q?q+d1numx3zwvUZtX68trROYLJnipesH1l7fClX15xOI8PSC3QK8YGlX1ko?=
 =?iso-8859-1?Q?xGCuOLdGe+nn+EVR3KQv7cUzRsS9nxEss7HXEkS0B2sezk64n23dNiI9RG?=
 =?iso-8859-1?Q?uLWqF2GOCOu19ISq1sY52H9oI6PuqP/Ru5gxUWA02LVdtYbYBuW4CURNY7?=
 =?iso-8859-1?Q?B2I3vAoC2QBnzRvtAjaoY5J/9S/2BdQIj/QEPBik7cXeIZa/0T89ZmpYu4?=
 =?iso-8859-1?Q?hzqXhj9W9YD+aWiznh9jJjZbYKjdOxR6inPummoEFqTxR2dACqEH/8Zncj?=
 =?iso-8859-1?Q?o6yn3BR5FF8qnt9EFUQbQ0JWjvxGZhNBIyvc9Pyp4gFwIpmLvcRLZzmebf?=
 =?iso-8859-1?Q?xGO/cZuXzdwDOjL9YTI4+AI5n9jxpymt390G1x3KW48iMp12UBQngy5qRj?=
 =?iso-8859-1?Q?ODInGnLnxX3aPbNyje6tvsBfu+H+lyLLfrZ6YBB7ZlnQzoQnzCtZh5onuW?=
 =?iso-8859-1?Q?q6x+G3ZkWulLEo7EbS1HwOTqaXnxPse38+/crizOqnbKOJx3DtHGsU92Gm?=
 =?iso-8859-1?Q?+AqqspdOMHaZjl+P3d07ys0k4MVIK2VZOztU7lsZdC+GeCiaG7Gshy1EGY?=
 =?iso-8859-1?Q?zPBmXLZLbDh250Y+JvNZPHgqGyd5EIuYPFdjy9tM/Li7+fQXhoSu2Xa2yx?=
 =?iso-8859-1?Q?zp0hEpxWCNxZU0NVINFQedAlIC3A8L2AoMyu5Z2Qj0evA3rfSmIGzt9ELG?=
 =?iso-8859-1?Q?ZGYKrthcC1kB/UTrKc4rGhHsuss28no=3D?=
X-Exchange-RoutingPolicyChecked: 4Nd7RNazl6mRyRUCTiL3FM4I7XIiPho3MdYUnXitqZ62ZiUU+UmfqafrLcHv5/Omb/OtIne5lIu2jQT6cN0TZISnHXramyJKvBf5j0+M2c/TkcT2FWxKOXA3OOe1stI3m5Lamfl6sbsWnN9NZHRM2NFVLyRQgKuGWhACa3ZTtPRr1m/i7mDWacAE1GyVZv+qohqinIMbFLK8zzSMxFZ9AmPqOPF2jvy95Wi96XsBxIlvY9d2OaQMqFHZ8HnBVTRpyJ+350sT1uAplVgS7LOkn3l98oSeuM7EZYMeXIRVjLH3UdZM19gL7446+lxNEyGirJFKabugw41EyKDNzoZfvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2b61be-cb34-4761-5bce-08df15d2553e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 22:15:22.8850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx1ByLhwXC1Sgcqz//xe12O8NJtWbbZH+oioB/jXNMpmQvMt0l+ZnnILzk68FB6otjv5OAFTp9BJh1LXD5uX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB245380
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Sep 18, 2026 at 01:43:21PM +0530, Varun Gupta wrote:
> drm_pagemap_dev_unhold_work() processes an unbatched llist of pagemaps
> on the system workqueue. This creates potential latency traps during
> heavy teardown cycles due to two compounding factors:
> 
> 1. The loop contains a per-item drm_dbg() trace. If dynamic debug is
> enabled on a slow serial console, synchronous print latency scales
> linearly with the batch size and can block worker execution.
> 2. The llist can accumulate large batches during intensive unmap
> operations, monopolizing worker resources without yielding.
> 
> This causes below log warning:
> "workqueue: drm_pagemap_dev_unhold_work [drm_gpusvm_helper] hogged CPU
> for >10000us 19 times, consider switching to WQ_UNBOUND"
> 
> Fix this by implementing a latency mitigation strategy:
> - Move the teardown work to system_unbound_wq to avoid tying up
>   per-CPU bound worker pools.
> - Add cond_resched() inside the teardown loop to yield the CPU during
>   large batch teardowns, ensuring system responsiveness.
> - Convert the drm_dbg() trace to drm_dbg_ratelimited() to mitigate
>   serial console bottlenecks while preserving debuggability.
> 
> v2:
>   - Changed workqueue from deprecated system_unbound_wq to system_dfl_wq.
>     (Arvind Yadav)
> 
> Fixes: a26084328ac4 ("drm/pagemap, drm/xe: Manage drm_pagemap provider lifetimes")
> Reviewed-by: Arvind Yadav <arvind.yadav@intel.com>
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Varun Gupta <varun.gupta@intel.com>

Did this patch break our CI [1] [2]? Varun can you take a look at a
follow up or work with CI so this isn't flagged?

Thanks,
Matt

[1] https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-174512v1/bat-bmg-2/igt@xe_exec_fault_mode@twice-basic.html
[2] https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-174512v1/bat-bmg-vm/igt@xe_exec_system_allocator@many-execqueues-free.html

> ---
>  drivers/gpu/drm/drm_pagemap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b..0867bfbde5c5 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -986,7 +986,7 @@ static void drm_pagemap_release(struct kref *ref)
>  	dpagemap->dev_hold = NULL;
>  	drm_pagemap_shrinker_add(dpagemap);
>  	llist_add(&dev_hold->link, &drm_pagemap_unhold_list);
> -	schedule_work(&drm_pagemap_work);
> +	queue_work(system_dfl_wq, &drm_pagemap_work);
>  	/*
>  	 * Here, either the provider device is still alive, since if called from
>  	 * page_free(), the caller is holding a reference on the dev_pagemap,
> @@ -1009,10 +1009,11 @@ static void drm_pagemap_dev_unhold_work(struct work_struct *work)
>  		struct drm_device *drm = dev_hold->drm;
>  		struct module *module = drm->driver->fops->owner;
>  
> -		drm_dbg(drm, "Releasing reference on provider device and module.\n");
> +		drm_dbg_ratelimited(drm, "Releasing reference on provider device and module.\n");
>  		drm_dev_put(drm);
>  		module_put(module);
>  		kfree(dev_hold);
> +		cond_resched();
>  	}
>  }
>  
> -- 
> 2.43.0
> 
