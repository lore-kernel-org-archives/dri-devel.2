Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD6ECD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578A110F624;
	Mon,  8 Jun 2026 15:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MJskV8wR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A64810F624
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:45:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAD6C601E2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E11F00898;
 Mon,  8 Jun 2026 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780933529;
 bh=QJeMgHuu9iuynCBTl0kUULt+dKYF04en3cirM3HDdQM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MJskV8wRfOpTV3JLlmC47pCUihQocHeUnr1uVIx0HP/Xx4iMfNPjiCJPz7GCYPjNU
 xGHoj+SN7R+ACdhJgW4x/ZcDpP3oqbs9L1EMYHQOMtpUG3CU7KhZLd0MaasZuKz3Oo
 uLT0GM6xdhdK19uSQkrt4aUJovhjbfXkKLflwdwmRdCwpTWBFQ0v8vGlfwY2x7QmVH
 sO0UHR/Q880m+lFgy4CHK+OyP0PKKcVRq24ERU53TE2GxPEmAZk2eTOgU1ivAKtp7R
 s1Ylq8C5pBBtO7WDLnKcalbKxlKbjB9/XuEUC/ESdoSafduI5GEo8O2xHAVT/gCg0m
 z4BgBSO0xl4Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/78] drm/bridge: imx8mp-hdmi-pvi: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-14-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-14-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:45:28 +0000
Message-Id: <20260608154529.3A7E11F00898@smtp.kernel.org>
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
- [High] Unbalanced pm_runtime_put and potential unclocked register access =
if pm_runtime_resume_and_get fails in atomic_enable.
- [High] Use-After-Free and unmapped memory access due to devm_ resource li=
fetime mismatch when the device is unbound.
--

commit 935043b57c7562e813344d06040c4edaf524faa0
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: imx8mp-hdmi-pvi: Switch to atomic_create_state

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.
Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/d=
rm/bridge/imx/imx8mp-hdmi-pvi.c
> index 7d5fda7173e5f..a31d4fc76f35b 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> @@ -131,7 +131,7 @@ static const struct drm_bridge_funcs imx_hdmi_pvi_bri=
dge_funcs =3D {
>  	.atomic_get_input_bus_fmts =3D imx8mp_hdmi_pvi_bridge_get_input_bus_fmt=
s,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  };
> =20
>  static int imx8mp_hdmi_pvi_probe(struct platform_device *pdev)

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling in
imx8mp_hdmi_pvi_bridge_enable() leave the bridge in a state that could
trigger a regression later?

If pm_runtime_resume_and_get() fails in the enable path, it returns without
setting a flag:

drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:imx8mp_hdmi_pvi_bridge_enable(=
) {
	...
	if (WARN_ON(pm_runtime_resume_and_get(pvi->dev)))
		return;
	...
}

Later, imx8mp_hdmi_pvi_bridge_disable() unconditionally writes to the regis=
ters
and decrements the usage counter:

drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:imx8mp_hdmi_pvi_bridge_disable=
() {
	...
	writel(0x0, pvi->regs + HTX_PVI_CTRL);

	pm_runtime_put(pvi->dev);
}

Could this unconditional write to an unclocked IP block cause a synchronous
data abort, and lead to a PM usage counter underflow?

[Severity: High]
This is a pre-existing issue, but could this resource allocation pattern
cause a regression during device unbind?

The bridge structure and I/O registers are allocated using devres in the
probe function:

drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:imx8mp_hdmi_pvi_probe() {
	...
	pvi =3D devm_drm_bridge_alloc(&pdev->dev, struct imx8mp_hdmi_pvi,
				    bridge, &imx_hdmi_pvi_bridge_funcs);
	...
	pvi->regs =3D devm_platform_ioremap_resource(pdev, 0);
	...
}

If the driver is unbound, these devm-managed resources will be freed and
unmapped. However, since drm_bridge_remove() does not synchronize with acti=
ve
display pipelines, the DRM core might still hold references to the bridge.

If the pipeline is torn down after unbind, imx8mp_hdmi_pvi_bridge_disable()
would be called:

drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:imx8mp_hdmi_pvi_bridge_disable=
() {
	...
	writel(0x0, pvi->regs + HTX_PVI_CTRL);
	...
}

Would this result in accessing unmapped registers and the freed bridge
structure during pipeline teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D14
