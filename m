Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C00C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E3710EB71;
	Tue, 21 Jul 2026 21:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ataeivfp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7204310EB6A;
 Tue, 21 Jul 2026 21:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784668030; x=1816204030;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/XzaQGI1589i3bnzf9AIhXkRkpJnhgW+8b7k5Yeem0Y=;
 b=ataeivfptKhMdfPIXnfevznWC2Snkx/sbuQY0vRVTPYe8BilY7D4Dnmj
 2T3JqifybvZ29c1VW/pY0TgH1ss/n1zzrto/5PDJRcn8J1hQ9grkqZu7C
 tDyOikxVJycRQP8+kp3ROAx5NFC+Zyz29CA3M2sytH14otydl7MFL3wRf
 S/bGYVtGRti+OVfeVHQ+OOtkR1Z7oKH5sRmkQ3z8TW+g3UFv5nEMMrKmL
 KtZ4d7kBaZWR/N1J6KwkWv1bFDXxMhx2ip0WwRt7mKxk7BqWak/VBP4bh
 mqn3iiC5gyexoPpoiI4HGIyziGQ6OB3a+LwtabjOCi0El0VBDxcenhIw2 Q==;
X-CSE-ConnectionGUID: XDWgFqllTSOoRqqmV1esWg==
X-CSE-MsgGUID: 1RhLqkAcQaqJFEFBcldWJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95877973"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="95877973"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 14:07:10 -0700
X-CSE-ConnectionGUID: NhOgJbRJQvS08DFfiC6iLA==
X-CSE-MsgGUID: XRcKTYnSRKiJQE9nnT/9IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="281154194"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 14:07:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 14:07:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 14:07:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 14:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpjqx4IAkO3MQJIS6gpGGO4RXibxcpvS4gwvyXjhJHCKH6f8sxmhE5Bm2RY4v0Bqh7ZH6Ibkx0+Q78ZOEojXpOraxWV4myT5j9VtAi6dttueI5URk7lm7SL3s8utN2Pva3w1Yvp7Vb/tTWTowUwu7QuLCI8YnhN2iZbD9OinWtCkzQT/Xdv8ShcU9vQpwffmHdljkBdQaDMU0KeO2mRjI2RdOFwHYLIoUioMaVkY441lFqM4Mnyp981TVCZTkDp7wIceXEt8Bq46gxQDShgWIwI0POBFcYnTIUxAweNpChYbZg8dXgoxUxGCGwVfQ0u8a/ZwMW9Xzfq40R354r8umA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F2qDvz+y5PGEmS/o+gEUjtT+zfJSX+ETs6WHhCub0s=;
 b=XuFWsKX6gm3erSqJJKDssVPfgMgr/hTkDdehEh/wlh8t3+E+StA1GRmg5eBuVyMS5zSjCGh5xdm9TsIf3rB+q+IetpHNPWloqniBHlTXwxF6Big0/KdBg8HKf890bujmjmBtSBVNBOOmDUU/7n+316kWJ8+wrKJD7BYBvhTRfwlcM35AcsTfcE/aRhWsA/HPndLjS9+G+HO4Nyeoj0rabsmTvUTLycxVyRVHWkboqrBzks4emssZzDNLKLJlwSd+Ip+4kBbjugkPMio4BP2xekQwzFIr4pLtMuwbjSuT4WELi8W8oMuLossX6w+INArSoFF7j5NWOrokCuBXPVGIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 21:07:07 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:07:07 +0000
Date: Tue, 21 Jul 2026 14:07:04 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <thomas.hellstrom@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/gpusvm: Zero HMM PFNs before scanning ranges
Message-ID: <al/feFGbWb+vn+SZ@gsse-cloud1.jf.intel.com>
References: <178465137297.1335238.13264315601290244705.stgit@skinsburskii>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178465137297.1335238.13264315601290244705.stgit@skinsburskii>
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA2PR11MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcc6f63-cd5f-4410-2c35-08dee76c059b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EzUiiW+QcjO5GE2sP2lKkIZjUlJs4O08w9mxc6HelOg52cg39WlGVN5IcilyqjLypnMLp7ktHcdrPOo8Zk6W3swvaRi4bi9CsfvW13M2GV0p8Tp6AtkZvDeoIysfHXTVF3ipi9i7EsxyZXlpHJ73GGwpDph/ORsZXoLSAF0+OnlZEboI9V2x6ThgE/ojKqOSErGkm+PNRm9dW/s+MRmLXBYttLwCS1BBqfK3Bkb5Zz1rLGHoQo0Zx+xf2HfgC4mlQ5AUTSq2H8qWyFMqGV5kDzIAKsTby2fFL5v5v1qV/AsaEn4T5wgxthavuy5UFhfw9fUlWC/puH8mRDlwwU1ei6whQTuGlbyzsvXi+MtMpAZ77xu9LjE6Smltfv2Qns4aQzw8ej/kW8zBZQJIY7DbxG0FzXm+1X2StTMmyshPGUsFFUNYlAJxSH1H2Fn9/0FMNX0rgPVm4ZbWn5wHyNoE2CdP7V4RAooo6Bzd7mf4cfJ7eL6X3FAUhEczRc+TDFIwmgjmF0lsoDtgZ/nerenbNvmQJ1Bpa3vQhHDxSi5oFEvgLB1ZP+vDDhmMaQyT4lUh/jg+erQcmIrWRmybXj6M/W/g4GueLgcwiepcuhTXnH9kARy5ee4aAjOgW1FRPJJBRH/+yAhg7vXhx8TjqgVevYe5qQpA+ZbIcCYmwRwOxWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pU3hn18Ex+ZhyVUV+JYccO6vJLN0QiAewHmGNBu5Ef3vVrUgzGtFkedNk+v?=
 =?us-ascii?Q?YG1qofbq0LV+ye5ih+6AbRYrbvQ87MmUH44mafCf0UT0KGxgKvylp1mDOZwS?=
 =?us-ascii?Q?sitXFxhWBcxXjEOpXu8ZWc0fdxVsli++dJw07jUpk6Bjw/7xeBiwtl+hclol?=
 =?us-ascii?Q?UnNE7Oz4VzWuDpCbnb8chbFXa+MpambIa5oi1zg8wMDwoYwfVmHflbwquelV?=
 =?us-ascii?Q?iOuIVX+Cdqs57DdiOnDs+tDYXG0QBKVNllgNHfUJF/4pv/UYauc/dApRhXWE?=
 =?us-ascii?Q?BsfCusQ1DKwwSoJ6eAH7qBZu1MVmk43+ANeqB9WLD/mwP239JDIajFl/tkZF?=
 =?us-ascii?Q?p5LgJn0VipQh4sj7a0Ao6hGVbfwENL/8qGp8D13FDnasrvwaTL2vMVDCdShv?=
 =?us-ascii?Q?JGpIIAf+GqPOI3cVqS30VsttLBzdpxrQp6l1fXqsAYfaXfGmW7MC9fLAHDbv?=
 =?us-ascii?Q?DP1alWsr4vIGhzI2JnGjQ8eA+JOgeaI1yGH27LCwMXbxAN6ydgt+/lAECC6l?=
 =?us-ascii?Q?5VtAqUGoKzb8Kz7CxJ3WCad0puWkAqEc3ZRWQoKzldeNPhspfas9MxGEqL2/?=
 =?us-ascii?Q?P0ld0s3uYmmv42bGcr1DJDEHqlgXLrcQxxmeQiWev4neZCBzgIGiRZwffO6q?=
 =?us-ascii?Q?nCujU14yqtbGCt2uYZSsGSrMt31nAAuG62EyjTvb52F2eD7e70CbYrvWRyGg?=
 =?us-ascii?Q?hEdxHKUw79RDYkik9MnOQGHZY6Mf542917ygHv2KKHG9ECnNoQb+BkUed5wE?=
 =?us-ascii?Q?epJ1gLc2fS+dVMsuIAmz6uTAync94628n6Er2ajXHsohCpGYUpGe1HfYS5we?=
 =?us-ascii?Q?ZAzfICtXhbKd9qVjoPgE4cf3rq7hSzLAMZT+VAgZz49Dht2iuaFXGe0S/tDn?=
 =?us-ascii?Q?g2ZS3I/d1d3KMs3L66GVzO2xXsKtyikd64cIWJ89KoJkW+zf6VJZm92DK7Qb?=
 =?us-ascii?Q?oHvNnjIAsnu+W0nhyA3X7mkMW0JVCGkLrJdKP70XSfw5T/UzVcoqV65+VufP?=
 =?us-ascii?Q?QWAiJiIWyubvyRD9x8fRTp9hUqV2v01TlUoN4K47ZWY6QlWPS2fmif7yBZxZ?=
 =?us-ascii?Q?wr4YIYGEToDQlyBwWFbZfsR404/y2iX2CcF7cfNKjtm/9ODLK331VGjvYfKU?=
 =?us-ascii?Q?3V7v6tfkUqt9roVBWND+KJV5DXrUGkt5wbTvGa4ZaCPWneHvRryXHpN/1atd?=
 =?us-ascii?Q?4rxIFATzgwajip1b4gPwbqBfInJaU76L9dZCNv+qT2XNCf15sGWjfgxQInwW?=
 =?us-ascii?Q?G845ZhvCxY0yovzNaHDm6kYBIlPSlg3jipWUsB0zkdoTdXnlxWzZx2zwutkM?=
 =?us-ascii?Q?0f/ZNVbZ6DkKhTE38lNTbYTnPovC0j8tqi0FTSzcVOxnKS2WVPQ5duRnGsGf?=
 =?us-ascii?Q?wkQNTDiBh5D4MoFZLnG65lO6bmybPIHqFmyYY0pfBOO+WQ2RrIsa0A92Smxj?=
 =?us-ascii?Q?eloQDUpJV8okuIRYGxlaFUtHU3fqp9pn1chXey8CUy96fUhy3AIUAyn14ZYc?=
 =?us-ascii?Q?uokDTpvEjAvvxEu20rVZqMDzkVTAe3NN/YqHjoN4/j9igqxNJwORa0zqmWso?=
 =?us-ascii?Q?+u+bGzqxdFXP+1JlbXFpxVv0rS+O8pEk/WFKIz9JYrdRlOBuYcsr9aD0nqHf?=
 =?us-ascii?Q?Vba+BBwdbXjAVe0evPgTHuUqbn4dlKRyS/DgETRpFMftsQrxGW1V/Wc2g0Bq?=
 =?us-ascii?Q?f+LKDRwjCyOZr0EOhMOuL7CU2NwZGuBM+LX8sxPnDMIFn3Q0BPTz+X+dzToK?=
 =?us-ascii?Q?judq/3pgwA=3D=3D?=
X-Exchange-RoutingPolicyChecked: br6/6IIyaXOuMitmT2NICEH6DLYIIUjaZSjF9bPfWDEfLkAn0Z5ubWn+xSGlkbA3/Kyore6iu1mnaeiMvM4QE7yFg9crC6zSo81fdI30YUoUMF8QM03Lyxn4AhnnCbBGw7KzStEqpnSm1aSDjXmRNh0USJUjwrHC4iQu9kX5wiVH2wfw3o7GJD6mDjWqrOZk24NF/RcQM/tCNjIrqOmeEfSbiH1Nh+ugdYoaArg40burwOF8tOu9+XovtkB/eAyF+82SiB0UPy/19k9DYrrrtWAbM0XV3YN4jEjJN/Z0gsC72eD0aV5TeKjQfH7ui2XxgWIE0m6Ub06j5dE8o+e49w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcc6f63-cd5f-4410-2c35-08dee76c059b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:07:07.1977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/ubQbl4PUzfLtKqBylpPhKSVw4fIMCF8vjQH4G9OQpS8ep3FYQQgdxEoPt14ffSayIK7C8MKxfRDRhvFJ+aVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
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

On Tue, Jul 21, 2026 at 09:29:56AM -0700, Stanislav Kinsburskii wrote:
> drm_gpusvm_check_pages() and drm_gpusvm_scan_mm() asks HMM to report the
> current CPU page-table state without faulting missing entries by leaving
> default_flags set to zero. The HMM PFN array is still caller-owned input/output
> state, and the framework may preserve input bits while filling entries. It is
> not safe for the caller to hand HMM an uninitialized array and then treat
> entries without HMM_PFN_VALID as an authoritative unpopulated result.
> 
> Use kvcalloc() for the temporary PFN array so entries that are not
> reported as valid start from the documented zero state. This prevents
> random stack or heap contents from being interpreted as HMM PFN flags or
> PFN values during the scan.
> 
> Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index ca234fd2c491..6ca6e68be5a6 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -708,7 +708,7 @@ static bool drm_gpusvm_check_pages(struct drm_gpusvm *gpusvm,
>  
>  	mmap_assert_locked(gpusvm->mm);
>  
> -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);

This is different offending original patch:

99624bdff867 drm/gpusvm: Add support for GPU Shared Virtual Memory

>  	if (!pfns)
>  		return false;
>  
> @@ -780,7 +780,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
>  	const struct dev_pagemap *other = NULL;
>  	int err, i;
>  
> -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);

Hence I merged your v1 to drm-misc-fixes last night.

Can you repost with just the drm_gpusvm_check_pages fix?

Matt

>  	if (!pfns)
>  		return DRM_GPUSVM_SCAN_UNPOPULATED;
>  
> 
> 
