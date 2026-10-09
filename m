Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC07ACA6017
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE0710E188;
	Fri,  9 Oct 2026 00:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FS1/0KgV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C5710E188
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 00:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 186D660DAF;
 Fri,  9 Oct 2026 00:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC41F000FF;
 Fri,  9 Oct 2026 00:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791505895;
 bh=5OlITJ0s80uw2JtIjKIqR3zSVcbOregfKjsrOYC72yk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FS1/0KgVQu1M5ZfUAWL/cNvGB4Oh+6B9m1o5adjpFvolHKZyaDxSIj9KGRqxkGbyV
 qChsKVrqUwXFv+1ABv2APsSkoHtJCgveGCbw2LNNjn45UCYkA7V6JJ2v5zFFeRsW2+
 75IX3jhzb/HO1/33x47uBqjmo5TGdK3fEpXPKmTlgwRdHf8E9C9bkKlbB81DG9WAhJ
 9ptcV8AgYEfU5kLUAm8dYmfmrvlRSEofpgFDsjwH+kh5B/+/VQ0E63jycWK+Fs7UO3
 4yR36LR8WmrCxZKlh5vcRolyjGJbjbjl5amNw0J0QfuKiUHnt0dacRozTqIMUmID90
 tk4r4VVS2F1bA==
Message-ID: <sashiko-outbox-164673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] drm/rockchip: Map imported buffers from DMA
 addresses
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261009002114.67851-3-kmehltretter@gmail.com>
References: <20261009002114.67851-1-kmehltretter@gmail.com>
 <20261009002114.67851-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 00:31:35 +0000
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
- [Medium] drm/rockchip: DMABUF_DEBUG crash on fallback iommu_map_sgtable i=
mport
--

commit 59e8ac2bc0441a5d0b8e3d0e4089c7508adc71d5
Author: Karl Mehltretter <kmehltretter@gmail.com>

drm/rockchip: Map imported buffers from DMA addresses

This commit updates rockchip_gem_iommu_map() to use iommu_map_sgtable_dma()
for imported buffers to avoid CONFIG_DMABUF_DEBUG import failures. If the
DMA mapping is not supported, it falls back to the old page-based path using
iommu_map_sgtable().

Link: https://lore.kernel.org/r/DLR74W1U9YPC.375IK0HOYHDIG@cknow-tech.com/
Link: https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_gem.c
> index 9a1dc9f120729..501c94cb921ad 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c

[ ... ]

> @@ -40,8 +41,16 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_=
object *rk_obj)
> =20
>  	rk_obj->dma_addr =3D rk_obj->mm.start;
> =20
> -	ret =3D iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sg=
t,
> -				prot);
> +	if (dma_dev) {
> +		ret =3D iommu_map_sgtable_dma(private->domain, rk_obj->dma_addr,
> +					    dma_dev, rk_obj->sgt, prot);
> +		if (ret =3D=3D -EOPNOTSUPP)
> +			ret =3D iommu_map_sgtable(private->domain, rk_obj->dma_addr,
> +						rk_obj->sgt, prot);

[Severity: Medium]
Will this fallback path crash if CONFIG_DMABUF_DEBUG is enabled?

The commit message mentions that unsupported imports still use the old
page-based path and remain unfixed. When iommu_map_sgtable_dma() returns
-EOPNOTSUPP, this code falls back to iommu_map_sgtable() which reads CPU-si=
de
pages. Since the dma-buf core explicitly clears these CPU-side page pointers
when CONFIG_DMABUF_DEBUG is enabled, won't this fallback lead to an invalid
memory access or kernel panic?

Should the code return an error instead of falling back to a function that
is known to crash under these conditions?

> +	} else {
> +		ret =3D iommu_map_sgtable(private->domain, rk_obj->dma_addr,
> +					rk_obj->sgt, prot);
> +	}
>  	if (ret < (ssize_t)rk_obj->base.size) {
>  		DRM_ERROR("failed to map buffer: size=3D%zd request_size=3D%zd\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009002114.6785=
1-1-kmehltretter@gmail.com?part=3D2
