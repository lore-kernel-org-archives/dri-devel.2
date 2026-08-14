Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14320C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592FF10F66B;
	Fri, 14 Aug 2026 15:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fgfvld5M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EDA10F66B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:14:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5111D41145
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F6E1F000E9;
 Fri, 14 Aug 2026 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720471;
 bh=jo5eUJsBjN/u7A6ydeyVsxSSI4m1LaKajOxehynode4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fgfvld5MVYKG51mhQpvcaYqt06seBxIRcLMKq1Znz6JWHiMeePnSPke7OZdw9K1f4
 QLreR7Y7KiEFWwd/7mGmSAn/Z0CBQ53IKqTd0E9xqSwQFoFSUzP3bHnhTotUkC1xLW
 pv4Pq3Ipj6K/LPztytZzh5oS0b3JIJGd/plat8sS1AebNXsGeyelW4jZSJgliuI2fu
 xjE4vLsEULQ60o3JisCwgZz0X9dm3nRja9E114CoUt536ZNHQGerzaFL/F5f6AVsyO
 2tpiuUY85bU2wbNAj8eTE/Y/5RrY6pKDkrmoN8GIGvS9Rrr4agahDzMUHPmSivngtU
 9ZGJV+MFETRtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/61] drm/kmb: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-20-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-20-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:14:30 +0000
Message-Id: <20260814151431.09F6E1F000E9@smtp.kernel.org>
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
- [High] Calling `kfree()` on a devres-managed pointer returned by `drmm_kz=
alloc()` causes memory corruption and a slab allocator panic.
--

--- Patch [20]: [PATCH v2 20/61] drm/kmb: Convert to atomic_create_state ---
commit 20dcd87ff6633adea5f70221b0a5e891634f5f0a
Author: Maxime Ripard <mripard@kernel.org>

drm/kmb: Convert to atomic_create_state

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
This isn't a bug introduced by this patch, but does calling kfree() on a
drm-managed pointer in kmb_plane_destroy() cause a slab allocator panic?

In kmb_plane_init(), the plane structure is allocated using the DRM managed
allocator:

kmb_plane_init() {
    ...
    plane =3D drmm_kzalloc(drm, sizeof(*plane), GFP_KERNEL);
    ...
}

However, the .destroy hook points to kmb_plane_destroy(), which uses
kfree():

kmb_plane_destroy() {
    ...
    kfree(kmb_plane);
    ...
}

Since drmm_kzalloc() returns an interior pointer embedded within a drmres
tracking structure, would passing this pointer directly to kfree() bypass
the DRM managed resource system and cause an immediate SLUB allocator panic?

Also, if the kernel survived the free, would a double-free occur during
device teardown when the DRM devres framework attempts to clean up the same
allocation?

This path appears reachable on device removal, unbind, or probe failure,
for example, if drm_crtc_init_with_planes() fails in kmb_setup_crtc():

kmb_setup_crtc() {
    ...
    kmb_plane_destroy(&primary->base_plane);
    ...
}

> -	.reset =3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D20
