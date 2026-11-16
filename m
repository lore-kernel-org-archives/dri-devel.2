Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC218606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpeZxR8Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3062810E3D8;
	Mon, 16 Nov 2026 10:54:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE1D10E3D8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:53:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25E8B413CA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77341F000C6;
 Mon, 16 Nov 2026 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794826435;
 bh=R/1IPjXtaTBrPgusSaO6H2YLWwEn4dsOW+wm8pspz4w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MpeZxR8YqBGBIHyMpZUOfCA1e6VcpwVG3V/+SgK8vYzeig/bLQFYlx8wa9HMHj77i
 z+xBHOVKYpFtIXN4sknsFDedVPtCoLi3kGEveyDglHE6ytzv8puO6ZJsB2fX0P8pRx
 oBgmqrELfjnbxEUj8UaOMBe6cd5mH6hpaCNieaFBubZfqTMFBTpoSYejAZyqPCe23a
 S/jaVPC6hzMkk31nxkOU0+6ev5AlJZWNS09vIMc7m2+kuoYReDzGrrUpPGfKhnON8n
 g6JT/0NFw2zO7iEvm7VSjk5krvme6hBn7EgPo0NCS8L3WnJZkaoEe/7oBsRUoNAc3o
 /WCHJpEwNVfow==
Message-ID: <sashiko-outbox-216790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/64] drm/loongson: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-drm-no-more-config-reset-v2-17-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-17-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:53:54 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/loongson: skipped CRTC and encoder hardware reset in
  lsdc_create_device()
--

commit 8beeb01686f101cdce0b7603e2b5e7c72cefba29
Author: Maxime Ripard <mripard@kernel.org>

drm/loongson: Switch to drm_mode_config_create_initial_state

This commit replaces drm_mode_config_reset() with
drm_mode_config_create_initial_state() during device creation in
lsdc_create_device().

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
> =20
>  	return ldev;
>  }

[Severity: High]
Does replacing drm_mode_config_reset() with
drm_mode_config_create_initial_state() skip hardware initialization that
this driver relies on during probe?

Unlike drm_mode_config_reset(), drm_mode_config_create_initial_state() does
not call crtc->helper_private->hw_reset() or encoder->funcs->reset():

drivers/gpu/drm/loongson/lsdc_output_7a2000.c:ls7a2000_hdmi0_encoder_reset(=
) {
	...
	val =3D PHY_CLOCK_POL | PHY_CLOCK_EN | PHY_DATA_EN;
	lsdc_wreg32(ldev, LSDC_CRTC0_DVO_CONF_REG, val);

	/* using software gpio emulated i2c */
	val =3D lsdc_rreg32(ldev, LSDC_HDMI0_INTF_CTRL_REG);
	val &=3D ~HW_I2C_EN;
	lsdc_wreg32(ldev, LSDC_HDMI0_INTF_CTRL_REG, val);

	/* help the hdmi phy to get out of reset state */
	lsdc_wreg32(ldev, LSDC_HDMI0_PHY_CTRL_REG, HDMI_PHY_RESET_N);
	...
}

On both LS7A1000 and LS7A2000, the encoder reset callbacks are the only
places in the driver that program LSDC_CRTC0_DVO_CONF_REG and
LSDC_CRTC1_DVO_CONF_REG.  On LS7A2000, skipping encoder reset also leaves
the HDMI PHY in reset and HW_I2C_EN set, breaking software GPIO I2C for
connector detection and EDID reads before an atomic enable runs.  In
addition, skipping lsdc_crtc_hw_reset() leaves LSDC_CRTC0_CFG_REG and
LSDC_CRTC1_CFG_REG with firmware settings across read-modify-write modeset
updates instead of initializing them to CFG_RESET_N | LSDC_PF_XRGB8888.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-no-mor=
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D17
