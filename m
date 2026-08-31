Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E0C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66C410EAD2;
	Mon, 31 Aug 2026 19:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dX34+E5i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2A210EAD2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:44:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89A0D601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229931F000E9;
 Mon, 31 Aug 2026 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788205456;
 bh=fqHTf13RmLT7FcddM7nd15iNbeiVZGhnRMjKsi0Pom0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dX34+E5ixoTyJzjoKfQHiQGmPaG1sHTxDxRS2l4/0iCEok/26LDVm2Cx3epmAkr7O
 fhP7w+2WPPAwlvejQo9tX+2ZsTbd8MkgEx7Y4qK1UZp8GyzehvBh5L1xPXWnWPugoB
 7jHFkeANQXIPfWK0cMkHvw8OP0qb6t39nRcUOcvqxhtv4tYNvcamdk0WgD9G27P10R
 fl99i/n4RGYRuRVH3aFmROQjzALaUZ8wfy4XQ/RPm5+tuBzXb8NZVaOIt6jIfm757L
 +7cuLbmmJE/zEKyOFWphmLRtvBEIQMmTVfF9Nldub8vybjM4S6s9mqpgsNbNWY1mpT
 YaDafZgJeZ7dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/40] drm/kmb: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-8-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-8-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:44:15 +0000
Message-Id: <20260831194416.229931F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but calling kfree() =
on an interior pointer allocated by drmm_kzalloc() causes heap corruption a=
nd a double free during DRM device teardown.
--

commit 8cb00e04f7c7c0f7305c33451c9eebfc86df5dd2
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
This isn't a bug introduced by this patch, but calling kfree() on an
interior pointer allocated by drmm_kzalloc() causes heap corruption and a
double free during DRM device teardown.

Looking at kmb_plane_init(), the plane is allocated using the DRM-managed
allocator:

drivers/gpu/drm/kmb/kmb_plane.c:kmb_plane_init() {
        ...
        plane =3D drmm_kzalloc(drm, sizeof(*plane), GFP_KERNEL);
        ...
}

However, in kmb_plane_destroy(), an unmanaged kfree() is erroneously called:

drivers/gpu/drm/kmb/kmb_plane.c:kmb_plane_destroy() {
        ...
        kfree(kmb_plane);
        ...
}

Since this is reachable during normal device teardown or initialization
failure, will this trigger a kernel panic due to an invalid free followed
by a double free when the DRM managed resource is cleaned up by
drm_dev_put()?

> -	.reset =3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D8
