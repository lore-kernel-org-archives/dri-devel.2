Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BC2C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6651210E879;
	Mon,  6 Jul 2026 10:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AqCTTc0V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00ECD10E879
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:34:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64D8761383;
 Mon,  6 Jul 2026 10:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40541F000E9;
 Mon,  6 Jul 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783334079;
 bh=0pb+xIEN5/7F1waBY5L39gOPHp3RJ4rl9J1pGcH3GRc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AqCTTc0VquXWxJ88j7DK/DOS9FyUkwI7lDXTin5X7Mu4gHv7eN4f6L4uQUHkooh81
 wrmdYQvXiGAux0+lsilmhVFqAfdT2O12Fw1XKsXBDZlFUBy2ts3D7jI54Ya4Rgaj5G
 39TOaWMDUGhaXLAeHgWmPDuFrR6EzXtHUsyEAK8+ZS0n4ido7X4KR/sSuTtrbN0XtN
 LV9+WoTIOvcD+QWkPLH/JoZr4s1PHk34KynyuxWJrAyQ00IVfxk/FMx4g8zTPfE0UL
 QP0YeT0JEiif5d8tWXjsYLDWs+tDaRssetcLKIHZ9Aype4q0IRO5PadWNh3biWd5lH
 +kPHK7lg2p7ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] drm/ttm: use
 ttm_bo_lru_for_each_reserved_guarded in evict_all
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-ttm_2_drm_exec-v2-7-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-7-4bf6bfc0d320@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:34:37 +0000
Message-Id: <20260706103438.E40541F000E9@smtp.kernel.org>
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
- [High] ttm_resource_manager_evict_all silently skips locked and zero-refc=
ount BOs, failing to completely evict the manager.
- [Medium] cond_resched() is called while the buffer object's dma_resv lock=
 is held.
--

commit ff3394ed91bf06ac0115f1da5665b9edeeb4a66b
Author: Natalie Vock <nat@pixelcluster.dev>

drm/ttm: use ttm_bo_lru_for_each_reserved_guarded in evict_all

Use the for_each loop to evict all BOs of an resource manager as well.
Greately simplifying the handling and finally allows us to remove
ttm_bo_evict_first().

> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm=
_resource.c
> index 154d6739256f8..107b6cfea66b3 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c

[ ... ]

> @@ -561,17 +561,24 @@ EXPORT_SYMBOL(ttm_resource_manager_init);
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
> +	};
>  	struct dma_fence *fence;
>  	int ret, i;
> =20
> -	do {
> -		ret =3D ttm_bo_evict_first(bdev, man, &ctx);
> +	ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo) {
> +		ret =3D ttm_bo_evict(bo, &ctx);
> +		if (ret)
> +			return ret;

[Severity: High]
Does this new loop successfully evict all buffers if some are locked by oth=
er
threads?

With the previous do/while loop using ttm_bo_evict_first(), it would keep
retrying until the manager was genuinely empty.=20

Using ttm_bo_lru_for_each_reserved_guarded() with an arg where
arg.ticket =3D NULL, __ttm_bo_lru_cursor_next() skips locked or zero-refcou=
nt BOs:

drivers/gpu/drm/ttm/ttm_bo_util.c:__ttm_bo_lru_cursor_next() {
        ...
        } else if (!arg->ticket || arg->ctx->no_wait_gpu ||
                   arg->trylock_only) {
            spin_unlock(lru_lock);
            ttm_bo_put(bo);
            spin_lock(lru_lock);
            continue;
        }
        ...
}

Because the new loop is a single-pass iteration, will these skipped BOs be =
left
permanently in the resource manager, potentially causing resource leaks or
kernel crashes (like a WARN_ON for non-empty LRU lists) during driver unloa=
d or
device suspend?

> -		cond_resched();
> -	} while (!ret);
> -
> -	if (ret && ret !=3D -ENOENT)
> -		return ret;
> +		cond_resched();

[Severity: Medium]
Is cond_resched() being called here while holding the buffer object's
dma_resv lock?

The ttm_bo_lru_for_each_reserved_guarded iterator yields each BO with its
dma_resv lock held, and only releases it during the implicit next call at t=
he
end of the loop.

Yielding the CPU while holding this lock might stall other kernel paths wai=
ting
for the lock.=20

In the previous implementation, the lock was explicitly released inside
ttm_bo_evict_first() before cond_resched() was invoked.

> +	}
> =20
>  	ret =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ttm_2_drm_=
exec-v2-0-4bf6bfc0d320@pixelcluster.dev?part=3D7
