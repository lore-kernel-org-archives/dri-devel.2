Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88C606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlK6jq/a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A4710F933;
	Tue, 17 Nov 2026 20:03:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC61A10F929
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:03:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19FE1601D4;
 Tue, 17 Nov 2026 20:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED6A1F000C4;
 Tue, 17 Nov 2026 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794945809;
 bh=UOaB9r1BwC8qkIBaPDUJRDEVjpKEaBIm7fbCfHTU9xA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RlK6jq/aYybpjqXoxVre0+KbhhlOOPx2dX5oXhNUnj1jtW2aJcgcJSa8WYSNptHU5
 T6WV8PHaAJiTt1Cw36jNnrjQDM/MH4LNTE2OFmBr4XAN+T3j7W4/jIc8Aw0rlmDZoN
 8n00xhPM8PcQHCrO+WXxhZRwmxNtO2G9iquLWajh3BuixpuADyoGkngEJNZKWrhB9/
 pZR9Yt/rtoauxZRnM8GrNcKC49RXrh9tpfmBa0d27J5W2dLL4SVOdIT6Sc/2LGGVzf
 EqdnidMCJoASfm0QfzrBJm8TxSmMtDz2ZUsTBZU2tK1QZPVWwb3xz8TQ1WGxWifxEy
 yjFYiYqQQYgOA==
Message-ID: <sashiko-outbox-219549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] drm/meson: dw-hdmi: Use the generic PHY framework
 for the HDMI TX PHY
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261117-meson-drm-create-hdmitx-phy-v1-7-9e0ac931381c@aliel.fr>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-7-9e0ac931381c@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:03:27 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/meson: dw-hdmi: suspend/resume order breaks PHY state and
  HDMI output
- [Medium] drm/meson: dw-hdmi: missing phy_exit() on dw_hdmi_probe()
  failure
- [Medium] drm/meson: dw-hdmi: premature PHY teardown in
  meson_dw_hdmi_unbind()
--

commit 91e31ad4e0b36171e791e7c0487c9a4c66b12b31
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI TX PHY

This commit converts meson_dw_hdmi from direct HHI_HDMI_PHY_CNTL0..5
register writes to the generic PHY API, with a legacy fallback when the
device tree lacks a "phys" property.

> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meso=
n/meson_dw_hdmi.c
> index 20a821936b3af..f28cc1e6ee1df 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c

[ ... ]

> @@ -590,13 +504,13 @@ static const struct meson_dw_hdmi_data meson_dw_hdm=
i_g12a_data =3D {
>  	.top_write =3D dw_hdmi_g12a_top_write,
>  	.dwc_read =3D dw_hdmi_g12a_dwc_read,
>  	.dwc_write =3D dw_hdmi_g12a_dwc_write,
> -	.cntl0_init =3D 0x000b4242, /* Bandgap */
> -	.cntl1_init =3D PHY_CNTL1_INIT,
> +	.phy_soc =3D MESON_HDMI_PHY_G12A,
>  };
> =20
> -static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
> +static int meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>  {
>  	struct meson_drm *priv =3D meson_dw_hdmi->priv;
> +	int ret;
> =20
>  	/* Reset HDMITX APB & TX & PHY */
>  	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
> @@ -624,8 +538,9 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *=
meson_dw_hdmi)
>  	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT=
(12));
> =20
>  	/* Setup PHY */
> -	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, meson_dw_hdmi->data->cntl1_=
init);
> -	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, meson_dw_hdmi->data->cntl0_=
init);
> +	ret =3D phy_init(meson_dw_hdmi->phy);
> +	if (ret)
> +		return ret;
> =20
>  	/* Enable HDMI-TX Interrupt */
>  	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
> @@ -634,6 +549,7 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *=
meson_dw_hdmi)
>  	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_MASKN,
>  				       HDMITX_TOP_INTR_CORE);
> =20
> +	return 0;
>  }
> =20
>  static void meson_disable_clk(void *data)
> @@ -746,7 +662,26 @@ static int meson_dw_hdmi_bind(struct device *dev, st=
ruct device *master,
>  		return ret;
>  	}
> =20
> -	meson_dw_hdmi_init(meson_dw_hdmi);
> +	meson_dw_hdmi->phy =3D devm_phy_optional_get(dev, "hdmi");
> +	if (IS_ERR(meson_dw_hdmi->phy))
> +		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->phy),
> +				     "failed to get HDMI PHY\n");
> +
> +	if (!meson_dw_hdmi->phy) {
> +		/* DEPRECATED: DT without "phys" */
> +		dev_warn(dev, "missing \"phys\", using legacy HDMI PHY\n");
> +		meson_dw_hdmi->phy =3D meson_hdmi_phy_create_legacy(dev, priv->hhi,
> +						meson_dw_hdmi->data->phy_soc);
> +		if (IS_ERR(meson_dw_hdmi->phy))
> +			return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->phy),
> +					     "failed to create legacy HDMI PHY\n");
> +
> +		meson_dw_hdmi->legacy_phy =3D true;
> +	}
> +
> +	ret =3D meson_dw_hdmi_init(meson_dw_hdmi);
> +	if (ret)
> +		return ret;
> =20
>  	/* Bridge / Connector */

[Severity: Medium]
Does meson_dw_hdmi_bind() leak a phy_init() reference if dw_hdmi_probe()
fails later in this function (for example with -EPROBE_DEFER when the DDC
I2C bus is not ready)?

When the PHY comes from the external PHY provider, devres cleanup on a
failed component bind only calls phy_put(), leaving phy->init_count at 1.
On the next bind attempt, meson_dw_hdmi_init() resets hdmitx_phy and calls
phy_init(), which sees init_count > 0 and skips phy->ops->init(), leaving
HHI_HDMI_PHY_CNTL0 and HHI_HDMI_PHY_CNTL1 uninitialized after the hardware
reset.

> @@ -784,6 +719,10 @@ static void meson_dw_hdmi_unbind(struct device *dev,=
 struct device *master,
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	int irq =3D platform_get_irq(pdev, 0);
> =20
> +	phy_exit(meson_dw_hdmi->phy);
> +	if (meson_dw_hdmi->legacy_phy)
> +		devm_phy_destroy(dev, meson_dw_hdmi->phy);
> +
>  	devm_free_irq(dev, irq, meson_dw_hdmi);
>  	dw_hdmi_unbind(meson_dw_hdmi->hdmi);
>  	drm_bridge_put(meson_dw_hdmi->bridge);

[Severity: Medium]
Can tearing down meson_dw_hdmi->phy before devm_free_irq() and
dw_hdmi_unbind() cause a use-after-free in dw_hdmi_top_thread_irq()?

CPU0                                    CPU1
meson_dw_hdmi_unbind()
  phy_exit(meson_dw_hdmi->phy)
  devm_phy_destroy(..., meson_dw_hdmi->phy)
                                        dw_hdmi_top_thread_irq()
                                          dw_hdmi_setup_rx_sense()
                                            ...
                                              dw_hdmi_phy_init()
                                                phy_configure(dw_hdmi->phy,=
 ...)
                                                  <-- use-after-free
  devm_free_irq(...)
  dw_hdmi_unbind(...)

In the legacy PHY path, devm_phy_destroy() immediately unregisters and
frees meson_dw_hdmi->phy while the threaded HPD interrupt handler is still
active and can invoke dw_hdmi_phy_init() or dw_hdmi_phy_disable().  Even
with a DT PHY, HPD handling or dw_hdmi_unbind() can access the PHY after
phy_exit().  Should phy_exit() and devm_phy_destroy() run after
devm_free_irq() and dw_hdmi_unbind()?

> @@ -801,6 +740,8 @@ static int __maybe_unused meson_dw_hdmi_pm_suspend(st=
ruct device *dev)
>  	if (!meson_dw_hdmi)
>  		return 0;
> =20
> +	phy_exit(meson_dw_hdmi->phy);
> +
>  	/* Reset TOP */
>  	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
>  				       HDMITX_TOP_SW_RESET, 0);
> @@ -811,11 +752,14 @@ static int __maybe_unused meson_dw_hdmi_pm_suspend(=
struct device *dev)
>  static int __maybe_unused meson_dw_hdmi_pm_resume(struct device *dev)
>  {
>  	struct meson_dw_hdmi *meson_dw_hdmi =3D dev_get_drvdata(dev);
> +	int ret;
> =20
>  	if (!meson_dw_hdmi)
>  		return 0;
> =20
> -	meson_dw_hdmi_init(meson_dw_hdmi);
> +	ret =3D meson_dw_hdmi_init(meson_dw_hdmi);
> +	if (ret)
> +		return ret;
> =20
>  	dw_hdmi_resume(meson_dw_hdmi->hdmi);

[Severity: High]
Does calling phy_exit() in meson_dw_hdmi_pm_suspend() and phy_init() in
meson_dw_hdmi_pm_resume() break HDMI output across system suspend/resume?

Because the HDMI TX platform device sits after the VPU master device on
dpm_list (both from DT node order and because devm_phy_optional_get() adds
a stateless device link to the PHY that reorders the consumer to the tail
of dpm_list), system suspend runs meson_dw_hdmi_pm_suspend() before
meson_drv_pm_suspend(), and system resume runs meson_drv_pm_resume()
before meson_dw_hdmi_pm_resume().

On suspend, meson_dw_hdmi_pm_suspend() calls phy_exit() while the PHY is
still powered on, before meson_drv_pm_suspend() ->
drm_mode_config_helper_suspend() -> dw_hdmi_phy_disable() calls
phy_power_off().

On resume, meson_drv_pm_resume() -> drm_mode_config_helper_resume() ->
dw_hdmi_phy_init() calls phy_configure() and phy_power_on() while
phy->init_count is still 0.  Then meson_dw_hdmi_pm_resume() runs
meson_dw_hdmi_init(), which resets hdmitx_phy and calls phy_init(); since
phy->power_count > phy->init_count, phy_init() warns ("phy_power_on was
called before phy_init") and runs meson_hdmi_phy_init(), overwriting
HHI_HDMI_PHY_CNTL0 and HHI_HDMI_PHY_CNTL1 with cntl0_init and cntl1_init
and clobbering the mode that meson_drv_pm_resume() just configured and
powered on.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-meson-drm-=
create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr?part=3D7
