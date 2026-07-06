Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04787C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A58710E718;
	Mon,  6 Jul 2026 02:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QrCRDelC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC19310E718
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:58:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DFDE60018;
 Mon,  6 Jul 2026 02:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF80D1F000E9;
 Mon,  6 Jul 2026 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783306725;
 bh=VlRgTFmC5WmtSwi5qBCoTkQCInEy+eQgGVmTvTM0HE4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QrCRDelCtr9Hu7kODiqwMfMDzPOQZnCZtbWVm1nt55+r5I3hskP/T+MSmQqVy1PBW
 a4wR04+EUZcLecSMYjgfm2OUyr3NBm8jB3bG9+RRgfjXZP5/Dxwxt4Rmd7/KSOwg8D
 pUQH2OOOcfSUT9xV29LaC54TcFTxSSNp5MeABNknV/eGCoIzCD924VEaQtvpk6PLKm
 7As+YT6IXg76zBzJGWURO6E3RnQ/zPfbc7gpOkt0IbFahtf3o5xEq0vWCMOCz68R0J
 fNtx+O0I1Xt6IaLwy1TpxWJHnyYvPPwdo1M1gV+efrSCdNGjXxFAr36n2jVUkTYMfR
 3nudhGyXDr0og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] ttm: add a memcg accounting flag to the
 alloc/populate APIs
To: "Dave Airlie" <airlied@gmail.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706024122.853329-3-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-3-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:58:42 +0000
Message-Id: <20260706025843.AF80D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `memcg_account` flag is not propagated to the TT r=
estore path, causing GPU memory to escape memory cgroup limits after being =
swapped out and restored.
--

commit 915e66ed2150a0401b7163c79a1f518da0005591
Author: Dave Airlie <airlied@redhat.com>

    ttm: add a memcg accounting flag to the alloc/populate APIs
   =20
This commit adds a memcg_account flag to the TTM populate and allocate APIs
to prepare for future memcg accounting. It updates driver callbacks to
accept the new parameter.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 278bbe7a11add..e4dbf4c93091c 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -935,7 +937,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool,=
 struct ttm_tt *tt,
>  			return 0;
>  	}
> =20
> -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
> +	return __ttm_pool_alloc(pool, tt, false, ctx, &alloc, restore);

[Severity: High]
Does this hardcoded false cause memory cgroup limits to be bypassed for
restored pages?

When a TT object is swapped out (backed up), its pages are freed and
uncharged from the memcg. When swapped back in, the pages are re-allocated,
but because ttm_pool_restore_and_alloc() hardcodes false for the
memcg_account parameter, they are not re-charged.=20

This causes a bypass of memory cgroup limits for restored pages, which
could allow an application to allocate GPU memory, trigger swap, and bypass
the restrictions upon restore.

>  }
> =20
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 4c80bac676229..20a10a174d1d3 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -536,6 +536,7 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buf=
fer_object *ttm_bo,
>  }
> =20
>  static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt =
*tt,
> +			      bool memcg_account,
>  			      struct ttm_operation_ctx *ctx)
>  {
>  	struct xe_ttm_tt *xe_tt =3D container_of(tt, struct xe_ttm_tt, ttm);
> @@ -553,7 +554,7 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_=
dev, struct ttm_tt *tt,
>  		err =3D ttm_tt_restore(ttm_dev, tt, ctx);

[Severity: High]
Will we need to update ttm_tt_restore() to accept the memcg_account
parameter as well?

Since ttm_tt_restore() doesn't accept the new memcg_account parameter,
drivers like xe here receive the flag but cannot pass it down when
restoring a backed-up TT object, losing the accounting information.

>  	} else {
>  		ttm_tt_clear_backed_up(tt);
> -		err =3D ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
> +		err =3D ttm_pool_alloc(&ttm_dev->pool, tt, memcg_account, ctx);
>  	}
>  	if (err)
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D2
