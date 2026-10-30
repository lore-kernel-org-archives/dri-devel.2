Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A48606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnJchf5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDD310E222;
	Fri, 30 Oct 2026 07:07:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B820310E222
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:07:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75292416FE;
 Fri, 30 Oct 2026 07:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82D81F0093A;
 Fri, 30 Oct 2026 07:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793344041;
 bh=bGQcWLDZKojn0AJiRpY1l3ycQc4C+6GY47OwFTdOD0E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bnJchf5weX6f0HqfMFcnyjFneXn3fLTOa+YDstPEryH5iJFg4h9HqEk5j6NYw/2R7
 lzULUjmHg9YN8LCS6NbsljZC/jJuwJEz3VncW9y7wZbYfImYGvxiidIB7bIB5wlSMc
 wq0WRICtwrb782hKLL7fKsfn17cj6E6wf8eP3DhZFeTfft+W9+FS0XN8RrG9LeU/iL
 DzdTe0+VqT9KjWOqXbxtwxCGBNaR/roZYZHs8+NCDfAO5+xrpRPrke4uSlCypKjvWO
 IZJUIoZ3pb5FPmQdn4wTMmn8McHEjDg7yaaQzsW8X5EhW82Tw+uF7ODeh08UxwwoC9
 vAx9Ku9FRzlpg==
Message-ID: <sashiko-outbox-190628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] phy: rockchip: Add support for Naneng eDP phy
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261030064905.2248999-5-damon.ding@rock-chips.com>
References: <20261030064905.2248999-1-damon.ding@rock-chips.com>
 <20261030064905.2248999-5-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 07:07:20 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] phy: rockchip: unclocked GRF register access in rockchip_edp_phy_p=
robe()
- [Medium] phy: rockchip: stale lane count in rockchip_edp_phy_verify_confi=
g()
- [Low] phy: rockchip: missing select REGMAP_MMIO for PHY_ROCKCHIP_NANENG_E=
DP
--

commit fa6e3e07850c3a98df33755e8389b184ff441616
Author: Damon Ding <damon.ding@rock-chips.com>

phy: rockchip: Add support for Naneng eDP phy

This commit adds a generic PHY driver for the Rockchip NaNeng eDP
transmitter PHY found on the RK3568 SoC, mapping its register window
directly and supporting 1/2/4 lanes at 1.62 and 2.7 Gbps.

> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 14698571b6075..202a6973e20ba 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -74,6 +74,16 @@ config PHY_ROCKCHIP_NANENG_COMBO_PHY
>  	  Enable this to support the Rockchip PCIe/USB3.0/SATA/QSGMII
>  	  combo PHY with NaNeng IP block.
> =20
> +config PHY_ROCKCHIP_NANENG_EDP
> +	tristate "Rockchip Naneng eDP Transmitter PHY driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY

[Severity: Low]
Since rockchip_edp_phy_probe() in drivers/phy/rockchip/phy-rockchip-naneng-=
edp.c
calls devm_regmap_init_mmio(), can this fail to link when
CONFIG_PHY_ROCKCHIP_NANENG_EDP is enabled without CONFIG_REGMAP_MMIO (or
with CONFIG_PHY_ROCKCHIP_NANENG_EDP=3Dy and CONFIG_REGMAP_MMIO=3Dm), since
ARCH_ROCKCHIP does not select REGMAP_MMIO? Should PHY_ROCKCHIP_NANENG_EDP
select REGMAP_MMIO (or MFD_SYSCON if using the parent syscon regmap)?

[ ... ]

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-edp.c b/drivers/phy=
/rockchip/phy-rockchip-naneng-edp.c
> new file mode 100644
> index 0000000000000..8c247eda1dcf8
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-edp.c

[ ... ]

> +static int rockchip_edp_phy_verify_config(struct rockchip_edp_phy *edpph=
y,
> +					  struct phy_configure_opts_dp *dp)
> +{
> +	int i;
> +
> +	/* If changing link rate was required, verify it's supported. */
> +	if (dp->set_rate) {
> +		switch (dp->link_rate) {
> +		case 1620:
> +		case 2700:
> +			/* valid bit rate */
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (dp->set_lanes) {
> +		/* Verify lane count. */
> +		switch (dp->lanes) {
> +		case 1:
> +		case 2:
> +		case 4:
> +			/* valid lane count. */
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * If changing voltages is required, check swing and pre-emphasis
> +	 * levels, per-lane.
> +	 */
> +	if (dp->set_voltages) {
> +		/* Lane count verified previously. */
> +		for (i =3D 0; i < edpphy->lanes; i++) {
> +			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
> +				return -EINVAL;
> +
> +			/*
> +			 * Sum of voltage swing and pre-emphasis levels cannot
> +			 * exceed 3.
> +			 */
> +			if (dp->voltage[i] + dp->pre[i] > 3)
> +				return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
In rockchip_edp_phy_configure(), rockchip_edp_phy_verify_config() runs
before rockchip_edp_phy_set_lanes() updates edpphy->lanes:

rockchip_edp_phy_configure()
  rockchip_edp_phy_verify_config()
    if (dp->set_voltages)
      for (i =3D 0; i < edpphy->lanes; i++)
  rockchip_edp_phy_set_lanes()
    edpphy->lanes =3D dp->lanes;
  rockchip_edp_phy_set_voltages()
    for (lane =3D 0; lane < edpphy->lanes; lane++)
      rockchip_edp_phy_set_voltage()

If a caller sets both set_lanes and set_voltages in the same
phy_configure() call when edpphy->lanes is 0 or smaller than dp->lanes,
won't rockchip_edp_phy_verify_config() only validate up to the old
edpphy->lanes count, allowing rockchip_edp_phy_set_voltage() to index
swing_pre_emph_table[dp->voltage[lane]][dp->pre[lane]] out of bounds or
write the -1 sentinel values to the PHY registers for the newly enabled
lanes?

Should rockchip_edp_phy_verify_config() check up to
dp->set_lanes ? dp->lanes : edpphy->lanes instead?

[ ... ]

> +static int rockchip_edp_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct rockchip_edp_phy *edpphy;
> +	void __iomem *regs;
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +
> +	edpphy =3D devm_kzalloc(dev, sizeof(*edpphy), GFP_KERNEL);
> +	if (!edpphy)
> +		return -ENOMEM;
> +
> +	edpphy->dev =3D dev;
> +
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	edpphy->regmap =3D devm_regmap_init_mmio(dev, regs, &rockchip_edp_phy_r=
egmap_config);
> +	if (IS_ERR(edpphy->regmap))
> +		return dev_err_probe(dev, PTR_ERR(edpphy->regmap),
> +				     "Failed to init regmap\n");
> +
> +	edpphy->refclk =3D devm_clk_get(dev, "refclk");

[Severity: High]
In the device tree binding
(Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml), the
APB clock PCLK_EDPPHY_GRF is attached to the parent edp_phy_grf syscon
node, while the child phy@0 node only has refclk:

      edp_phy_grf: syscon@fdcb0000 {
        compatible =3D "rockchip,rk3568-edp-phy-grf", "syscon", "simple-mfd=
";
        reg =3D <0x0 0xfdcb0000 0x0 0x8000>;
        clocks =3D <&cru PCLK_EDPPHY_GRF>;
        ...
        edp_phy: phy@0 {
          compatible =3D "rockchip,rk3568-edp-phy";
          reg =3D <0x0 0x100>;
          clocks =3D <&pmucru XIN_OSC0_EDPPHY_G>;
          clock-names =3D "refclk";
          #phy-cells =3D <0>;
        };
      };

In drivers/clk/rockchip/clk-rk3568.c, PCLK_EDPPHY_GRF is a normal gated
clock and is not marked critical:

	GATE(PCLK_EDPPHY_GRF, "pclk_edpphy_grf", "pclk_top", 0,
			RK3568_CLKGATE_CON(34), 14, GFLAGS),

Because simple-mfd does not enable the parent node's clocks, and the syscon
driver only attaches and enables a syscon node's clock when a consumer
looks up its regmap via syscon_node_to_regmap(), mapping the register
window directly in rockchip_edp_phy_probe() with devm_regmap_init_mmio()
means PCLK_EDPPHY_GRF is never prepared or enabled (and will be gated by
clk_disable_unused()).

Won't accessing edpphy->regmap in rockchip_edp_phy_power_on(),
rockchip_edp_phy_configure(), and rockchip_edp_phy_power_off() while
PCLK_EDPPHY_GRF is gated cause an APB bus hang or synchronous external
abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030064905.2248=
999-1-damon.ding@rock-chips.com?part=3D4
