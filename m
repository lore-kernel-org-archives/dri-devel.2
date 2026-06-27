Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314A6C43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D3010F76D;
	Sat, 27 Jun 2026 03:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jG/4GAzi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4A710F76E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:44:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A12A4416E3;
 Sat, 27 Jun 2026 03:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CD41F000E9;
 Sat, 27 Jun 2026 03:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531895;
 bh=mvVbH37Pv4i9ADM7ffdbX/XSo7QL+XUklL0P91iHOO8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jG/4GAziEhZHym6bfaMqs2alDjtCcf/j6BxxOH6kQWPb93MxGnXZ41UH55fFjQMZH
 t0sUnUJ62FlhA1dBwZF6B6y31ou0FUYvKbKX3sIyLMqImyU3aIotZqGPVTTb5l53gY
 3NAYFCr1ICvVVI3sBdwnc8YnhpgiaW950MhPxcNglCqDr+95vW6yhubw5bFLY1vE81
 dSp9feMXhk0MK12Og8kguJe/qSpp209ZZy0MgfJPk8//AdGXxP6vhXJ4jkC5yB8y1y
 jc72cYnDL+UmbrAcrZ2eWRAtNcenbo6salgDXlVoDfTB2YWiM7BltASNxv1U3ou9dI
 k0vxnRlPa6yjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/38] drm/vkms: Properly render plane using their zpos
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-24-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-24-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:44:54 +0000
Message-Id: <20260627034455.54CD41F000E9@smtp.kernel.org>
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
- [High] Heap Out-of-bounds Write / NULL Pointer Dereference in vkms_crtc_a=
tomic_check and blend.
- [High] Validation Bypass / Incorrect API Usage via calling drm_atomic_nor=
malize_zpos in CRTC atomic check.
--

commit ba6a2ee7af0fa7f9537a297540c84e807c85f3f7
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Properly render plane using their zpos

Currently planes are rendered in creation order. This is not an issue, but
with the introduction of new zpos configuration, it is required to
properly render planes.

> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index 079abfba427d0..b9428de2d4aa8 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -142,14 +142,20 @@ static int vkms_crtc_atomic_check(struct drm_crtc *=
crtc,
>  		return -ENOMEM;
>  	vkms_state->num_active_planes =3D i;
> =20
> -	i =3D 0;
> +	ret =3D drm_atomic_normalize_zpos(crtc->dev, state);
> +	if (ret)
> +		return ret;

[Severity: High]
Does calling drm_atomic_normalize_zpos() inside a per-CRTC atomic check byp=
ass
plane validation?

In the DRM atomic framework, drm_atomic_helper_check_planes() calls plane
atomic_check() callbacks before CRTC atomic_check() callbacks. By calling
drm_atomic_normalize_zpos() here and adding affected planes to the state, a=
ny
planes pulled into the state at this stage will completely miss their
plane-level validation.

Also, since drm_atomic_normalize_zpos() operates on the global atomic state=
, it
will be executed redundantly for every modified CRTC.

Could this be handled by setting dev->mode_config.normalize_zpos =3D true d=
uring
driver initialization instead, letting the core run the helper before the p=
lane
validation phase?

> +
>  	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
>  		plane_state =3D drm_atomic_get_new_plane_state(crtc_state->state, plan=
e);
> =20
>  		if (!plane_state->visible)
>  			continue;
> =20
> -		vkms_state->active_planes[i++] =3D
> +		// Order planes according to their normalized_zpos
> +		// After drm_atomic_normalize_zpos, the possible values are 0..n_plane=
s-1
> +		// so store them using this index
> +		vkms_state->active_planes[plane_state->normalized_zpos] =3D
>  			to_vkms_plane_state(plane_state);

[Severity: High]
Can this cause an out-of-bounds write if there are invisible planes?

Earlier in this function, vkms_state->active_planes is allocated based on t=
he
number of visible planes (the variable i).

However, drm_atomic_normalize_zpos() computes a sequential normalized_zpos =
for
all planes attached to the CRTC, not just visible ones. If a userspace clie=
nt
configures planes such that some are invisible (e.g., clipped or scaled to =
0),
the maximum normalized_zpos will exceed the allocated size (i - 1), resulti=
ng
in a heap out-of-bounds write.

Additionally, this sparse assignment leaves holes in the array. During
composition, blend() in drivers/gpu/drm/vkms/vkms_composer.c iterates up to
num_active_planes and blindly dereferences the plane array elements. Will t=
his
cause a NULL pointer dereference for the skipped indices?

>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D24
