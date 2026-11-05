Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3F606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYDI438H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E5E10E144;
	Thu,  5 Nov 2026 18:28:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EC910E144
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:28:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27D26600B4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04D81F000C1;
 Thu,  5 Nov 2026 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793903285;
 bh=1nXhkm1lXooy9DBSDeilQjJqUExHyUyUwtdhZd3hCjI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IYDI438HjlMzgR+vxPViT2ggdmnm07UFeF1Fc0xdaV2ma+vx8Ms1lkz6J38OtO5ws
 criQhqb5+7cy/XYGu9+yBZtEqZg+8F88xeWvmFkSW6GKfboeM05FDtBahntuJjKBJ0
 NXGKfvA4GG/4pnftgNtV7DqkT625j4h8JUVs2uHw8j1e0bAjF0pbzITVzMMhE911PS
 UbHZHTsYiydQpvNHb/aeI3f78iCr4U7hd8RkX4+f6lPQlBtib1oCHTVkgPFZPmPvv4
 DfWnjhh1HDlviJvJ76aCISVrV4q28kuJJk64F7hUFr4ypdGzaRYBnRkzIE1+iJ58ji
 M0bnS+IxzcKOw==
Message-ID: <sashiko-outbox-199763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 23/83] drm/loongson: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-23-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-23-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:28:05 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/loongson: skipped CRTC and encoder hardware reset in lsdc_crea=
te_device()
--

commit 648f0256277cc04b62e3a2eb71b3474bb1ab8054
Author: Maxime Ripard <mripard@kernel.org>

drm/loongson: Switch to drm_mode_config_create_initial_state

This commit replaces drm_mode_config_reset() with
drm_mode_config_create_initial_state() in lsdc_create_device() during probe.

> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index 5a13df31eb902..fbb2658acce40 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -247,7 +247,9 @@ lsdc_create_device(struct pci_dev *pdev,
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> -	drm_mode_config_reset(ddev);
> +	ret =3D drm_mode_config_create_initial_state(ddev);
> +	if (ret)
> +		return ERR_PTR(ret);

[Severity: High]
Does switching from drm_mode_config_reset() to
drm_mode_config_create_initial_state() in lsdc_create_device() skip required
CRTC and encoder hardware initialization at probe time?

Unlike drm_mode_config_reset(), drm_mode_config_create_initial_state() does
not invoke crtc->helper_private->hw_reset() or encoder->funcs->reset().

In drivers/gpu/drm/loongson/lsdc_crtc.c, lsdc_crtc_hw_reset() calls
lsdc_crtc0_reset() and lsdc_crtc1_reset():

static void lsdc_crtc0_reset(struct lsdc_crtc *lcrtc)
{
	struct lsdc_device *ldev =3D lcrtc->ldev;

	lsdc_wreg32(ldev, LSDC_CRTC0_CFG_REG, CFG_RESET_N | LSDC_PF_XRGB8888);
}

Other runtime accesses to LSDC_CRTC0_CFG_REG and LSDC_CRTC1_CFG_REG during
modeset and plane updates (such as lsdc_crtc0_enable(), lsdc_crtc0_disable(=
),
lsdc_crtc0_set_dma_step(), and lsdc_primary0_update_fb_format()) perform
read-modify-write operations that neither assert CFG_RESET_N nor clear stale
firmware bits such as CFG_HW_CLONE or CFG_GAMMA_EN.

In addition, the encoder reset hooks in
drivers/gpu/drm/loongson/lsdc_output_7a1000.c and
drivers/gpu/drm/loongson/lsdc_output_7a2000.c are the only places in the
driver that program LSDC_CRTC0_DVO_CONF_REG and LSDC_CRTC1_DVO_CONF_REG:

static void ls7a2000_hdmi0_encoder_reset(struct drm_encoder *encoder)
{
	struct drm_device *ddev =3D encoder->dev;
	struct lsdc_device *ldev =3D to_lsdc(ddev);
	u32 val;

	val =3D PHY_CLOCK_POL | PHY_CLOCK_EN | PHY_DATA_EN;
	lsdc_wreg32(ldev, LSDC_CRTC0_DVO_CONF_REG, val);

	/* using software gpio emulated i2c */
	val =3D lsdc_rreg32(ldev, LSDC_HDMI0_INTF_CTRL_REG);
	val &=3D ~HW_I2C_EN;
	lsdc_wreg32(ldev, LSDC_HDMI0_INTF_CTRL_REG, val);

	/* help the hdmi phy to get out of reset state */
	lsdc_wreg32(ldev, LSDC_HDMI0_PHY_CTRL_REG, HDMI_PHY_RESET_N);
	mdelay(20);
}

On LS7A2000, skipping ls7a2000_hdmi0_encoder_reset() and
ls7a2000_hdmi1_encoder_reset() at probe time also leaves HW_I2C_EN set in
LSDC_HDMI0_INTF_CTRL_REG and LSDC_HDMI1_INTF_CTRL_REG and leaves the HDMI P=
HY
in reset, breaking software GPIO-emulated I2C DDC probing in
ls7a2000_hdmi0_vga_connector_detect() and ls7a2000_connector_get_modes()
before any atomic enable commit runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D23
