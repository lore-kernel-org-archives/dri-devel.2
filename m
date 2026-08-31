Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CD4C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9429010E792;
	Mon, 31 Aug 2026 09:16:40 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D2110E792
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:16:38 +0000 (UTC)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::4e])
 (Authenticated sender: pza@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1679A201EB9;
 Mon, 31 Aug 2026 11:16:37 +0200 (CEST)
Message-ID: <dfcd32d28aa0a450abfaa852e819ee7c25c925ee.camel@pengutronix.de>
Subject: Re: [PATCH v3 07/13] drm: renesas: rz-du: Add support for RZ/G3L
 LVDS encoder
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm	 <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>
Date: Mon, 31 Aug 2026 11:16:37 +0200
In-Reply-To: <20260826174854.199139-8-biju.das.jz@bp.renesas.com>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-8-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mi, 2026-08-26 at 18:48 +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add support for the RZ/G3L LVDS encoder driver. It operates in single-lin=
k
> mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
> from 25 to 87 MHz. The LVDS module cannot be used at the same time as
> MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock an=
d
> the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
> MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
> module.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
[...]
> ---
>  drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
>  drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
>  drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 295 ++++++++++++++++++
>  .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
>  4 files changed, 334 insertions(+)
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
>=20
[...]
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm=
/renesas/rz-du/rzg3l_lvds.c
> new file mode 100644
> index 000000000000..2a7ae67ff08d
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
> @@ -0,0 +1,295 @@
[...]
> +static int rzg3l_lvds_probe(struct platform_device *pdev)
> +{
> +	struct reset_control *rstc, *arstc;
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
> +				     "failed to init regmap\n");
> +
> +	lvds->dotclk =3D devm_clk_get(dev, "dotclk");
> +	if (IS_ERR(lvds->dotclk))
> +		return PTR_ERR(lvds->dotclk);
> +
> +	rstc =3D devm_reset_control_get_exclusive(dev, "rst");
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc), "failed to get rst\n");
> +
> +	arstc =3D devm_reset_control_get_exclusive(dev, "arst");
> +	if (IS_ERR(arstc))
> +		return dev_err_probe(dev, PTR_ERR(arstc),
> +				     "failed to get arst\n");

It would be nice to have a comment about the two MIPI DSI resets having
to be asserted here as well.

Also, it looks like you could pair these two ...

> +
> +	lvds->prstc =3D devm_reset_control_get_exclusive(dev, "prst");
> +	if (IS_ERR(lvds->prstc))
> +		return dev_err_probe(dev, PTR_ERR(lvds->prstc),
> +				     "failed to get prst\n");
> +
> +	lvds->lvd_rstc =3D devm_reset_control_get_exclusive(dev, "lvdrst");
> +	if (IS_ERR(lvds->lvd_rstc))
> +		return dev_err_probe(dev, PTR_ERR(lvds->lvd_rstc),
> +				     "failed to get core reset\n");

... and these two into a devm_reset_control_bulk_get_exclusive() each.

regards
Philipp
