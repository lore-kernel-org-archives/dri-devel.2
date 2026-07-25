Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261BEC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E64810F4F9;
	Sat, 25 Jul 2026 05:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LF0mP8Xg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB10210F4F9
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:02:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 36E6744E52;
 Sat, 25 Jul 2026 05:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7091F000E9;
 Sat, 25 Jul 2026 05:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784955775;
 bh=j1l9WKvO3rqihB+U+ZgLEcKN9WSynhxIvhL+TFeCEdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LF0mP8XgbF6W80UoI8X3N3ws4Sx2ZtpY8lDg5kjT9ZfxFyxShSVl0EC1Ory6GoYjQ
 Y8S/E59plDih7/SvQ2u7A0URV3AfCvK8oQGECTPxaHopEKKpXzyXaZ1VunlMfPkeDj
 t1bT/EvIE4kJwNFbYubzMe3CdYNDlTdDnyEIQ2qGiATUZQXYXzlzb9tt41sTkZkHbn
 rIPhn9fSghVYvXZNQ+zbj+6EB7MTs015F7sLSM5UqYrSwufJApy6hYZd49SjT/LDcn
 EVa2w9rUhSWSlVgBNK0eBQRDA4HwjL7ifn8Fzi+PThpv/1xEDxteksJMqoSnKq65+2
 RzHpjtcl7UA/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 05/17] phy: spacemit: add Innosilicon DP TX PHY
 driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org, robh@kernel.org,
 devicetree@vger.kernel.org, olteanv@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260725-k3-display-v1-5-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-5-6de34d80e86c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:02:54 +0000
Message-Id: <20260725050254.9F7091F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] PHY provider is registered before probe finishes, exposing it to e=
arly concurrent access and potential Use-After-Free (UAF) on probe failure.
- [High] Lack of driver-level synchronization between CCF and PHY framework=
s leads to concurrent hardware state corruption.
- [Medium] The MPLL (main link PLL) is powered on during PHY initialization=
 but is never powered off in the power down sequence.
- [Medium] Missing hardware state cleanup on error paths in `k3_inno_dp_phy=
_power_on` leaves the PHY powered on.
- [Medium] Rate configuration functions unconditionally power on the PLLs, =
overriding the logical PHY power state.
- [Medium] PLL programming functions do not poll for hardware lock before p=
roceeding.
--

--- Patch [5]: [PATCH RESEND 05/17] phy: spacemit: add Innosilicon DP TX PH=
Y driver ---
commit 31db74eae7dc59ddc61373dbe3e2c6c1e6966ccd
Author: Cody Kang <codykang.hk@gmail.com>
Subject: phy: spacemit: add Innosilicon DP TX PHY driver

This commit introduces the SpacemiT K3 Innosilicon DisplayPort PHY driver.
It integrates the PHY as a child of the DP controller, registering a PHY
provider and exposing the pixel PLL as a clock provider.

> diff --git a/drivers/phy/spacemit/phy-k3-inno-dp.c b/drivers/phy/spacemit=
/phy-k3-inno-dp.c
> new file mode 100644
> index 0000000000000..9dd62edb7a5af
> --- /dev/null
> +++ b/drivers/phy/spacemit/phy-k3-inno-dp.c
> @@ -0,0 +1,948 @@

[ ... ]

> +static int k3_inno_dp_phy_power_on(struct phy *phy)
> +{
> +	struct k3_inno_dp_phy *p =3D phy_get_drvdata(phy);
> +	u32 lane_en;
> +	u32 val;
> +	int ret;

[ ... ]

> +	ret =3D regmap_read_poll_timeout(p->regmap, DPTX_ANA_MPLL, val,
> +				       val & DPTX_ANA_MPLL_LOCKED,
> +				       2000, 10 * 1000);
> +	if (ret) {
> +		dev_err(p->dev, "DP PHY core PLL lock timed out\n");
> +		return ret;
> +	}

[Severity: Medium]
If the MPLL or PREPLL fails to lock within 10ms, this immediately returns an
error without restoring the power down bits or XMIT_EN.

Since the generic PHY framework does not automatically call phy_power_off()
when phy_power_on() fails, could this leave the hardware running in an
inconsistent state and leak power?

> +
> +	ret =3D regmap_read_poll_timeout(p->regmap, DPTX_ANA_PREPLL, val,
> +				       val & DPTX_ANA_PREPLL_LOCKED,
> +				       2000, 10 * 1000);
> +	if (ret)
> +		dev_err(p->dev, "DP PHY pixel PLL lock timed out\n");
> +
> +	return ret;
> +}
> +
> +static int k3_inno_dp_phy_power_off(struct phy *phy)
> +{
> +	struct k3_inno_dp_phy *p =3D phy_get_drvdata(phy);
> +
> +	regmap_write_bits(p->regmap, DPTX_PHY_CTRL, DPTX_PHY_CTRL_XMIT_EN, 0);
> +	usleep_range(2000, 4000);
> +
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL, DPTX_ANA_PREPLL_PD,
> +			  DPTX_ANA_PREPLL_PD);
> +	usleep_range(2000, 4000);
> +
> +	return 0;
> +}

[Severity: Medium]
Does this power down sequence omit the MPLL?

The k3_inno_dp_phy_power_on() function powers up the MPLL by clearing
DPTX_ANA_MPLL_PD, but this power_off function does not appear to re-assert
it. Could this leave the main link PLL running indefinitely when the DP
controller is suspended or torn down?

[ ... ]

> +static void k3_inno_dp_phy_program_mpll(struct k3_inno_dp_phy *p,
> +					const struct k3_inno_dp_mpll_cfg *cfg)
> +{
> +	struct regmap *rm =3D p->regmap;

[ ... ]

> +	regmap_write_bits(rm, DPTX_ANA_PREPLL_CTRL, DPTX_ANA_PREPLL_LOCK_BYPEN,
> +		FIELD_PREP(DPTX_ANA_PREPLL_LOCK_BYPEN, 1));
> +
> +	regmap_write_bits(rm, DPTX_ANA_MPLL, DPTX_ANA_MPLL_PD,
> +		FIELD_PREP(DPTX_ANA_MPLL_PD, 0));

[Severity: Medium]
Does unconditionally writing 0 to DPTX_ANA_MPLL_PD override the logical
power state of the PHY?

If a DRM driver configures the link rate (calling phy_configure()) while the
PHY is logically powered off, this will force the PLL to run and
desynchronize the hardware from the PHY framework's power state.

> +	usleep_range(2000, 4000);
> +}

[Severity: Medium]
Is it safe to rely on a fixed 2-4ms sleep here instead of polling
DPTX_ANA_MPLL_LOCKED?

The power_on() function polls the locked bit for up to 10ms. A fixed delay
here might proceed with an unstable clock if the hardware takes longer to
lock, potentially causing display failures or link training issues.

[ ... ]

> +static void k3_inno_dp_program_prepll(struct k3_inno_dp_phy *p,
> +				      const struct k3_inno_dp_prepll_cfg *cfg)
> +{
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL, DPTX_ANA_PREPLL_PD,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PD, 1));
> +	usleep_range(2000, 4000);

[Severity: High]
Is a driver-level lock needed to synchronize access to the PHY registers
between the CCF and PHY frameworks?

Since this driver exposes both a clock (via CCF) and a PHY that share the
same hardware registers, concurrent calls to clk_set_rate() and
phy_power_on() can interleave.

If clk_set_rate() begins this multi-step programming sequence, a concurrent
phy_power_on() could clear the PD bit while the clock is still being
configured, corrupting the hardware state.

[ ... ]

> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL,
> +		DPTX_ANA_PREPLL_PCLK_NORMAL,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PCLK_NORMAL, 1));
> +	usleep_range(2000, 4000);
> +
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL, DPTX_ANA_PREPLL_PD,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PD, 0));

[Severity: Medium]
Similar to the MPLL configuration, does unconditionally clearing
DPTX_ANA_PREPLL_PD here override the PHY power state if the clock rate is
set while the PHY is logically off?

> +	usleep_range(2000, 4000);
> +}

[Severity: Medium]
Is it safe to rely on a fixed delay here instead of polling the
DPTX_ANA_PREPLL_LOCKED bit, which could lead to proceeding with an unstable
pixel clock?

[ ... ]

> +static int k3_inno_dp_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct k3_inno_dp_phy *p;
> +	struct phy_provider *provider;
> +	struct clk_init_data init =3D {};
> +	int ret;

[ ... ]

> +	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return dev_err_probe(dev, PTR_ERR(provider),
> +				     "failed to register PHY provider\n");
> +
> +	/* PHY takes a 24 MHz reference clock */
> +	p->ref_clk_khz =3D 24000;
> +
> +	/* The APMU pixel-clock mux references this clock by name. */
> +	of_property_read_string(dev->of_node, "clock-output-names", &init.name);
> +	if (!init.name)
> +		init.name =3D dev_name(dev);
> +	init.ops =3D &k3_inno_dp_pxclk_ops;
> +	init.parent_names =3D NULL;
> +	init.num_parents =3D 0;
> +	init.flags =3D 0;
> +	p->pxclk_hw.init =3D &init;
> +
> +	ret =3D devm_clk_hw_register(dev, &p->pxclk_hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register pixel clock\n");

[Severity: High]
Can the PHY provider be accessed by consumers before probe completes
successfully?

The PHY provider is registered via devm_of_phy_provider_register() before
the pixel clock is registered. If devm_clk_hw_register() fails, probe will
return an error and devres will free the driver context struct.

If a consumer driver acquires a reference to the PHY during this race
window, it could retain the reference after probe fails, leading to a
use-after-free when it attempts PHY operations on the freed pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-k3-display=
-v1-0-6de34d80e86c@gmail.com?part=3D5
