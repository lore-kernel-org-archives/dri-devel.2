Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A93606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxK01jt4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F1610F92A;
	Tue, 17 Nov 2026 20:11:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F4B10F92A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:11:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E8EB60F34;
 Tue, 17 Nov 2026 20:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82BB1F000C5;
 Tue, 17 Nov 2026 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794946292;
 bh=o1Y/yNbkW2bZMPXGpyxomoYGDfphc/X8oVtcisFJF/w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mxK01jt4UnB6GGRkK3XBjM7Wv9pTSp0H6bwXjTnQrTNecq0e19UljW9rpEbjbLou2
 HT051gZxjbrrOFqQZEEhkMRikxEOy8ATUMeXemwAGWbOtdSVTh+KDD3yl8rYoGfFh+
 yDOeuBxfYbfClk89EWalLhTbOY22jZv1ufcflwJnyaLtoz855Y7JrAwcPvPYpnSh48
 Ms8Zv8AEo5qtbbja0tXJxpDK3K2tOJLCwDCYr7vGiOzK+XTMcVlGpT77h0TPwa67r6
 jPBaSryASiMUdgxzpqyRTLDfff3DRr/jfbvfe8jWjYQ+b3xCbJizPA87xoKAVW5RtO
 X0Ri0s6MRn/Fw==
Message-ID: <sashiko-outbox-219570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] drm/meson: dw-hdmi: Drop manual HHI clock and
 memory PD setup
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261117-meson-drm-create-hdmitx-phy-v1-6-9e0ac931381c@aliel.fr>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-6-9e0ac931381c@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:11:31 +0000
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
- [High] drm/meson: dw-hdmi: skipped HDMITX mem PD power-up in
  meson_dw_hdmi_init()
--

commit c8e782099f758bf635402705a20f57d7df9682a7
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

drm/meson: dw-hdmi: Drop manual HHI clock and memory PD setup

This commit removes the direct HHI_HDMI_CLK_CNTL and HHI_MEM_PD_REG0
register writes in meson_dw_hdmi_init() and takes a runtime PM reference
in meson_dw_hdmi_probe() to power on the VPU power domain.

> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meso=
n/meson_dw_hdmi.c
> index eb33c70f29c31..20a821936b3af 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
[ ... ]
> @@ -599,12 +598,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi =
*meson_dw_hdmi)
>  {
>  	struct meson_drm *priv =3D meson_dw_hdmi->priv;
> =20
> -	/* Enable clocks */
> -	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
> -
> -	/* Bring HDMITX MEM output of power down */
> -	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
> -
>  	/* Reset HDMITX APB & TX & PHY */
>  	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
>  	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
> @@ -829,9 +822,29 @@ static int __maybe_unused meson_dw_hdmi_pm_resume(st=
ruct device *dev)
>  	return 0;
>  }
> =20
> +static void meson_dw_hdmi_pm_put(void *dev)
> +{
> +	pm_runtime_put_sync(dev);
> +}
> +
>  static int meson_dw_hdmi_probe(struct platform_device *pdev)
>  {
> -	return component_add(&pdev->dev, &meson_dw_hdmi_ops);
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on HDMI TX\n");

[Severity: High]
Can dropping the HHI_MEM_PD_REG0 write leave the HDMITX memory powered
down when the bootloader turns on the top-level VPU domain without
enabling HDMI?

In the VPU power domain driver, pwrc_ee_is_powered_off() only checks the
top-level AO sleep bit and does not check HHI_MEM_PD_REG0[15:8].  When
the top-level VPU domain is already powered on at boot,
meson_ee_pwrc_init_domain() registers the genpd as already on without
calling meson_ee_pwrc_on():

drivers/pmdomain/amlogic/meson-ee-pwrc.c:meson_ee_pwrc_init_domain() {
	...
	if (dom->num_clks && dom->desc.is_powered_off && !dom->desc.is_powered_off=
(dom)) {
		ret =3D clk_bulk_prepare_enable(dom->num_clks, dom->clks);
		if (ret)
			return ret;

		dom->base.flags =3D GENPD_FLAG_ALWAYS_ON;
		ret =3D pm_genpd_init(&dom->base, NULL, false);
		if (ret)
			return ret;
	}
	...
}

Because the genpd is initialized in the ON state with
GENPD_FLAG_ALWAYS_ON, pm_runtime_resume_and_get() is a no-op and
meson_ee_pwrc_on() never runs to clear HHI_MEM_PD_REG0[15:8], leaving
HDMITX memory powered down when meson_dw_hdmi_init() and dw_hdmi_probe()
access the controller.

In addition, power-domains and assigned-clocks are optional in the
amlogic,meson-dw-hdmi binding and were only added to in-tree DTs in
v6.11, so dropping the HHI_HDMI_CLK_CNTL and HHI_MEM_PD_REG0 writes also
regresses older DTBs (where meson_vclk_set() only configures
HHI_HDMI_CLK_CNTL later at atomic_enable time) and builds with CONFIG_PM
disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-meson-drm-=
create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr?part=3D6
