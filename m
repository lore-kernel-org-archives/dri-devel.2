Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E698C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0651B10EC59;
	Tue, 14 Jul 2026 08:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZqF0JTv5";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D051110EC60
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784016584;
 bh=KM0AD2d1EYJgiOQUU1RPa2KcJ5Mzyd7oeXs7HFutUwc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZqF0JTv5RavzCgRN3074owMAwCXT8XEumcwTeZvNHv5pCsarbgg8ccSCFOELEUpOk
 nZb7Gn0UTx7o5a4o0uNUr8r/woyFjKkmnAdRBRh4xCqkqTnCf9tbXh9nbvi2pjeuHb
 vMzRxeL6i9K8Wc+eV5gFGLzO21ULgP11joRef6VIr35qvq2wQwoselF0cORENi6nAZ
 mpdSHjp16BFPcXSdPXGufTh0yGcuefIo1ofzEaRYMvWxWcl+G7laCzd4kSRLRWhzWW
 Km7WNtEqVI+K92CM88BgDs1ZTnRkU7AE22yyxr6v/2ey9GLjO4khV+4qCRMRf3pN3Q
 ZyYBXd9i14EZQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7CBF617E05D3;
 Tue, 14 Jul 2026 10:09:43 +0200 (CEST)
Message-ID: <9cd02188-d697-43a2-b2f4-2868819133d3@collabora.com>
Date: Tue, 14 Jul 2026 10:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] drm/mediatek: Implement Display Stream
 Compression support
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-3-angelogioacchino.delregno@collabora.com>
 <20260713144154.0F1E11F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260713144154.0F1E11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/13/26 16:41, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Truncation of RC buffer thresholds due to incorrect bitwise masking instead of right-shifting.
> - [High] Hardcoded and conflicting slice count assumptions without panel validation.
> - [High] Component discovery loop skips DSI component, preventing DSC initialization.
> - [High] DSI timing calculation ignores compression and overwrites D-PHY clock lane register.
> - [Medium] State retention bug where `dsc_config_done` is never reset to false.
> --
> 
> --- Patch [2]: [PATCH v4 02/10] drm/mediatek: Implement Display Stream Compression support ---
> commit 94686398e3eedc1a9e39476763b6747a4bcfb4c9
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Subject: drm/mediatek: Implement Display Stream Compression support
> 
> This commit introduces a new driver for the Display Stream Compression (DSC)
> Display Controller IP, implementing support for DSC v1.1 to v1.2. It adds
> DSC handling into the DSI driver and integrates the bypass setup via CPU
> writes instead of CMDQ.
> 
>> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
>> index 8e552cdc3b53b..d4be40b2574a1 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> [ ... ]
>> @@ -398,6 +401,17 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
>>   		if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
>>   			mtk_mutex_add_comp(mtk_crtc->mutex,
>>   					   mtk_crtc->ddp_comp[i]->id);
>> +
>> +		/* For now, only single DSI is supported */
>> +		if (mtk_crtc->ddp_comp[i]->id >= DDP_COMPONENT_DSI0 &&
>> +		    mtk_crtc->ddp_comp[i]->id <= DDP_COMPONENT_DSI3)
>> +			if (!comp_dsi)
>> +				comp_dsi = mtk_crtc->ddp_comp[i];
>> +
> 
> [Severity: High]
> Does this loop terminate one iteration early, causing the DSI component
> to be skipped?
> 
> Because the loop condition is i < mtk_crtc->ddp_comp_nr - 1, and the DSI
> interface is typically the final component in the display pipeline, it
> appears comp_dsi will remain NULL here. This would cause the subsequent
> DSC initialization check to silently fail and bypass the DSC setup entirely.
> 
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
>> new file mode 100644
>> index 0000000000000..bed6b77bf9a9e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
> [ ... ]
>> +static void mtk_dsc_pps_setup(struct mtk_dsc *disp_dsc, struct drm_dsc_config *dsc_cfg)
>> +{
> [ ... ]
>> +	/* PPS 8..11 - Each register holds 4 RC buffer thresholds (PPS 11 has two) */
>> +	for (i = 0; i < 4; i++) {
>> +		u8 block_num = i * 4;
>> +		data = 0;
>> +
>> +		for (j = 0; j < 4; j++) {
>> +			u8 buf_index = block_num + j;
>> +			u8 data_shift = j * 8;
>> +
>> +			/* rc_buf_thresh holds 14 elements in total */
>> +			if (buf_index > 13)
>> +				break;
>> +
>> +			data |= (rbt[buf_index] & DSC_P8_RC_BUF_THR_X) << data_shift;
> 
> [Severity: High]
> Does this code truncate the RC buffer thresholds by masking with 0xFF
> instead of shifting right?
> 

This is not truncating anything, and it is the equivalent of

		dsc->dsc_cfg.rc_buf_thresh[idx+3] << 24 |
		dsc->dsc_cfg.rc_buf_thresh[idx+2] << 16 |
		dsc->dsc_cfg.rc_buf_thresh[idx+1] << 8 |
		dsc->dsc_cfg.rc_buf_thresh[idx+0]);

So this is fine.

> The VESA DSC specification requires programming the Picture Parameter Set
> registers with RC buffer thresholds divided by 64. Using a bitwise AND mask
> instead of shifting right by 6 appears to write truncated values to the PPS
> registers, which could break rate control.
> 
> [ ... ]
>> +void mtk_dsc_setup(struct device *dev, struct drm_dsc_config *dsc_cfg)
>> +{
> [ ... ]
>> +	pic_height_ext_num = dsc_cfg->pic_height + dsc_cfg->slice_height - 1;
>> +	pic_group_width = dsc_cfg->slice_width * 4;
>> +	pic_group_width /= 3;
> 
> [Severity: High]
> Does this calculation hardcode the picture group width to assume exactly
> four slices per line?
> 

No, that makes the hardware process 1+1/4 pic width per iteration.

> If a panel requests a different slice count, this could conflict with the
> payload size assumptions made elsewhere in the pipeline and potentially
> cause display corruption.
> 
> [ ... ]
>> +	if (dsc_en_bit)
>> +		dsc_con |= DSC_EN;
>> +
>> +	writel(dsc_con, disp_dsc->reg + DISP_REG_DSC_CON);
>> +
>> +	disp_dsc->dsc_config_done = true;
>> +}
> 
> [Severity: Medium]
> Can this state retention cause issues on subsequent modesets?
> 
> Since the dsc_config_done flag is never reset to false on teardown, will a
> subsequent non-DSC modeset bypass the check below in mtk_dsc_start() and
> leave the DSC IP active with stale parameters?
> 

The dynamic DSC -> non-DSC modesets can be supported only after the mediatek-drm
restructuring. As of now, only all-compressed or all-uncompressed modes displays
are supported.

> [ ... ]
>> +void mtk_dsc_start(struct device *dev)
>> +{
>> +	struct mtk_dsc *disp_dsc = dev_get_drvdata(dev);
>> +
>> +	/* If no DSC or config not done, set bypass mode */
>> +	if (!disp_dsc->dsc_config_done) {
> 
> [ ... ]
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 3f3f56eed3f92..8ab5c3431dbbc 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> [ ... ]
>> +static void mtk_dsi_ps_control_dsc(struct mtk_dsi *dsi, bool config_vact)
>> +{
>> +	const struct mtk_dsi_driver_data *data = dsi->driver_data;
>> +	const u16 *reg_main = dsi->driver_data->reg_main;
>> +	const short dsi_buf_bpp = 3;
>> +	u32 ps_wc;
>> +
>> +	/* Word count */
>> +	ps_wc = FIELD_PREP(DSI_PS_WC, 2 * dsi->dsc->slice_chunk_size);
> 
> [Severity: High]
> Does this hardcode the DSI payload to assume exactly two slices per line?
> 
> This appears to conflict with the assumption of four slices per line inside
> mtk_dsc_setup(). Is it possible to validate the panel's requested slice
> count against these assumptions during the mode_valid check?
> 

No, that's another thing entirely, it's the per-iteration DSI word count and
the dsc_setup is not hardcoding four slices per line.

>> +
>> +	if (config_vact) {
>> +		writel(FIELD_PREP(VACT_NL, dsi->vm.vactive),
>> +		       dsi->regs + reg_main[DSI_VACT_NL]);
>> +		writel(ps_wc, dsi->regs + reg_main[DSI_HSTX_CKL_WC]);
> 
> [Severity: High]
> Will writing the compressed payload size here overwrite the correctly
> calculated D-PHY High-Speed Clock Lane Word Count?
> 

What!??! No!!!

> [ ... ]
>> -static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>> +static int mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>>   {
>>   	struct videomode *vm = &dsi->vm;
>> +	int ret;
>>   
>>   	writel(vm->vsync_len, dsi->regs + DSI_VSA_NL);
>>   	writel(vm->vback_porch, dsi->regs + DSI_VBP_NL);
>>   	writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
>>   	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>>   
>> -	if (dsi->driver_data->has_size_ctl)
>> -		writel(FIELD_PREP(DSI_HEIGHT, vm->vactive) |
>> -			FIELD_PREP(DSI_WIDTH, vm->hactive),
>> -			dsi->regs + DSI_SIZE_CON);
>> -
>>   	if (dsi->driver_data->support_per_frame_lp)
>>   		mtk_dsi_config_vdo_timing_per_frame_lp(dsi);
>>   	else
>>   		mtk_dsi_config_vdo_timing_per_line_lp(dsi);
>>   
>> -	mtk_dsi_ps_control(dsi, false);
>> +	if (dsi->dsc) {
>> +		ret = mtk_dsi_set_dsc_params(dsi);
>> +		if (ret)
>> +			return ret;
>> +
>> +		mtk_dsi_ps_control(dsi, true);
> 
> [Severity: High]
> Do the DSI lane timings calculated earlier in
> mtk_dsi_config_vdo_timing_per_frame_lp() incorrectly use the uncompressed
> pixel count?
> 
> By passing config_vact = true into mtk_dsi_ps_control() for DSC streams, it
> looks like the raw compressed payload size will subsequently overwrite the
> timing synchronized register DSI_HSTX_CKL_WC.
> 

It's done on purpose.
