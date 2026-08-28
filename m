Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFBFC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C8D10E02F;
	Fri, 28 Aug 2026 09:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Uf/Q2SMr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A58E10E02F;
 Fri, 28 Aug 2026 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787910390; x=1819446390;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3GJAWa6aCDaRjirC0gXwr0xpSThoGu8WDLWs/bWUitQ=;
 b=Uf/Q2SMr9ZtyUtHun0wYvC7OhNkYRh6PbXBFn3Gv/IHabn8TgPNWqavz
 rcUhSKnqEK0JvT2jMxiX3DF/XxEe/C8WKOMWViwUZkp1cUNit7Bv3shZD
 aCjcWUko8/7DbrwwVZD1ihY/6gCgdamR7rAh6bZKirMSttT5OzkJ1/gYf
 fo79e793Jlxh+mUYqd7VPfmsw+k70jJBm1VljbfwW4gn7rRG6gTYf8R7V
 98dHRVV5kyUw9eYkUqDMR6/086g3zJVrfZ2iWCHojdsMqTatyqKui8jCh
 /1gb/Tu8/zOrc2FSpkSiA+wrYJFL3tjialT6zIdfe59JdN/JkfwHDATpv g==;
X-CSE-ConnectionGUID: hFvh/wJUQsmLt6HaqR16+Q==
X-CSE-MsgGUID: Z5zxpAptQ+emTL1l/UkDEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99016347"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="99016347"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 02:46:29 -0700
X-CSE-ConnectionGUID: Fe2/O3a/SO2mlm9YoeZE7Q==
X-CSE-MsgGUID: PnLe2diGSQyulcRDJJMutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="264865216"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 02:46:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 02:46:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 02:46:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 02:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OY4TATDsP8fKdSr//GpDM0fO0CH/6baxOqu4jzRx6uppWIeU+Ym0mjIggc7UfunAVttaCXtrFu303IgI8f8A0jlzW3lStp4bnHC/dvknml3vwg2KWahuainhUXmF4OGsQTnYHK98USdXAjwI3Av6ZV06mU89zIk3WHem4wkcc3+GDEpw4mCNv1qW8hXwnuy3xa9vS4aRnU9b+zoO5/YMcczncv+HW7pCGKvdTwv5YJu+FXYX25zEb90l5yUuawoPQSns2WnaNa1+7XzAlv1KmqggoljJz+zNmllmnzQzxRbNNHV6ajseXDuvhJq2ybni5SMID7j8QR1WJI40pixkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S7SSfePSCZ2AzlVc+WK5h6/RaTLLDrbXMmtF2eA2jc=;
 b=e045Ldo2cckaw+mBWaOZeCq8hfBVFQP1+JKD7U3w6CE4gIp4+djhlSo/HLhg1gtiQRC428HLA4b8gdIZ3xNX+jNrHhHc4bVTdxIN2vzfuB2C58qA+9X3pPtUy5z9Y/TaAXCcg0BSnSZl0Ei//O6+I5niiVbwpu2h5rHrpmYELbDAMROCvjC+0kZnTcedenXNHcZh8qQOKZlOM5uf4epnGv5qNDe8GHqz8AWrFNEYXQgVcO+8Aq8OMabt+vleckb9mAjro/Mrn12ynmmUF8h/8rOnrTKCdIqeyKI66/GBLhRwqrjOBW2+BPQzfeGRId9/dqxL5KtsQ+rA1Os1HKZWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA7PR11MB9541.namprd11.prod.outlook.com (2603:10b6:806:4cf::19)
 by IA3PR11MB9181.namprd11.prod.outlook.com (2603:10b6:208:571::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 09:46:25 +0000
Received: from SA7PR11MB9541.namprd11.prod.outlook.com
 ([fe80::3346:c49d:542d:ee6b]) by SA7PR11MB9541.namprd11.prod.outlook.com
 ([fe80::3346:c49d:542d:ee6b%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:46:25 +0000
Date: Fri, 28 Aug 2026 11:46:05 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Junhua Shen <Junhua.Shen@amd.com>
CC: <dri-devel@lists.freedesktop.org>, Matt Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Yiru Ma <Yiru.Ma@amd.com>
Subject: Re: [PATCH] drm/pagemap: centralize migrate src base-page counting
Message-ID: <apFY3QDowfV30Xoc@fdugast-desk>
References: <20260828083652.40855-1-Junhua.Shen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828083652.40855-1-Junhua.Shen@amd.com>
Organization: Intel Corporation
X-ClientProxiedBy: DU7P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::33) To PH8PR11MB9534.namprd11.prod.outlook.com
 (2603:10b6:510:39f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA7PR11MB9541:EE_|IA3PR11MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f3a086-44d5-4ced-59d7-08df04e933ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: W1f18dVxnujJRZxtmE45HZ1eUNvoNDsiFk1Ki3LM+phgo89Lhcz+llywxo/dOh8ILwANs/ID43QFcdJzEbk+SwG98d0CYB73i15XiRqpy8Pytab+OJpGl3LBfU39WJVEKa5xnCTucOgbhIUnBuiuPJ9RvZnOPGxFoRuGs4o+A3d3QiNwukV6OMGd6KDtoIBcAxCfWmXdw+syI6ci710Kqy+cs/uyZFwTVirMiUjiNjM8lres4epQ3mtewYyRhH77QVUdcj6AGYbt+xQv4El9fw2amOIKv9zKu1arLH2PUqk9TOGvc+cZbLhahR/cjK1ABYawiScuECZ10CoVy+KTVsFa+UfZG9XNcyDLfpOJlcH5QMY1QvmT97vkdMRro/2IxYeKGz24mJhrp9KyOkdNYSn59iKmUJGecLSaXaToCrrtZzXjGrZZQL1uk+fEBJUlhUQGMflxgp+roTHR0v+HwBqYzTWFcVY1MqwQoMurnKfiwfxsurVXoeIv5viww3eZB6sFCFalVsaaSE0n/INJhtnZTCm53suu198nmU287nzpvPlvxaMZqBqgfwxzXPzsBnUHdP9PqNzEf6bDQqKjEUNo5Eh6df9DrZpvsdixYvneSx/wc1w7viqJ4WYYxSk+x9Q6HvmwODJLhtTqGlV98Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA7PR11MB9541.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIPCvpAYu0wM1j0gMmDXXEFXRJZ+/z5DufEUXnOACbr6bMwEhKzPiNiiUv97?=
 =?us-ascii?Q?7PAKRxydZFJWRDt+iv2iQIbtxIQRj5elg0uZQhqs3PijlgbF+gQRSP/MokJX?=
 =?us-ascii?Q?pF1foN5A9cl6V+esSbxQEGQT1c6gEIrbZMgdXqe0CxtfuLJo6YregxdYMqZ3?=
 =?us-ascii?Q?nN6n4ANiyI7fyxoixNTYe4KRQNuejUKMoWVmhDAfXBN5Gyo7hO1e8hMnaTOg?=
 =?us-ascii?Q?MsvTVtycmxCdXfyqHJiZvWq6NjnXe094QaJBbqdFviFaPoasB1ghJI8JH5a0?=
 =?us-ascii?Q?sa8OlGbLP/8ZDdjhr7bSQ4y5qYz5i4mTgQ09md9VZXCV0w2OdyTLojjJJ6MV?=
 =?us-ascii?Q?tetLmCDBmldTGBAOfKit7bTuiDvTPh1ZamA7LbeYiKIHIiRl2j6iTshy/gJX?=
 =?us-ascii?Q?VSnOdgnJmHmUTimGWmM4e9aFJ4uPT+58xyNQstV29yEiELK2Mx1jBq5HuPpx?=
 =?us-ascii?Q?nQdbRW4Yre4/5t0HVpd6WqrQg5aWPqCrP+Hb6CxLodAESeFgdEV9+DC0gmis?=
 =?us-ascii?Q?nduuceKPGbSzc6oHJag1KA8Mcsjr+f/FMLzi3EFgwqAUqVb+qLXjJwDFZu/g?=
 =?us-ascii?Q?6Fb8Xm8Q1nyo/tz1woz1gzLM/0Fe+1XE0yxrVg4d9WS+Gf7je5YgD3kWsSdv?=
 =?us-ascii?Q?3THY9RNQKC0b7NU0i+PBzDJZh/QykABwnW9CTqAUTHT/sQ/PHtoGldMkorpo?=
 =?us-ascii?Q?pBiKYC6O73vrELe5iLDnont8AYvZUOaSl/bU6EiOHjrquLVqRpUWV37YeeoE?=
 =?us-ascii?Q?B83UAGmdeNWPhujeKVTnlNBbU7WNqkENtz+DepE545onB3Yv+V5AJVMhRfm0?=
 =?us-ascii?Q?IuPGcna2pilWmlvMR9zaWstDg/tuIxYXY8M652CdtbyIc65bywqIoDkEkCZL?=
 =?us-ascii?Q?HFh0gWlnA+KZ0kyTD9KiWDJk1CYtZStlUjEmpe6C+1hCVQs1jiViWbiznZyy?=
 =?us-ascii?Q?opaquFebc1IvXaKINp/lBjHI4yTVFaJ3aEeULRaejEkdix3PP8LizztpIFJk?=
 =?us-ascii?Q?fUWOifFoQUI6hNzkHU0ZARYxQi3JMZ1nU4e/126JhfmDSjG8LM6RxYepn50o?=
 =?us-ascii?Q?LuhEgUbba+1EdFT2hUkG02iUsnP8UmnLm0iS1r2deHdRMstg9gg+M+14HEAV?=
 =?us-ascii?Q?uDtivYKVw6zCmyFX9SUEP77K2IIvjeclHDOxeNnVjgcb39oTdZsaMg2a9+bg?=
 =?us-ascii?Q?gpuTi2oeJbG8gxoX3d3ZdEVFXoAOcwRzcVGlY+nw7u2uqBcC3rO6Q/YyeoEn?=
 =?us-ascii?Q?OvIeTvAThcWyAkkA4wsTE/omUSYtwL4LtPiW8Pq7SMbPk1rsgY18gl2wMTUO?=
 =?us-ascii?Q?1uPTiOdgio7XalALP/TLVrv6dZT1Kk+ubJWKVtMTki9eeU8i1DHPUJUAibtx?=
 =?us-ascii?Q?cxWKLMNxTQOzhuU+kp4Vn9v7zBil2DliZQuKWavp6NCWkvmGCkK5sNIO8e8B?=
 =?us-ascii?Q?PKZWeOUgvwFffG51UJ2K9o4JI+PTJEK2dPWSm0R7VKbV4vYZgzs5gsK1hNkS?=
 =?us-ascii?Q?STDLqbA+Z6ccmb9I8Q0dHOsBetMDiW1XHZRHlI0hvTGKeHYg6wnACMuL42X2?=
 =?us-ascii?Q?qljAtUVbjn8vJnkwQ1tmiILO1LlKe9jkaY+0WoT4n8x3mokfdSQ8IAUs3+Ph?=
 =?us-ascii?Q?GgGJih8f7PQ/cMyOSnVwv2h311qOB3M+jeuQchIOTxm0kfB/q/sKF9tX3C4s?=
 =?us-ascii?Q?bEAck0gISOAsDdJ3xZTlw3k2MnMz+KZ8HyFtHK+GaRDNWSdQcWVBMIRH3nCZ?=
 =?us-ascii?Q?FrcPkcFESNjMX2bIpuGP62DGuvFazYo=3D?=
X-Exchange-RoutingPolicyChecked: uuzJ1/n/tymbWRB1LwjNroVd6XMZCE4OU3lkA8EcqH4OO1AE2xrY2PPtIM3W92zUaG73WJWj33NPdeHu2ORTgRptH6zPvw0FCOjO7Zq6Yy3S8R6cXXQNBAslgRqSAOOTXVEQocAxDxv0z08cmus9/jzVxjWtv9tLno40/pkMU19HgcyhiHh6fIO2rur0FCTbRNJ9uAcYygADwKIqgDI9XDQAoSqojmk9u29KDCPfc03zwDSiqBanrH/b7cf3Ow304hdbAXiKSiUhgVwa0HWuTx4rptis0j38cH+dTWA7I8XevgTcK3HH+aHP9ClFkP3u4UsAHP1V1YXCOLUY6BWJnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f3a086-44d5-4ced-59d7-08df04e933ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB9534.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:46:25.2026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JeuXtg7tqaHKkN+/cihuax0Qa8uDZuL+a9XUzY7tqXHvstTq08aFaxtOSklcNjBml7yzuULWwhVOdnMqG/6B12AeqznmBTyRQN/DrtPsKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9181
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

Hi,

On Fri, Aug 28, 2026 at 04:36:52PM +0800, Junhua Shen wrote:
> 
> The base-page count for a migrate.src[] entry was open-coded in several
> places along the migration path, and these variants handled
> MIGRATE_PFN_COMPOUND entries inconsistently.

Nit: not just inconsistently, I would mention the existing undercount issue
this patch fixes when VALID=0 && COMPOUND=1.

> 
> Factor it out into drm_pagemap_src_pfn_nr_pages() and use it in
> drm_pagemap_cpages() and both accounting loops of
> drm_pagemap_migrate_to_devmem(), so every site agrees on the base-page
> count and iteration stride.
> 
> Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>

Consequently, we need a "Fixes" tag here.

With that, the change itself LGTM:

    Reviewed-by: Francois Dugast <francois.dugast@intel.com>

Francois

> ---
>  drivers/gpu/drm/drm_pagemap.c | 60 +++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b..a31cc4f0af68 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -554,6 +554,37 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
>  	return ret;
>  }
>  
> +/**
> + * drm_pagemap_src_pfn_nr_pages() - Decode src entry and return base-page count
> + * @src_pfn: Source migrate entry
> + * @src_page: Optional decoded source page when MIGRATE_PFN_VALID is set
> + *
> + * Decode @src_pfn to compute how many base pages it represents: use folio
> + * page count for valid entries, HPAGE_PMD_NR for COMPOUND-only entries,
> + * otherwise 1.
> + *
> + * Return: Number of base pages represented by @src_pfn.
> + */
> +static unsigned long drm_pagemap_src_pfn_nr_pages(unsigned long src_pfn,
> +						   struct page **src_page)
> +{
> +	struct page *page = NULL;
> +	unsigned long nr_pages = 1;
> +
> +	if (src_pfn & MIGRATE_PFN_VALID) {
> +		page = migrate_pfn_to_page(src_pfn);
> +		if (page)
> +			nr_pages = NR_PAGES(folio_order(page_folio(page)));
> +	} else if (src_pfn & MIGRATE_PFN_COMPOUND) {
> +		nr_pages = HPAGE_PMD_NR;
> +	}
> +
> +	if (src_page)
> +		*src_page = page;
> +
> +	return nr_pages;
> +}
> +
>  /**
>   * drm_pagemap_cpages() - Count collected pages
>   * @migrate_pfn: Array of migrate_pfn entries to account
> @@ -570,20 +601,14 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
>  	unsigned long i, cpages = 0;
>  
>  	for (i = 0; i < npages;) {
> -		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
> -		struct folio *folio;
> -		unsigned int order = 0;
> +		unsigned long src_pfn = migrate_pfn[i];
> +		struct page *page;
> +		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, &page);
>  
> -		if (page) {
> -			folio = page_folio(page);
> -			order = folio_order(folio);
> -			cpages += NR_PAGES(order);
> -		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> -			order = HPAGE_PMD_ORDER;
> -			cpages += NR_PAGES(order);
> -		}
> +		if (page || (src_pfn & MIGRATE_PFN_COMPOUND))
> +			cpages += nr_pages;
>  
> -		i += NR_PAGES(order);
> +		i += nr_pages;
>  	}
>  
>  	return cpages;
> @@ -703,8 +728,9 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  
>  	/* Count device-private pages to migrate */
>  	for (i = 0; i < npages;) {
> -		struct page *src_page = migrate_pfn_to_page(migrate.src[i]);
> -		unsigned long nr_pages = src_page ? NR_PAGES(folio_order(page_folio(src_page))) : 1;
> +		unsigned long src_pfn = migrate.src[i];
> +		struct page *src_page;
> +		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, &src_page);
>  
>  		if (src_page && is_zone_device_page(src_page)) {
>  			if (page_pgmap(src_page) == pagemap)
> @@ -818,10 +844,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  	migrate_vma_pages(&migrate);
>  
>  	for (i = 0; !err && i < npages;) {
> -		struct page *page = migrate_pfn_to_page(migrate.src[i]);
> -		unsigned long nr_pages = page ? NR_PAGES(folio_order(page_folio(page))) : 1;
> +		unsigned long src_pfn = migrate.src[i];
> +		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, NULL);
>  
> -		if (migrate.src[i] & MIGRATE_PFN_MIGRATE)
> +		if (src_pfn & MIGRATE_PFN_MIGRATE)
>  			migrated_pages += nr_pages;
>  
>  		i += nr_pages;
> -- 
> 2.34.1
> 
