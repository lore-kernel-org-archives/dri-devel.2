Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C99C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C70010E4B5;
	Fri,  3 Jul 2026 17:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PY7o9x23";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3574510E4B5
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 17:10:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC98740A48;
 Fri,  3 Jul 2026 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F61F00A3A;
 Fri,  3 Jul 2026 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783098626;
 bh=RBMn8CnW3Xmm1eYDu7RN78211Ee6d8xpmI9N20hLV10=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PY7o9x23M6FxTDhOnNE3CwTJWlmOER+GDdPq4zIy+1UdAkTR42z3qgq8LP0Uc4bP1
 4bN0v8ITzkM+4bIWuOw/yeFl/YbZElW4xbN4i28gW+FjAOo94eH3xRekmGNXNILBLt
 YpVdcX5BrZx3EOsTaS0HyjiX34amAh2kInkFjXDnmNQgb62cSdHFPOLT460bGP2TR9
 xpeB42vvjsBb2kYWD+tZ9yrAEh+8O5MoNIk3SMBwvNNXFYp7yDyzCkpCZv24k7RrJF
 GMdVJSQVb1TVP86VWFA1ha2b+wnZ2LNsfNLiQ03eT2HoWaQzP1wkcFaqZYU4FVawll
 d/VW1BIGit2zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] drm/ttm: use ttm_bo_lru_for_each_reserved_guarded
 in evict_all
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-ttm_2_drm_exec-v1-7-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-7-43685ac1286b@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:10:26 +0000
Message-Id: <20260703171026.897F61F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ttm_resource_manager_evict_all() silently skips locked BOs instead=
 of waiting for them, failing to ensure the resource manager is completely =
empty.
- [Low] The function prototype for ttm_bo_evict_first() was left in the hea=
der despite its implementation being removed.
--

commit 916bbbd30917f83e8ac0aca7e1ff8e726b30968b
Author: Christian K=C3=B6nig <christian.koenig@amd.com>

drm/ttm: use ttm_bo_lru_for_each_reserved_guarded in evict_all

This patch replaces the while loop in ttm_resource_manager_evict_all()
with the ttm_bo_lru_for_each_reserved_guarded() iterator. It also removes
the ttm_bo_evict_first() function and makes ttm_bo_evict() available
externally.

> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm=
_resource.c
> index 154d6739256f8..cf3fc3a594388 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -561,17 +561,25 @@ EXPORT_SYMBOL(ttm_resource_manager_init);
>  int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>  				   struct ttm_resource_manager *man)
>  {
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
>  	struct dma_fence *fence;
>  	int ret, i;
> =20
> -	do {
> -		ret =3D ttm_bo_evict_first(bdev, man, &ctx);
> +	ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo) {

[Severity: High]
Does this new iterator loop silently skip locked BOs instead of waiting for=
 them?

Because arg.trylock_only is set to true, the iterator will fail to trylock
any BO currently reserved by another thread and simply continue to the next=
 one:

drivers/gpu/drm/ttm/ttm_bo_util.c:__ttm_bo_lru_cursor_next() {
        ...
		} else if ((!arg->ticket || arg->ctx->no_wait_gpu ||
			    arg->trylock_only) && !arg->ctx->exec) {
			spin_unlock(lru_lock);
			ttm_bo_put(bo);
			spin_lock(lru_lock);
			continue;
		}
        ...
}

The previous while loop would repeatedly try to evict everything until
ttm_bo_evict_first() returned -ENOENT. Will this new single-pass approach c=
ause
ttm_resource_manager_evict_all() to return success (0) while leaving un-evi=
cted
BOs behind if they are concurrently locked?

> +		ret =3D ttm_bo_evict(bo, &ctx);
> +		if (ret)
> +			return ret;
>  		cond_resched();
> -	} while (!ret);
> -
> -	if (ret && ret !=3D -ENOENT)
> -		return ret;
> =20
>  	ret =3D 0;
> =20
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index bbed63064c9a9..a4060e44d23d0 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -389,6 +389,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
>  void ttm_bo_fini(struct ttm_buffer_object *bo);
>  void ttm_bo_set_bulk_move(struct ttm_buffer_object *bo,
>  			  struct ttm_lru_bulk_move *bulk);
> +int ttm_bo_evict(struct ttm_buffer_object *bo, struct ttm_operation_ctx =
*ctx);

[Severity: Low]
This isn't a bug, but it looks like the prototype for ttm_bo_evict_first()
was left in include/drm/ttm/ttm_bo.h even though its implementation is remo=
ved
by this patch.

>  bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>  			      const struct ttm_place *place);
>  int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_obje=
ct *bo,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-ttm_2_drm_=
exec-v1-0-43685ac1286b@gmx.de?part=3D7
