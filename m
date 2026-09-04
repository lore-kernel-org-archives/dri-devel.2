Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3759CC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8241F10F970;
	Fri,  4 Sep 2026 13:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BOLEJpgc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E69D10F970
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:57:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4148241834;
 Fri,  4 Sep 2026 13:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DFB1F00A3D;
 Fri,  4 Sep 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788530230;
 bh=3vpS1tYpkPfcUSeqjetCrUKJtytc4S0Lgm4goTB6NAE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BOLEJpgcKjuxgddgJKzoW8b+Zl/njdDhxZhxVzDtCTnCULczgFtd2mulKVwRiB1Fz
 179W3jsmHPb+6OLPabobQ0Uc4lkcKzKKrDDbJ1kKOF2hLZqEeW8J4/8VnOsTxHVqSQ
 +aRJg8Ickba024n3tdybJleJyckZvbIveO5LhBZVLDXg52Mg48e4sAtfFtrCdkCRmQ
 URapLvJR1BcH7uI/KyN5K+7vEU5+1x1xfPfj++MtpO1NwysaWotl6TSsXVx0yU/K9N
 7QFY79EQkX1VslmtG+uFSy4Eei3i1RucYFqPzjmewbNT1Q1gY+FimhbhB9n4R8ySke
 dWu1wwDvYl50g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/19] drm/bridge: starfive: Add JH7110 HDMI
 controller driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: mfd@lists.linux.dev, robh@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, olteanv@gmail.com, conor+dt@kernel.org,
 lee@kernel.org, dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260904-jh7110-clean-send-v3-14-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-14-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:57:08 +0000
Message-Id: <20260904135709.41DFB1F00A3D@smtp.kernel.org>
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
- [Medium] The `regmap` variable is assigned and checked but never used or =
passed to the generic driver, contradicting the commit message.
- [Medium] Missing mandatory `phy_init()` and `phy_exit()` calls for the HD=
MI PHY.
--

commit a25b9a0e71017577ee552276d0b9a0aa22a5f9f0
Author: Michal Wilczynski <m.wilczynski@samsung.com>
drm/bridge: starfive: Add JH7110 HDMI controller driver

This commit adds the HDMI controller (bridge) driver for the StarFive
JH7110. It registers as a DRM bridge, manages clock rates and PHY power,
and configures the mux setting based on the port graph.

> The driver calls the generic inno_hdmi_probe function and passes the
> shared regmap to it, registering as a DRM bridge.

[Severity: Medium]
Is this description accurate regarding the regmap? Looking at the
starfive_inno_hdmi_controller_probe() function below, the regmap is fetched
but doesn't appear to actually be passed to inno_hdmi_probe() or used
anywhere else.

> diff --git a/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c b/drivers/gpu/drm/=
bridge/jh7110-inno-hdmi.c
> new file mode 100644
> index 0000000000000..b0bf6abaa55fb
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
[ ... ]
> +static void inno_hdmi_starfive_enable(struct device *dev,
> +				      struct drm_display_mode *mode)
> +{
[ ... ]
> +	/*
> +	 * 3. Power on the PHY. This calls the PHY driver's .power_on op,
> +	 * which configures the Post-PLL and analog blocks.
> +	 */
> +	ret =3D phy_power_on(ctrl->phy);

[Severity: Medium]
Does this code omit a required initialization step? The generic PHY API
strictly requires phy_init() to be called before phy_power_on(). Even if
the current starfive-inno-hdmi-phy driver lacks an .init callback, omitting
phy_init() here violates the API contract and could lead to initialization
failures if the PHY driver is updated or a different PHY is bound.

> +	if (ret) {
> +		dev_err(dev, "Failed to power on PHY: %d\n", ret);
> +		clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
> +		return;
> +	}
> +
> +	ctrl->enabled =3D true;
> +}
> +
> +static void inno_hdmi_starfive_disable(struct device *dev)
> +{
> +	struct stf_inno_hdmi_controller *ctrl =3D dev_get_drvdata(dev);
> +
> +	/*
> +	 * .enable bails out early if the pixel clock rate is unsupported or
> +	 * the PHY fails to power on, leaving pclk and the PHY untouched.
> +	 * Only tear down what was actually brought up, otherwise the clock
> +	 * refcount underflows.
> +	 */
> +	if (!ctrl->enabled)
> +		return;
> +
> +	phy_power_off(ctrl->phy);

[Severity: Medium]
Should there be a call to phy_exit() here? Following the same API contract,
phy_exit() should generally be invoked to clean up resources after
phy_power_off() completes.

> +	clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
> +	ctrl->enabled =3D false;
> +}
[ ... ]
> +static int starfive_inno_hdmi_controller_probe(struct platform_device *p=
dev)
> +{
[ ... ]
> +	/* Get the shared regmap from the parent */
> +	regmap =3D dev_get_regmap(parent, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}

[Severity: Medium]
Could this be dead code? The regmap is fetched and checked here, but
subsequent code within starfive_inno_hdmi_controller_probe() never uses it.

[ ... ]
> +	plat_data =3D of_device_get_match_data(dev);
> +
> +	/* Hand off to the generic library to create the bridge. */
> +	inno =3D inno_hdmi_probe(pdev, plat_data);

[Severity: Medium]
As mentioned regarding the commit message, should the regmap have been
passed to inno_hdmi_probe() here?

> +	if (IS_ERR(inno))
> +		return PTR_ERR(inno);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D14
