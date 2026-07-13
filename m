Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC0CC44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A6B10EA05;
	Mon, 13 Jul 2026 14:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DN4KHqhL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97EA10EA05
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:41:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70AC5401DB;
 Mon, 13 Jul 2026 14:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E11F000E9;
 Mon, 13 Jul 2026 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783953714;
 bh=q2fLhw9ZIcN84g5BPx9iRFZCJqh8poFKMFbQ5AanGcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DN4KHqhLSsfOHaR2i+QddAzkPIv1IwZsnBC0CvRsJkwzdS6yEQH/MAM7Gipfbb4iU
 JU9H/6NMKtv7GYOXdvBaXw4Dcng5fwfGDAlF2u6D68gNi7GKbizXXgFh1WM27y5kW0
 tA7NY75viM0p9oNqcQIRQnkFRjfAgyCTwGoM/RRuF4NZ9qVwVAMd7xJMA5ySTS/kVt
 123WmqDUm7LpsQka3QDIU+o1vKdOohMlAgr8FM+dtxrMiz2qDYpqpttMB+l80nwWkQ
 zB9zxtxv9jnbac9YSDFK8H3Haxm4pT3JV0kc7laDVJp6XeGlCzQ0aPXneTStID+D3f
 B1zMcJWPUNgyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] drm/mediatek: Implement Display Stream
 Compression support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713142746.40259-3-angelogioacchino.delregno@collabora.com>
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:41:53 +0000
Message-Id: <20260713144154.0F1E11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Truncation of RC buffer thresholds due to incorrect bitwise maskin=
g instead of right-shifting.
- [High] Hardcoded and conflicting slice count assumptions without panel va=
lidation.
- [High] Component discovery loop skips DSI component, preventing DSC initi=
alization.
- [High] DSI timing calculation ignores compression and overwrites D-PHY cl=
ock lane register.
- [Medium] State retention bug where `dsc_config_done` is never reset to fa=
lse.
--

--- Patch [2]: [PATCH v4 02/10] drm/mediatek: Implement Display Stream Comp=
ression support ---
commit 94686398e3eedc1a9e39476763b6747a4bcfb4c9
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: Implement Display Stream Compression support

This commit introduces a new driver for the Display Stream Compression (DSC)
Display Controller IP, implementing support for DSC v1.1 to v1.2. It adds
DSC handling into the DSI driver and integrates the bypass setup via CPU
writes instead of CMDQ.

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
Does this loop terminate one iteration early, causing the DSI component=20
to be skipped?

Because the loop condition is i < mtk_crtc->ddp_comp_nr - 1, and the DSI=20
interface is typically the final component in the display pipeline, it=20
appears comp_dsi will remain NULL here. This would cause the subsequent=20
DSC initialization check to silently fail and bypass the DSC setup entirely.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> new file mode 100644
> index 0000000000000..bed6b77bf9a9e
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
[ ... ]
> +static void mtk_dsc_pps_setup(struct mtk_dsc *disp_dsc, struct drm_dsc_c=
onfig *dsc_cfg)
> +{
[ ... ]
> +	/* PPS 8..11 - Each register holds 4 RC buffer thresholds (PPS 11 has t=
wo) */
> +	for (i =3D 0; i < 4; i++) {
> +		u8 block_num =3D i * 4;
> +		data =3D 0;
> +
> +		for (j =3D 0; j < 4; j++) {
> +			u8 buf_index =3D block_num + j;
> +			u8 data_shift =3D j * 8;
> +
> +			/* rc_buf_thresh holds 14 elements in total */
> +			if (buf_index > 13)
> +				break;
> +
> +			data |=3D (rbt[buf_index] & DSC_P8_RC_BUF_THR_X) << data_shift;

[Severity: High]
Does this code truncate the RC buffer thresholds by masking with 0xFF=20
instead of shifting right?

The VESA DSC specification requires programming the Picture Parameter Set=20
registers with RC buffer thresholds divided by 64. Using a bitwise AND mask=
=20
instead of shifting right by 6 appears to write truncated values to the PPS=
=20
registers, which could break rate control.

[ ... ]
> +void mtk_dsc_setup(struct device *dev, struct drm_dsc_config *dsc_cfg)
> +{
[ ... ]
> +	pic_height_ext_num =3D dsc_cfg->pic_height + dsc_cfg->slice_height - 1;
> +	pic_group_width =3D dsc_cfg->slice_width * 4;
> +	pic_group_width /=3D 3;

[Severity: High]
Does this calculation hardcode the picture group width to assume exactly=20
four slices per line?

If a panel requests a different slice count, this could conflict with the=20
payload size assumptions made elsewhere in the pipeline and potentially=20
cause display corruption.

[ ... ]
> +	if (dsc_en_bit)
> +		dsc_con |=3D DSC_EN;
> +
> +	writel(dsc_con, disp_dsc->reg + DISP_REG_DSC_CON);
> +
> +	disp_dsc->dsc_config_done =3D true;
> +}

[Severity: Medium]
Can this state retention cause issues on subsequent modesets?

Since the dsc_config_done flag is never reset to false on teardown, will a=
=20
subsequent non-DSC modeset bypass the check below in mtk_dsc_start() and=20
leave the DSC IP active with stale parameters?

[ ... ]
> +void mtk_dsc_start(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +
> +	/* If no DSC or config not done, set bypass mode */
> +	if (!disp_dsc->dsc_config_done) {

[ ... ]
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3f3f56eed3f92..8ab5c3431dbbc 100644
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
Does this hardcode the DSI payload to assume exactly two slices per line?

This appears to conflict with the assumption of four slices per line inside=
=20
mtk_dsc_setup(). Is it possible to validate the panel's requested slice=20
count against these assumptions during the mode_valid check?

> +
> +	if (config_vact) {
> +		writel(FIELD_PREP(VACT_NL, dsi->vm.vactive),
> +		       dsi->regs + reg_main[DSI_VACT_NL]);
> +		writel(ps_wc, dsi->regs + reg_main[DSI_HSTX_CKL_WC]);

[Severity: High]
Will writing the compressed payload size here overwrite the correctly=20
calculated D-PHY High-Speed Clock Lane Word Count?

[ ... ]
> -static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> +static int mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>  {
>  	struct videomode *vm =3D &dsi->vm;
> +	int ret;
> =20
>  	writel(vm->vsync_len, dsi->regs + DSI_VSA_NL);
>  	writel(vm->vback_porch, dsi->regs + DSI_VBP_NL);
>  	writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
>  	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
> =20
> -	if (dsi->driver_data->has_size_ctl)
> -		writel(FIELD_PREP(DSI_HEIGHT, vm->vactive) |
> -			FIELD_PREP(DSI_WIDTH, vm->hactive),
> -			dsi->regs + DSI_SIZE_CON);
> -
>  	if (dsi->driver_data->support_per_frame_lp)
>  		mtk_dsi_config_vdo_timing_per_frame_lp(dsi);
>  	else
>  		mtk_dsi_config_vdo_timing_per_line_lp(dsi);
> =20
> -	mtk_dsi_ps_control(dsi, false);
> +	if (dsi->dsc) {
> +		ret =3D mtk_dsi_set_dsc_params(dsi);
> +		if (ret)
> +			return ret;
> +
> +		mtk_dsi_ps_control(dsi, true);

[Severity: High]
Do the DSI lane timings calculated earlier in=20
mtk_dsi_config_vdo_timing_per_frame_lp() incorrectly use the uncompressed=20
pixel count?

By passing config_vact =3D true into mtk_dsi_ps_control() for DSC streams, =
it=20
looks like the raw compressed payload size will subsequently overwrite the=
=20
timing synchronized register DSI_HSTX_CKL_WC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713142746.4025=
9-1-angelogioacchino.delregno@collabora.com?part=3D2
