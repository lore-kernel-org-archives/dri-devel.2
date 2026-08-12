Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D971BC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26BA10E2A4;
	Wed, 12 Aug 2026 15:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gccTAr/0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F4B10E2A4
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:20:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CD3A40311;
 Wed, 12 Aug 2026 15:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B611F000E9;
 Wed, 12 Aug 2026 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786548018;
 bh=c0yA88OFrqU6fia2SkX1Fx50EWZ0trYYTecpHyEHwQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gccTAr/04kw+U1UEL1vM80IH9eOnxj6Ob/xF3v8WaGxEZH5sgxKOPh04uT/WFsg6W
 3ZilXmVXxYQ9ha3khuZVME+CL04Av4zIBuQnf3ycOGUQw5aqLCXF8cDC+GzyOc6XjX
 RB1/0zbmhEZa0EFshjPFt72x6WufzVaRoxxmrr3n3axoud7lypzJc71jMHrstwocgq
 DtLstl1RjHLNDeOid3/s3nVgwiw5o1bDvl2q5o5Ts86TPTBhlo5DgRmNc+47YLl2qj
 FwIYPwnFuy+3/sFbLl8uEEFUNyOXb7eymFYpJL+o6Xhfdk8x4cgz5Kt0NFnjGzBe6l
 sjlJN4cJMH46g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/nouveau: prevent NULL deref of gr in
 GETPARAM_GRAPH_UNITS
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:20:17 +0000
Message-Id: <20260812152018.45B611F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The patch fixes a NULL pointer dereference for `gr` in `nouveau_ab=
i16_ioctl_getparam()`, but misses an identical vulnerability in `nouveau_ab=
i16_ioctl_get_zcull_info()` within the same file.
--

--- Patch [2]: [PATCH 2/2] drm/nouveau: prevent NULL deref of gr in GETPARA=
M_GRAPH_UNITS ---
commit 368f46fbd7701fc98a09aa941af876abf6e518b8
Author: Zhenhao Wan <whi4ed0g@gmail.com>

drm/nouveau: prevent NULL deref of gr in GETPARAM_GRAPH_UNITS

This patch prevents a NULL pointer dereference in nouveau_abi16_ioctl_getpa=
ram()
when an unprivileged client requests NOUVEAU_GETPARAM_GRAPH_UNITS. If the
graphics engine is absent, gr is NULL, which previously oopsed the kernel.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/no=
uveau/nouveau_abi16.c
> index 291203121f0c2..dd3f8d386377f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -306,7 +306,7 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
>  		getparam->value =3D 1;
>  		break;
>  	case NOUVEAU_GETPARAM_GRAPH_UNITS:
> -		getparam->value =3D nvkm_gr_units(gr);
> +		getparam->value =3D gr ? nvkm_gr_units(gr) : 0;
>  		break;
>  	case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
>  		int ib_max =3D getparam_dma_ib_max(device);

[Severity: High]
This is a pre-existing issue, but does a similar NULL pointer dereference
vulnerability exist slightly further down in the same file?

If the graphics engine is absent (making gr =3D=3D NULL), could an unprivil=
eged
client calling DRM_IOCTL_NOUVEAU_GET_ZCULL_INFO trigger a kernel oops here?

drivers/gpu/drm/nouveau/nouveau_abi16.c:nouveau_abi16_ioctl_get_zcull_info(=
) {
	...
	struct nvkm_gr *gr =3D nvxx_gr(drm);
	struct drm_nouveau_get_zcull_info *out =3D data;

	if (gr->has_zcull_info) {
	...
}

Should nouveau_abi16_ioctl_get_zcull_info() also check if gr is valid before
dereferencing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-nouveau-nv=
km-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com?part=3D2
