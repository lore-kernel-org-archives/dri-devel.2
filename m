Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBDCC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B7210E1A7;
	Mon,  6 Jul 2026 13:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iIga0vWA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B7C10E1A7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:57:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A61A403BE;
 Mon,  6 Jul 2026 13:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120061F000E9;
 Mon,  6 Jul 2026 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783346264;
 bh=cEUXQE8v67wbYiTzbCmSop15osBemRp0tkTxxiCOCJA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iIga0vWAAmGWYojm40XKWhoZ/8kVoAEN7nRPfnKlp+VmpCfkd+9JeFJAduNj3Lt2P
 +ESyDENKrp0D34ugp7WlJIdpY3P99xevD+WQ+yTWDLJn3ydsRCvajdC48+kHCIRqUr
 lo95/nqXQd6kyrPcdwlS1uSPOEfK9fZbLQjiwpk0cDQTLUdSldvbKeaMZZHGM9k71N
 OG08f3pMZdFFV+tlqdNQ79SXQZSzwpYwik/T7FfOSTdv54LwsQvDJuF5U2rcnrcOoa
 AZ09qVTE6ntei9izqMlzS6KWggqft3GyrAgOuF+0m/W1LaDTlCaDWkZycRCg44YFgT
 ElcRD36A7okjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] gpu/drm: Remove unused 'drm device *dev' parameter
 from drm_mode_create()
To: "Jan Niedziolka" <j.niedziolka@samsung.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706134515.3369960-3-j.niedziolka@samsung.com>
References: <20260706134515.3369960-1-j.niedziolka@samsung.com>
 <CGME20260706134551eucas1p2699f145a53a0d5d8cd92d0a062c62ad9@eucas1p2.samsung.com>
 <20260706134515.3369960-3-j.niedziolka@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:57:43 +0000
Message-Id: <20260706135744.120061F000E9@smtp.kernel.org>
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
- [Low] Build failure due to referencing non-existent members in struct exy=
nos_dp_device and unused static functions.
--

commit aa4d752f4408535e5aa104d5d47b153a65ec83e2
Author: Jan Niedziolka <j.niedziolka@samsung.com>

gpu/drm: Remove unused 'drm device *dev' parameter from drm_mode_create()
   =20
This commit removes the unused struct drm_device *dev parameter from the
drm_mode_create() prototype and definition. It also updates all calls to
drm_mode_create() to reflect this change.

> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/=
exynos_dp.c
> index b805403281504..78183809b4fb3 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -68,6 +68,53 @@ static int exynos_dp_poweroff(struct analogix_dp_plat_=
data *plat_data)
>  	return exynos_dp_crtc_clock_enable(plat_data, false);
>  }
> =20
> +static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data,
> +			       struct drm_connector *connector)
> +{
> +	struct exynos_dp_device *dp =3D to_dp(plat_data);
> +	struct drm_display_mode *mode;
> +
> +	if (dp->plat_data.panel)
> +		return 0;
> +
> +	mode =3D drm_mode_create();
> +	if (!mode) {
> +		DRM_DEV_ERROR(dp->dev,
> +			      "failed to create a new display mode.\n");
> +		return 0;
> +	}
> +
> +	drm_display_mode_from_videomode(&dp->vm, mode);

[Severity: Low]
Does this code compile successfully? Looking at the definition of
struct exynos_dp_device, it doesn't appear to have a vm member. This might
cause a build failure.

> +	connector->display_info.width_mm =3D mode->width_mm;
> +	connector->display_info.height_mm =3D mode->height_mm;
> +
> +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_set_name(mode);
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_da=
ta,
> +				   struct drm_bridge *bridge,
> +				   struct drm_connector *connector)
> +{
> +	struct exynos_dp_device *dp =3D to_dp(plat_data);
> +	int ret;
> +
> +	dp->connector =3D connector;

[Severity: Low]
Similarly here, is connector a valid member of struct exynos_dp_device?

> +
> +	/* Pre-empt DP connector creation if there's a bridge */
> +	if (dp->ptn_bridge) {

[Severity: Low]
And here, does struct exynos_dp_device have a ptn_bridge member? It looks
like these functions might have been accidentally pasted from another driver
during a rebase, as they don't seem to match the struct definition and don't
appear to be referenced anywhere in this file.

> +		ret =3D drm_bridge_attach(&dp->encoder, dp->ptn_bridge, bridge,
> +					0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706134515.3369=
960-1-j.niedziolka@samsung.com?part=3D2
