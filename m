Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBCFC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111B010E8E4;
	Mon, 10 Aug 2026 15:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mKmyUTUl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE5010E8E4
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:01:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC24E42451;
 Mon, 10 Aug 2026 15:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0131F000E9;
 Mon, 10 Aug 2026 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786374111;
 bh=YShLWpcwCs6MJSLzKT73D+ZIPEOHNOp2B3e9gM9+pgE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mKmyUTUl5Vi9dUS2PwSCTwhNjkjeHCdZG326Ojxea/DFBX3QETG7EM9Jhtyym5Wdi
 8R2SLBk6lxlbcnUe9efyvTqcVyxwcad9x8wU6YdYsWjB+1o1TY8sKcBygzsUDcylUl
 gSDDgSgun1MudarEs+0UKF3WIHggRdXYrEP78WqoHC8eswlhK2dW9j0pMa5G6b4aYk
 37EQno4Axa9blVjXqSjyknUYrVzQtrlixUcM18PJQZQZ+J8sYnhqH7tvwC+2Lh7gfq
 EZ1Z9rqxW8loSSLIzdx7dgYqvxPyYMqDQzVc9sfruyyjdjUZcyZ5H3O+JCLvUQ1Mz+
 pY6qISD1pXxrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/imx: imx-tve: probe DDC before claiming the
 connector is connected
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-imx53-fix-hdmi-v1-3-fff9b1b17f25@oss.qualcomm.com>
References: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
 <20260810-imx53-fix-hdmi-v1-3-fff9b1b17f25@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:01:50 +0000
Message-Id: <20260810150151.7E0131F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Missing polling configuration for dynamic hotplug detection.

Pre-existing issues:
- [High] Missing -EPROBE_DEFER handling undermines the intended fix under n=
ormal probe ordering.
--

--- Patch [3]: [PATCH 3/4] drm/imx: imx-tve: probe DDC before claiming the =
connector is connected ---
commit 496cfa19c398d86d2f77e8a07cbe96a51f14ca0a
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/imx: imx-tve: probe DDC before claiming the connector is connected

This commit adds a detect_ctx hook to the TVE connector using the DDC bus to
detect whether a monitor is attached. It aims to fix a CRTC timeout issue
caused by unconditionally lighting up the VGA output when nothing is
connected.

> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ip=
uv3/imx-tve.c
> index e861b8b9d8fa8..11ac69561eb81 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> @@ -322,6 +322,7 @@ static const struct drm_connector_funcs imx_tve_conne=
ctor_funcs =3D {
>  static const struct drm_connector_helper_funcs imx_tve_connector_helper_=
funcs =3D {
>  	.get_modes =3D imx_tve_connector_get_modes,
>  	.mode_valid =3D imx_tve_connector_mode_valid,
> +	.detect_ctx =3D drm_connector_helper_detect_from_ddc,

[Severity: Medium]
Since this adds dynamic detection through the detect_ctx callback, shouldn't
we also configure the connector polling flags in imx_tve_bind()?

It looks like the connector is initialized here:

imx_tve_bind() {
    ...
    ret =3D drm_connector_init_with_ddc(drm, connector,
                                      &imx_tve_connector_funcs,
                                      DRM_MODE_CONNECTOR_VGA, tve->ddc);
    ...
}

Without setting connector->polled =3D DRM_CONNECTOR_POLL_CONNECT |
DRM_CONNECTOR_POLL_DISCONNECT, the DRM core's periodic poll worker will
ignore this connector. Will this prevent dynamic detection if a user plugs
in a monitor after boot?

[Severity: High]
This is a pre-existing issue, but could probe ordering undermine this fix?

The patch relies on tve->ddc being initialized to accurately report the
connector status. However, imx_tve_probe() does not currently handle probe
deferral:

imx_tve_probe() {
    ...
    tve->ddc =3D of_find_i2c_adapter_by_node(ddc_node);
    of_node_put(ddc_node);
    if (tve->ddc) {
    ...
}

If the I2C driver hasn't probed yet, tve->ddc will be left as NULL instead
of returning -EPROBE_DEFER.

If detect_ctx is later called with a NULL DDC adapter,
drm_connector_helper_detect_from_ddc() will return connector_status_unknown.
Because the DRM core treats unknown as connected when fallback modes are
involved, does this mean the CRTC timeout bug will reoccur whenever the I2C
driver probes after imx-tve?

>  };
> =20
>  static const struct drm_encoder_helper_funcs imx_tve_encoder_helper_func=
s =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-imx53-fix-=
hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com?part=3D3
