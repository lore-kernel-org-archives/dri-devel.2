Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D897CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8572810EAF0;
	Tue, 12 May 2026 13:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QAxfaugY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D8810EAF0;
 Tue, 12 May 2026 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778592629; x=1810128629;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wtJqHHaIl13PAglqRFyFPd5gLhqQXFoxrvpBhQYYIEI=;
 b=QAxfaugYWVocuVDjzN2XmtgOnAo5QpVVNuhOB14XGBOkSb4Evd4MOYKV
 7NMSi4THhS+MLxF8wuwobcU2BBSF3qE3eKEJhgJana9CB/9GbE3Lm7MBj
 zQijcde3jxSpSmqn5sSxH1zY9yDAaa02fsOveCtA3J71mJ4YzN/3u/1BO
 w/DUHinNERI2jDnUkUw6MGIKInTosQEnUhFoq8q9mA3AN7kpavFskJcLE
 z/R8Qk0LQD011ecQh9cB/Ce1ovqZ4OX2dQ2fc7cz2pW60K0LkwXq7lpKe
 LzDn5LNGndMpWMZz3AVaDTsZvZNBRnIi5lNSw9ewTapGDhfR2YPEX1J0H A==;
X-CSE-ConnectionGUID: SoY4bNCYSHigmxIKHSwtoA==
X-CSE-MsgGUID: JszZDvs/SyOKMcTBLO7dEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79448918"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="79448918"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 06:30:27 -0700
X-CSE-ConnectionGUID: 6zNkqupeSrOr3resEA9THA==
X-CSE-MsgGUID: ha2l5MCwQri+SNdEqz8fwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="241766446"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.184])
 ([10.245.245.184])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 06:30:25 -0700
Message-ID: <353e4a2f-102e-4d77-98b1-19f37d691e8c@intel.com>
Date: Tue, 12 May 2026 14:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup
 failure
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/05/2026 17:24, Thomas Hellström wrote:
> Apply the same fix as b2ed01e7ad ("drm/ttm: Fix ttm_bo_swapout()
> infinite LRU walk on swapout failure") to the ttm_bo_shrink() path.
> 
> Move del_bulk_move from before the backup to after success only,
> using ttm_resource_del_bulk_move_unevictable() since the resource
> is now unevictable once fully backed up.
> 
> Fixes: 70d645deac98 ("drm/ttm: Add helpers for shrinking")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.15+
> Assisted-by: GitHub_Copilot:claude-opus-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index f83b7d5ec6c6..3e3c201a0222 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -1112,19 +1112,14 @@ long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
>   	if (lret < 0)
>   		return lret;
>   
> -	if (bo->bulk_move) {
> -		spin_lock(&bdev->lru_lock);
> -		ttm_resource_del_bulk_move(bo->resource, bo);
> -		spin_unlock(&bdev->lru_lock);
> -	}
> -
>   	lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
>   			     {.purge = flags.purge,
>   			      .writeback = flags.writeback});
>   
> -	if (lret <= 0 && bo->bulk_move) {
> +	if (lret > 0) {
>   		spin_lock(&bdev->lru_lock);
> -		ttm_resource_add_bulk_move(bo->resource, bo);
> +		ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
> +		ttm_resource_move_to_lru_tail(bo->resource);
>   		spin_unlock(&bdev->lru_lock);
>   	}
>   

