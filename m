Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0C6C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A83810E5F7;
	Mon, 13 Jul 2026 13:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Foxulu6J";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532CB10E5F7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:16:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E0DB43BC0;
 Mon, 13 Jul 2026 13:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EA71F000E9;
 Mon, 13 Jul 2026 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783948594;
 bh=P2Er9am7Z3Xn398CMIQPxCXQXcaUX9pHEU0RjCvw6yM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Foxulu6JLuY/0HxyW2nUbeR0NbcZPNYtKXYu0pi7QAPzxd7WMwuEWig+CLFeT7mb0
 yQHtVL6aqiLNfNenejjoPpdd67GPKlDGNV0xCQ7FsztjlLdjGgNk8Ujbn4SWebDbiD
 L/y8/hk3j477wC5cZv4upGdb1eK5DP4etKgMQjxCoI9MZAEcEr/IIK/sEiY4dlJxU7
 OQaZsWNk8ZgQnllSEi2gbsmgmV7HDTr+xIYPDRQPqavLD0q6Druqa5g8kDqhloDQIR
 E3dVLB50Qx5zb4rxVS6iQfmXCUl4Hk5Q6w8zDZsU7TCUDy5nH7ksCf02NEru8JaI25
 1/cgXfePDrEEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] drm/mediatek: Implement Display Stream
 Compression support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260713130103.34654-3-angelogioacchino.delregno@collabora.com>
References: <20260713130103.34654-1-angelogioacchino.delregno@collabora.com>
 <20260713130103.34654-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:16:33 +0000
Message-Id: <20260713131633.B0EA71F000E9@smtp.kernel.org>
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
- [High] Missing DSC setup due to DSI component being skipped in pipeline c=
omponent search loop.
- [High] DSC is permanently forced into bypass mode due to inverted initial=
ization order and missing bit clear.
- [High] mtk_dsi_poweron() programs DSI_HSTX_CKL_WC with 0 due to using sli=
ce_chunk_size before it is computed.
- [High] An operator precedence bug in the DSC padding calculation yields 3=
 instead of 0 when no padding is required.
- [High] The mtk_disp_dsc driver will fail to probe if the device tree lack=
s the optional 'mediatek,gce-client-reg' property.
- [High] Dangling pointer to `drm_dsc_config` if `component_add()` fails du=
ring DSI host attach.
- [Low] The mode_valid callback triggers kernel log spam by using dev_err()=
 for unsupported modes.
--

--- Patch [2]: [PATCH v3 02/10] drm/mediatek: Implement Display Stream Comp=
ression support ---
commit 5dbf4bdae96138e01b5a5d8e367604bb50ec6d84
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: Implement Display Stream Compression support

This commit introduces a dedicated driver for the Display Stream Compression
(DSC) controller. It extracts DSC bypass configuration from mtk_ddp_comp to
the new driver and updates the DSI driver to handle DSC panel configuration=
s.
It also adds DSC parameter computation and mode validation to the DSI
component.

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
Does this loop miss the DSI component when it is the final component in the
display pipeline?

The enclosing loop in mtk_crtc_ddp_hw_init() has the condition
i < mtk_crtc->ddp_comp_nr - 1. Because the DSI component is almost always t=
he
final block in the display pipeline, the loop terminates before evaluating =
it,
leaving comp_dsi as NULL.

Consequently, the later check if (comp_dsc && comp_dsi) evaluates to false,
and mtk_ddp_comp_dsc_setup() is entirely skipped, causing the display to
fail.

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
> +

[Severity: High]
Are we permanently forcing the DSC into bypass mode by invoking start before
setup here?

Because mtk_ddp_comp_start() is called on all components right before this
block, mtk_dsc_start() executes while dsc_config_done is still false.
This explicitly sets the DSC_BYPASS bit in DISP_REG_DSC_CON.

When mtk_ddp_comp_dsc_setup() runs immediately after, mtk_dsc_setup()
reads the register (which now has bypass set) and fails to clear it before
writing it back. This sequence leaves the DSC IP in bypass mode, sending
uncompressed data to a panel expecting compressed data.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> new file mode 100644
> index 0000000000000..2b3da91e75b1f
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
[ ... ]
> +	dsc_slice_h |=3D FIELD_PREP(DSC_SLICE_NUM_M1,
> +				  (pic_height_ext_num / dsc_cfg->slice_height) - 1);
> +	dsc_slice_h |=3D FIELD_PREP(DSC_SLICE_HEIGHT_M1, dsc_cfg->slice_height =
- 1);
> +
> +	dsc_pad_num =3D 3 - ((chunk_size * 2) % 3) % 3;
> +	dsc_pad_num =3D FIELD_PREP(DSC_PAD_NUMBER, dsc_pad_num);

[Severity: High]
Could this padding calculation evaluate to 3 instead of 0 when no padding is
required?

Because the modulo % operator binds tighter than subtraction -, when
chunk_size * 2 is a multiple of 3 (meaning 0 padding bytes are needed),
it evaluates as 3 - (0 % 3), resulting in 3. This writes an invalid
padding value to the hardware which corrupts the DSC chunk output.

Should this include parentheses for the intended wrap-around logic, like
(3 - ((chunk_size * 2) % 3)) % 3?

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
Will the mtk_disp_dsc driver fail to probe on older device trees lacking the
optional mediatek,gce-client-reg property?

In the previous setup code for DSC in mtk_ddp_comp_init(),
cmdq_dev_get_client_reg() failures were treated as a debug warning and
execution continued. Treating this as a fatal error here prevents probe
entirely on older configurations.

Since the CMDQ register does not appear to be used in this driver (which
uses CPU writes), could this fatal exit be removed to prevent breaking older
device trees?

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index eb325e68aa592..ec5b94f7fa68e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -741,12 +826,19 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> =20
>  	mtk_dsi_ps_control(dsi, true);
>  	mtk_dsi_set_vm_cmd(dsi);
> -	mtk_dsi_config_vdo_timing(dsi);
> +	ret =3D mtk_dsi_config_vdo_timing(dsi);
> +	if (ret)
> +		goto err_disable_dsi_and_digital_clk;
> +

[Severity: High]
Does mtk_dsi_poweron() program DSI_HSTX_CKL_WC with 0 because
slice_chunk_size hasn't been computed yet?

In mtk_dsi_poweron(), mtk_dsi_ps_control(dsi, true) is called before
mtk_dsi_config_vdo_timing(dsi). mtk_dsi_ps_control_dsc() calculates the
pixel stream word count using dsi->dsc->slice_chunk_size and writes it to
DSI_HSTX_CKL_WC because config_vact is true.

However, the DSC RC parameters (including slice_chunk_size) are not computed
until drm_dsc_compute_rc_parameters() executes inside the subsequent call to
mtk_dsi_config_vdo_timing(). Consequently, slice_chunk_size is initially
0, which writes a 0 word count and breaks the DSI pixel stream.

When mtk_dsi_config_vdo_timing() later completes and calls
mtk_dsi_ps_control(dsi, false), the block that writes DSI_HSTX_CKL_WC is
skipped since config_vact is false, leaving the hardware incorrectly
programmed.

[ ... ]
> @@ -883,6 +975,28 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	if (mode->clock * bpp / dsi->lanes > 1500000)
>  		return MODE_CLOCK_HIGH;
> =20
> +	if (dsi->dsc) {
> +		if (dsi->dsc->slice_width =3D=3D 0 || dsi->dsc->slice_height =3D=3D 0)=
 {
> +			dev_err(dsi->host.dev,
> +				"DSC: Slice width %u height %u not valid!\n",
> +				dsi->dsc->slice_width, dsi->dsc->slice_height);
> +			return MODE_BAD;
> +		}
> +
> +		if (mode->hdisplay % dsi->dsc->slice_width) {
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

[Severity: Low]
Will this trigger kernel log spam by using dev_err() during mode validation?

Because mode_valid is invoked frequently by userspace (e.g., during EDID
enumeration and mode probing), printing an error using dev_err() for
incompatible panel modes can flood the kernel log. Mode rejection should
typically use drm_dbg_kms() or fail silently.

[ ... ]
> @@ -1006,6 +1127,9 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host=
 *host,
>  			return PTR_ERR(dsi->next_bridge);
>  	}
> =20
> +	if (device->dsc)
> +		dsi->dsc =3D device->dsc;
> +
>  	drm_bridge_add(&dsi->bridge);
> =20
>  	ret =3D component_add(host->dev, &mtk_dsi_component_ops);

[Severity: High]
Does this leave a dangling pointer to drm_dsc_config if component_add()
fails?

If component_add() fails, mtk_dsi_host_attach() returns an error, which
prompts the DSI panel driver to tear down and free device->dsc. However,
dsi->dsc is never cleared on this error path.

If a different panel (without DSC) later attaches, device->dsc is NULL, so
the conditional if (device->dsc) does not update dsi->dsc, leaving it as
a dangling pointer. When the display pipeline later starts, this freed
pointer will be dereferenced, leading to a Use-After-Free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713130103.3465=
4-1-angelogioacchino.delregno@collabora.com?part=3D2
