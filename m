Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F97F9B5E3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEA710E987;
	Wed, 22 Apr 2026 08:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ML4/oefa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0263A10E974;
 Wed, 22 Apr 2026 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776846696; x=1808382696;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BLoTYMxGQTA/oOMa4NfPFqVslSfO4JVYrMUvoKq0rLQ=;
 b=ML4/oefaGYjIlKiYDKe0CWZoPsM8Hy5mGSk9WjfQqVsOZWBHLxmxElno
 9PbByHb5+AEMgps5mFzYN4aw2CcOKeogZhjXTz/EZA48lXq4BH81VDGe+
 Qissu6ujjMmsrvUEJevDWrVSr6FUu4+pSRsSRDq8m7VOszlAeP8l0Pgq9
 jozSmmvH5NnwwrIHlRlDHhTss3JaKXpZd5CvfMMhTlUPrBtWz5MkLazDf
 ytZnJHI6Vi62Bu1XmrhPBImuz24Pijy577olaaZQhujLv6QddsyK9vU6r
 mbG68Ty2JEVJ++Ml2GgCuMcwWfrCCcBrZGkwGqre6UoS8wclyqfnZkHaG g==;
X-CSE-ConnectionGUID: 9Z57PNTxTuWy5kg8+KjAcQ==
X-CSE-MsgGUID: +wyvLtfvTriQBtkOh63x6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88870020"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="88870020"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:31:35 -0700
X-CSE-ConnectionGUID: t8N3QOulRZCJDsonFBsNWA==
X-CSE-MsgGUID: f0JvRIgESJ+fIWx0meLcwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="232159328"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.228])
 ([10.245.245.228])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:31:31 -0700
Message-ID: <4b647952-0038-4878-b67e-6c7fc7ab27a6@linux.intel.com>
Date: Wed, 22 Apr 2026 10:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hey,

(Adding Thadeu to cc since they've been working on the same issue)

Den 2026-03-27 kl. 09:15, skrev Thomas Hellström:
> Add an optional reclaim callback to struct dmem_cgroup_region.  When
> dmem.max is set below current usage, invoke the callback to evict memory
> and retry setting the limit rather than failing immediately.  Signal
> interruptions propagate back to the write() caller.
> 
> RFC:
> Due to us updating the max limit _after_ the usage has been
> sufficiently lowered, this should be prone to failures if there are
> aggressive allocators running in parallel to the reclaim.
> So can we somehow enforce the new limit while the eviction is
> happening?
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  include/linux/cgroup_dmem.h | 11 +++++
>  kernel/cgroup/dmem.c        | 94 +++++++++++++++++++++++++++++++++----
>  2 files changed, 96 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index dd4869f1d736..61520a431740 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  				      bool ignore_low, bool *ret_hit_low);
>  
>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
> +						   u64 target_bytes, void *priv),
> +				    void *priv);
>  #else
>  static inline __printf(2,3) struct dmem_cgroup_region *
>  dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
> @@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  { }
>  
> +static inline void
> +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +			       int (*reclaim)(struct dmem_cgroup_pool_state *pool,
> +					      u64 target_bytes, void *priv),
> +			       void *priv)
> +{ }
> +
>  #endif
>  #endif	/* _CGROUP_DMEM_H */
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 3e6d4c0b26a1..f993fb058b74 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -51,6 +51,18 @@ struct dmem_cgroup_region {
>  	 * No new pools should be added to the region afterwards.
>  	 */
>  	bool unregistered;
> +
> +	/**
> +	 * @reclaim: Optional callback invoked when dmem.max is set below the
> +	 * current usage of a pool. The driver should attempt to free at least
> +	 * @target_bytes from @pool. May be called multiple times if usage
> +	 * remains above the limit after returning.
> +	 */
> +	int (*reclaim)(struct dmem_cgroup_pool_state *pool, u64 target_bytes,
> +		       void *priv);
> +
> +	/** @reclaim_priv: Private data passed to @reclaim. */
> +	void *reclaim_priv;
>  };
>  
>  struct dmemcg_state {
> @@ -145,23 +157,59 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
>  }
>  
>  static int
> -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
> +		 struct dmem_cgroup_region *region)
>  {
>  	page_counter_set_min(&pool->cnt, val);
>  	return 0;
>  }
>  
>  static int
> -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
> +		 struct dmem_cgroup_region *region)
>  {
>  	page_counter_set_low(&pool->cnt, val);
>  	return 0;
>  }
>  
>  static int
> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
> +		 struct dmem_cgroup_region *region)
>  {
> -	return page_counter_set_max(&pool->cnt, val);
> +	int err = page_counter_set_max(&pool->cnt, val);
> +
> +	if (err != -EBUSY || !region || !region->reclaim)
> +		return err;
> +
> +	/*
> +	 * The new max is below current usage.  Ask the driver to evict memory
> +	 * and retry, up to a bounded number of times.  Signal interruptions are
> +	 * propagated back to the write() caller; other reclaim failures leave
> +	 * -EBUSY as the result.
> +	 */
> +	for (int retries = 5; retries > 0; retries--) {
> +		u64 usage = page_counter_read(&pool->cnt);
> +		u64 target = usage > val ? usage - val : 0;
> +		int reclaim_err;
> +
> +		if (!target) {
> +			err = page_counter_set_max(&pool->cnt, val);
> +			break;
> +		}
> +
> +		reclaim_err = region->reclaim(pool, target, region->reclaim_priv);
> +		if (reclaim_err) {
> +			if (reclaim_err == -EINTR || reclaim_err == -ERESTARTSYS)
> +				err = reclaim_err;
> +			break;
> +		}
> +
> +		err = page_counter_set_max(&pool->cnt, val);
> +		if (err != -EBUSY)
> +			break;
> +	}
> +
> +	return err;
>  }

I mentioned this in chat but I wanted to mention it on the mailing list for others as well,
can we reproduce the behavior from memory_max_write() in mm/memcontrol.c?

1. First set new limit through xchg.
2. If O_NONBLOCK is set -> do nothing, next allocation in target region will fail and cause reclaim.
3. If not set -> reclaim until below new limit or interrupted by a signal, return success in all cases here since we set new limit.

>  
>  static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
> @@ -186,9 +234,9 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
>  
>  static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
>  {
> -	set_resource_min(rpool, 0);
> -	set_resource_low(rpool, 0);
> -	set_resource_max(rpool, PAGE_COUNTER_MAX);
> +	set_resource_min(rpool, 0, NULL);
> +	set_resource_low(rpool, 0, NULL);
> +	set_resource_max(rpool, PAGE_COUNTER_MAX, NULL);
>  }
>  
>  static void dmemcs_offline(struct cgroup_subsys_state *css)
> @@ -570,6 +618,32 @@ void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
>  
> +/**
> + * dmem_cgroup_region_set_reclaim - Register a reclaim callback on a region.
> + * @region: The region to register the callback for.
> + * @reclaim: Callback to invoke when dmem.max is set below current usage.
> + *           Called with the pool that needs reclaiming and the number of
> + *           bytes to free. Returns 0 on progress, negative on failure.
> + * @priv: Opaque pointer passed back to @reclaim.
> + *
> + * When dmem.max is lowered below the current usage of a cgroup pool, the
> + * dmem controller will call @reclaim with a target number of bytes to free.
> + * After @reclaim returns the controller retries setting the limit; if usage
> + * is still too high it calls @reclaim again, up to a bounded retry count.
> + */
> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
> +						   u64 target_bytes, void *priv),
> +				    void *priv)
> +{
> +	if (!region)
> +		return;
> +
> +	region->reclaim = reclaim;
> +	region->reclaim_priv = priv;
> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_region_set_reclaim);
> +
>  static struct dmem_cgroup_pool_state *
>  get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
>  {
> @@ -728,7 +802,8 @@ static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
>  
>  static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>  				 char *buf, size_t nbytes, loff_t off,
> -				 int (*apply)(struct dmem_cgroup_pool_state *, u64))
> +				 int (*apply)(struct dmem_cgroup_pool_state *, u64,
> +					      struct dmem_cgroup_region *))
>  {
>  	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
>  	int err = 0;
> @@ -775,7 +850,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>  		}
>  
>  		/* And commit */
> -		err = apply(pool, new_limit);
> +		err = apply(pool, new_limit, region);
> +
>  		dmemcg_pool_put(pool);
>  
>  out_put:

Kind regards,
~Maarten Lankhorst
