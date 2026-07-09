Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DACDC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3ABE10F57A;
	Thu,  9 Jul 2026 12:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X57Ji+t5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7137A10F57A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:10:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA979600C3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3624C1F000E9;
 Thu,  9 Jul 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599034;
 bh=JgqqnoaQ/uJLEhV6k1DjxxMWWTFyz5sok+2KR/viM0g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X57Ji+t5gpu/L8Xy9BnytNPUafAoK4WyL2af9aoCY80zqPG5Kac3iCx6XU+Oy03f5
 ZC+7/MsWEucoBjquQb4vhRCwkSjeFTPeEM1q6BAYT83BWEyJEDGszcYQoj/L8i+1Yn
 RnG3YUs3JgxiX0i2W/f4DwWFh5JEuBMv29WF6SCwaxGK62nVR3vaLx+tu0U0VGHRHn
 Q1xEIPShUY0t2haH8QGBDRorJgzzlP6Zd3bFPLR+KSS00eUuWM2qE1YMMA/FjY69N0
 QFgVualPRiNF4LVbtdifwDkX8CilrZe0TlXzdFSo8UyQP6pNdw37ztx1nCCXEGmXcm
 088GF5mpbuvIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/60] drm/kmb: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-20-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-20-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:10:33 +0000
Message-Id: <20260709121034.3624C1F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but `kmb_plane_destr=
oy()` explicitly calls `kfree()` on a pointer allocated with `drmm_kzalloc(=
)`. The devres-managed `drmm_kzalloc()` allocates a block with a header and=
 returns an interior pointer to the data section. Calling `kfree()` directl=
y on this interior pointer causes an immediate bad slab kernel panic. Furth=
ermore, because the memory is registered with the DRM managed resources sub=
system, it would also lead to a double-free when the DRM device is torn dow=
n.
--

--- Patch [20]: [PATCH 20/60] drm/kmb: Convert to atomic_create_state ---
commit a20682a33b057586ca5c0d0ad2bf47bc5c88d302
Author: Maxime Ripard <mripard@kernel.org>

    drm/kmb: Convert to atomic_create_state
   =20
    The plane only initializes a pristine state in its reset hook
    using drm_atomic_helper_plane_reset(), which is equivalent to what
    atomic_create_state expects. Convert to it.

[ ... ]

> diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_pl=
ane.c
> index a0001edb1e21a..1742c2c6dfd89 100644
> --- a/drivers/gpu/drm/kmb/kmb_plane.c
> +++ b/drivers/gpu/drm/kmb/kmb_plane.c
> @@ -561,7 +561,7 @@ static const struct drm_plane_funcs kmb_plane_funcs =
=3D {
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
>  	.destroy =3D kmb_plane_destroy,

[Severity: High]
This isn't a bug introduced by this patch, but kmb_plane_destroy() explicit=
ly
calls kfree() on a pointer allocated with drmm_kzalloc().

The devres-managed drmm_kzalloc() allocates a block with a header and retur=
ns
an interior pointer to the data section:

drivers/gpu/drm/kmb/kmb_plane.c:kmb_plane_init() {
    ...
    for (i =3D 0; i < KMB_MAX_PLANES; i++) {
        plane =3D drmm_kzalloc(drm, sizeof(*plane), GFP_KERNEL);
    ...
}

Calling kfree() directly on this interior pointer in kmb_plane_destroy() wi=
ll
cause an immediate bad slab kernel panic:

drivers/gpu/drm/kmb/kmb_plane.c:kmb_plane_destroy() {
    ...
    struct kmb_plane *kmb_plane =3D to_kmb_plane(plane);

    drm_plane_cleanup(plane);
    kfree(kmb_plane);
}

Additionally, because the memory is registered with the DRM managed resourc=
es
subsystem, this will lead to a double-free when the DRM device is torn down.

Should this manual kfree() be removed to avoid the panic and double-free?

> -	.reset =3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D20
