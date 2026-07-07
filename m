Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D45C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BFE10E0D8;
	Tue,  7 Jul 2026 16:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C0m/bi7Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A865210E0D8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:00:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E3B0600FF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB51F000E9;
 Tue,  7 Jul 2026 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440049;
 bh=XhfIB40pHuHgnUGY0ifMoiuNqRbdEf/MKta+E7FtvGw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C0m/bi7QiY45F3PfcnxRUJdV3Y5ZbXzG3tFElVtZEsqbgSln1KgBRuZbwNDBvwA8y
 C2/RbSF/uM0SLpIbjUuD0l2swH3XwGDkfcexf81TMNkrdBHxTDoiLqEJa5s83ZWv0W
 qGjWuXhf6AN841Pym9+kIqHAbUk5Pne5/hvKr6nGnHJ/qvFpw8cWkqxIBJkEgqVn5n
 baoAm8GQaa+f01i/Dk975Iz919wMxhMcGXD1VNLzlY9ZL0y2/VS/Mzx/O5vjqh+ob7
 wrSxcm1xWQhBOb+/7Mq+mzTZE3D/xH6lytojV/Ew3Jcop2AMVpsDrtcOlYr/YJmNuc
 0Zyq4KwrgFKLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/37] drm/exynos: mic: Switch to atomic bridge
 callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-26-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-26-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:00:49 +0000
Message-Id: <20260707160049.8FEB51F000E9@smtp.kernel.org>
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
- [High] The result of `exynos_drm_crtc_get_by_type()` is dereferenced dire=
ctly without an error pointer check, leading to a kernel panic.
--

--- Patch [26]: [PATCH v2 26/37] drm/exynos: mic: Switch to atomic bridge c=
allbacks ---
commit 1ac627a57ce38903ca33c5eb6829642986ddaad3
Author: Maxime Ripard <mripard@kernel.org>

drm/exynos: mic: Switch to atomic bridge callbacks

This commit switches the mic bridge driver to use atomic pre_enable and
post_disable callbacks instead of the legacy non-atomic ones. It also adds
the necessary atomic state handlers to support the transition in the DRM
bridge core.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_mic.c
> index e68c954ec3e61..3069f958137f5 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c

[ ... ]

> @@ -295,9 +298,12 @@ static void mic_pre_enable(struct drm_bridge *bridge)
>  }
> =20
>  static const struct drm_bridge_funcs mic_bridge_funcs =3D {
> -	.post_disable =3D mic_post_disable,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_post_disable =3D mic_post_disable,
>  	.mode_set =3D mic_mode_set,
> -	.pre_enable =3D mic_pre_enable,
> +	.atomic_pre_enable =3D mic_pre_enable,
>  };
> =20
>  static int exynos_mic_bind(struct device *dev, struct device *master,
>  			   void *data)

[Severity: High]
This is a pre-existing issue, but can this function trigger a kernel
panic on invalid or incomplete devicetree configurations?

Looking at exynos_mic_bind(), exynos_drm_crtc_get_by_type() can return
an error pointer like ERR_PTR(-ENODEV) if the LCD CRTC component is
not found:

	struct exynos_drm_crtc *crtc =3D exynos_drm_crtc_get_by_type(drm_dev,
						       EXYNOS_DISPLAY_TYPE_LCD);
	struct drm_encoder *e, *encoder =3D NULL;

	drm_for_each_encoder(e, drm_dev)
		if (e->possible_crtcs =3D=3D drm_crtc_mask(&crtc->base))
			encoder =3D e;

Since the code passes &crtc->base to drm_crtc_mask() without checking
if crtc is an error pointer first, and drm_crtc_mask() dereferences it to
access crtc->index, won't this cause a panic during probe if the component
is missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D26
