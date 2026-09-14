Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C49C88E66
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AD010EE13;
	Mon, 14 Sep 2026 12:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PLAq8gat";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD3A10EE13
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:14:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86DB460120;
 Mon, 14 Sep 2026 12:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1DC1F000FF;
 Mon, 14 Sep 2026 12:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789388063;
 bh=ODSVSyx06mM0EpsCLHsJi4P7JRyrA2Wu6m19U/nSj+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PLAq8gateE8gOSUbIkmBeMOL3zmczMs8ZDq4J/9JIiy8ojVIPWyyMacqxo7SBAfnB
 jHwQyWXspVi4D71ZAzy2tQ8Zhh52UlzV2OMPyP1juEOBEPgu47/q56p1M76e4Y6WUR
 Gh8SwWxggHEtgfCNk0UsDe3Z/4KbXjo44Ajf4HmQovHsvG+yhjkvSHiK63jHliRx/E
 7/oqPoZVs3AVLgDYgGM9yPIh5OBs/9h6/Ez0zZmaUNB44SBXOJp5YC2n56FmxVrqAx
 +m9hrMfSs9+qUgYWbVKhP2zS9g6MWvw7K5na4ouBlZ/Cd+6pfNQKuBnGH06VReBu2X
 TpKDA+re3+CxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/13] drm/mediatek: Implement Display Stream
 Compression support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260914115812.22751-3-angelogioacchino.delregno@collabora.com>
References: <20260914115812.22751-1-angelogioacchino.delregno@collabora.com>
 <20260914115812.22751-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:14:22 +0000
Message-Id: <20260914121422.EE1DC1F000FF@smtp.kernel.org>
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
- [High] DSI and DSC component detection loop misses the terminal component=
 of the display pipeline, preventing DSC configuration.
- [High] Incorrect execution order for DSC setup and missing state reset ca=
uses DSC hardware corruption on subsequent modesets or resume.
- [High] DSI link data rate, horizontal blanking timings, and clock lane wo=
rd counts do not adjust for DSC compression, breaking timing synchronizatio=
n.
- [High] The pixel stream word count incorrectly hardcodes an assumption of=
 exactly 2 DSC slices per line.
- [High] DSI power-on accesses uninitialized DSC parameters by invoking `mt=
k_dsi_ps_control` before computing them.
- [Medium] The `dsi->dsc` pointer is set to NULL during panel unbind withou=
t serialization, leading to a Use-After-Free or NULL pointer dereference du=
ring modeset.
--

commit d2929d85efc73eb974427b3e2c2a0afbfbe66701
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: Implement Display Stream Compression support

This commit adds Display Stream Compression (DSC) support for the MediaTek
DRM driver. It introduces a new standalone mtk_disp_dsc driver and modifies
the existing CRTC and DSI drivers to configure and integrate DSC.

> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 97e3ff412e6ee..c0a53c153b8d5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -398,6 +401,17 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
_crtc)
>  		if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
>  			mtk_mutex_add_comp(mtk_crtc->mutex,
>  					   mtk_crtc->ddp_comp[i]->id);
> +
> +		/* For now, only single DSI is supported */
> +		if (mtk_crtc->ddp_comp[i]->id >=3D DDP_COMPONENT_DSI0 &&
> +		    mtk_crtc->ddp_comp[i]->id <=3D DDP_COMPONENT_DSI3)
> +			if (!comp_dsi)
> +				comp_dsi =3D mtk_crtc->ddp_comp[i];
> +
> +		if (mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC0 ||
> +		    mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC1)
> +			if (!comp_dsc)
> +				comp_dsc =3D mtk_crtc->ddp_comp[i];
>  	}

[Severity: High]
Will this loop successfully find the DSI component?=20

The loop condition in mtk_crtc_ddp_hw_init iterates until
mtk_crtc->ddp_comp_nr - 1. Because the DSI encoder is always the terminal
component of the display pipeline at ddp_comp_nr - 1, the loop appears to
terminate before inspecting it.

Could this leave comp_dsi as NULL and skip the DSC configuration entirely?

> @@ -413,6 +427,13 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
_crtc)
>  		mtk_ddp_comp_start(comp);
>  	}
> =20
> +	/* Setup the DSC if present, with the config coming from DSI */
> +	if (comp_dsc && comp_dsi) {
> +		dsc_cfg =3D mtk_dsi_get_dsc_config(comp_dsi->dev);
> +		if (dsc_cfg)
> +			mtk_ddp_comp_dsc_setup(comp_dsc, dsc_cfg);
> +	}

[Severity: High]
Is the hardware started before it is fully configured?=20

The preceding loop calls mtk_ddp_comp_start on all components, which will
invoke mtk_dsc_start and write the DSC_EN bit to the control register.

If mtk_ddp_comp_dsc_setup is executed afterwards, could the hardware enter
an invalid state by being enabled before its parameters are applied?

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
[ ... ]
> +void mtk_dsc_stop(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +
> +	writel(0, disp_dsc->reg + DISP_REG_DSC_CON);
> +}

[Severity: High]
Should dsc_config_done be reset to false when stopping the hardware?

If mtk_dsc_stop writes 0 to the register but leaves dsc_config_done as
true, a subsequent resume or modeset might cause mtk_dsc_start to see
dsc_config_done =3D=3D true.=20

Would this skip the bypass mode fallback and write DSC_EN over a zeroed
configuration register, potentially hanging the display pipeline?

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index f82506e10fd59..97b8a91874f5b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> +static void mtk_dsi_ps_control_dsc(struct mtk_dsi *dsi, bool config_vact)
> +{
> +	const struct mtk_dsi_driver_data *data =3D dsi->driver_data;
> +	const u16 *reg_main =3D dsi->driver_data->reg_main;
> +	const short dsi_buf_bpp =3D 3;
> +	u32 ps_wc;
> +
> +	/* Word count */
> +	ps_wc =3D FIELD_PREP(DSI_PS_WC, 2 * dsi->dsc->slice_chunk_size);

[Severity: High]
Can this hardcoded multiplier cause incorrect word counts on different pane=
ls?

Using 2 here assumes there are always exactly 2 DSC slices per line.

Should this use dsi->dsc->slice_count to ensure the payload bytes are
calculated correctly for displays with other slice layouts?

> +	if (config_vact) {
> +		writel(FIELD_PREP(VACT_NL, dsi->vm.vactive),
> +		       dsi->regs + reg_main[DSI_VACT_NL]);
> +		writel(ps_wc, dsi->regs + reg_main[DSI_HSTX_CKL_WC]);
> +	}

[Severity: High]
Does this blindly overwrite the clock lane word count register?

In mtk_dsi_config_vdo_timing_per_frame_lp, hstx_cklp_wc is carefully
calculated based on front porch, back porch, and trailing lengths, and then
written to DSI_HSTX_CKL_WC. When mtk_dsi_ps_control_dsc is subsequently
called, it overwrites that same register with ps_wc (the raw compressed
payload size).=20

Additionally, the calculations for dsi->data_rate in mtk_dsi_poweron and
horizontal blanking timings use uncompressed pixel bit depths rather than
adjusting for DSC compression.

Will these issues combined break clock lane timing synchronization?

> @@ -741,10 +828,17 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> =20
>  	mtk_dsi_ps_control(dsi, true);
>  	mtk_dsi_set_vm_cmd(dsi);
> -	mtk_dsi_config_vdo_timing(dsi);
> +	ret =3D mtk_dsi_config_vdo_timing(dsi);

[Severity: High]
Could this sequence write uninitialized values to the hardware?

mtk_dsi_poweron calls mtk_dsi_ps_control, which reads
dsi->dsc->slice_chunk_size to program the DSI payload size registers.

However, dsi->dsc->slice_chunk_size is only populated when
mtk_dsi_config_vdo_timing eventually calls drm_dsc_compute_rc_parameters.

Does this imply the payload size registers are initially programmed with
zeros or uninitialized memory?

> @@ -1030,6 +1157,8 @@ static int mtk_dsi_host_detach(struct mipi_dsi_host=
 *host,
> =20
>  	component_del(host->dev, &mtk_dsi_component_ops);
>  	drm_bridge_remove(&dsi->bridge);
> +	dsi->dsc =3D NULL;
> +
>  	return 0;
>  }

[Severity: Medium]
Is it safe to clear dsi->dsc without modeset synchronization?

If a user unbinds the panel concurrently while a display modeset is active
(for example, while executing mtk_dsi_config_vdo_timing), could the pointer
become NULL immediately after the check for dsi->dsc?=20

Could this lead to a NULL pointer dereference or use-after-free in
mtk_dsi_set_dsc_params?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914115812.2275=
1-1-angelogioacchino.delregno@collabora.com?part=3D2
