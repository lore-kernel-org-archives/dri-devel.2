Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC023C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DE610E1BF;
	Mon, 20 Jul 2026 15:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lgp+DB77";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1F410E1BF
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:52:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21F4A43CE4;
 Mon, 20 Jul 2026 15:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977A51F00A3A;
 Mon, 20 Jul 2026 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784562760;
 bh=nGdQxqcaIC04tyTye7SFtUtqtKsuT9hgPtoDK04EPgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lgp+DB77KA0glEGY2KC3kK7SGwXXDWcymcYVLNkJX/iJPvDbZ/wjSCfHYtH9bA17q
 RsePj2B38Hza3XWDiLs1CzU/fnLKX5bX62+fwvh06ja77yT7oJQQZi4WgZnNcziRSh
 VU9BHGcpdQVURVCip3a40uIxVQxBDcFM40QjyPoJQPBYiP6j1ODf80N3JPqCK+XMDX
 xR58yaP42uYK5BpHpcXXCtwzrg/sTDz8C5aYkyGtJXHFDS0xLBT5AyjFND6xAoAfep
 b94bXG3sFn7ltkeJ/LAYihpSJB7yOeNE7aFPT0dHB/Y8bjZ1+lTlLG/ws9xZ8b3kDS
 dXfYFDM0S5zqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/15] drm/exynos: remove dependency on DRM simple
 helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: Frank.Li@kernel.org, neil.armstrong@linaro.org,
 wsa+renesas@sang-engineering.com, imx@lists.linux.dev,
 linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-drm_simple_encoder_init-v2-1-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <20260720-drm_simple_encoder_init-v2-1-5020b630668a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:52:39 +0000
Message-Id: <20260720155239.977A51F00A3A@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the DP AUX chann=
el and resources registered by analogix_dp_bind() are leaked if drm_bridge_=
connector_init() fails, leading to a Use-After-Free (UAF).
--

--- Patch [1]: [PATCH v2 01/15] drm/exynos: remove dependency on DRM simple=
 helpers ---
commit c403fdd838b4dabbda14312eb449cb97a7566462
Author: Diogo Silva <diogompaissilva@gmail.com>
Subject: drm/exynos: remove dependency on DRM simple helpers

The simple KMS helpers are deprecated because they only add an
intermediate layer between drivers and atomic modesetting. Open-code
drm_simple_encoder_init() by calling drm_encoder_init() directly and
providing driver-local drm_encoder_funcs.

> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/=
exynos_dp.c
> index b805403281504..957382223956a 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c

[ ... ]

> @@ -95,7 +99,12 @@ static int exynos_dp_bind(struct device *dev, struct d=
evice *master, void *data)
> =20
>  	dp->drm_dev =3D drm_dev;
> =20
> -	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	ret =3D drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret) {
> +		drm_err(drm_dev, "Failed to initialize encoder\n");
> +		return ret;
> +	}
> =20
>  	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);

[Severity: High]
This isn't a bug introduced by this patch, but looking further down in
exynos_dp_bind(), if drm_bridge_connector_init() fails, does this code leak
the DP AUX character device and resources registered by analogix_dp_bind()?

Currently, if the bridge connector init fails:

	connector =3D drm_bridge_connector_init(dp->drm_dev, dp->plat_data.encoder=
);
	if (IS_ERR(connector)) {
		ret =3D PTR_ERR(connector);
		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
		return ret;
	}

The error path returns directly without calling analogix_dp_unbind() to roll
back the earlier success of analogix_dp_bind().

Since the component bind fails, the master DRM bind will also fail, and the
component's unbind hook (exynos_dp_unbind()) is never invoked.

When the devres framework later frees the struct analogix_dp_device, could
the still-registered /dev/drm_dp_auxN character device cause a
Use-After-Free if accessed from userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-drm_simple=
_encoder_init-v2-0-5020b630668a@gmail.com?part=3D1
