Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF09CD37B0
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 17:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DCC10F574;
	Fri,  8 May 2026 17:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="miuG7geX";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC16410F569;
 Fri,  8 May 2026 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1778259792;
 bh=g7sFg48r5Dm+Qo/8mMdFgMdzbwgpDyCQ/p6NpvKjuO8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=miuG7geX4V6aqu09394g21y6aer2ii5J64k2rHShJV8jxg/42yvdAD+jr8x1BExwg
 PmLL9b/4p/cj6ohFV2NhFfHbyKkXEuIwEFeFsOo3TxcQv424om/vILos5m59ZGvfHQ
 /yOrmhjgjr0Pskt7f0HccWUa1Lis4ijC1oiBt410jI5yfdIEEcccL4FT/e+hzPOX9O
 2bvHcx2+FCcRCyGs9J3p5iBtXsdGk2cZkEUCaL3svIVO63DCZ1kasqQmCeMk5vX+gy
 sTWk2FNsVbcecTdbihl5sTP32OhZ1LoYQCZsVwLnkQ6gHvNFVtzStkIqvvTsR0TemU
 IKi5yt+iqOA2A==
Message-ID: <433c0bbd-6c47-4011-8551-d1cfd0b4e17c@lankhorst.se>
Date: Fri, 8 May 2026 19:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to
 -ENOSPC
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260508160920.230339-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260508160920.230339-1-thomas.hellstrom@linux.intel.com>
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

Den 2026-05-08 kl. 18:09, skrev Thomas Hellström:
> dmem_cgroup_try_charge() returns -EAGAIN when the cgroup limit is
> hit and the charge fails. TTM has no concept of -EAGAIN from resource
> allocation; -ENOSPC is the canonical error meaning "no space, try
> eviction". Convert at the source in ttm_resource_alloc() so no caller
> needs to handle an unexpected error code, and clean up the now-redundant
> -EAGAIN check in ttm_bo_alloc_resource().
> 
> Without this, -EAGAIN escaping ttm_resource_alloc() during an eviction
> walk causes the walk to terminate early instead of continuing to the
> next candidate.
> 
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Maarten Lankhorst <dev@lankhorst.se>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.14+
> Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c       | 2 +-
>  drivers/gpu/drm/ttm/ttm_resource.c | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index d85f0a37ac35..cee3828df655 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -739,7 +739,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>  		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
>  		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
>  		if (ret) {
> -			if (ret != -ENOSPC && ret != -EAGAIN) {
> +			if (ret != -ENOSPC) {
>  				dmem_cgroup_pool_state_put(limit_pool);
>  				return ret;
>  			}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 9f36631d48b6..b0efffe5a526 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -385,8 +385,11 @@ int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  
>  	if (man->cg) {
>  		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
> -		if (ret)
> +		if (ret) {
> +			if (ret == -EAGAIN)
> +				ret = -ENOSPC;
>  			return ret;
> +		}
>  	}
>  
>  	ret = man->func->alloc(man, bo, place, res_ptr);

Yeah looks reasonable with the conversion to callbacks.

Reviewed-by: Maarten Lankhorst <dev@lankhrost.se>
