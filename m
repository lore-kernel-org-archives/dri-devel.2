Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A3FC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FEA10F27C;
	Fri, 28 Aug 2026 07:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j2uqfu55";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBE910F27C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:02:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E0A66053A;
 Fri, 28 Aug 2026 07:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB0A1F00A3D;
 Fri, 28 Aug 2026 07:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787900540;
 bh=tx/PN1t3hNq6PABQ1WcZYGwr+G27wjV/zT+1n/o3XeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j2uqfu553yBe6hYdIuY9d7iq0ysP6gs+u7SMm18BTs6THc5UbD2BxOinMfDiYvfaJ
 duf9AxeiFdkIJGRx5VwzWSWXnVa5Lz6uY8VdKX4ozbtDXrDG8uOqDv4bWfZ99jDGkx
 sa2p/15dv7YT0U+936pmqGVd2OX/m9k3EhDBLLrthDL5tPr0/ksFWjgSoPzMhi1bn0
 WbJjFmWtod9Z6NZDosh/kGMbpYqgvOSD1RddMwSa0BZauHhddhminwgVIphtaMX1ph
 xw57rfBBPs4LH0hJs8R1z/4gCPAXEkpe+QSmMJPjlIcYI01x5vgZtkXzzsTfb0KFHs
 0LKnXh1CR6itQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] drm/bridge: analogix_dp: Add validation for
 samsung,lane-count property
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260828065153.590802-5-damon.ding@rock-chips.com>
References: <20260828065153.590802-1-damon.ding@rock-chips.com>
 <20260828065153.590802-5-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 07:02:19 +0000
Message-Id: <20260828070219.AAB0A1F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] devm_drm_bridge_add() is used inside a component bind callback, ca=
using devres leakage and double-add on re-bind.
- [High] Missing analogix_dp_unbind() and encoder cleanup in component bind=
 error paths.
--

commit 3586f9db6c3c7447ea980ac18be62fa966e709ae
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Add validation for samsung,lane-count property

Add validity check for samsung,lane-count to ensure DT-provided
lane count values are specification-compliant.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 4213cd68d5a0d..ba12fde8accde 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

This isn't a bug introduced by this patch, but I noticed an issue in the
analogix_dp_bind() component bind flow:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bind() {
	...
	bridge->type =3D DRM_MODE_CONNECTOR_eDP;
	ret =3D devm_drm_bridge_add(dp->dev, &dp->bridge);
	if (ret)
		goto err_unregister_aux;
	...
}

[Severity: High]
Since devm_drm_bridge_add() is called in a component bind function, does it
tie the bridge registration lifetime to the platform device rather than the
component?=20

If the master DRM device defers, unbinds, and later rebinds,
analogix_dp_bind() executes again. Because the devres actions are not
cleaned up during component unbind, would this trigger duplicate devres
additions, list corruption via double list_add_tail() in drm_bridge_add(),
and double initialization of the bridge's hpd_mutex?

This is also a pre-existing issue, but I noticed the error paths in the
component bind functions seem to be missing cleanup steps:

drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:rockchip_dp_bind() {
	...
	connector =3D drm_bridge_connector_init(dp->drm_dev,
					      dp->plat_data.encoder);
	if (IS_ERR(connector)) {
		ret =3D PTR_ERR(connector);
		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
		goto err_cleanup_encoder;
	}

	return 0;
err_cleanup_encoder:
	dp->encoder.encoder.funcs->destroy(&dp->encoder.encoder);
	return ret;
}

[Severity: High]
If drm_bridge_connector_init() fails, does this error path skip calling
analogix_dp_unbind()?=20

This would leave the DP AUX device registered. If component binding is
retried, would drm_dp_aux_register() be called again on the same device,
causing a sysfs duplicate name error and preventing the display from ever
initializing?

A similar issue appears in exynos_dp.c:

drivers/gpu/drm/exynos/exynos_dp.c:exynos_dp_bind() {
	...
	connector =3D drm_bridge_connector_init(dp->drm_dev,
					      dp->plat_data.encoder);
	if (IS_ERR(connector)) {
		ret =3D PTR_ERR(connector);
		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
		return ret;
	}

	return 0;
}

[Severity: High]
If drm_bridge_connector_init() fails here, does the error path miss cleaning
up the resources by skipping both analogix_dp_unbind() and the encoder
destruction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828065153.5908=
02-1-damon.ding@rock-chips.com?part=3D4
