Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1C2C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB9610E0CC;
	Tue, 14 Jul 2026 20:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GZ88ljOH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4271510E0CC
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:40:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCFB24049B;
 Tue, 14 Jul 2026 20:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B601F000E9;
 Tue, 14 Jul 2026 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784061626;
 bh=eMwuiiVXZtcMNsrsV59LBCASCN0xEf161qO/7bI4i+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GZ88ljOH2zlrUPHIT/Ezhj37m1CJUwf9ixK/XdHxOXMC5zybZm64VQGEeI6TCRoDk
 J5m0k0ceg7WswOddTWJeHWV+ZP3dz+V4WoKgHWQljUWOeHYsdmVwg0C5N03CkpQsS6
 HMpcg5Kn+7fCwZJSqOsvOn4y6rYZejegg7UQJmVzTM8vFGUIQAvhjsHy5qkQL74KiX
 Y+2l7CNoLUOTVqAE8gcNALfL7fEyg6r5mCX1/OQJ+05ywRQfFWpG9UEo+1YQzFiCYM
 CKrJAhLfx0LUpodicx1WAMzamR2KU+qYLkdI2hZt32Gp6Z0+3jgp7UmbZVVDVVCPvA
 aUql5B9MG2tbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714202850.40999-1-royalnet026@gmail.com>
References: <20260714202850.40999-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 20:40:26 +0000
Message-Id: <20260714204026.84B601F000E9@smtp.kernel.org>
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
- [High] Returning an error from `dw_hdmi_qp_rockchip_bind()` without cance=
lling `hdmi->hpd_work` leads to a Use-After-Free when the delayed work or H=
PD interrupt fires.
--

--- Patch [1]: [PATCH] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace=
 connector property ---
commit 77d2f0e8bc60d50755aec22dee119ad08bb92b3c
Author: Igor Paunovic <royalnet026@gmail.com>

drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace connector property

This commit creates and attaches the standard HDMI colorspace property=20
after the bridge connector is initialised. This allows userspace to request=
=20
BT.2020 colorimetry and enables wide-gamut/HDR output on RK3588.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
[ ... ]
> @@ -695,6 +695,20 @@ static int dw_hdmi_qp_rockchip_bind(struct device *d=
ev, struct device *master,
>  		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
>  				     "Failed to init bridge connector\n");
> =20
> +	/*
> +	 * Attach the HDMI Colorspace property. The HDMI connector framework
> +	 * already consumes conn_state->colorspace for the AVI infoframe
> +	 * (drm_hdmi_avi_infoframe_colorimetry()), and HDR_OUTPUT_METADATA and
> +	 * max bpc are attached by drmm_connector_hdmi_init(), but without the
> +	 * Colorspace property userspace cannot request BT.2020 signalling,
> +	 * which keeps wide-gamut/HDR output unavailable. Passing 0 selects
> +	 * the full HDMI colorspace set defined by the core.
> +	 */
> +	ret =3D drm_mode_create_hdmi_colorspace_property(connector, 0);
> +	if (ret)
> +		return ret;

[Severity: High]
This is a pre-existing issue, but by adding this error path, the patch
exposes it further. Does returning an error here without cancelling=20
hdmi->hpd_work risk a use-after-free?

If a hardware HPD interrupt fires right before the devres cleanup=20
unregisters the IRQ, hdmi->hpd_work can get queued. The DRM master=20
teardown then frees hdmi (which was allocated via drmm_kzalloc),=20
leaving the delayed work to execute later with a dangling pointer:

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rk3588_hpd_work()=
 {
        struct rockchip_hdmi_qp *hdmi =3D container_of(work,
                                                     struct rockchip_hdmi_q=
p,
                                                     hpd_work.work);
        struct drm_device *drm =3D hdmi->encoder.encoder.dev;
        ...
}

Could we ensure that the delayed work is properly cancelled before=20
returning errors from dw_hdmi_qp_rockchip_bind()?

> +	drm_connector_attach_colorspace_property(connector);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714202850.4099=
9-1-royalnet026@gmail.com?part=3D1
