Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5706FC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA94110ECA3;
	Tue,  7 Jul 2026 12:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d15AAZex";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C5410E4B8;
 Tue,  7 Jul 2026 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783427721; x=1814963721;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=wqsEg8gEkIQBQiVK7zKnHpQo6YwkHFT7tdr95XGnyoI=;
 b=d15AAZextERiw5cvkKOhskoyDl+re/OACh9RULwtcOcu61bjHuGmBmqz
 PsUl1s/v6VrwtlbApcU4StWpWjNtNpv1tJcHYNvexuxFdvmFTxap2EvVD
 aUU+Hb15+9EaOhNcW5E6ebJhh6OotBOZJFHdW5vIwNPjGiwIPDu8fDzq1
 HkoelAEFP8SpJnM605KYF4g8xZS05W7IQJ8SrX5E+4cjsR/CGfjWNvz3V
 e5KKBCp8WpRjBx2JG9giFUN8+LhiswEyQ9shSguh+bUxVBQRYN+DeSVFc
 q+/K6lbMsk5umOMthPuzR8E/LI0LYuNjMs0jNXggt6jQoyoAHZc0KiSXp w==;
X-CSE-ConnectionGUID: ACnllpsESXqF1ZHYvzEikQ==
X-CSE-MsgGUID: ijJP2XUuRj6RaDF0ogck/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84192327"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84192327"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:35:20 -0700
X-CSE-ConnectionGUID: eI3I6jMOTdmmca73txZuFg==
X-CSE-MsgGUID: 7uO41+3gSu+tIgufN9Tpwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="277199432"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.199])
 ([10.245.244.199])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:35:16 -0700
Message-ID: <f4506c9230e3f608b3f660ad4a7d29a0711cb914.camel@linux.intel.com>
Subject: Re: [PATCH 07/10] drm/ttm: use ttm_bo_lru_for_each_reserved_guarded
 in evict_all
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula	
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Christian Koenig	
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld	
 <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, Alex
 Deucher	 <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Tue, 07 Jul 2026 14:35:14 +0200
In-Reply-To: <20260703-ttm_2_drm_exec-v1-7-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-7-43685ac1286b@gmx.de>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Fri, 2026-07-03 at 18:31 +0200, Natalie Vock wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> Use the for_each loop to evict all BOs of an resource manager as
> well.
>=20
> Greately simplifying the handling and finally allows us to
> remove ttm_bo_evict_first().
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
51 +---------------------------
> ----------
> =C2=A0drivers/gpu/drm/ttm/ttm_resource.c | 22 ++++++++++------
> =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A03 files changed, 17 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> b/drivers/gpu/drm/ttm/ttm_bo.c
> index 54f01611ec823..80933ba6aada9 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -351,8 +351,7 @@ static int ttm_bo_bounce_temp_buffer(struct
> ttm_buffer_object *bo,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int ttm_bo_evict(struct ttm_buffer_object *bo,
> -			struct ttm_operation_ctx *ctx)
> +int ttm_bo_evict(struct ttm_buffer_object *bo, struct
> ttm_operation_ctx *ctx)
> =C2=A0{
> =C2=A0	struct ttm_resource *evict_mem;
> =C2=A0	struct ttm_placement placement;
> @@ -437,54 +436,6 @@ bool ttm_bo_eviction_valuable(struct
> ttm_buffer_object *bo,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(ttm_bo_eviction_valuable);
> =C2=A0
> -/**
> - * ttm_bo_evict_first() - Evict the first bo on the manager's LRU
> list.
> - * @bdev: The ttm device.
> - * @man: The manager whose bo to evict.
> - * @ctx: The TTM operation ctx governing the eviction.
> - *
> - * Return: 0 if successful or the resource disappeared. Negative
> error code on error.
> - */
> -int ttm_bo_evict_first(struct ttm_device *bdev, struct
> ttm_resource_manager *man,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_operation_ctx *ctx)
> -{
> -	struct ttm_resource_cursor cursor;
> -	struct ttm_buffer_object *bo;
> -	struct ttm_resource *res;
> -	unsigned int mem_type;
> -	int ret =3D 0;
> -
> -	spin_lock(&bdev->lru_lock);
> -	ttm_resource_cursor_init(&cursor, man);
> -	res =3D ttm_resource_manager_first(&cursor);
> -	ttm_resource_cursor_fini(&cursor);
> -	if (!res) {
> -		ret =3D -ENOENT;
> -		goto out_no_ref;
> -	}
> -	bo =3D res->bo;
> -	if (!ttm_bo_get_unless_zero(bo))
> -		goto out_no_ref;
> -	mem_type =3D res->mem_type;
> -	spin_unlock(&bdev->lru_lock);
> -	ret =3D ttm_bo_reserve(bo, ctx->interruptible, ctx-
> >no_wait_gpu, NULL);
> -	if (ret)
> -		goto out_no_lock;
> -	if (!bo->resource || bo->resource->mem_type !=3D mem_type)
> -		goto out_bo_moved;
> -
> -	ret =3D ttm_bo_evict(bo, ctx);
> -out_bo_moved:
> -	dma_resv_unlock(bo->base.resv);
> -out_no_lock:
> -	ttm_bo_put(bo);
> -	return ret;
> -
> -out_no_ref:
> -	spin_unlock(&bdev->lru_lock);
> -	return ret;
> -}
> -
> =C2=A0/**
> =C2=A0 * struct ttm_bo_evict_walk - Parameters for the evict walk.
> =C2=A0 */
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c
> b/drivers/gpu/drm/ttm/ttm_resource.c
> index 154d6739256f8..cf3fc3a594388 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -561,17 +561,25 @@ EXPORT_SYMBOL(ttm_resource_manager_init);
> =C2=A0int ttm_resource_manager_evict_all(struct ttm_device *bdev,
> =C2=A0				=C2=A0=C2=A0 struct ttm_resource_manager *man)
> =C2=A0{
> -	struct ttm_operation_ctx ctx =3D { };
> +	struct ttm_bo_lru_cursor cursor;
> +	struct ttm_buffer_object *bo;
> +	struct ttm_operation_ctx ctx =3D {
> +		.interruptible =3D false,
> +		.no_wait_gpu =3D false,
> +	};
> +	struct ttm_lru_walk_arg arg =3D {
> +		.ctx =3D &ctx,
> +		.trylock_only =3D true
> +	};
> =C2=A0	struct dma_fence *fence;
> =C2=A0	int ret, i;
> =C2=A0
> -	do {
> -		ret =3D ttm_bo_evict_first(bdev, man, &ctx);
> +	ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo)
> {
> +		ret =3D ttm_bo_evict(bo, &ctx);
> +		if (ret)
> +			return ret;
> =C2=A0		cond_resched();
> -	} while (!ret);
> -
> -	if (ret && ret !=3D -ENOENT)
> -		return ret;
> +	}
> =C2=A0
> =C2=A0	ret =3D 0;
> =C2=A0
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index bbed63064c9a9..a4060e44d23d0 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -389,6 +389,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
> =C2=A0void ttm_bo_fini(struct ttm_buffer_object *bo);
> =C2=A0void ttm_bo_set_bulk_move(struct ttm_buffer_object *bo,
> =C2=A0			=C2=A0 struct ttm_lru_bulk_move *bulk);
> +int ttm_bo_evict(struct ttm_buffer_object *bo, struct
> ttm_operation_ctx *ctx);
> =C2=A0bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct ttm_place *place);
> =C2=A0int ttm_bo_init_reserved(struct ttm_device *bdev, struct
> ttm_buffer_object *bo,
