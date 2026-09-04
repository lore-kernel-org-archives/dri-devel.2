Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79FEC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB51B10F920;
	Fri,  4 Sep 2026 08:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GOfd59ZP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C17510F920
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:07:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6168B40712;
 Fri,  4 Sep 2026 08:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34441F00A3D;
 Fri,  4 Sep 2026 08:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788509273;
 bh=TTpe92jTRI6wSX1y43XSvLdwYbEXW2c0BGBAa0o80Nw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GOfd59ZPCSnZQnLFo6jDTOqBNrAeF6Cs798Ot87LIk1HpCNXtLMlmjKn78lRYwcAW
 PYrycCNydbnf7IgcLnuJVBAcPiLOOnhDSIon53fPIJWNQGwFmGUG07Qfj8oTrAtdMp
 EcGQ6ejA5ySG1uOcRY2m/hcy+0ZUkeguxfJU8J2LN2VEpz4UboG9JBTi9IRZsHi0wZ
 IYQS5EygpSsaPFoKRtcXQm1J/ebjO5JlXHYGlMRrCBhKDw3Pud9p6Ydy0me/dOhZp9
 B5IePd773qGqBD+mMGUweg9WE4LlK5cAhrQEp6cKOt3kE8TqgvOtr09lVA0XuMrwY7
 ja7ESWIgNJYeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] drm/imx: dc-fu: Fix dimensions
To: "Liu Ying" <victor.liu@nxp.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-imx8-dc-prefetch-v6-3-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-3-26643e3f6cb7@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:07:52 +0000
Message-Id: <20260904080752.D34441F00A3D@smtp.kernel.org>
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
- [High] Integer underflow in plane dimensions when a plane is fully clippe=
d, causing hardware misconfiguration.
--

commit dbd00e4ed77401b79cffe99deaf03ef1ee191363
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc-fu: Fix dimensions

This commit fixes an off-by-one issue in LINEWIDTH, LINECOUNT, FRAMEWIDTH
and FRAMEHEIGHT macro definitions used to set fetchunit dimensions.

> diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-f=
u.c
> index 1d8f74babef8a..2e197b3344bd1 100644
> --- a/drivers/gpu/drm/imx/dc/dc-fu.c
> +++ b/drivers/gpu/drm/imx/dc/dc-fu.c
> @@ -31,8 +31,8 @@
>  #define STRIDE(x)			FIELD_PREP(STRIDE_MASK, (x) - 1)
> =20
>  /* SOURCEBUFFERDIMENSION */
> -#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x))
> -#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
> +#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
> +#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)

[Severity: High]
Could this unconditional subtraction cause an integer underflow when a
plane is fully clipped?

When an unprivileged userspace application moves a DRM plane completely
off-screen, drm_atomic_helper_check_plane_state() sets
plane_state->visible =3D false and clips the src and dst rectangles such
that their width and height become 0 or negative.

Because dc_plane_atomic_update() lacks an early return for
!new_state->visible, it appears to extract src_w and src_h and pass them
to these macros:

drivers/gpu/drm/imx/dc/dc-plane.c:dc_plane_atomic_update() {
    ...
	src_w =3D drm_rect_width(&new_state->src) >> 16;
	src_h =3D drm_rect_height(&new_state->src) >> 16;
    ...
	fu_ops->set_src_buf_dimensions(fu, DC_FETCHUNIT_FRAC0, src_w, src_h);
	fu_ops->set_framedimensions(fu, src_w, src_h);
    ...
}

Because (x) - 1 underflows for x <=3D 0, FIELD_PREP() would apply the
bitmask and result in the maximum possible field value (16383) being
written to the hardware registers. Will this cause out-of-bounds DMA
fetches leading to IOMMU faults or system lockups?

> diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-f=
u.h
> index f678de3ca8c0a..cc93317e30013 100644
> --- a/drivers/gpu/drm/imx/dc/dc-fu.h
> +++ b/drivers/gpu/drm/imx/dc/dc-fu.h
> @@ -38,8 +38,8 @@
>  #define YUVCONVERSIONMODE(x)		FIELD_PREP(YUVCONVERSIONMODE_MASK, (x))
> =20
>  /* FRAMEDIMENSIONS */
> -#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x))
> -#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
> +#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
> +#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)

[Severity: High]
Similarly, will these frame dimension macros also underflow to the maximum
field width when height or width is 0 or negative?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-imx8-dc-pr=
efetch-v6-0-26643e3f6cb7@nxp.com?part=3D3
