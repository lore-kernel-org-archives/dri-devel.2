Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F678C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEA810E3FA;
	Fri, 24 Jul 2026 08:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nXxgDfsB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD5910E3FA
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:19:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49C8E600AF;
 Fri, 24 Jul 2026 08:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9787E1F000E9;
 Fri, 24 Jul 2026 08:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784881160;
 bh=gWx9UNVjnKtfoMQ6Z9LFyVzOm7NhkgnrUH+MpbB/elI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nXxgDfsBwm+ZUt6Eth+EAa3OfgEVuYG3YfvDrEyPevhJobDxTtWYj61sq68Ij4MgZ
 1783J+sGf5X9ioDch5oRmsUYqdiCYERFt8P79KU5NaTz9xB2BwFm0OQZykF0N4ZjZ1
 Xxwwe5lkHcIgka4SByz/A/7vq1Q0ezw/8eLRO9tKUsKNbnM8bKJdhFdwS/mPlvfWZv
 m+4YsKxmddx9EhpEJ3Uo9CNIfrhPTaZS0lXY/Z99o43agP64ed36B0RUVU1eHCQI6k
 0YdNSW5yieYn2FPB0bqWPq8fAfme6guLi6KYjCQUa4imjdbBnjXh28Kv6CXge7d2qp
 hWKZ3ZVQ60WkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/rockchip: lvds: propagate bus_flags to the
 CRTC state
To: "Rok Markovic" <rok@kanardia.eu>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260724080824.115260-2-rok@kanardia.eu>
References: <20260724080824.115260-1-rok@kanardia.eu>
 <20260724080824.115260-2-rok@kanardia.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 08:19:19 +0000
Message-Id: <20260724081919.9787E1F000E9@smtp.kernel.org>
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
- [High] rockchip_lvds_bind overwrites external bridge function pointers, p=
erforms invalid frees on error paths, and leaks objects on unbind.
--

--- Patch [1]: [PATCH v2 1/4] drm/rockchip: lvds: propagate bus_flags to th=
e CRTC state ---
commit 1b0e3d7f00cf4d61b195bc93e8d5dc954705b92b
Author: Rok Markovic <rok@kanardia.eu>

drm/rockchip: lvds: propagate bus_flags to the CRTC state

rockchip_lvds_encoder_atomic_check() sets output_mode and output_type
but never copies the connector's bus_flags into the Rockchip CRTC state.
This prevents the VOP from deriving the pixel clock polarity, causing
panels to be clocked on the wrong edge.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/r=
ockchip/rockchip_lvds.c
> index 7a0c4fa29f2f0..150299c12298a 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c

[ ... ]

While reviewing this patch, I noticed some pre-existing issues in the same
file.

Looking at rockchip_lvds_bind():

	if (lvds->bridge) {
		lvds->bridge->driver_private =3D lvds;
		lvds->bridge->ops =3D DRM_BRIDGE_OP_MODES;
		lvds->bridge->funcs =3D &rockchip_lvds_bridge_funcs;

[Severity: High]
This is a pre-existing issue, but does overwriting the bridge's function
pointers and private data here destroy the foreign driver state if this is
an external bridge?=20

It seems this would break drm_bridge_is_panel() and prevent the bridge from
being enabled or providing modes.


Further down in rockchip_lvds_bind() on the error path:

err_free_bridge:
	drm_panel_bridge_remove(lvds->bridge);

[Severity: High]
This is a pre-existing issue, but could this error path leak the panel brid=
ge?

Since the bridge's funcs were overwritten earlier in this function,
drm_bridge_is_panel() will return false. This would cause
drm_panel_bridge_remove() to early-return without freeing the bridge.


Looking at rockchip_lvds_unbind():

static void rockchip_lvds_unbind(struct device *dev, struct device *master,
				void *data)
{
	struct rockchip_lvds *lvds =3D dev_get_drvdata(dev);
	const struct drm_encoder_helper_funcs *encoder_funcs;

	encoder_funcs =3D lvds->soc_data->helper_funcs;
	encoder_funcs->disable(&lvds->encoder.encoder);
	pm_runtime_disable(dev);
}

[Severity: High]
This isn't a bug introduced by this patch, but is the unbind function
missing cleanup for the bridge, encoder, and connector?=20

It appears these objects will leak and corrupt the DRM state list on
every unbind.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724080824.1152=
60-1-rok@kanardia.eu?part=3D1
