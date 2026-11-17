Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A996606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h4wEUr3i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEB610E43A;
	Tue, 17 Nov 2026 16:51:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDC610E43A;
 Tue, 17 Nov 2026 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794934278; x=1826470278;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AKUx4JkMQ0A2fuXZJJmjfmw4iHvEkRiAjUN4it/C2Z0=;
 b=h4wEUr3iPX/stF9mRIbT4ZqJyPXukJr1R3gkiitMBHqbKZ91gfVrM6Vd
 RCW1R4mWNAm0GA2u1rvgxWfAB/3PgqKr1CZJhK/cqknZv61Bel65c40CH
 9JWOzxEeO+ihL+XiFQsIvkczWRXL+UUuBpmQOuIeMCUo7HKvm2TnkDKJr
 fmuhw+nN+JB6+lWw8+s0SQ2t94j+vVSzV1L036kbEEhzFbiJ/OntROS5+
 skjBHIq1Bj5/fZHbXtlTH9es6yPr/TcypznzO0wIS1UOT+5X8OzreKvjM
 FYeMW3Y3Ai2immou1BQ44HUIuZhwOOIzxcvi8W61KT1+qw51vxxF/tbZY g==;
X-CSE-ConnectionGUID: D7DxVgdWQvmkvqLjpUjjXw==
X-CSE-MsgGUID: r+k/IkmZT/ihFBHCx6Zz+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3735715"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3735715"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 08:51:17 -0800
X-CSE-ConnectionGUID: NJKy9sZ9QPKSW8fgbMGKjw==
X-CSE-MsgGUID: fksg995yS1uOD2c6/VocTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="11817124"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.57])
 ([10.245.244.57])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 08:51:16 -0800
Message-ID: <579e8385-fe82-4a81-bf41-97d36f3d89cb@intel.com>
Date: Tue, 17 Nov 2026 16:51:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/ttm: remove unused num_pages
To: =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>
References: <20261115102237.3091682-1-michal.grzelak@linux.intel.com>
 <20261115102237.3091682-2-michal.grzelak@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261115102237.3091682-2-michal.grzelak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 15/11/2026 10:22, Michał Grzelak wrote:
> ttm_pool_mgr_init() does not use num_pages argument in any way. Remove
> it.
> 
> v1->v2
> - include ttm maintainers in Cc: list
> 
> Cc: Natalie Vock <nat@pixelcluster.dev>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>

Looks like not needed since 4516432284e1

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/ttm/ttm_device.c | 2 +-
>   drivers/gpu/drm/ttm/ttm_pool.c   | 4 +---
>   include/drm/ttm/ttm_pool.h       | 2 +-
>   3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> index d3bfb9a696a74..4a9786ffa5fe2 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -96,7 +96,7 @@ static int ttm_global_init(void)
>   		>> PAGE_SHIFT;
>   	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
>   
> -	ttm_pool_mgr_init(num_pages);
> +	ttm_pool_mgr_init();
>   	ttm_tt_mgr_init(num_pages, num_dma32);
>   
>   	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 1bf37023fed66..2f6c666868d5f 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1485,11 +1485,9 @@ static inline u64 ttm_get_node_memory_size(int nid)
>   /**
>    * ttm_pool_mgr_init - Initialize globals
>    *
> - * @num_pages: default number of pages
> - *
>    * Initialize the global locks and lists for the MM shrinker.
>    */
> -int ttm_pool_mgr_init(unsigned long num_pages)
> +int ttm_pool_mgr_init(void)
>   {
>   	unsigned int i;
>   
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e19949..bb6347e5b2970 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -94,7 +94,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *ttm,
>   int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>   			       const struct ttm_operation_ctx *ctx);
>   
> -int ttm_pool_mgr_init(unsigned long num_pages);
> +int ttm_pool_mgr_init(void);
>   void ttm_pool_mgr_fini(void);
>   
>   #endif

