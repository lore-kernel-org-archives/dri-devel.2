Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257E7C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA6E10E743;
	Mon,  6 Jul 2026 05:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eEA79zAE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C6610E743
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE3C660018;
 Mon,  6 Jul 2026 05:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F821F000E9;
 Mon,  6 Jul 2026 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316086;
 bh=3Y4f8XzFzwksbP9/uSVkdbUQKa7kDjkCoFi3xZNE3/U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eEA79zAEWXmrMPjSE+q+OruLGYNOyhm8eBt3YebhkY1D6hN0xXYeR188Fw10UZ5HP
 NRjPgJM/oIaYIfPfHu73yP3uRMI8F90YaDOYSni5sAFx1Sq4AT5VstXAM6UT+QmmQf
 YiOy75QQJ4ff+HCp4F0BeOOkk5UOtO5P9T8XKlDkHFJDFMm4BCDrqKRD+ddASQCk6g
 lkQmR8hcJRe1VTY1lCs89mIXd03qkmwpYfIk8jBNywidQXYhovF6u+EiLRgoIja/7u
 r84tWtu6xKt/LGh31gX43DsiL3uRrgBXQoYPvCSsPTNiYxFdRGwZX1up94VUMBSYkg
 Y3+IVbyVjJ7Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] ttm: add objcg pointer to bo and tt (v3)
To: "Dave Airlie" <airlied@gmail.com>
Cc: mkoutny@suse.com, dri-devel@lists.freedesktop.org, tj@kernel.org,
 hannes@cmpxchg.org
In-Reply-To: <20260706052330.1110909-5-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-5-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:34:45 +0000
Message-Id: <20260706053446.61F821F000E9@smtp.kernel.org>
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
- [High] The obj_cgroup reference acquired in ttm_buffer_object_transfer() =
is leaked on the error path.
--

commit 1cccf014e6a8377ef4e98ad7bba76a7229069c1c
Author: Dave Airlie <airlied@redhat.com>
Subject: ttm: add objcg pointer to bo and tt (v3)

This commit adds the obj cgroup pointer to the bo and tt structs, and
sets it between them.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_=
bo_util.c
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -238,6 +238,8 @@ static int ttm_buffer_object_transfer(struct ttm_buff=
er_object *bo,
>  		return -ENOMEM;
> =20
>  	fbo->base =3D *bo;
> +	if (bo->objcg)
> +		obj_cgroup_get(bo->objcg);
> =20
>  	/**
>  	 * Fix up members that we shouldn't copy directly:

[ ... ]

>  	ret =3D dma_resv_trylock(&fbo->base.base._resv);
>  	WARN_ON(!ret);
> =20
>  	ret =3D dma_resv_reserve_fences(&fbo->base.base._resv, TTM_NUM_MOVE_FEN=
CES);
>  	if (ret) {
>  		dma_resv_unlock(&fbo->base.base._resv);
>  		kfree(fbo);
>  		return ret;
>  	}

[Severity: High]
Does this error path leak the objcg reference?

We acquire a new reference for the transfer buffer object with
obj_cgroup_get() earlier in ttm_buffer_object_transfer(). If
dma_resv_reserve_fences() fails, this error path frees the memory for fbo
and returns, but it doesn't seem to drop the newly acquired objcg reference.

Should there be a call to obj_cgroup_put() before returning here to ensure
the memory cgroup doesn't stay pinned indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D4
