Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92151C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6A010EAFA;
	Mon, 31 Aug 2026 20:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b247uYEe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8511A10EAF7;
 Mon, 31 Aug 2026 20:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788209017; x=1819745017;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Hqmm50pLxjbfU0t3l8B5pmSVd096syss+WGKJcQJUKM=;
 b=b247uYEeLX4zb/xUuWkACEdJRSTyqgJsMthzWqqDoDtkEGujA7eKYcLu
 XCMIrVEG86zcyde5Kmy+uwCAkmHxrw0MAD21eWJYY86xWwEVS+N9JezZj
 IvH4yGCdNeJOkAPJhbfOaAeOQd4RSPYowtL6JN3MY0r9fiBylL1Y+HElm
 3eqaqcBdMP/h/qI90mT4it5eNr5M+FTZa3mBvacWRz7sGdEOwPjjAiHDl
 yFvUFGog/GeV1VtfcIWI+NL/pl2TSXYQ0ERF9vCpt9tVSIkQE8IDBKwdO
 tBblR+0WoelMAX5PJcSaFvL901d4OrCZwsfe76Su8iIjuezq5msKYcwbJ w==;
X-CSE-ConnectionGUID: xfZ4oNZoTCCXB7PQj3bw9A==
X-CSE-MsgGUID: YiohwXg3Q+S3Tb6ykfhmJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106147002"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="106147002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:43:37 -0700
X-CSE-ConnectionGUID: SezkmBk6Ttu+vc/dx3Tg8g==
X-CSE-MsgGUID: GyJHjRk2TqW8qqK4C+4O4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="267092854"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:43:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:43:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 13:43:36 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dljrm6BP7SB7XdYRnyYaxJ5/N4MxsE34/GZkr7BL8dC67tiC5ISn8cGeHnqvV1Daxli8rdrLNkyz2vGJ3TwKpOVWdgjHEp/TrHvXB9to/B8stp3SmK89I5aeXoGdaV8f/rMLMZ7/LOoWYjBLFiXvRqwTcF4qyeJCZEIdsK2DhlNvN/rVdz0EaDpGgc8iDUwbnsnUNOlcOlQAxxrzu4yXc5bb8ODGVTVyqQkmrsiHoHw0eelUNIa6ugUOZdbb+mPWRAGNPRk2BGbTbXTmpRrPp8Viso4gcvxamH/GHNHMR5tx+wNrYT4mhCTfxVE4lSpHFLMW2j0suNc8zLwrl/UzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFzEUbSDjG6GWF5PsFU1qTQ4N3c8oGU2qRfQ6AXfspI=;
 b=Qdt38L4BBU/Kl8iBLWJ4n2UwlsggN+/6p2SOIGfPxeHPEW0V1cq8VyIQE6ZWKPGGKBJOluwrJWl4nQWQJCDKfWhgVdKD3VE7rasbTt2GDlnJowc3pZR9PwmddCGcnxGKT7TqpqI+J/6WMkIDwEQGW9pdFlOCBN7NdVtEQ3JPxwgbpG3/a68mpzQcfIYFVRsycNOaKw77sbA491Y9bZlITWfpey22G8cp2sUsFxBranwfkmdZBGaTJeemp6qBkXW4mbjfHy9hOQnWnjJnT5YXNv4pyHrJqxd12EHmILLom0p6L40cdE9jukUGRHLyrlu00aIN/UEw9kja7p+mD5xMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:43:33 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 20:43:32 +0000
Date: Mon, 31 Aug 2026 16:43:27 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 03/13] drm/xe: Drop queued page faults when device I/O is
 blocked
Message-ID: <apXnb3_WmpYhPeUo@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-4-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827101801.1247654-4-arvind.yadav@intel.com>
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 21483956-c450-4eab-1b63-08df07a08583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: diWLFYMLTK2awIotpItpu4WXZiwS0sgv1k063MF5U1LJif0P2/p4BMKfxVe1FbREDgQv+ikDfejNXE+ZFQLernybZVOeQyRS24FJXm+zIzpLN2h4WALt8oBLbnpDrQaYXLcAwelh55vK30bcqPo8v0yuTDXJeQHuGTas6TZ9fEPilWlJd4LiE8rFgrRcfc9GXkCgidhpIU3OST+L9sSpYadIKb85u81D697zqYB7yIsZBChJ3kZPxNLWJFG6DAHEXIVkKh8eSUdr1yMyZ5/1yrENguvIVjEYfW9fcLgq8yea9IVODEErdNLZp/HUIscso600E9ucy5F/tm7+L0ZXPuMzPPMDkKpDcqyg5N8oF/miW+NDyGgMoRNgizI8d414mlCFNUZLAKAmk2Ezs9cKJkrm/FTd4Fw8P2nse8RmAEBBTLf5V77PjI7ydCEssvovyEJZEW1Np7I4HqYDbfXREJ3QrZM92YXbJFIZNN0LRjHcIp4sOdkE0qBYj9159++buFuugdWsNDCPMA1/g2Ua0j4GKEeykHdM9975fAI6wmATD3kKBQLaEwnRb7H9m6NdFeUufFZQNxsG0HZPuTXp6k/F1ZGIoLRQYl+ZhIf3nMRNI43RiS4wdyQ9J0dByFPpCwiDBPj2qxZMdZKwfQKSX56WZP2ZxnluppbnAwXn8Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BpWzPZ2Vc3Uxb2f6GKR0QEnkr3eHgptdmceatvJnHZuHB67zovsnqQbOC6?=
 =?iso-8859-1?Q?4qlJbWSFjAAiOjV+YKjn5JiYQAPKGPiHI4ktO1sA6etab2l3d7z7wLQ4/R?=
 =?iso-8859-1?Q?AUyYRAPzft7b/lYmJ9YaMUwZFCcHpZyl8jL38j5alaxVtvFIGkVg3SQQnU?=
 =?iso-8859-1?Q?RydGjTGnqu12c1v5Yq31ZlMoMmBU/uKiSLcVlIfu8TUl65ig6G5P14Caw/?=
 =?iso-8859-1?Q?z8vsqRRr1iP7k4UliXXKKZCRgCtsgVCVWJvJ+oErEnxERGXXLGdQPJtDXo?=
 =?iso-8859-1?Q?oEHdBF5XbMRo1FlZ6e2CRmHqLYK9+jHfxIXCLO91rXE2O/0q5URY+7941/?=
 =?iso-8859-1?Q?0SRSl4cPa3jY3lyQkq70QaXlD6habrFd2LcjsZKmNGYkpqJIG4p9hUUix7?=
 =?iso-8859-1?Q?dTeysSaggh9S3Kg0MEP+MOYs1jGtWlXR81dASrhGHL1LBBt5S6UwTLyWbe?=
 =?iso-8859-1?Q?eaabhyMhMT6Kt0t30IeZM0I9h+95mKY/UjjxsiSR0SOPKY5djeQKcgw2o9?=
 =?iso-8859-1?Q?kPK3QQ8gVHq15c5G3RgbD+TPUtQpHXvqHIEP7ehRStnQ1FClwVSNmN97pT?=
 =?iso-8859-1?Q?Zt1QYV0kMbM9OMOhjZ8Lj9PEGbSmJ6/QDJjtUT/2cYAiMBiTepykqk8KX/?=
 =?iso-8859-1?Q?RaJhs6zRRi4NbsJaxmbTe5aEiD5KsCO6tdqjcgstrqq/BHleqoq0eMSL3U?=
 =?iso-8859-1?Q?lz1hCocD95/di0nsE2Dh9UsUnz2DA9x5usp0GArtwFrBOurp8/+cSOO7RO?=
 =?iso-8859-1?Q?LTOQYjgoY0PDUp+6dGGHlTZ4OWUU/xA00i6mrRYD9hlXJUbvxeaBnY4Nu5?=
 =?iso-8859-1?Q?EqhXyw9r9g802yxrqYjeh2s4GK1YXc9MXm2A04/peVJEdWUBrkdzCeJvde?=
 =?iso-8859-1?Q?BQhZPI49ZC26vJHMXpsJryEIbtnk2AJNzdiFy/yA6INdFo1oS7VcI1jGjS?=
 =?iso-8859-1?Q?JvSS3T5zo/fcBm94kwBJlPfh4tGr34qO9/E+tgyGxbwN5aEhXyzvmhv4Th?=
 =?iso-8859-1?Q?0sswBSsNZtnSRKnoNeu9BIqzHZnZ6QbAHX6XTlfuO3uoi5xU4s3VmBPxMT?=
 =?iso-8859-1?Q?bz2T+usRLMlxYtTLduwgMtUML4+xMlTh0ay94npaJNBK8uTZT07c++1hlB?=
 =?iso-8859-1?Q?EjSIqI1zgx5E5b10gw3+BNLzdBYYDbC9K8PtR2BiFMgLQG9SlzHO1O0SIO?=
 =?iso-8859-1?Q?6+ubCf7j+LVm1+op7ImAQNKUMxLrnA3vcrcZwxxPDB2eNGTGZt/Xrg89Vm?=
 =?iso-8859-1?Q?6gh0Foj1mYV5De2Wq1kgypE5yEQhpbF6F9/cN8jyvjazo+tsjuLbVnD+JA?=
 =?iso-8859-1?Q?42dbppaDhAi4XJcjFcn3LPUOZ2qvfOfRw51Rrjmb8UVurhSjapjg4OuN+w?=
 =?iso-8859-1?Q?lncJCfjB0knyGYUg89jktnL7/Wxg0JExd8JZg0IOhLKG3MNOxEvD6qjy3b?=
 =?iso-8859-1?Q?mmXUrvo7fZyM3TiT3Wy5uZy84Jt0M4wPwDyLPbBpKAYxGFSdcvZr/BysTQ?=
 =?iso-8859-1?Q?CjB+5YW42tjei56+uswAVaVxxxwUupO3/GqfIksCWKwWRmlKP1DJ1FSwAj?=
 =?iso-8859-1?Q?3VWU5lSHuAYLLSdr0YR0p25m7uxBdFcyvwykdKqXLDuKmki11Ovbojs62J?=
 =?iso-8859-1?Q?d/fUOJg774dgQ5eKvAglhO29Eik2U0kM0fH+FTMGLGgJSwG9dNQd/Or1l1?=
 =?iso-8859-1?Q?Dfv0WGo7Ft5XP+qjIyF/24BoVkQDJDyHqs+0pGIJzv8pQW0wbhF6/taDWQ?=
 =?iso-8859-1?Q?veZyup2/iJNjbAlBSoNddNOWsnd5/1ngzgG/0o59iMF8Hqt+6fEvtuas5Z?=
 =?iso-8859-1?Q?dxKNGqtIeA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 30bAK/Gw0lK34wahut83uvkRq5/ofciqajamBPrq91WTIbqFLryx/TgM7ijSMRwj7GGTWj5qeCuXh+fru6CVVC5Yufwop9Pmo3vkPNYCBQioLvJvizXdfGTL2wCs8oqsccT5UE7LJTqxwQm4JJlXwQuVd6Bpl8QYD4oi699GPibUKSF3T+mUPDDBHOn2ve5fxO0DzTpjZ3PjYxWU4v+iXv5yuTCdGvdbt/927ngpiO9u9byq+jqLq/yVyNzZ4qM4mUz4yeo3HNCygXGD20GVW+PIYyzQdufwCPaJEi9y97andwIwF75vemzJ8mL9MiajyVzMf9MVV1CrWy1r7vfA7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21483956-c450-4eab-1b63-08df07a08583
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:43:32.8488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ell8D7gZbfHmkqU5aM7+KtAjLAUpZW8fcsqnWFI4nRW562Je4WxMbOHRLxsYnCBvTo8/vx8IKRLqssIcY2Z1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
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

On Thu, Aug 27, 2026 at 03:47:51PM +0530, Arvind Yadav wrote:
> Page-fault work may still be queued when PCI error recovery starts or
> the device becomes permanently wedged. Servicing these faults can migrate
> memory or update page tables after device I/O has been blocked.
> 
> Check the device state before and after fault servicing to cover a reset
> racing with the worker. Drop the active fault and its chained faults
> without sending a hardware response, and invalidate the cached fault
> state.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pagefault.c | 40 +++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index 2e415995f067..f486165f2323 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -592,6 +592,38 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
>  	xe_vm_put(vm);
>  }
>  
> +static bool
> +xe_pagefault_drop_if_blocked(struct xe_pagefault_queue *pf_queue,
> +			     struct xe_pagefault_work *pf_work,
> +			     struct xe_pagefault *pf,
> +			     u64 *cache_start)
> +{
> +	struct xe_pagefault *next;
> +
> +	if (!xe_device_io_blocked(pf_work->xe))
> +		return false;
> +
> +	/*
> +	 * cache_start is private to this worker invocation. pf_work->cache is
> +	 * shared with fault producers and must be invalidated under the queue
> +	 * lock.
> +	 */
> +	xe_pagefault_cache_start_invalidate(*cache_start);
> +
> +	guard(spinlock_irq)(&pf_queue->lock);
> +
> +	xe_pagefault_cache_invalidate(pf_queue, pf_work);
> +
> +	while (pf) {
> +		next = pf->consumer.next;
> +		pf->consumer.next = NULL;
> +		pf->consumer.alloc_state = XE_PAGEFAULT_ALLOC_STATE_FREE;
> +		pf = next;

is there some helper we could re-use? I know we cannot use the pop directly,
because it would deadlock, but perhaps we can unify some code here...

> +	}
> +
> +	return true;
> +}
> +
>  static void xe_pagefault_queue_work(struct work_struct *w)
>  {
>  	struct xe_pagefault_work *pf_work =
> @@ -615,6 +647,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>  		int err = 0;
>  		bool invalidated = false;
>  
> +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
> +						 &cache_start))
> +			continue;

do we really need to loop inside the loop or only check and let this main loop goes?

> +
>  		/* Last fault same address, ack immediately */
>  		if (xe_pagefault_match(pf, cache_start, cache_end, cache_asid)) {
>  			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
> @@ -623,6 +659,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>  
>  		err = xe_pagefault_service(pf);
>  
> +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
> +						 &cache_start))

do we really need to check after?

> +			continue;
> +
>  		if (err) {

now this err far from where it is collected is pretty bad...

>  			if (!(pf->consumer.access_type & XE_PAGEFAULT_ACCESS_PREFETCH)) {
>  				xe_pagefault_save_to_vm(gt_to_xe(gt), pf);
> -- 
> 2.43.0
> 
