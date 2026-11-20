Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C55606A6F8
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVDbAutf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B2D112CD7;
	Fri, 20 Nov 2026 19:20:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1D3112CD7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:20:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1603543CEA;
 Fri, 20 Nov 2026 19:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABC31F000ED;
 Fri, 20 Nov 2026 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795202440;
 bh=vxlrH7ZyE4Vxgz8nt01JW/28BAYUCeqTyQt+hXyeCFI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EVDbAutfcdKj6lUOz2AMjxnLptzDf9dj0f+SLHMWMwSo3TRTyP+W0h9BAJVeB54aI
 GncSb4UIO8Ghi2rQ6oX/lstFTNZIwStcBNTwY8HAR3hcyQA0r1nyiQb8GfpP12Vc0Q
 D3qI6uQn96pAmxAnV2M0qbTD9P3iNS+H5tBijDfMBmnXEym2k8b846LVwbBpQ4S8bb
 seWnpNbsR8AuKdDyDpDV9wQytZv8pM3s5PLdWim76CXy7AdlsYA6gOgpx+8cRBzrSX
 Ww/KmMyogRF45rc7HwzLAhWp7m/O9TqrMmq+5CxiKMiOnD+nQNu18G9KJH1qIGDVkL
 hJ0PdLBUGhREg==
Message-ID: <sashiko-outbox-225914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] drm/meson: dw-hdmi: Use the generic PHY
 framework for the HDMI TX PHY
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261120-meson-drm-create-hdmitx-phy-v2-8-93d622d9bb07@aliel.fr>
References: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
 <20261120-meson-drm-create-hdmitx-phy-v2-8-93d622d9bb07@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:20:39 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/meson: dw-hdmi: missing PHY init in meson_dw_hdmi_init()
  breaks CEC/ARC
- [Medium] drm/meson: dw-hdmi: phy_init() leak on error path in
  dw_hdmi_phy_init()
--

commit 9c4e52bbd305f6371ee6545c479c9a84e6845324
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI TX PHY

This commit converts the Meson DW-HDMI driver from direct HHI register
programming to the generic PHY API, with a legacy fallback when the DT
node lacks a "phys" property.

> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meso=
n/meson_dw_hdmi.c
> index 20a821936b3af..1ca1ce6173563 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
[ ... ]
> @@ -364,10 +276,18 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, v=
oid *data,
>  	unsigned int wr_clk =3D
>  		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
>  	bool mode_is_420 =3D false;
> +	unsigned int pixel_clock =3D mode->clock;
> +	union phy_configure_opts opts =3D {};
> +	int ret;
> =20
>  	DRM_DEBUG_DRIVER("\"%s\" div%d\n", mode->name,
>  			 mode->clock > 340000 ? 40 : 10);
> =20
> +	/* Setup PHY */
> +	ret =3D phy_init(dw_hdmi->phy);
> +	if (ret)
> +		return ret;
> +
>  	if (drm_mode_is_420_only(display, mode) ||
>  	    (!is_hdmi2_sink && drm_mode_is_420_also(display, mode)) ||
>  	    dw_hdmi_bus_fmt_is_420(hdmi))
> @@ -392,19 +312,22 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, v=
oid *data,
>  	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x2);
> =20
>  	/* Setup PHY parameters */
> -	meson_hdmi_phy_setup_mode(dw_hdmi, mode, mode_is_420);
> -
> -	/* Disable clock, fifo, fifo_wr */
> -	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
> +	if (mode_is_420)
> +		pixel_clock /=3D 2;
> +	opts.hdmi.tmds_char_rate =3D (u64)pixel_clock * 1000;
> +	opts.hdmi.bpc =3D 8;
> +	ret =3D phy_configure(dw_hdmi->phy, &opts);
> +	if (ret)
> +		return ret;
> =20
>  	dw_hdmi_set_high_tmds_clock_ratio(hdmi, display);
> =20
>  	msleep(100);
> =20
>  	/* Reset PHY 3 times in a row */
> -	meson_dw_hdmi_phy_reset(dw_hdmi);
> -	meson_dw_hdmi_phy_reset(dw_hdmi);
> -	meson_dw_hdmi_phy_reset(dw_hdmi);
> +	ret =3D phy_power_on(dw_hdmi->phy);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Do the error returns from phy_configure() and phy_power_on() leak a
dw_hdmi->phy->init_count reference?

When dw_hdmi_phy_init() fails, dw_hdmi_setup() leaves hdmi->phy.enabled
false, so dw_hdmi_poweroff() never calls dw_hdmi_phy_disable() to balance
phy_init() with phy_exit().  A non-VIC DMT mode with a pixel clock below
25.175 MHz passes meson_encoder_hdmi_mode_valid() but is rejected with
-EINVAL by meson_hdmi_phy_configure() -> meson_hdmi_phy_find_rate(),
permanently elevating init_count so subsequent phy_init() calls skip
hardware initialization.

[ ... ]

> @@ -623,10 +542,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi =
*meson_dw_hdmi)
>  	/* Enable normal output to PHY */
>  	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT=
(12));
> =20
> -	/* Setup PHY */
> -	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, meson_dw_hdmi->data->cntl1_=
init);
> -	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, meson_dw_hdmi->data->cntl0_=
init);
> -
>  	/* Enable HDMI-TX Interrupt */
>  	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
>  				       HDMITX_TOP_INTR_CORE);

[Severity: High]
Does removing the initial PHY setup from meson_dw_hdmi_init() leave the
HDMI TX PHY uninitialized whenever no HDMI video mode is active?

meson_dw_hdmi_init() pulses reset_control_reset(meson_dw_hdmi->hdmitx_phy)
at bind and system resume time, while meson_venc_init() zeroes
HHI_HDMI_PHY_CNTL0.  Commits 04703bfd7f99 ("drm/meson: dw-hdmi: power up
phy on device init") and 08001033121d ("drm/meson: dw-hdmi: add bandgap
setting for g12") programmed HHI_HDMI_PHY_CNTL1 and HHI_HDMI_PHY_CNTL0
here because CEC and the G12A ARC/eARC utility pin need the PHY
initialized even before the first HDMI modeset or when another display
interface is used.

With phy_init() deferred to dw_hdmi_phy_init(), which dw_hdmi_setup() only
calls when enabling an active HDMI display mode (and which
meson_dw_hdmi_pm_resume() -> dw_hdmi_resume() does not call), the PHY
stays in its post-reset state at boot and after resume whenever HDMI
video is inactive.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-meson-drm-=
create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr?part=3D8
