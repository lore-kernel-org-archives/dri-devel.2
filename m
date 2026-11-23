Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6A606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mva1vmAt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E466210E78A;
	Mon, 23 Nov 2026 10:04:01 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E0F10E78A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795428234;
 bh=GTPJKfk+Vuy2iJXONi3rgzMkg2upooVyvUQ8sikp9Ko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mva1vmAt4wiEfY/P6hmAexz+TZmUVwCKqFfC68UosI6UC5iRnTQ/MKVWSlCQaLDkm
 srypqWcI8XjD/3X4m/cN9cbhpxeqKTESHIWvyr2kIiDZOO4Ae82RYHGZ1v1T5BVbcs
 DDYc4ZSS2GUK8RkLPIB1LKKn/y8hfvrJTLTTKnxjjeeAWHPZ0CePtF6YbhTu2HIZJy
 4yE7GaFfatjjgjW7vslx8PHwAFyGwLA/TS5cu7QSq0/hKTo6s/GPqmKJTYszKWOeMJ
 OP6+dXPSMniA10R5/pEIMOYrsu2btNPplVo5wAw+353PXjeUzuOYSg2DvsKviI03kt
 V6Ny6qwxp2i5w==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 348EF17E031C;
 Mon, 23 Nov 2026 11:03:54 +0100 (CET)
Message-ID: <b973584f-55c7-4d66-b02a-f253bf774ad7@collabora.com>
Date: Mon, 23 Nov 2026 11:03:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/46] drm/mediatek: Add support for MediaTek Digital
 Video Output (DVO)
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?UTF-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-29-angelogioacchino.delregno@collabora.com>
 <b7b4c2bf61a88b533e504603c4dcbc79c1de6f06.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <b7b4c2bf61a88b533e504603c4dcbc79c1de6f06.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 08:42, CK Hu (胡俊光) wrote:
> On Tue, 2026-07-14 at 13:43 +0200, AngeloGioacchino Del Regno wrote:
>> Add a new driver for the Digital Video Output (DVO) hardware found
>> in the MT8189, MT8196 Kompanio SoCs and their Dimensity and Genio
>> variants.
>>
>> This version currently supports output to Embedded DisplayPort on
>> MT8189 and MT8196, and to DisplayPort on MT8189.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> [snip]
> 
>>   static inline struct mtk_dpi *bridge_to_dpi(struct drm_bridge *b)
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index f7cbf9b47672..f96f887809c0 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> @@ -621,8 +621,12 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>>   	  .data = (void *)MTK_DISP_DSI },
>>   	{ .compatible = "mediatek,mt8188-dsi",
>>   	  .data = (void *)MTK_DISP_DSI },
>> -	{ .compatible = "mediatek,mt8196-dsi",
> 
> Why do you remove "mediatek,mt8196-dsi"? This is not related to this patch.

That was not supposed to be here and it's a (huge) mistake.

Thanks for pointing that out.

> 
>> -	  .data = (void *)MTK_DISP_DSI },
>> +	{ .compatible = "mediatek,mt8189-dp-dvo",
>> +	  .data = (void *)MTK_DISP_DVO },
>> +	{ .compatible = "mediatek,mt8189-edp-dvo",
>> +	  .data = (void *)MTK_DISP_DVO },
>> +	{ .compatible = "mediatek,mt8196-edp-dvo",
>> +	  .data = (void *)MTK_DISP_DVO },
>>   	{ }
>>   };
>>   
> 
> [snip]
> 
>> +static void mtk_dvo_config_color_format(struct mtk_dpi *dvo,
>> +					enum mtk_dpi_out_color_format format)
>> +{
>> +	mtk_dvo_config_channel_swap(dvo, dvo->channel_swap);
>> +
>> +	dev_err(dvo->dev, "[DPTX] format:%d", format);
> 
> I think you should use debug, not err.
> 

Yes.

>> +
>> +	switch (format) {
>> +	case MTK_DPI_COLOR_FORMAT_YCBCR_444:
>> +		mtk_dvo_config_yuv422_enable(dvo, false);
>> +		mtk_dvo_config_csc_enable(dvo, true);
>> +		break;
>> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422:
>> +		mtk_dvo_config_yuv422_enable(dvo, true);
>> +		mtk_dvo_config_csc_enable(dvo, true);
>> +		break;
>> +	case MTK_DPI_COLOR_FORMAT_RGB:
>> +	default:
>> +		mtk_dvo_config_yuv422_enable(dvo, false);
>> +		mtk_dvo_config_csc_enable(dvo, false);
>> +		break;
>> +	}
>> +}
>> +
> 
> [snip]
> 
>> +static void mtk_dvo_config_hw(struct mtk_dpi *dvo,
>> +			      struct videomode *vm, struct mtk_dpi_sync *sync,
>> +			      struct mtk_dpi_polarities *dpi_pol,
>> +			      struct mtk_dpi_yc_limit *limit)
>> +{
>> +	struct drm_display_mode *mode = &dvo->mode;
>> +	u32 vactive = vm->vactive;
>> +
>> +	mtk_dvo_sw_reset(dvo, true);
>> +
>> +	mtk_dvo_irq_enable(dvo);
>> +
>> +	mtk_dpi_config_pol(dvo, dpi_pol);
>> +
>> +	mtk_dvo_config_hsync(dvo, &sync->hsync);
>> +	mtk_dvo_config_vsync(dvo, &sync->vsync_l_odd, DVO_TGEN_V0, DVO_TGEN_V1);
>> +	mtk_dvo_config_vsync(dvo, &sync->vsync_l_even, DVO_TGEN_V_EVEN0, DVO_TGEN_V_EVEN1);
>> +
>> +	mtk_dvo_config_interface(dvo, !!(vm->flags & DISPLAY_FLAGS_INTERLACED));
>> +
>> +	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
>> +		vactive >>= 1;
>> +
>> +	mtk_dvo_config_fb_size(dvo, vm->hactive, vactive);
>> +
>> +	mtk_dvo_config_channel_limit(dvo, limit);
>> +	mtk_dvo_config_channel_swap(dvo, dvo->channel_swap);
>> +	mtk_dvo_config_color_format(dvo, dvo->color_format);
>> +
>> +	mtk_dvo_info_queue_start(dvo);
>> +	mtk_dpi_buffer_ctrl(dvo);
>> +
>> +	mtk_dvo_trailing_blank_setting(dvo);
>> +	mtk_dvo_get_gs_level(dvo);
>> +	mtk_dvo_golden_setting(dvo);
> 
> The two register set by mtk_dvo_golden_setting() would immediately set by mtk_dvo_sodi_setting(),
> so mtk_dvo_golden_setting() is redundant function. Drop it.
> 

That's right. I'll recheck that part.

>> +	mtk_dvo_sodi_setting(dvo, mode);
>> +
>> +	mtk_dvo_set_output_pixiter(dvo);
>> +
>> +	mtk_dvo_sw_reset(dvo, false);
>> +}
>> +
> 
> [snip]
> 
>> +
>> +static enum drm_mode_status
>> +mtk_dvo_bridge_mode_valid(struct drm_bridge *bridge,
>> +			  const struct drm_display_info *info,
>> +			  const struct drm_display_mode *mode)
>> +{
> 
> In dpi driver, it check mode->clock max_clock_khz, so I think here should also check this.
> 

Yeah, thing is - this was a bit more complicated than just checking max_clock_hz to
actually be correct, and I was planning to improve that later - but I guess that a
basic check for max_clock_hz is better than unconditionally and stupidly accepting
any mode.

I'll add a decent check here, thanks for pointing that out.

>> +	return MODE_OK;
>> +}
>> +
> 
> [snip]
> 
>> --- /dev/null
>> +++ b/drivers/gpu/drm/mediatek/mtk_dvo_regs.h
>> @@ -0,0 +1,192 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2014 MediaTek Inc.
>> + * Author: Jie Qiu <jie.qiu@mediatek.com>
>> + */
>> +#ifndef __MTK_DPI_REGS_H
> 
> __MTK_DVO_REGS_H
> 
>> +#define __MTK_DPI_REGS_H
>> +
> 
> [snip]
> 
>> +#define DVO_TGEN_INFOQ_LATENCY	0x80
>> +#define INFOQ_START_LATENCY		0
>> +#define INFOQ_START_LATENCY_MASK	(0xffff << 0)
>> +#define INFOQ_END_LATENCY		16
>> +#define INFOQ_END_LATENCY_MASK		(0xffff << 16)
>> +
>> +#define DVO_BUF_CON0		0x220
> 
> It's better to place register definition in address number order.
> 

I completely agree. That was my intention, but with all this stuff that I've done
some things started slipping out of my sight ;-)


>> +#define DISP_BUF_EN			BIT(0)
>> +#define FIFO_UNDERFLOW_DONE_BLOCK	BIT(4)
>> +
> 
> [snip]
> 
>> +#define DVO_PATTERN_COLOR		0x104
>> +#define PAT_R					(0x3ff << 0)
>> +#define PAT_G					(0x3ff << 10)
>> +#define PAT_B					(0x3ff << 20)
>> +
>> +#define DVO_Y_LIMIT			0x130
>> +#define Y_LMT_BOT				GENMASK(9, 0)
>> +#define Y_LMT_TOP				GENMASK(21, 12)
>> +
>> +#define DVO_C_LIMIT			0x134
>> +#define C_LMT_BOT				GENMASK(9, 0)
>> +#define C_LMT_TOP				GENMASK(21, 12)
>> +
>> +#define DVO_SHADOW_CTRL			0x190
>> +#define FORCE_COMMIT				BIT(0)
>> +#define BYPASS_SHADOW				BIT(1)
>> +#define READ_WRK_REG				BIT(2)
>> +
>> +#define DVO_SIZE			0x18
> 
> Ditto.
> 
>> +#define DVO_TGEN_VWIDTH			0x28
>> +#define DVO_TGEN_VPORCH			0x2c
>> +#define DVO_TGEN_HPORCH			0x24
>> +#define DVO_TGEN_HWIDTH			0x20
>> +
>> +#define DVO_BUF_SODI_HIGHT		0x230
>> +#define DVO_BUF_SODI_LOW		0x234
>> +#define DVO_BUF_DVFS_HIGHT		0x238
>> +#define DVO_BUF_DVFS_LOW		0x23c
>> +#define DVO_BUF_PREULTRA_HIGHT		0x240
>> +#define DVO_BUF_PREULTRA_LOW		0x244
>> +#define DVO_BUF_ULTRA_HIGHT		0x248
>> +#define DVO_BUF_ULTRA_LOW		0x24c
>> +#define DVO_BUF_URGENT_HIGHT		0x250
>> +#define DVO_BUF_URGENT_LOW		0x254
>> +#define DVO_DISP_BUF_MASK		GENMASK(31 ,0)
> 
> GENMASK(31, 0)

Thanks, will cleanup

Cheers,
Angelo

> 
> Regards,
> CK
> 
>> +
>> +#define DVO_MATRIX_SET			0x140
>> +#define DVO_CSC_EN			BIT(0)
>> +#define DVO_INT_MTX_SEL_MASK		GENMASK(8, 4)
>> +
>> +#define DVO_YUV422_SET			0x170
>> +#define DVO_YUV422_EN			BIT(0)
>> +#define DVO_CRYCB_MAP			BIT(8)
>> +
> 
