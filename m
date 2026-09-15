Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE83C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D31E310E174;
	Tue, 15 Sep 2026 08:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GdykA5u3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001A410E174
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:58:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D41EC43678;
 Tue, 15 Sep 2026 08:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC9A1F000FF;
 Tue, 15 Sep 2026 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789462688;
 bh=q6pD0RjPeWeZhQuJEeDuQW6XqaK9bKRU0RTGo1P1IMA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GdykA5u3Oq3D/vdcYn1b5A0krD/f77F+iLyeyPS64NqRYt3kJJ4edz/zrUokqKuIa
 tuaynH1fkSp0XeSoluSFN0RmrIwd/9fB+nF2VvWiQWSCJwiscrw1lL5hXewlEdXNxL
 2JIKeMYM+013vVY95uXM49iZVg/WxDUf9N1IQpsS5y5kPi9xsGC3PrESgljljCzu8c
 xCfiYHqLOJJVT6p8oEAjZ4uy6HUSOT2anCSOP35Wl+gHK3lgf+kz1AWWWnwF/a0qGM
 Buve6zev8PRWTt8BfWeaTvt8a5/D7X8urLuyQZApiy+zuZGKSN7WMhQAmRWxlfEJ/G
 QOKf3sGT+Li2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/13] drm/mediatek: Implement Display Stream
 Compression support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:58:07 +0000
Message-Id: <20260915085808.4EC9A1F000FF@smtp.kernel.org>
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
- [High] mtk_crtc: DSC hardware enabled before being configured
- [High] drm/mediatek: Hardcoded DSC slice geometry breaks configurable top=
ology
- [High] mtk_crtc: Component loop excludes terminal DSI component, skipping=
 DSC init
- [High] mtk_dsi: Hardware state updated using uninitialized slice_chunk_si=
ze
- [High] mtk_dsi: Data rate and mode validation ignore DSC compression bene=
fits
- [Medium] mtk_disp_dsc: State flag dsc_config_done not cleared on hardware=
 stop
- [Low] mtk_dsi: Reversed string formatting arguments in debug messages
--

commit 842ba0cd3cf93b49cd15a2061c815f58c2c063f1
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: Implement Display Stream Compression support

This commit adds a new driver for the Display Stream Compression (DSC)
Display Controller IP, implementing support for DSC v1.1. It introduces DSC
handling in the mtk_dsi driver and removes basic bypass setup from
mtk_ddp_comp, migrating it to the new mtk_disp_dsc driver.

> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -396,6 +399,17 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
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
Is the terminal DSI component missed by the bounds condition in this loop?

This logic is evaluated inside a loop defined as for (i =3D 0; i <
mtk_crtc->ddp_comp_nr - 1; i++). If the DSI component is the last element in
the display pipeline, it is never evaluated by the loop because of the bound
check. As a result, comp_dsi would remain NULL, and DSC initialization would
be silently skipped entirely.

[ ... ]
> @@ -411,6 +425,13 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk=
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
Could this execution order lead to pipeline synchronization glitches or data
corruption?

The pipeline starts transmitting data when the loop above calls
mtk_ddp_comp_start() for all components. The DSC block is not configured
until mtk_ddp_comp_dsc_setup() runs after the loop completes. This momentary
transmission in an unconfigured or bypass state, followed by programming and
re-enabling on the fly, might lock up the hardware FIFOs.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
[ ... ]
> +void mtk_dsc_setup(struct device *dev, struct drm_dsc_config *dsc_cfg)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
[ ... ]
> +	pic_height_ext_num =3D dsc_cfg->pic_height + dsc_cfg->slice_height - 1;
> +	pic_group_width =3D (dsc_cfg->slice_width * 4) / 3;

[Severity: High]
Is the picture group width hardcoded to exactly 4 slices per line here?

This seems to mathematically conflict with the word count calculation in
mtk_dsi_ps_control_dsc() which assumes 2 slices per line. Hardcoded,
conflicting slice geometry assumptions rather than utilizing the slice_count
from the configuration might guarantee data corruption on panels that do not
match these exact assumptions.

[ ... ]
> +void mtk_dsc_start(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +	u32 val;
> +
> +	val =3D readl(disp_dsc->reg + DISP_REG_DSC_CON);
> +
> +	/* If no DSC or config not done, stop the HW temporarily and set bypass=
 mode */
> +	if (!disp_dsc->dsc_config_done) {
> +		val &=3D ~DSC_EN;
> +		val |=3D DSC_BYPASS | DSC_UFOE_SEL | DSC_DUAL_INOUT;
> +		writel(val, disp_dsc->reg + DISP_REG_DSC_CON);
> +	}
[ ... ]
> +void mtk_dsc_stop(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +
> +	writel(0, disp_dsc->reg + DISP_REG_DSC_CON);
> +}

[Severity: Medium]
Does the config flag remain true on subsequent modesets after being stopped?

Since mtk_dsc_stop() resets the hardware register but doesn't clear the
disp_dsc->dsc_config_done flag, a subsequent modeset enable might see this
flag as true. This would skip the bypass mode logic and instead re-enable
the IP with zeroed configuration bits, momentarily corrupting the stream
until setup executes.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
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
Does this hardcode the DSI payload word count to exactly 2 slices per line?

This conflicts with the 4 slice assumption in mtk_dsc_setup() and breaks
configurable topologies that rely on dsi->dsc->slice_count.

[ ... ]
> @@ -741,10 +828,17 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
[ ... ]
>  	mtk_dsi_ps_control(dsi, true);
>  	mtk_dsi_set_vm_cmd(dsi);
> -	mtk_dsi_config_vdo_timing(dsi);
> +	ret =3D mtk_dsi_config_vdo_timing(dsi);

[Severity: High]
Is it possible for this hardware state to be updated using an uninitialized
slice_chunk_size?

The mtk_dsi_ps_control() call consumes dsi->dsc->slice_chunk_size to program
active DSI hardware, but this variable is not calculated until
mtk_dsi_config_vdo_timing() runs on the subsequent line. This could write
uninitialized memory into critical hardware registers.

[ ... ]
> @@ -884,6 +978,28 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	if (mode->clock * bpp / dsi->lanes > 1500000)
>  		return MODE_CLOCK_HIGH;
> =20
> +	if (dsi->dsc) {

[Severity: High]
Are we validating the mode and calculating the data rate using the
uncompressed BPP?

In mtk_dsi_bridge_mode_valid() (and similarly in mtk_dsi_poweron()), the bpp
is retrieved using mipi_dsi_pixel_format_to_bpp() before checking if DSC is
enabled. Applying the uncompressed BPP to clock limits and data rate
calculations ignores DSC bandwidth savings. This forces the DSI PHY to be
clocked much faster than necessary and artificially rejects valid
high-bandwidth modes.

> +		if (dsi->dsc->slice_width =3D=3D 0 || dsi->dsc->slice_height =3D=3D 0)=
 {
> +			dev_err(dsi->host.dev,
> +				"DSC: Slice width %u height %u not valid!\n",
> +				dsi->dsc->slice_width, dsi->dsc->slice_height);
> +			return MODE_BAD;
> +		}
> +
> +		if (mode->hdisplay % dsi->dsc->slice_width) {
> +			dev_dbg(dsi->host.dev,
> +				"DSC: hdisplay %u is not a multiple of slice width %u\n",
> +				dsi->dsc->slice_width, mode->hdisplay);

[Severity: Low]
Have the string formatting arguments been reversed here?

The slice_width variable is passed to the first format specifier which
expects hdisplay, and mode->hdisplay is passed to the second which expects
the slice width.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915084148.1138=
5-1-angelogioacchino.delregno@collabora.com?part=3D2
