Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C7FCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B7410E1BF;
	Wed, 30 Sep 2026 14:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g3Vh/8iv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0236210E1BF
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A93EE40091;
 Wed, 30 Sep 2026 14:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6194B1F000FF;
 Wed, 30 Sep 2026 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790778447;
 bh=zmEzA22qFxZV8rV0BMR3gLi7QlBmvUPH/48u1OHCXYw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g3Vh/8ivdo5be/qiiTzpDCIxpNAe5sy7I+92qZ5i4Y85hIgijmSNeaSbRSwr4WVSM
 nEeDUo7kLKArPNxFDnAtC47UQyhU9AQ2Tv3OAxSroN5Kr2d6gcjDZY8o2lAUYQanzt
 PwRSyAomaKZb57WY4wC61BOZDrcLY/atHO/vUP/QFLs7bJjDfqUTGqdvKMtQXhdLNt
 npBoMmIEil9+AxJlOmFRDJ+zYPyilICHfpE4+eFKJnignSaPQ2Cil1SAL1tp7ZAJJ5
 o0giHn9xMKQ4jD5fEIPfdXYiFm2kXzYi1w5kXFEb9mtXhjmqQBTV007kS6HBDB8K1Y
 5v6KWu7nimSGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
To: Biju <biju.das.au@gmail.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260930133257.23210-8-biju.das.jz@bp.renesas.com>
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
 <20260930133257.23210-8-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:27:26 +0000
Message-Id: <20260930142727.6194B1F000FF@smtp.kernel.org>
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
- [High] drm/atomic: sleeping functions called from atomic context in bridg=
e callbacks
- [High] core: static resets array in probe causes devres double-free and d=
ata races
- [Medium] pm: PM_RUNTIME_ACQUIRE_IF_ENABLED guard prevents synchronous sus=
pend
- [Medium] pm: refcount underflow in atomic_disable due to early return in =
atomic_enable
- [Low] build: DRM_RZG3L_LVDS cannot be built under COMPILE_TEST without ba=
se DU driver
- [Low] clk: unused dotclk resource allocation wastes memory and references
--

commit 40f44004822fcb3da6bccf8a2c28906d5abaa57d
Author: Biju Das <biju.das.jz@bp.renesas.com>

drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
from 25 to 87 MHz. The LVDS module cannot be used at the same time as
MIPI-DSI.

> diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/rene=
sas/rz-du/Kconfig
> index 7f2ef7137ae53..0dbe86bd65d09 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
> @@ -26,3 +26,16 @@ config DRM_RZG2L_MIPI_DSI
>  	def_tristate DRM_RZG2L_DU
>  	depends on DRM_RZG2L_USE_MIPI_DSI
>  	select DRM_MIPI_DSI
> +
> +config DRM_RZG3L_USE_LVDS
> +	bool "RZ/G3L DU LVDS Encoder Support"
> +	depends on DRM_BRIDGE && OF
> +	depends on DRM_RZG2L_DU || COMPILE_TEST
> +	default DRM_RZG2L_DU
> +	help
> +	  Enable support for the RZ/G3L Display Unit embedded LVDS encoder.
> +
> +config DRM_RZG3L_LVDS
> +	def_tristate DRM_RZG2L_DU
> +	depends on DRM_RZG3L_USE_LVDS
> +	select DRM_KMS_HELPER

[Severity: Low]
Is it intended that this driver can never be built in a pure COMPILE_TEST
configuration when the base driver is disabled?

Without a prompt, def_tristate DRM_RZG2L_DU unconditionally forces the
module to 'n' if DRM_RZG2L_DU is 'n', ignoring the COMPILE_TEST intent.

> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm=
/renesas/rz-du/rzg3l_lvds.c
> new file mode 100644
> index 0000000000000..1658be8da545f
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c

[ ... ]

> +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct rzg3l_lvds *lvds =3D bridge_to_rzg3l_lvds(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	u32 fmt;
> +
> +	/* Get the LVDS format from the bridge state. */
> +	bridge_state =3D drm_atomic_get_new_bridge_state(state, bridge);
> +	if (WARN_ON(!bridge_state))
> +		return;

[Severity: Medium]
Could this early return cause a PM runtime reference count underflow?

Since rzg3l_lvds_atomic_disable() unconditionally calls
pm_runtime_put_sync(), skipping the pm_runtime_get_sync() here due to an
early return means the subsequent disable will drop a reference that was
never acquired.

> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +		fmt =3D RZG3L_LVDS_MODE_JEIDA;
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +		fmt =3D RZG3L_LVDS_MODE_VESA;
> +		break;
> +	default:
> +		fmt =3D RZG3L_LVDS_MODE_VESA;
> +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
> +			 bridge_state->output_bus_cfg.format);
> +		break;
> +	}
> +
> +	if (WARN_ON(pm_runtime_get_sync(lvds->dev) < 0))
> +		return;
> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, LVDS_0_PHY_CH_EN_BGR);
> +	fsleep(20);

[Severity: High]
Is it safe to call sleeping functions like pm_runtime_get_sync() and
fsleep() here?

Bridge atomic_enable callbacks run in atomic context during non-blocking
commits, so these sleeping calls might cause kernel warnings or deadlocks.

[ ... ]

> +static void rzg3l_lvds_atomic_disable(struct drm_bridge *bridge,
> +				      struct drm_atomic_commit *state)
> +{
> +	struct rzg3l_lvds *lvds =3D bridge_to_rzg3l_lvds(bridge);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(lvds->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret < 0)
> +		goto pm_put_sync;
> +
> +	regmap_update_bits(lvds->regmap, LVDS_CMN, LVDS_CMN_PHY_RESET, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN0_MSK, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, 0);
> +
> +pm_put_sync:
> +	pm_runtime_put_sync(lvds->dev);
> +}

[Severity: High]
Similar to atomic_enable(), is it safe to call the sleeping function
pm_runtime_put_sync() from the atomic context of atomic_disable()?

[Severity: Medium]
Additionally, does the PM_RUNTIME_ACQUIRE_IF_ENABLED guard prevent
pm_runtime_put_sync() from synchronously suspending the device?

The scoped guard holds a PM reference until the function returns. This
means the usage counter remains > 0 when pm_runtime_put_sync() executes,
causing the device to be suspended asynchronously instead.

[ ... ]

> +static int rzg3l_lvds_probe(struct platform_device *pdev)
> +{
> +	static struct reset_control_bulk_data resets[2];

[Severity: High]
Is there a reason this resets array is declared static?

Because devm_reset_control_bulk_get_exclusive() stores the exact pointer to
this array in the device's devres allocations list, making it globally
shared across all device instances could lead to a double-free on device
unbind, or data races during probe.

> +	struct device *dev =3D &pdev->dev;
> +	struct rzg3l_lvds *lvds;
> +	void __iomem *base;
> +	int ret;
> +
> +	lvds =3D devm_drm_bridge_alloc(dev, struct rzg3l_lvds, bridge,
> +				     &rzg3l_lvds_bridge_ops);
> +	if (IS_ERR(lvds))
> +		return PTR_ERR(lvds);
> +
> +	lvds->dev =3D dev;
> +	lvds->bridge.of_node =3D pdev->dev.of_node;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	lvds->regmap =3D devm_regmap_init_mmio(dev, base, &rzg3l_lvds_regmap_co=
nfig);
> +	if (IS_ERR(lvds->regmap))
> +		return dev_err_probe(dev, PTR_ERR(lvds->regmap),
> +				     "Failed to init regmap\n");
> +
> +	lvds->dotclk =3D devm_clk_get(dev, "dotclk");
> +	if (IS_ERR(lvds->dotclk))
> +		return PTR_ERR(lvds->dotclk);

[Severity: Low]
Does the driver need to allocate this dotclk?

It is fetched here but never referenced again, which might unnecessarily
consume memory and a clock reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930133257.2321=
0-1-biju.das.jz@bp.renesas.com?part=3D7
