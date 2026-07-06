Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ABAC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102FB10E749;
	Mon,  6 Jul 2026 05:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BBzXmJiz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA7810E749
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:35:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45F98400B5;
 Mon,  6 Jul 2026 05:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D207E1F000E9;
 Mon,  6 Jul 2026 05:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316113;
 bh=9f7f1WnbhwZkoBXa0vTCuIiiuxQKcdIRpquxVoHczK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BBzXmJizYPJP/AAvY0alp3yLhKOyPJukQ00MbyvOLSPa5UZslC/EI0CxNev4k4uaV
 99SQXJZ1LgdesaqrxDVedaX3vOv0xWD49cY/yyWcdOliLrFxqH2QReMy/ZYrnURTi/
 IJWQtURqGDcCuRgNzvwT23ocXKVwULlEWaDIZGvaD/Boj0xKwKggwWLVSSRH6XPSGA
 N9NOsJk+SpWTq3Xnj+vxD0juNmbXertsvoRrxZgy4jC5FOTT4AVc648sAwKQupkQQ1
 xDEAZAUmNmV/eyMAxXR3YSnzyETHfDlufHu8w+uZLZ82c0vtkoMw9VKgWxFrFQRj2P
 5Y0cDsc1Nv7oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] ttm: add a memcg accounting flag to the
 alloc/populate APIs
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706052330.1110909-3-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-3-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:35:12 +0000
Message-Id: <20260706053512.D207E1F000E9@smtp.kernel.org>
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
- [High] The `memcg_account` flag is not plumbed through `ttm_tt_restore` a=
nd `ttm_pool_restore_and_alloc`, bypassing memory cgroup accounting for res=
tored TTs.
--

commit b7727d0f7c7e75f86466225e149812b98610b27c
Author: Dave Airlie <airlied@redhat.com>

ttm: add a memcg accounting flag to the alloc/populate APIs

This flag does nothing yet, but this just changes the APIs to accept
it in the future across all users.

[ ... ]

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
>  }

[Severity: High]
Should ttm_pool_restore_and_alloc() and ttm_tt_restore() also be updated to
accept the memcg_account flag?

By hardcoding false here, pages allocated to restore a backed-up TT will by=
pass
memory cgroup accounting. This could allow userspace to circumvent memory l=
imits
by triggering swapout/backup and subsequently forcing a restore.

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 4c80bac676229..20a10a174d1d3 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -553,7 +554,7 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_=
dev, struct ttm_tt *tt,
>  		err =3D ttm_tt_restore(ttm_dev, tt, ctx);
>  	} else {
>  		ttm_tt_clear_backed_up(tt);
> -		err =3D ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
> +		err =3D ttm_pool_alloc(&ttm_dev->pool, tt, memcg_account, ctx);
>  	}
>  	if (err)

[Severity: High]
Because ttm_tt_restore() wasn't updated to take the memcg_account parameter=
, the
flag passed into xe_ttm_tt_populate() is dropped when a backed-up buffer is
restored. Does this mean restored TTs in the xe driver will fail to be trac=
ked
by their memory cgroup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D2
