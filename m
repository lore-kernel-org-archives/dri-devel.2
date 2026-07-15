Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C395C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1849B10F007;
	Wed, 15 Jul 2026 12:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LR6urBFg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1283710F007
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:02:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3800F6001A;
 Wed, 15 Jul 2026 12:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11FD1F000E9;
 Wed, 15 Jul 2026 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784116939;
 bh=rPl8kv9fi72XcSNecqo8biSYfW1Br/DvpXR2qn6GGO8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LR6urBFgB0bzLzRZZzrQ22mdgT+yJ/PmGi3B+xmzMW5YFNhbAAWGek+/exGxeNp1i
 yTnZhCqfu46KnhuKlhjSD6NKzfkU6iOGm+17OE/g60HYH7AJbzCY6y0ziHNqu3AoVL
 gayRX3k4kPCc1Ms8t8sCbHPJ3MRqgzKakRjo+/avaxqungqhgYK78fpK5YDScXxLDB
 WHN+Aca6IkJ3Es8j9VD3wH6Co76vXJXoQjIjoLdnO0NGm+xFysfKM3qKlHEEf5BQEH
 aJtSUylPgSY/NovxlnQ8s6uHCewD0n9y2jQTpclkPIH8R8fx0K69kZlB5lyvoRH8gS
 YBaUztC++sWDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] drm/mediatek: Implement Display Stream
 Compression support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260715114916.19690-3-angelogioacchino.delregno@collabora.com>
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:02:19 +0000
Message-Id: <20260715120219.B11FD1F000E9@smtp.kernel.org>
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
- [High] Hardware Initialization Bypass due to skipped array element in DDP=
 component loop.
- [High] DSC configuration is written after the component is started, causi=
ng pipeline corruption.
- [High] State leak of `dsc_config_done` breaks non-DSC display modes.
- [High] DSI clock lane timing register `DSI_HSTX_CKL_WC` is destroyed by b=
eing overwritten with the pixel payload word count.
- [High] Hardcoded 2x multiplier for DSC slice count results in incorrect D=
SI payload word count.
- [High] Bandwidth calculations use uncompressed bits-per-pixel (bpp), fals=
ely rejecting valid DSC modes and misconfiguring PHY clocks.
- [Medium] Uninitialized variable `slice_chunk_size` is used for hardware c=
onfiguration during DSI power-on.
--

--- Patch [2]: [PATCH v5 02/11] drm/mediatek: Implement Display Stream Comp=
ression support ---
commit e5bc691dc168426274a3882d1ba1c028fccf77c4
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: Implement Display Stream Compression support

This commit introduces Display Stream Compression (DSC) support for the
MediaTek display controller IP. It extracts DSC IP bypass setup from
mtk_ddp_comp into a new mtk_disp_dsc driver and adds DSC handling to the
mtk_dsi driver.

> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
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

[Severity: High]
Does this loop skip checking the DSI component?

Looking at the loop definition in mtk_crtc_ddp_hw_init(), it iterates up to
ddp_comp_nr - 1. Since DSI is typically the sink and sits at the very end of
the pipeline, it is at index ddp_comp_nr - 1. This means the loop body
checking for DSI components never executes for it, leaving comp_dsi as NULL.
Consequently, the subsequent mtk_ddp_comp_dsc_setup() call is silently
bypassed.

> +
> +		if (mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC0 ||
> +		    mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC1)
> +			if (!comp_dsc)
> +				comp_dsc =3D mtk_crtc->ddp_comp[i];
>  	}
[ ... ]
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
Is mtk_ddp_comp_dsc_setup() called too late here?

The preceding loop calls mtk_ddp_comp_start(comp) for all components, which
starts the DSC in bypass mode. Then mtk_dsc_setup() disables the active DSC
engine:

writel(dsc_con & ~DSC_EN, disp_dsc->reg + DISP_REG_DSC_CON);

It then reconfigures and re-enables the engine. Could disabling and
reconfiguring the active component while the pipeline is already streaming
video data cause hardware hangs or stream corruption?

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
[ ... ]
> +void mtk_dsc_start(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +
> +	/* If no DSC or config not done, set bypass mode */
> +	if (!disp_dsc->dsc_config_done) {
> +		mtk_ddp_write_mask(NULL, DSC_BYPASS, &disp_dsc->cmdq_reg,
> +				   disp_dsc->reg, DISP_REG_DSC_CON, DSC_BYPASS);

[Severity: High]
Does disp_dsc->dsc_config_done need to be cleared when the DSC is stopped?

When switching from a DSC mode to a non-DSC mode, mtk_dsc_stop() zeros
DISP_REG_DSC_CON but leaves dsc_config_done set to true. Later,
mtk_dsc_start() evaluates !disp_dsc->dsc_config_done as false and skips
writing the DSC_BYPASS bit.

Since mtk_dsc_stop() previously zeroed the register, DSC_BYPASS is 0,
leaving compression enabled on a pipeline that now expects uncompressed
video.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> -static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
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
Is it safe to hardcode the slice multiplier to 2?

If a DSC panel uses a different slice count, such as 1 or 4, this calculates
an incorrect payload word count. Should this dynamically multiply by
dsi->dsc->slice_count instead?

> +
> +	if (config_vact) {
> +		writel(FIELD_PREP(VACT_NL, dsi->vm.vactive),
> +		       dsi->regs + reg_main[DSI_VACT_NL]);
> +		writel(ps_wc, dsi->regs + reg_main[DSI_HSTX_CKL_WC]);

[Severity: High]
Does this overwrite the clock lane timing configuration?

In mtk_dsi_config_vdo_timing(), the code calculates and writes intricate
clock timing to DSI_HSTX_CKL_WC via mtk_dsi_config_vdo_timing_per_frame_lp(=
).
Immediately after, it calls mtk_dsi_ps_control(dsi, true), which executes
this writel.

Could this destroy the previously calculated clock timing by completely
overwriting it with just the pixel payload word count?

[ ... ]
> @@ -741,12 +828,19 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> =20
>  	mtk_dsi_ps_control(dsi, true);

[Severity: Medium]
Is dsi->dsc->slice_chunk_size fully initialized before this call?

Here, mtk_dsi_ps_control(dsi, true) routes to mtk_dsi_ps_control_dsc(),
which reads dsi->dsc->slice_chunk_size.

However, the chunk size is only calculated later when
mtk_dsi_config_vdo_timing() calls drm_dsc_compute_rc_parameters(dsc). Will
this result in uninitialized values being temporarily written to DSI hardwa=
re
registers during power-on?

[ ... ]
> @@ -883,6 +977,28 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	if (mode->clock * bpp / dsi->lanes > 1500000)
>  		return MODE_CLOCK_HIGH;

[Severity: High]
Does this bandwidth calculation falsely reject valid DSC modes?

The bpp value is calculated earlier using mipi_dsi_pixel_format_to_bpp(),
which returns the uncompressed bits-per-pixel. Using the uncompressed bpp
for DSC modes calculates a much higher required bandwidth, which can exceed
hardware limits and reject legitimate modes.

Similarly, in mtk_dsi_poweron(), using the uncompressed bpp calculates
a data_rate that misconfigures the PHY clock. Should these calculations
use the compressed bpp (dsi->dsc->bits_per_pixel >> 4) when DSC is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715114916.1969=
0-1-angelogioacchino.delregno@collabora.com?part=3D2
