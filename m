Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E051C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C11210E9EA;
	Tue,  8 Sep 2026 05:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nP+VGzgk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A46E10E9EA
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 05:12:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CA4841600;
 Tue,  8 Sep 2026 05:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0B81F00A3A;
 Tue,  8 Sep 2026 05:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788844368;
 bh=/+IK8w7WpFTP2qvi5xNJEz+WT0e//SC4KVLE9N6LWhM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nP+VGzgkOZ2FtnV9FJpUKC7fgPUOGnucskp0SaN84sULflFdOJGPZ7qC3/6MC99Ep
 48ZJIe+ppxIGoZqsZlxhg5+4aNp+5CkLAR1/9Yq7HM4nSOlFeK1qfd1Q1EutRxGetX
 cFJVgLDsYkJ4pnE+XhX+zuXVP/rmkdcQslaIutjnotX3CsMufQYtAEo8JMiVQ1t5hm
 RpgqoBVK1Enadb2u2kuxxy8qRRNOCUG81Gw3A2XNr2HA1+G76XKjP8uUW9BedUTkWH
 /ntgPEJDpOmyMhFyMLZ6zpi65U9WcimKBjw5oR0QM4pbOcPOSMdBj2DyRwdkdho+RY
 nclA4vO/OT/YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/sun4i: Align VI buffer addresses for subsampled
 formats
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260908050229.754977-1-wenst@chromium.org>
References: <20260908050229.754977-1-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:12:48 +0000
Message-Id: <20260908051248.AA0B81F00A3A@smtp.kernel.org>
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

New issues:
- [High] DMA buffer underflow caused by mixing clipped and unclipped plane =
coordinates

Pre-existing issues:
- [High] Hardware clipping broken because `drm_fb_dma_get_gem_addr()` ignor=
es clipped source coordinates
--

commit ecc3d1ed4b5c80402d5086efdcdc7ff6a120827c
Author: Chen-Yu Tsai <wenst@chromium.org>

drm/sun4i: Align VI buffer addresses for subsampled formats

This commit adjusts the DMA address returned by drm_fb_dma_get_gem_addr
for subsampled formats by calculating an intra-block offset and subtracting
it. This ensures the address points to the start of a subsampled block for
the display hardware.

> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -207,6 +207,20 @@ static void sun8i_vi_layer_update_buffer(struct sun8=
i_layer *layer,
>  		/* Get the start of the displayed memory */
>  		dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);

[Severity: High]
This is a pre-existing issue, but does using drm_fb_dma_get_gem_addr
break hardware clipping since it ignores clipped source coordinates?

The drm_fb_dma_get_gem_addr function calculates the base address using the
unclipped coordinates (state->src_x and state->src_y).=20

If the hardware relies on the DMA base address to handle source X/Y offsets,
providing the unclipped address would cause it to fetch pixels starting from
the unclipped origin. This could shift the image and reveal regions that
should be hidden when a plane is placed partially off-screen on the left or
top edge.

> =20
> +		/*
> +		 * The mixer can handle odd offsets into sub-sampled YUV
> +		 * planes, but needs the address of the first pixel in each
> +		 * sub-sampled block. Adjust the luma buffer address backwards.
> +		 */
> +		if (i =3D=3D 0) {
> +			u32 x_diff, y_diff;
> +
> +			x_diff =3D (state->src.x1 >> 16) & (format->hsub - 1);
> +			y_diff =3D (state->src.y1 >> 16) & (format->vsub - 1);
> +			dma_addr -=3D y_diff * fb->pitches[i];
> +			dma_addr -=3D x_diff * format->cpp[i];

[Severity: High]
Can this subtraction lead to a DMA buffer underflow if the plane is clipped?

If userspace positions a sub-sampled YUV plane partially off-screen to the
left or top, the DRM core clips the source rectangle. This makes state->src=
.x1
or state->src.y1 positive, while the original state->src_x and state->src_y
remain 0.

Because drm_fb_dma_get_gem_addr calculates the base dma_addr using the
unclipped coordinates, it will start at offset 0. The patch then calculates
x_diff and y_diff using the clipped state->src.x1 and state->src.y1.

If the plane is clipped by 1 pixel, y_diff might be 1. Subtracting
y_diff * pitch from the unclipped base dma_addr (which is at offset 0)
would shift the pointer into unallocated memory before the start of the
buffer, which could trigger IOMMU faults or memory corruption.

> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908050229.7549=
77-1-wenst@chromium.org?part=3D1
