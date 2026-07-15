Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFFEC4450A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A0B10E109;
	Wed, 15 Jul 2026 14:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CeJ0M8SY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8258C10E109
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:09:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD27F40893;
 Wed, 15 Jul 2026 14:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A48D1F00ADE;
 Wed, 15 Jul 2026 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784124563;
 bh=TUU5MD04Z1oXDDnPBNnE5ml0h/lInaDp5I70PAnZJ6k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CeJ0M8SYtwvM2viRIzs1kR9OWDdoWEhK0s2K8vzPofgQNhuIRMdWKN7I2mCZF9gR9
 9I2T/ko/A6ANPtu+gQqLU2tmn3tYiArULi9OUabzm+9b62Wx9P1tZiQkBKCNGj9ldO
 oqoEWXU+dxaaycjy1qgpk4XlIv0ncMNvE023t9x67Eywxr52KxgTnpe4IH6MDESlFS
 YW7NmqC9nwCK9fI9Y2eTrFzMidi4RuOzcyKKRIkHjMR6c8qYy7qKDDi33PcvLh3aAI
 DfnZWKVoev5YGvZ0Nj0Tw0B7VdBsvVUvSxpsEUWeg7bBStM04lrPBpfLx//5A/9wCy
 /jactX+eNBzAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/11] drm/mediatek: Implement Display Stream
 Compression support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260715135703.46540-3-angelogioacchino.delregno@collabora.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:09:22 +0000
Message-Id: <20260715140923.6A48D1F00ADE@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Loop iterating over DDP components skips the last element, silentl=
y bypassing DSC hardware initialization.
- [High] DSC hardware is configured after the display pipeline has already =
been started, and state is not reset on stop, risking pipeline hangs and st=
ate mismatches.
- [High] The DSI payload word count is hardcoded to exactly 2 DSC slices pe=
r line, breaking displays with different slice topologies.
- [High] CMDQ client registration failure breaks probe on non-CMDQ platform=
s, contradicting intended CPU fallback.
- [Medium] Calling `mtk_dsi_ps_control(dsi, true)` before computing DSC par=
ameters results in configuring DSI registers with an uninitialized `slice_c=
hunk_size`.
- [Medium] Missing initialization of `pic_width` and `pic_height` in the DS=
C configuration before calculating RC parameters.

Pre-existing issues:
- [Critical] Failure during DSC parameter setup inside `mtk_dsi_poweron` ca=
uses clocks to be disabled, leading to a kernel panic from unclocked regist=
er accesses in `mtk_dsi_start`.
--

--- Patch [2]: [PATCH v6 02/11] drm/mediatek: Implement Display Stream Comp=
ression support ---
commit 4b7d7243b726f6a21138b6126227ad71271efb1e
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: Implement Display Stream Compression support

Add a real driver for the Display Stream Compression (DSC) Display
Controller IP, implementing support for DSC v1.1 to v1.2. This also
introduces DSC handling in the mtk_dsi driver and sets up validation
of DSC parameters.

> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 8e552cdc3b53b..d4be40b2574a1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
[ ... ]
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

[Severity: High]
Are we skipping the final array element in this loop?

In mtk_crtc_ddp_hw_init(), the loop condition is:
i < mtk_crtc->ddp_comp_nr - 1

Since the DSI interface is positioned at the end of the pipeline, comp_dsi =
is
never assigned here, preventing DSC from being configured.

> +		if (mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC0 ||
> +		    mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC1)
> +			if (!comp_dsc)
> +				comp_dsc =3D mtk_crtc->ddp_comp[i];
>  	}
>  	if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
>  		mtk_mutex_add_comp(mtk_crtc->mutex, mtk_crtc->ddp_comp[i]->id);
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
> +

[Severity: High]
Could configuring the DSC hardware after the pipeline has started cause har=
dware
hangs?

mtk_ddp_comp_start() is called for all components just above this code,
starting the pipeline in BYPASS mode. Then mtk_ddp_comp_dsc_setup() dynamic=
ally
disables, reconfigures, and re-enables the active DSC block on the live str=
eam.

>  	/* Initially configure all planes */
>  	for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
>  		struct drm_plane *plane =3D &mtk_crtc->planes[i];
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> new file mode 100644
> index 0000000000000..bed6b77bf9a9e
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
[ ... ]
> +void mtk_dsc_stop(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +
> +	writel(0, disp_dsc->reg + DISP_REG_DSC_CON);
> +}

[Severity: High]
Should this function reset disp_dsc->dsc_config_done on stop?

If dsc_config_done is not cleared, on resume mtk_dsc_start() will skip BYPA=
SS
mode and immediately assert DSC_EN with zeroed configuration registers, whi=
ch
could lead to pipeline hangs or display failures.

[ ... ]
> +static int mtk_dsc_probe(struct platform_device *pdev)
> +{
[ ... ]
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get gce client reg\n");
> +#endif

[Severity: High]
Will this unconditional return break the driver probe on non-CMDQ platforms?

If the optional mediatek,gce-client-reg device tree property is missing,
cmdq_dev_get_client_reg() returns an error. Propagating this error prevents
the driver from gracefully falling back to CPU writes on systems without CM=
DQ.

> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index eb325e68aa592..3237dc765701d 100644
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
Is it intentional to hardcode the payload word count to exactly 2 DSC slices
per line?

If a panel requests a different slice topology (e.g., 1, 3, or 4 slices per
line), hardcoding this to 2 rather than dynamically calculating it based on
dsc->slice_count could cause DSI framing errors.

> +
> +	if (config_vact) {
> +		writel(FIELD_PREP(VACT_NL, dsi->vm.vactive),
> +		       dsi->regs + reg_main[DSI_VACT_NL]);
> +		writel(ps_wc, dsi->regs + reg_main[DSI_HSTX_CKL_WC]);
> +	}
[ ... ]
> +static int mtk_dsi_set_dsc_params(struct mtk_dsi *dsi)
> +{
> +	struct drm_dsc_config *dsc =3D dsi->dsc;
> +	struct device *dev =3D dsi->host.dev;
> +	int ret;
[ ... ]
> +	dsc->initial_scale_value =3D drm_dsc_initial_scale_value(dsc);
> +	dsc->line_buf_depth =3D dsc->bits_per_component + 1;
> +
> +	return drm_dsc_compute_rc_parameters(dsc);
> +}

[Severity: Medium]
Should pic_width and pic_height be populated in the DSC config before
calculating RC parameters?

drm_dsc_compute_rc_parameters() relies on the slice_count calculation, which
divides pic_width by slice_width. If the panel driver does not initialize
them statically, they remain zero, which could cause a division by zero err=
or.

[ ... ]
> @@ -741,12 +828,19 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> =20
>  	mtk_dsi_ps_control(dsi, true);

[Severity: Medium]
Is it safe to call mtk_dsi_ps_control(dsi, true) before computing the DSC
parameters?

mtk_dsi_config_vdo_timing() calculates RC parameters including
slice_chunk_size. Calling mtk_dsi_ps_control() first causes it to utilize a
slice_chunk_size of 0, briefly configuring hardware with a word count of 0
until it gets overwritten.

>  	mtk_dsi_set_vm_cmd(dsi);
> -	mtk_dsi_config_vdo_timing(dsi);
> +	ret =3D mtk_dsi_config_vdo_timing(dsi);
> +	if (ret)
> +		goto err_disable_dsi_and_digital_clk;

[Severity: Critical]
This is a pre-existing issue, but does a failure in mtk_dsi_poweron() lead =
to a
kernel panic later?

When mtk_dsi_config_vdo_timing() fails, mtk_dsi_poweron() gracefully disabl=
es
the clocks and returns an error. However, callers like mtk_dsi_ddp_start()
ignore this error, and the DRM atomic commit proceeds to call mtk_dsi_start=
().

mtk_dsi_start() then unconditionally writes to the DSI_START register while
the clocks are disabled, causing a bus fault (SError) kernel panic. This pa=
tch
adds a new failure path (DSC parameter validation) that readily exposes this
architectural flaw.

> +
>  	mtk_dsi_set_interrupt_enable(dsi);
>  	mtk_dsi_lane_ready(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715135703.4654=
0-1-angelogioacchino.delregno@collabora.com?part=3D2
