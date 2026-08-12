Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54424C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840D510F07A;
	Wed, 12 Aug 2026 15:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mIqivNDF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB39710F07A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:27:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84A0F418DA;
 Wed, 12 Aug 2026 15:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D181F000E9;
 Wed, 12 Aug 2026 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786548454;
 bh=80cTA5ocKhIoqgyfZagIw6qEBlJvTAGfovfoYXUzzcQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mIqivNDFNUhkHJHTbBUaYdqTzCyVoBeosyT5dY7H9xDQdR7iE9W1jFfMvGnz2IcQ8
 MjXcVZCerqtO1vuMgisewFO+rqQN4F/lPPX9mLR4kmVCfBqUf6YTZXQMrLcZqvupsa
 jvk9WVYuQTKl+CsKHS3AqSRcAzqDCOCtNVA56OIuoovbrPRnr1Y0TIC6+Y9yw4zmkJ
 OZe+IBgMMXc311nM8LU4rvzlPDrG+TXT1nuhoE3QM4nYiNlq+VtP2vTMZsZZNsQdw9
 kynUa2zAL/wzh2KGc3FMxoZTNtBxvzr5bC9IplyY3FNBaIbbHgw35fUD+cHBk1ttoW
 vIeuJy0jJCrdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/nouveau/sw: prevent NULL deref of disp in
 vblank methods
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:27:33 +0000
Message-Id: <20260812152734.46D181F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Potential heap buffer overflow and out-of-bounds array access =
in SW channel initialization and method handlers if the display hardware su=
pports more than 4 heads.
- [High] Truncation of 64-bit virtual addresses on hardware with >40-bit ad=
dress spaces (e.g., GV100) when updating vblank offset.
--

--- Patch [1]: [PATCH 1/2] drm/nouveau/sw: prevent NULL deref of disp in vb=
lank methods ---
commit 8a4bbb200908564b29f376aa02dccafae5c8262f
Author: Zhenhao Wan <whi4ed0g@gmail.com>

    drm/nouveau/sw: prevent NULL deref of disp in vblank methods

This commit prevents a NULL pointer dereference in the software-class vblank
methods nv50_sw_chan_mthd() and gf100_sw_chan_mthd(). It adds a check to ve=
rify
device->disp is not NULL before accessing device->disp->vblank.index_nr,
protecting against kernel oopses on headless cards where the display subdev=
ice
is absent.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/sw/gf100.c
> index 0171cdf6f6397..4cf8cd120c765 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> @@ -72,7 +72,7 @@ gf100_sw_chan_mthd(struct nvkm_sw_chan *base, int subc,=
 u32 mthd, u32 data)
>  		chan->vblank.value =3D data;
>  		return true;
>  	case 0x040c:
> -		if (data < device->disp->vblank.index_nr) {
> +		if (device->disp && data < device->disp->vblank.index_nr) {

[Severity: Critical]
This is a pre-existing issue, but can this out-of-bounds array access cause
heap corruption?

The notify array in struct nv50_sw_chan is fixed to 4 elements:

	struct nvkm_event_ntfy notify[4];

If the hardware supports more than 4 display heads (e.g. GV100) and
device->disp->vblank.index_nr is greater than 4, a user-supplied data value
up to index_nr - 1 can bypass the check and overflow the notify array:

	nvkm_event_ntfy_allow(&chan->vblank.notify[data]);

Could we bound-check data against the array capacity instead of index_nr?


[Severity: High]
This isn't a bug introduced by this patch, but does the offset handling
earlier in gf100_sw_chan_mthd() truncate 64-bit virtual addresses?

When userspace attempts to set a virtual address greater than 40 bits and
writes method 0x0400 followed by 0x0404, it looks like bits 40-63 of the
offset are erroneously cleared by the mask:

	case 0x0404:
		chan->vblank.offset &=3D 0xff00000000ULL;
		chan->vblank.offset |=3D data;

This clears bits above 39, which could cause the vblank semaphore to be
written to an incorrect GPU virtual address.

>  			nvkm_event_ntfy_allow(&chan->vblank.notify[data]);
>  			return true;
>  		}
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/sw/nv50.c
> index 0cfb1eaae6ded..b202e11238a53 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> @@ -69,7 +69,7 @@ nv50_sw_chan_mthd(struct nvkm_sw_chan *base, int subc, =
u32 mthd, u32 data)
>  	case 0x0400: chan->vblank.offset =3D data; return true;
>  	case 0x0404: chan->vblank.value  =3D data; return true;
>  	case 0x0408:
> -		if (data < device->disp->vblank.index_nr) {
> +		if (device->disp && data < device->disp->vblank.index_nr) {

[Severity: Critical]
This is a pre-existing issue, but this location suffers from the same
out-of-bounds array access as gf100_sw_chan_mthd().

Since chan->vblank.notify is a 4-element array, if
device->disp->vblank.index_nr exceeds 4, could an unprivileged client
provide a data value that causes an overflow when accessing
&chan->vblank.notify[data]?

>  			nvkm_event_ntfy_allow(&chan->vblank.notify[data]);
>  			return true;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-nouveau-nv=
km-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com?part=3D1
