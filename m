Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88027F4643A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F6810E38E;
	Mon, 16 Mar 2026 09:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hX2TpC9P";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C5710E38D;
 Mon, 16 Mar 2026 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773653808; x=1805189808;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SZ+t1ZFCwrzIW4RO2mz1vCZvRv5QGcN+9M0nm545El0=;
 b=hX2TpC9PyfpLr7OzObpaVvA1yYZKVAZH3TpMMSyZMbfD3u63/3u6Y4dd
 LueucNob1T2Pic211BMCXuif03qOgFX2y9bJ+64AzFt4EWJztDEYfaRrJ
 R68lTEGo93u9LYyvc3+6jVm1BJugcciXVL5xqSJYD1MT4DsyQ5mJlXbZv
 ZR4razo2djiq590p40xmz41dsPXxxIb8tip8IJsfjGnoVWJ0LjvhznWLy
 wGqG/kN10l5LxJcboMqVb9bWRkTebWXuColv0eGeIdDJKfqrBAgOelnPM
 MiVj1khxpo0CxdMgUCARSypcd8RX3FOpoyW2l+x4nnmzvIdqqxFc9zn+Q A==;
X-CSE-ConnectionGUID: VEs20tHKSiyEGT4Zfso4xg==
X-CSE-MsgGUID: z25xL4/GTqy6i5vr+Dr9eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74581883"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74581883"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 02:36:46 -0700
X-CSE-ConnectionGUID: I0AedmSETjyTnjGiUgtgaA==
X-CSE-MsgGUID: 1AcrgF9/Qvin+zRfcAmUZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="226526344"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.219])
 ([10.245.244.219])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 02:36:43 -0700
Message-ID: <68b086ba-bb60-45a2-8587-7030ab3c559f@linux.intel.com>
Date: Mon, 16 Mar 2026 10:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/pagemap_util: Ensure proper cache lock management
 on free
To: Jonathan Cavitt <jonathan.cavitt@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com,
 intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com
References: <20260306154322.60120-2-jonathan.cavitt@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260306154322.60120-2-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Den 2026-03-06 kl. 16:43, skrev Jonathan Cavitt:
> Static analysis issue:
> 
> Though probably unnecessary given the cache is being freed at this step,
> for the sake of consistency, ensure that the cache lock is always
> unlocked after drm_pagemap_cache_fini.
> 
> v2:
> - Use requested code flow (Maarten)
> 
> v3:
> - Clear cache->dpagemap (Matt Brost, Maarten)
> 
> Fixes: 77f14f2f2d73f ("drm/pagemap: Add a drm_pagemap cache and shrinker")
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_pagemap_util.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap_util.c b/drivers/gpu/drm/drm_pagemap_util.c
> index 14ddb948a32e..6111d90a38e2 100644
> --- a/drivers/gpu/drm/drm_pagemap_util.c
> +++ b/drivers/gpu/drm/drm_pagemap_util.c
> @@ -65,18 +65,14 @@ static void drm_pagemap_cache_fini(void *arg)
>  	drm_dbg(cache->shrinker->drm, "Destroying dpagemap cache.\n");
>  	spin_lock(&cache->lock);
>  	dpagemap = cache->dpagemap;
> -	if (!dpagemap) {
> -		spin_unlock(&cache->lock);
> -		goto out;
> -	}
> +	cache->dpagemap = NULL;
> +	if (dpagemap && !drm_pagemap_shrinker_cancel(dpagemap))
> +		dpagemap = NULL;
> +	spin_unlock(&cache->lock);
>  
> -	if (drm_pagemap_shrinker_cancel(dpagemap)) {
> -		cache->dpagemap = NULL;
> -		spin_unlock(&cache->lock);
> +	if (dpagemap)
>  		drm_pagemap_destroy(dpagemap, false);
> -	}
>  
> -out:
>  	mutex_destroy(&cache->lookup_mutex);
>  	kfree(cache);
>  }

