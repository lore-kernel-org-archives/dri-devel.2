Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA00CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E682B10E063;
	Fri, 19 Jun 2026 10:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WnFK/fWt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F8110E063
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:20:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCDDE40855;
 Fri, 19 Jun 2026 10:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990C71F000E9;
 Fri, 19 Jun 2026 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781864414;
 bh=I/WjW0IR/fbFdGadkqphvTETG/2RWQrgYNZ3F+QvoeA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WnFK/fWtk+D+fW1fHX38+qcEjPiXAhS6SxVXIO/ra25npVvDtqo5v+dnn2YfrBX9m
 /qmVyrppy1vfLPd4QIgMgIU0/g5AYw/WkA6a0P4eDLcgintypEUulgfmGNYyhevb/T
 3dVx6xVfI/oRlt5iQedtDD63aZOFQl2+ayZ9hq1/Dcots9OtlcUx05HuoIPnH4bEUa
 6NeG9OuPZXx+PwY2mgzsanfU/cyEr94hjz6Zv+JZyDdLwS/c+hO58Aqu9ENwe72uOt
 754iGwrGgRen1371Ac7IRJzQe9XjLWXdrrqHFeTjIWcsPeDkEIvWckhzFe3h4MBQj3
 PR9mPUCfjKG3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
To: Biju <biju.das.au@gmail.com>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260619101026.323633-3-biju.das.jz@bp.renesas.com>
References: <20260619101026.323633-1-biju.das.jz@bp.renesas.com>
 <20260619101026.323633-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 10:20:14 +0000
Message-Id: <20260619102014.990C71F000E9@smtp.kernel.org>
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
- [High] Sleeping functions called in atomic context during bridge enable
- [High] Early returns in `atomic_enable` cause unbalanced PM counter and u=
npowered hardware access in `atomic_disable`
--

commit 0eae00dcaa6988008a1dca84233d19bc97469ed0
Author: Biju Das <biju.das.jz@bp.renesas.com>

drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

Adds support for the RZ/G3L LVDS encoder driver operating in single-link
mode with 4 lanes. It supports pixel clocks from 25 to 87 MHz and shares
peripherals with MIPI-DSI.

> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm=
/renesas/rz-du/rzg3l_lvds.c
> new file mode 100644
> index 0000000000000..6100888ea7284
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
[ ... ]
> @@ -0,0 +1,285 @@
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

[Severity: High]
If drm_atomic_get_new_bridge_state() returns NULL and takes this early retu=
rn,
will rzg3l_lvds_atomic_disable() later execute unconditionally and access
unpowered hardware registers or cause a runtime PM usage counter underflow?
Since atomic_enable returns void, the DRM core might still consider the bri=
dge
enabled.

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

[Severity: High]
Similarly, if pm_runtime_get_sync() fails, returning early here leaves the
device unpowered. When rzg3l_lvds_atomic_disable() is called during teardow=
n,
could this lead to a bus fault from accessing unpowered MMIO registers and
an unbalanced pm_runtime_put() counter?

[Severity: High]
Also, since atomic_enable callbacks run in an atomic commit context where
sleeping is forbidden, is it safe to use pm_runtime_get_sync() here? This
function blocks and sleeps while waiting for the device to resume, which mi=
ght
cause a scheduling while atomic regression.

> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, LVDS_0_PHY_CH_EN_BGR);
> +	fsleep(20);
> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, LVDS_0_PHY_CH_EN_LDO);
> +	fsleep(10);

[Severity: High]
Because this is an atomic commit path, delay functions that can sleep like
fsleep() are unsafe. Could these fsleep() calls (which map to usleep_range()
or msleep()) lead to scheduling while atomic bugs? Would udelay() or ndelay=
()
be more appropriate for these hardware delays?

> +
> +	regmap_write(lvds->regmap, LVDS_CMN, LVDS_CMN_RST_PHY0_SEL);
> +	regmap_update_bits(lvds->regmap, LVDS_0_CTL_OFFSET,
> +			   LVDS_0_CTL_FMT_SEL0_MSK,
> +			   FIELD_PREP(LVDS_0_CTL_FMT_SEL0_MSK, fmt));
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN0_MSK, LVDS_0_PHY_CH_IO_EN0);
> +	regmap_write(lvds->regmap, LVDS_CMN,
> +		     LVDS_CMN_RST_PHY0_SEL | LVDS_CMN_PHY_RESET);
> +	fsleep(100);

[Severity: High]
Could this fsleep(100) call also sleep in this atomic context?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619101026.3236=
33-1-biju.das.jz@bp.renesas.com?part=3D2
