Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B7C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4CF10E052;
	Sat,  4 Jul 2026 09:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mWM9CTHA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADFA10E03F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:24:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 801686001A;
 Sat,  4 Jul 2026 09:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29901F000E9;
 Sat,  4 Jul 2026 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783157049;
 bh=9g1M//fB3kUTee06CSULh3f5JxrsVKUUm1z/yZKZzHg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mWM9CTHAJ1v5DAQxhBbjPxQcS7PRwraDTv+CU9v7SmCmJ+WyJnoGZScykUMgEZtGO
 8kufY4fp6GO5IBH4kka+YvnhlyZrD9MFNWnlccDkwtZnaaTZSTNK7itvKFKMA/Oxc9
 tR/TvbInbmngu3ECsnLEAonaCSxeHTIMBVxy29gp5km8bfQj63PnSVZbdHdHyXQkDu
 bfwSDUJwI3fvJzpX0NdfTZvBZVhr/etZTZ0eGR1hr2EV3D4G8twaxRwmIGTQUnhlqU
 FtERWGuOs9hnRpxZjx1KxAEwWXMWKW2pQx7NC+R2jqwJIbjDYwNkiETkyHD8Lu+yc1
 Vn96Do77WjUIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/rockchip: Remove dependency on DRM simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260704-rockchip-drm-simple-v5-1-a333f527a4f9@gmail.com>
References: <20260704-rockchip-drm-simple-v5-1-a333f527a4f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 09:24:07 +0000
Message-Id: <20260704092408.A29901F000E9@smtp.kernel.org>
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
- [High] Unchecked return value of drm_encoder_init() leads to NULL pointer=
 dereference on error or unbind paths.
- [High] Incorrect usage of devres (devm_*) functions inside component bind=
 callbacks causes resource leaks and duplicate registrations.
--

commit 58124ed88e765fc2655a16706ba7e0962ef4b3df
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/rockchip: Remove dependency on DRM simple helpers

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting. This patch removes
the drm_simple_encoder_init() helper usage in the rockchip drivers
by open coding it and using the encoder atomic helpers directly.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index e159e1627f3c2..68aa66915e8ac 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
[ ... ]
> @@ -988,8 +991,8 @@ static int cdn_dp_bind(struct device *dev, struct dev=
ice *master, void *data)
>  							     dev->of_node);
>  	DRM_DEBUG_KMS("possible_crtcs =3D 0x%x\n", encoder->possible_crtcs);
> =20
> -	ret =3D drm_simple_encoder_init(drm_dev, encoder,
> -				      DRM_MODE_ENCODER_TMDS);
> +	ret =3D drm_encoder_init(drm_dev, encoder, &cdn_dp_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
This is a pre-existing issue, but could using devm_drm_bridge_add() and
other devres functions inside a component bind callback cause resources to
permanently leak on unbind?

The DRM component framework calls bind and unbind callbacks during the mast=
er
DRM device lifecycle. However, the component platform devices themselves are
not destroyed during unbind. Because devm allocations are tied to the
platform device's lifetime, they are not freed when unbind runs.

When cdn_dp_bind() is called again, new resources are allocated and registe=
red,
causing duplicate registrations (such as devm_extcon_register_notifier) and
undefined behavior on re-bind.

>  	if (ret) {
>  		DRM_ERROR("failed to initialize encoder with drm\n");
>  		return ret;
[ ... ]
> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> index 9b8981fa19aee..f28d6a883e099 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
[ ... ]
> @@ -696,7 +699,8 @@ rk3066_hdmi_register(struct drm_device *drm, struct r=
k3066_hdmi *hdmi)
>  		return -EPROBE_DEFER;
> =20
>  	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but should the return value of
drm_encoder_init() be checked here?=20

If drm_encoder_init() fails, the encoder->funcs pointer remains NULL and
initialization continues because the error is ignored. If a subsequent
initialization step fails, or during a later component unbind in
rk3066_hdmi_unbind(), the code unconditionally executes:

    hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);

Can this lead to a NULL pointer dereference? The patch replaced the function
call without adding the necessary error check that was properly added to
other drivers updated in this same patch.

[Severity: High]
This is also a pre-existing issue, but similar to the devres issues in
cdn_dp_bind() and rockchip_rgb_init(), does using devm_kzalloc() and=20
devm_request_threaded_irq() in rk3066_hdmi_bind() cause resources to
permanently leak on unbind?

Because devm allocations are tied to the platform device's lifetime, they
are not freed when unbind runs, leaking resources and causing duplicate IRQ
handler registrations on re-bind.

> =20
>  	hdmi->bridge.driver_private =3D hdmi;
>  	hdmi->bridge.funcs =3D &rk3066_hdmi_bridge_funcs;
[ ... ]
> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/ro=
ckchip/rockchip_rgb.c
> index add3123e5ce70..2ad24b914989f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
[ ... ]
> @@ -127,7 +130,8 @@ struct rockchip_rgb *rockchip_rgb_init(struct device =
*dev,
>  	encoder =3D &rgb->encoder.encoder;
>  	encoder->possible_crtcs =3D drm_crtc_mask(crtc);
> =20
> -	ret =3D drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_NONE=
);
> +	ret =3D drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);

[Severity: High]
This is a pre-existing issue, but does the devm allocation in
rockchip_rgb_init() leak memory when the VOP unbinds and re-binds?

rockchip_rgb_init() is called from vop_bind(), and devm_kzalloc() ties the
memory to the VOP device's lifetime, which is not destroyed during an unbin=
d.
When bind is called again, new resources are allocated and registered, leak=
ing
the old ones.

>  	if (ret < 0) {
>  		DRM_DEV_ERROR(drm_dev->dev,
>  			      "failed to initialize encoder: %d\n", ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704-rockchip-d=
rm-simple-v5-1-a333f527a4f9@gmail.com?part=3D1
