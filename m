Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37418C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC3910E8D0;
	Mon, 13 Jul 2026 10:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hgl00vC9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56DF410E8D0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:14:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C13B1600FC;
 Mon, 13 Jul 2026 10:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED09F1F00A3A;
 Mon, 13 Jul 2026 10:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937640;
 bh=BVfe0oej2a8YVnGYC2isoX9divgQnu2DMYjF7G7jSO0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hgl00vC9K+Fqt6BnDs2Cbs2N8ogtOWr/LNRXRr2XAx+8jSVNbyCak2kwmwq9tIVah
 MQynBoiXTTA8pHvBPGY8h/oHWqj6hUj+roitMcRYu2XQs4t6/FcKyk60fSXPpfhddG
 T64C3gDvEwV62PotgqKSyn4iVuOOOv5MVucm7V4O6+IjliUidgXiIsjMLQBWNOAFS6
 uIVLv4n+q0MsJIAP5ehz6nFc9mgxq9SN2d1m1+lB2T5A+rIufEronQkk79pOJT0SzR
 SikvOzMBDKQHQdrjRJyfX+0AwvE/uRDsh2CSc73P3P7T3srTwextDemuk8WZnEQoTF
 21og8H/DHKwQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] drm/mediatek: Implement Display Stream
 Compression support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260713095837.16590-3-angelogioacchino.delregno@collabora.com>
References: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
 <20260713095837.16590-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:13:58 +0000
Message-Id: <20260713101359.ED09F1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 16 potential issue=
(s) to consider:

New issues:
- [High] DSC setup overwrites the DSC control register, disabling the IP af=
ter it was started.
- [High] Uninitialized `slice_chunk_size` is used to configure hardware reg=
isters.
- [High] Integer truncation on `range_data` zeroes out the second set of RC=
 range parameters.
- [High] Off-by-one loop boundary misses PPS 19 and the final RC range para=
meter.
- [High] Incorrect bitmask validation erroneously rejects valid integer BPP=
 configurations.
- [High] State leakage of `dsc_config_done` causes bypass to be skipped whe=
n switching out of DSC modes.
- [High] Loop skips the final pipeline component, causing DSI and DSC to no=
t be found and DSC configuration to be ignored.
- [High] Integer truncation on `dsc_pre_pad_sz` zeroes out the `DSC_PIC_PRE=
PAD_WIDTH` configuration.
- [High] The DSI pixel stream word count assumes exactly 2 DSC slices per l=
ine, violating panel variability.
- [High] DSI link timings use uncompressed byte counts instead of compresse=
d payloads when DSC is active.
- [High] Dangling pointer to `drm_dsc_config` leads to Use-After-Free if th=
e DSI panel is unbound.
- [High] Unscaled RC buffer thresholds are packed into PPS registers, causi=
ng bitwise overflows.
- [Medium] Missing hardware cleanup in `mtk_dsi_poweron()` error path leave=
s DSI enabled but unclocked.
- [Medium] `COMPRESSED_PS_DSC` stream type is conditionally set only when t=
he format is `MIPI_DSI_FMT_RGB888`.
- [Medium] Missing zero validation for `slice_width` and `slice_height` ris=
ks division by zero panics.

Pre-existing issues:
- [High] Caller ignores `mtk_dsi_poweron()` errors, causing unprotected wri=
tes to unclocked DSI MMIO registers.
--

--- Patch [2]: [PATCH v2 02/10] drm/mediatek: Implement Display Stream Comp=
ression support ---
commit 1aa5619e9968680600a369e5067b3b6f174817c1
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: Implement Display Stream Compression support

Add a real driver for the Display Stream Compression (DSC) Display
Controller IP, implementing support for DSC v1.1 to v1.2.

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
> +		if (mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC0 ||
> +		    mtk_crtc->ddp_comp[i]->id =3D=3D DDP_COMPONENT_DSC1)
> +			if (!comp_dsc)
> +				comp_dsc =3D mtk_crtc->ddp_comp[i];
>  	}

[Severity: High]
Does this loop skip the final pipeline component? Because it iterates only =
to
mtk_crtc->ddp_comp_nr - 1, the final component (which is often DSI) won't be
checked, leaving comp_dsi as NULL and silently bypassing DSC configuration.

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
Can calling mtk_ddp_comp_dsc_setup() after mtk_ddp_comp_start() disable the
DSC IP? Looking at mtk_dsc_setup(), it performs a direct writel() to
DISP_REG_DSC_CON which clears the DSC_EN bit that was just set during the
start phase.

>  	/* Initially configure all planes */
>  	for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
>  		struct drm_plane *plane =3D &mtk_crtc->planes[i];
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> new file mode 100644
> index 0000000000000..79b66bd7e5f3c
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
> +			data |=3D dsc_cfg->rc_buf_thresh[buf_index] << data_shift;

[Severity: High]
Are the RC buffer thresholds missing scaling here? The rc_buf_thresh values
can be up to 14 bits wide, but they are packed into 8-bit fields without be=
ing
right-shifted by 6, which could cause bitwise overflows into adjacent field=
s.

> +		}
> +		writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(8 + i));
> +	}
> +
> +	/* PPS 12..19 - Each register holds two sets of RC range parameters (19=
 has one) */
> +	for (i =3D 0; i < 7; i++) {

[Severity: High]
Does this loop terminate before configuring PPS 19? The condition i < 7
means it iterates through i =3D 6, which covers up to PPS 18 (12 + 6). The =
15th
RC range parameter in PPS 19 appears to be skipped.

> +		struct drm_dsc_rc_range_parameters *rcrp =3D dsc_cfg->rc_range_params;
> +		u8 block_num =3D i * 2;
> +		data =3D 0;
> +
> +		for (j =3D 0; j < 2; j++) {
> +			u8 buf_index =3D block_num + j;
> +			u8 data_shift =3D j * 16;
> +			u16 range_data;
> +
> +			range_data =3D FIELD_PREP(DSC_P12_RC_RANGE_MIN_QP,
> +						 rcrp[buf_index].range_min_qp);
> +			range_data |=3D FIELD_PREP(DSC_P12_RC_RANGE_MAX_QP,
> +						 rcrp[buf_index].range_max_qp);
> +			range_data |=3D FIELD_PREP(DSC_P12_RC_RANGE_BPG_OFFSET,
> +						 rcrp[buf_index].range_bpg_offset);
> +
> +			range_data <<=3D data_shift;

[Severity: High]
Could this shift cause integer truncation? The range_data variable is decla=
red
as u16. When j=3D1, data_shift is 16, shifting all bits out of the u16 and
truncating it to 0, which would lose the configuration for the odd-indexed =
RC
range parameters.

> +			data |=3D range_data;
> +
> +			/* rc_range_params holds 15 elements in total */
> +			if (buf_index =3D=3D 14)
> +				break;
> +		}
> +		writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(12 + i));
> +	}
> +}
> +
> +void mtk_dsc_setup(struct device *dev, struct drm_dsc_config *dsc_cfg)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +	u32 dsc_slice_w, dsc_slice_h, dsc_mode, dsc_cfg_rval, dsc_shadow;
> +	u32 dsc_dbg_con, dsc_con, dsc_enc_width, dsc_pic_w, dsc_pic_h;
> +	u16 pic_group_width, pic_height_ext_num, slice_group_width;
> +	u16 chunk_size, dsc_pad_num, dsc_pre_pad_sz;
[ ... ]
> +	dsc_slice_w =3D FIELD_PREP(DSC_SLICE_GROUP_WIDTH_M1, slice_group_width =
- 1);
> +	dsc_slice_w |=3D FIELD_PREP(DSC_SLICE_WIDTH, dsc_cfg->slice_width);
> +	dsc_slice_h =3D FIELD_PREP(DSC_SLICE_WIDTH_MOD3, dsc_cfg->slice_width %=
 3);
> +	dsc_slice_h |=3D FIELD_PREP(DSC_SLICE_NUM_M1,
> +				  (pic_height_ext_num / dsc_cfg->slice_height) - 1);

[Severity: Medium]
Is it possible for dsc_cfg->slice_height to be zero here, leading to a
division by zero panic? A validation check for zero slice height might be
needed.

> +	dsc_slice_h |=3D FIELD_PREP(DSC_SLICE_HEIGHT_M1, dsc_cfg->slice_height =
- 1);
> +
> +	dsc_pad_num =3D 3 - ((chunk_size * 2) % 3) % 3;
> +	dsc_pad_num =3D FIELD_PREP(DSC_PAD_NUMBER, dsc_pad_num);
> +
> +	dsc_pre_pad_sz =3D FIELD_PREP(DSC_PIC_PREPAD_HEIGHT, dsc_cfg->pic_heigh=
t);
> +	dsc_pre_pad_sz |=3D FIELD_PREP(DSC_PIC_PREPAD_WIDTH, dsc_cfg->pic_width=
);

[Severity: High]
Will this truncate the DSC_PIC_PREPAD_WIDTH value? The variable dsc_pre_pad=
_sz
is declared as a u16, but DSC_PIC_PREPAD_WIDTH is defined as GENMASK(31, 16=
),
which means the OR operation will overflow the u16 and lose the width data.

> +
> +	dsc_mode =3D FIELD_PREP(DSC_INIT_DELAY_HEIGHT, 4);
[ ... ]
> +void mtk_dsc_start(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +
> +	/* If no DSC or config not done, set bypass mode */
> +	if (!disp_dsc->dsc_config_done) {

[Severity: High]
Does this handle transitioning from DSC to non-DSC modes correctly? Because
disp_dsc->dsc_config_done is never cleared after being set in mtk_dsc_setup=
(),
it looks like setting bypass mode will be skipped on subsequent starts in
non-DSC configurations.

> +		mtk_ddp_write_mask(NULL, DSC_BYPASS, &disp_dsc->cmdq_reg,
> +				   disp_dsc->reg, DISP_REG_DSC_CON, DSC_BYPASS);
> +		mtk_ddp_write_mask(NULL, DSC_UFOE_SEL, &disp_dsc->cmdq_reg,
> +				   disp_dsc->reg, DISP_REG_DSC_CON, DSC_UFOE_SEL);
> +		mtk_ddp_write_mask(NULL, DSC_DUAL_INOUT, &disp_dsc->cmdq_reg,
> +				   disp_dsc->reg, DISP_REG_DSC_CON, DSC_DUAL_INOUT);
> +	}
> +
> +	mtk_ddp_write_mask(NULL, DSC_EN, &disp_dsc->cmdq_reg,
> +			   disp_dsc->reg, DISP_REG_DSC_CON, DSC_EN);
> +}
> +
> +void mtk_dsc_stop(struct device *dev)
> +{
> +	struct mtk_dsc *disp_dsc =3D dev_get_drvdata(dev);
> +
> +	writel(0, disp_dsc->reg + DISP_REG_DSC_CON);
> +}
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3f3f56eed3f92..3e22553ca990f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -395,7 +399,7 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
> =20
>  static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
>  {
> -	u32 dsi_buf_bpp, ps_val, ps_wc, vact_nl;
> +	u32 dsi_buf_bpp, ps_val, ps_wc, size_val, vact_nl;
> =20
>  	if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
>  		dsi_buf_bpp =3D 2;
>  	else
>  		dsi_buf_bpp =3D 3;
> =20
>  	/* Word count */
> -	ps_wc =3D FIELD_PREP(DSI_PS_WC, dsi->vm.hactive * dsi_buf_bpp);
> +	if (dsi->dsc)
> +		ps_wc =3D FIELD_PREP(DSI_PS_WC, 2 * dsi->dsc->slice_chunk_size);

[Severity: High]
Is it safe to assume exactly 2 DSC slices per line here? If a panel requires
1, 4, or another slice count, hardcoding the multiplier to 2 could result in
improperly sized MIPI DSI packets.

> +	else
> +		ps_wc =3D FIELD_PREP(DSI_PS_WC, dsi->vm.hactive * dsi_buf_bpp);
>  	ps_val =3D ps_wc;
> =20
>  	/* Pixel Stream type */
> @@ -411,7 +418,10 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi, =
bool config_vact)
>  	default:
>  		fallthrough;
>  	case MIPI_DSI_FMT_RGB888:
> -		ps_val |=3D FIELD_PREP(DSI_PS_SEL, PACKED_PS_24BIT_RGB888);
> +		if (dsi->dsc)
> +			ps_val |=3D FIELD_PREP(DSI_PS_SEL, COMPRESSED_PS_DSC);
> +		else
> +			ps_val |=3D FIELD_PREP(DSI_PS_SEL, PACKED_PS_24BIT_RGB888);
>  		break;

[Severity: Medium]
Will this prevent compressed streams for formats other than RGB888? Since t=
he
COMPRESSED_PS_DSC assignment is fully nested inside the MIPI_DSI_FMT_RGB888
case, using DSC with RGB666 would mistakenly signal PACKED_PS_18BIT_RGB666
over the bus.

>  	case MIPI_DSI_FMT_RGB666:
>  		ps_val |=3D FIELD_PREP(DSI_PS_SEL, LOOSELY_PS_24BIT_RGB666);
> @@ -565,7 +587,43 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(st=
ruct mtk_dsi *dsi)
>  	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
>  }
> =20
> -static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> +static int mtk_dsi_set_dsc_params(struct mtk_dsi *dsi)
> +{
> +	struct drm_dsc_config *dsc =3D dsi->dsc;
> +	struct device *dev =3D dsi->host.dev;
> +	int ret;
> +
> +	if (dsc->bits_per_pixel & GENMASK(7, 0)) {
> +		dev_err(dev, "Fractional bits_per_pixel not supported\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Could this bitmask erroneously reject valid integer bits-per-pixel values? =
The
bits_per_pixel value is shifted by 4 (to allow 4 fractional bits).
GENMASK(7, 0) covers the lower 8 bits, which includes 4 of the integer bits.
This would fail for a valid 8 BPP configuration.

> +
> +	if (dsc->bits_per_component !=3D 8) {
> +		dev_err(dev, "%u bits per component is not supported\n",
> +			dsc->bits_per_component);
[ ... ]
> +static int mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>  {
>  	struct videomode *vm =3D &dsi->vm;
> =20
> @@ -574,17 +632,17 @@ static void mtk_dsi_config_vdo_timing(struct mtk_ds=
i *dsi)
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
>  	mtk_dsi_ps_control(dsi, false);
> +
> +	if (dsi->dsc)
> +		return mtk_dsi_set_dsc_params(dsi);
> +
> +	return 0;
>  }

[Severity: High]
Is there an ordering issue here with uninitialized parameters?=20
mtk_dsi_ps_control() reads dsi->dsc->slice_chunk_size, but it hasn't been
computed yet because mtk_dsi_set_dsc_params() is called afterwards.

Additionally, do the DSI timing calculations use uncompressed byte counts w=
hen
DSC is active? The functions mtk_dsi_config_vdo_timing_per_frame_lp() and
per_line_lp() calculate ps_wc using vm->hactive * dsi_tmp_buf_bpp, which
ignores the reduced compressed payload size, potentially miscomputing the
front/back porch and roundup metrics.

> @@ -741,12 +799,17 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> =20
>  	mtk_dsi_ps_control(dsi, true);
>  	mtk_dsi_set_vm_cmd(dsi);
> -	mtk_dsi_config_vdo_timing(dsi);
> +	ret =3D mtk_dsi_config_vdo_timing(dsi);
> +	if (ret)
> +		goto err_disable_digital_clk;
> +
>  	mtk_dsi_set_interrupt_enable(dsi);
>  	mtk_dsi_lane_ready(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 1);
> =20
>  	return 0;
> +err_disable_digital_clk:
> +	clk_disable_unprepare(dsi->digital_clk);
>  err_disable_engine_clk:
>  	clk_disable_unprepare(dsi->engine_clk);
>  err_phy_power_off:

[Severity: Medium]
Does this error path miss cleaning up the DSI hardware state? If
mtk_dsi_config_vdo_timing() fails, jumping to err_disable_digital_clk skips
calling mtk_dsi_disable(dsi), which was enabled earlier in mtk_dsi_poweron(=
),
leaving it enabled but unclocked.

[Severity: High]
This is a pre-existing issue, but does mtk_dsi_ddp_start() ignore
mtk_dsi_poweron() errors? Since mtk_dsi_poweron() can now return errors (li=
ke
when DSC parameter setup fails), mtk_dsi_ddp_start() might proceed to call
mtk_dsi_start() on unclocked hardware.

> @@ -883,6 +946,21 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	if (mode->clock * bpp / dsi->lanes > 1500000)
>  		return MODE_CLOCK_HIGH;
> =20
> +	if (dsi->dsc) {
> +		if (mode->hdisplay % dsi->dsc->slice_width) {

[Severity: Medium]
Is there a risk of a division by zero panic here? If an external panel driv=
er
supplies a zero slice_width, this modulo operation will crash.

> +			dev_err(dsi->host.dev,
> +				"DSC: hdisplay %u is not a multiple of slice width %u\n",
> +				dsi->dsc->slice_width, mode->hdisplay);
> +			return MODE_H_ILLEGAL;
> +		}
> +		if (mode->vdisplay % dsi->dsc->slice_height) {
> +			dev_err(dsi->host.dev,
> +				"DSC: vdisplay %u is not a multiple of slice height %u\n",
> +				dsi->dsc->slice_height, mode->vdisplay);
> +			return MODE_V_ILLEGAL;
> +		}
> +	}
> +
>  	return MODE_OK;
>  }
[ ... ]
> @@ -1006,6 +1091,9 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host=
 *host,
>  			return PTR_ERR(dsi->next_bridge);
>  	}
> =20
> +	if (device->dsc)
> +		dsi->dsc =3D device->dsc;
> +

[Severity: High]
Does this create a dangling pointer if the DSI panel is unbound? A pointer =
to
device->dsc is captured here, but there appears to be no corresponding code=
 in
mtk_dsi_host_detach() to set it back to NULL, which could lead to a
use-after-free.

>  	drm_bridge_add(&dsi->bridge);
> =20
>  	ret =3D component_add(host->dev, &mtk_dsi_component_ops);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095837.1659=
0-1-angelogioacchino.delregno@collabora.com?part=3D2
