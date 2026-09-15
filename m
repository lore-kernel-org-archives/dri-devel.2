Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F31EC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD2C10FC1B;
	Tue, 15 Sep 2026 15:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="G/D51xBP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDBD10FC1B
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789484740;
 bh=pN+y+ua7LcQO4k08fzswufOynoNn3Gegmsif93HWJfw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=G/D51xBPXsh/78g+ra+ytqPS9njN+2QjXQlko8dJ3FUYq32RQHTYCEd4pqbfbAPBR
 r5qbbj/lwRONctQ5LMiAlG3fG2pcP8OvNrPoHFvEiwBEnzU4oufy47+tqaUE/ZezoD
 owr41VHIE0Ry1zdqS48Ry2A23xFXypqfLnwH+Uvkfi5iOoR2CeH7fqxPLAmY/Nt9Sf
 LAeCx2myTG2grgKNZFiP/fEk7RvoA+cGWqhgHLWzJduQ5C7Gf8f2F7kRA10q2mk9aN
 Pqh+fnpjZffqewNoWNo7LDLok6Mc5m+lbBxA0qRS4Yq037IYSuhEP/JTKie3v0Kz2r
 wOzPAmiBHyzUg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4514817E0082;
 Tue, 15 Sep 2026 17:05:39 +0200 (CEST)
Message-ID: <14b99e0a-e08a-42af-b982-471cae869149@collabora.com>
Date: Tue, 15 Sep 2026 17:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/13] drm/mediatek: Implement Display Stream
 Compression support
To: Nikolai Burov <nikolai.burov@jolla.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "jitao.shi@mediatek.com" <jitao.shi@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "justin.yeh@mediatek.com" <justin.yeh@mediatek.com>,
 "jason-jh.lin@mediatek.com" <jason-jh.lin@mediatek.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
 <GV1PR06MB8417DED4A9C82CE84248F5F5E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <GV1PR06MB8417DED4A9C82CE84248F5F5E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
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

On 9/15/26 15:55, Nikolai Burov wrote:
> (Sorry for the resend, I made a mistake with the formatting and the recipient list)
> 
> On 9/15/26 11:41 AM, AngeloGioacchino Del Regno wrote:
>> Add a real driver for the Display Stream Compression (DSC) Display
>> Controller IP, implementing support for DSC v1.1 to v1.2.
>>
>> In order to do this, it was necessary to remove the basic DSC IP
>> bypass setup from mtk_ddp_comp: this functionality is retained in
>> the new mtk_disp_dsc driver, which checks if DSC was actually
>> requested by other components (with the only one that currently
>> supports this being DSI) and, if not, it will set BYPASS mode in
>> the DSC IP.
>>
>> Like before, the BYPASS mode is set before starting the DSC IP,
>> but unlike before, this is being done in the component start
>> callback instead of the config one.
>> Notably, the config callback is called by mtk_crtc always
>> immediately before the calling start callback, so the order of
>> register writes is retained.
>> The only real difference is that now this is being done through
>> CPU writes instead of CMDQ, but since that's called only once
>> and since it's just three registers, the performance impact will
>> not be minimal and not even measurable.
>>
>> As anticipated, DSC handling was also introduced in the mtk_dsi
>> driver: when performing dsi_host_attach, the driver now checks
>> if the DSI panel adds the DSC configuration structure to the
>> mipi_dsi_device structure and, if it does, it will store a
>> pointer in the driver-local mtk_dsi structure's `dsc` member.
>>
>> The DSI driver will then check whether the DSC configuration
>> that comes from the panel is valid (in regard to MediaTek DSI)
>> and will call the DRM API's DSC helpers to calculate and set
>> all of the const and RC parameters for the actual DSC setup.
>>
>> For the time being, even though the latest MediaTek SoCs do
>> support DSC v1.2, only DSC v1.1 pre-scr support is implemented
>> as an initial contribution (which is rather big, and 1.2 would
>> make it even bigger - but that can anyway be implemented later).
>>
>> As a last step for validation of DSC parameters in DSI, a check
>> for the hdisplay against DSC slice sidth and one for vdisplay
>> against DSC slice height was added to the mode_valid callback,
>> making sure that H/V are, as expected, multiples of slice W/H.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Hello,
> 
> I have been testing previous versions of this patch on an MT6858 device
> with a DSC-only panel. Since I spotted a few issues with the code, I
> decided to leave a few comments here even though I am not a maintainer.
> Some of them are already mentioned in the Sashiko report.
> 

Hey, thanks for your comments!

> [...]
>> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
>> index 97e3ff412e6e..c0a53c153b8d 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
>> @@ -22,6 +22,7 @@
>>   
>>   #include "mtk_crtc.h"
>>   #include "mtk_ddp_comp.h"
>> +#include "mtk_disp_drv.h"
>>   #include "mtk_drm_drv.h"
>>   #include "mtk_plane.h"
>>   
>> @@ -344,6 +345,8 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
>>   	struct drm_connector *connector;
>>   	struct drm_encoder *encoder;
>>   	struct drm_connector_list_iter conn_iter;
>> +	struct mtk_ddp_comp *comp_dsi = NULL, *comp_dsc = NULL;
>> +	struct drm_dsc_config *dsc_cfg;
>>   	struct drm_device *dev = mtk_crtc->base.dev;
>>   	unsigned int width, height, vrefresh, bpc = MTK_MAX_BPC;
>>   	int ret;
>> @@ -398,6 +401,17 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
> 
> This is inside a for loop that skips the last item:
> 
>      for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
> 
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
>> +		if (mtk_crtc->ddp_comp[i]->id == DDP_COMPONENT_DSC0 ||
>> +		    mtk_crtc->ddp_comp[i]->id == DDP_COMPONENT_DSC1)
>> +			if (!comp_dsc)
>> +				comp_dsc = mtk_crtc->ddp_comp[i];
> 
> If DSI is the last component, it would never be considered as a
> candidate for DSC setup. Shouldn't this be in a loop that covers all
> components?
> 

That's my own mess during conflict resolution.... as that was supposed to be in
the latter loop instead, ugh. Just 7-8 lines above...

I guess that's what happens when carrying things and rebasing continuously...

Though, that worked for me because I tested that on the restructured mediatek-drm
code which, in turn, resolves this bug due to the refactoring. Oops again.

>>   	}
>>   	if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
>>   		mtk_mutex_add_comp(mtk_crtc->mutex, mtk_crtc->ddp_comp[i]->id);
>> @@ -413,6 +427,13 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
>>   		mtk_ddp_comp_start(comp);
>>   	}
>>   
>> +	/* Setup the DSC if present, with the config coming from DSI */
>> +	if (comp_dsc && comp_dsi) {
>> +		dsc_cfg = mtk_dsi_get_dsc_config(comp_dsi->dev);
>> +		if (dsc_cfg)
>> +			mtk_ddp_comp_dsc_setup(comp_dsc, dsc_cfg);
>> +	}
>> +
>>   	/* Initially configure all planes */
>>   	for (i = 0; i < mtk_crtc->layer_nr; i++) {
>>   		struct drm_plane *plane = &mtk_crtc->planes[i];
> [...]
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
>> new file mode 100644
>> index 000000000000..090f0609a14c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
> [...]
>> +
>> +#define DISP_REG_DSC_DBG_CON		0x60
>> +#  define DSC_CKSM_CAL_EN		BIT(9)
>> +
>> +#define DISP_REG_DSC_OUTBUF		0x70
>> +#  define DSC_OBUF_SIZE			GENMASK(11, 0)
>> +
>> +#define DISP_REG_DSC_PPS(x)		(0x80 + (x * 4)) /* 0..19 */
> 
> This causes an operator precedence bug when you use
> DISP_REG_DSC_PPS(8 + i) below. Wrap the argument in parentheses:
> 
> #define DISP_REG_DSC_PPS(x)        (0x80 + ((x) * 4)))
> 

Whoops. Yup, that's right.

>> +#  define DSC_P0_UP_LINE_BUF_DEPTH	GENMASK(3, 0)
>> +#  define DSC_P0_BPC			GENMASK(7, 4)
>> +#  define DSC_P0_BPP			GENMASK(17, 8)
>> +#  define DSC_P0_RCT_ON			BIT(18)
>> +#  define DSC_P0_BLOCK_PRED_EN		BIT(19)
> [...]
>> +static void mtk_dsc_pps_setup(struct mtk_dsc *disp_dsc, struct drm_dsc_config *dsc_cfg)
>> +{
>> +	struct drm_dsc_rc_range_parameters *rcrp = dsc_cfg->rc_range_params;
>> +	u16 *rbt = dsc_cfg->rc_buf_thresh;
>> +	u32 data;
>> +	int i, j;
>> +
>> +	/* PPS 0 - Note: Fractional BPP is not supported! */
>> +	data = FIELD_PREP(DSC_P0_UP_LINE_BUF_DEPTH, dsc_cfg->line_buf_depth);
>> +	data |= FIELD_PREP(DSC_P0_BPC, dsc_cfg->bits_per_component);
>> +	data |= FIELD_PREP(DSC_P0_BPP, dsc_cfg->bits_per_pixel);
>> +	data |= DSC_P0_RCT_ON | DSC_P0_BLOCK_PRED_EN;
>> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(0));
>> +
>> +	/* PPS 1 */
>> +	data = FIELD_PREP(DSC_P1_INITIAL_XMIT_DELAY, dsc_cfg->initial_xmit_delay);
>> +	data |= FIELD_PREP(DSC_P1_INITIAL_DEC_DELAY, dsc_cfg->initial_dec_delay);
>> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(1));
>> +
>> +	/* PPS 2 */
>> +	data = FIELD_PREP(DSC_P2_INITIAL_SCALE_VALUE, dsc_cfg->initial_scale_value);
>> +	data |= FIELD_PREP(DSC_P2_SCALE_INCR_INTERVAL, dsc_cfg->scale_increment_interval);
>> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(2));
> 
> Is RC_MODEL_SIZE omitted here on purpose?
> 

Nope, that was not on purpose. Added, but it's on PPS6, not on PPS2.

>> +
>> +	/* PPS 3 */
>> +	data = FIELD_PREP(DSC_P3_SCALE_DECR_INTERVAL, dsc_cfg->scale_decrement_interval);
>> +	data |= FIELD_PREP(DSC_P3_FIRST_LINE_BPG_OFFSET, dsc_cfg->first_line_bpg_offset);
>> +	writel(data, disp_dsc->reg + DISP_REG_DSC_PPS(3));
> [...]
>> +
>> +void mtk_dsc_setup(struct device *dev, struct drm_dsc_config *dsc_cfg)
>> +{
>> +	struct mtk_dsc *disp_dsc = dev_get_drvdata(dev);
>> +	u32 dsc_slice_w, dsc_slice_h, dsc_mode, dsc_cfg_rval, dsc_shadow;
>> +	u32 dsc_dbg_con, dsc_con, dsc_enc_width, dsc_pic_w, dsc_pic_h;
>> +	u32 pic_group_width, pic_height_ext_num, slice_group_width;
>> +	u32 chunk_size, dsc_pad_num, dsc_pre_pad_sz;
>> +	bool dsc_en_bit;
>> +
>> +	pic_height_ext_num = dsc_cfg->pic_height + dsc_cfg->slice_height - 1;
>> +	pic_group_width = (dsc_cfg->slice_width * 4) / 3;
>> +	slice_group_width = (dsc_cfg->slice_width + 2) / 3;
>> +
>> +	if (dsc_cfg->slice_chunk_size)
>> +		chunk_size = dsc_cfg->slice_chunk_size;
>> +	else
>> +		chunk_size = dsc_cfg->slice_width * dsc_cfg->bits_per_pixel / 8 / 16;
>> +
>> +	dsc_enc_width = FIELD_PREP(DSC_ENC_WIDTH_PIC, dsc_cfg->pic_width) |
>> +			FIELD_PREP(DSC_ENC_WIDTH_SLICE, dsc_cfg->slice_width);
>> +
>> +	dsc_pic_w = FIELD_PREP(DSC_PIC_GROUP_WIDTH_M1, pic_group_width - 1);
>> +	dsc_pic_w |= FIELD_PREP(DSC_PIC_WIDTH, dsc_cfg->pic_width);
>> +	dsc_pic_h = FIELD_PREP(DSC_PIC_HEIGHT_EXT_M1, pic_height_ext_num - 1);
>> +	dsc_pic_h |= FIELD_PREP(DSC_PIC_HEIGHT, dsc_cfg->pic_height - 1);
>> +
>> +	dsc_slice_w = FIELD_PREP(DSC_SLICE_GROUP_WIDTH_M1, slice_group_width - 1);
>> +	dsc_slice_w |= FIELD_PREP(DSC_SLICE_WIDTH, dsc_cfg->slice_width);
>> +	dsc_slice_h = FIELD_PREP(DSC_SLICE_WIDTH_MOD3, dsc_cfg->slice_width % 3);
>> +	dsc_slice_h |= FIELD_PREP(DSC_SLICE_NUM_M1,
>> +				  (pic_height_ext_num / dsc_cfg->slice_height) - 1);
>> +	dsc_slice_h |= FIELD_PREP(DSC_SLICE_HEIGHT_M1, dsc_cfg->slice_height - 1);
>> +
>> +	dsc_pad_num = (3 - ((chunk_size * 2) % 3)) % 3;
>> +	dsc_pad_num = FIELD_PREP(DSC_PAD_NUMBER, dsc_pad_num);
>> +
>> +	dsc_pre_pad_sz = FIELD_PREP(DSC_PIC_PREPAD_HEIGHT, dsc_cfg->pic_height);
>> +	dsc_pre_pad_sz |= FIELD_PREP(DSC_PIC_PREPAD_WIDTH, dsc_cfg->pic_width);
>> +
>> +	dsc_mode = FIELD_PREP(DSC_INIT_DELAY_HEIGHT, 4);
>> +	dsc_mode |= FIELD_PREP(DSC_RGB_SWAP, 0);
> 
> This register has a field called SLICE_MODE (bit 0) that should be set
> when there is more than one slice. Since the code above already
> configures the slice count, this should probably be enabled. (Maybe only
> some SoCs require it, but I wasn't able to get it working on MT6858
> without this.)
> 

No idea, but mine worked without (MT8196 Chromebook), and works with SLICE_MODE set
as you say as well, so that's nice.

>> +
>> +	/* Must enable checksum calc in DBG if enabling core checksum in CFG */
>> +	dsc_cfg_rval = DSC_CFG_ICH_EN | DSC_CFG_CRC_EN | DSC_CFG_DSC12_BUGFIX |
>> +		       DSC_CFG_CORE_CHECKSUM;
>> +	dsc_dbg_con = DSC_CKSM_CAL_EN;
>> +
>> +	if (dsc_cfg->bits_per_component == 8)
>> +		dsc_cfg_rval |= FIELD_PREP_CONST(DSC_CFG_FLATNESS_DET_THRES,
>> +						 DSC_CFG_FLATNESS_8BITS);
>> +	else
>> +		dsc_cfg_rval |= FIELD_PREP_CONST(DSC_CFG_FLATNESS_DET_THRES,
>> +						 DSC_CFG_FLATNESS_10BITS);
> [...]
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index f82506e10fd5..97b8a91874f5 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -18,6 +18,8 @@
>>   #include <video/mipi_display.h>
>>   #include <video/videomode.h>
>>   
>> +#include <drm/display/drm_dsc.h>
>> +#include <drm/display/drm_dsc_helper.h>
>>   #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_bridge.h>
>>   #include <drm/drm_bridge_connector.h>
>> @@ -71,11 +73,12 @@
>>   
>>   #define DSI_PSCTRL		0x1c
>>   #define DSI_PS_WC			GENMASK(13, 0)
>> -#define DSI_PS_SEL			GENMASK(17, 16)
>> +#define DSI_PS_SEL			GENMASK(19, 16)
>>   #define PACKED_PS_16BIT_RGB565		0
>>   #define PACKED_PS_18BIT_RGB666		1
>>   #define LOOSELY_PS_24BIT_RGB666		2
>>   #define PACKED_PS_24BIT_RGB888		3
>> +#define COMPRESSED_PS_DSC		5
>>   
>>   #define DSI_VSA_NL		0x20
>>   #define DSI_VBP_NL		0x24
>> @@ -203,6 +206,7 @@ struct mtk_dsi {
>>   	struct drm_bridge bridge;
>>   	struct drm_bridge *next_bridge;
>>   	struct drm_connector *connector;
>> +	struct drm_dsc_config *dsc;
>>   	struct phy *phy;
>>   
>>   	void __iomem *regs;
>> @@ -393,9 +397,35 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>>   	writel(regval, dsi->regs + DSI_TXRX_CTRL);
>>   }
>>   
>> -static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
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
> This assumes that there are exactly two slices. That is often the case,
> but the number of slices may vary depending on the width. I think this
> would be a good place to use dsi->dsc->slice_count.
> 

Definitely. Yes.

>> +
>> +	if (config_vact) {
>> +		writel(FIELD_PREP(VACT_NL, dsi->vm.vactive),
>> +		       dsi->regs + reg_main[DSI_VACT_NL]);
>> +		writel(ps_wc, dsi->regs + reg_main[DSI_HSTX_CKL_WC]);
>> +	}
>> +
>> +	/* Always use DSC Pixel Stream type */
>> +	writel(ps_wc | FIELD_PREP(DSI_PS_SEL, COMPRESSED_PS_DSC),
>> +	       dsi->regs + reg_main[DSI_PSCTRL]);
>> +
>> +	if (data->has_size_ctl)
>> +		writel(FIELD_PREP(DSI_HEIGHT, dsi->vm.vactive) |
>> +		       FIELD_PREP(DSI_WIDTH, (ps_wc + dsi_buf_bpp - 1) / dsi_buf_bpp),
>> +		       dsi->regs + reg_main[DSI_SIZE_CON]);
>> +}
>> +
>> +static void mtk_dsi_ps_control_uncompressed(struct mtk_dsi *dsi, bool config_vact)
>>   {
>> -	u32 dsi_buf_bpp, ps_val, ps_wc, vact_nl;
>> +	u32 dsi_buf_bpp, ps_val, ps_wc, size_val, vact_nl;
>>   
>>   	if (dsi->format == MIPI_DSI_FMT_RGB565)
>>   		dsi_buf_bpp = 2;
>> @@ -430,6 +460,21 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
>>   		writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
>>   	}
>>   	writel(ps_val, dsi->regs + DSI_PSCTRL);
>> +
>> +	if (dsi->driver_data->has_size_ctl) {
>> +		size_val = FIELD_PREP(DSI_HEIGHT, dsi->vm.vactive);
>> +		size_val |= FIELD_PREP(DSI_WIDTH, dsi->vm.hactive);
>> +
>> +		writel(size_val, dsi->regs + DSI_SIZE_CON);
>> +	}
>> +}
>> +
>> +static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
>> +{
>> +	if (dsi->dsc)
>> +		mtk_dsi_ps_control_dsc(dsi, config_vact);
>> +	else
>> +		mtk_dsi_ps_control_uncompressed(dsi, config_vact);
>>   }
>>   
>>   static void mtk_dsi_config_vdo_timing_per_frame_lp(struct mtk_dsi *dsi)
>> @@ -565,26 +610,68 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
>>   	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
>>   }
>>   
>> -static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>> +static int mtk_dsi_set_dsc_params(struct mtk_dsi *dsi)
>> +{
>> +	struct drm_dsc_config *dsc = dsi->dsc;
>> +	struct device *dev = dsi->host.dev;
>> +	int ret;
>> +
>> +	if (dsc->bits_per_pixel & GENMASK(3, 0)) {
>> +		dev_err(dev, "Fractional bits_per_pixel not supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (dsc->bits_per_component != 8) {
>> +		dev_err(dev, "%u bits per component is not supported\n",
>> +			dsc->bits_per_component);
>> +		return -EINVAL;
>> +	}
> 
> Any reason why this wouldn't support 10bpc? The rest of the code seems
> to handle it fine.
> 

I have no way to test it with 10bpc, and downstream limits it to 8...
but if you can test that and make sure that it works, I can remove the
limitation.

>> +
>> +	dsc->simple_422 = false;
>> +	dsc->convert_rgb = true;
>> +	dsc->vbr_enable = false;
>> +
>> +	drm_dsc_set_const_params(dsc);
>> +	drm_dsc_set_rc_buf_thresh(dsc);
>> +
>> +	ret = drm_dsc_setup_rc_params(dsc, DRM_DSC_1_1_PRE_SCR);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot find DSC RC params\n");
>> +		return ret;
>> +	}
> 
> The defaults in MediaTek's downstream driver match DRM_DSC_1_2_444, not
> DRM_DSC_1_1_PRE_SCR, and the panel on my test device requires that even
> though it uses DSC v1.1. This may be a panel-specific problem, but have
> you tested this with any actual panels that need 1_1_PRE_SCR?
> 

My downstream uses 1_1_PRE_SCR... that's why it is like this.

I can resolve it like

	if (dsc->dsc_version_major == 1 && dsc->dsc_version_minor == 1)
		type = DRM_DSC_1_1_PRE_SCR;
	else
		type = DRM_DSC_1_2_444;

	ret = drm_dsc_setup_rc_params(dsc, type);

...that will work, granted that the panel declares the correct DSC version.

>> +
>> +	dsc->initial_scale_value = drm_dsc_initial_scale_value(dsc);
>> +	dsc->line_buf_depth = dsc->bits_per_component + 1;
>> +
>> +	return drm_dsc_compute_rc_parameters(dsc);
>> +}
>> +
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
>> +	} else {
>> +		mtk_dsi_ps_control(dsi, false);
>> +	}
> 
> I don't quite understand what is going on here, even in the original
> driver before this patch. What is the point of setting VACT_NL twice?
> Does mtk_dsi_ps_control() really need to be called in mtk_dsi_poweron()
> if mtk_dsi_config_vdo_timing() ends up calling it a second time?

I didn't do much research, but MT8173 and 8192 if I remember correctly won't work
without this sequence. I saw that 2 years ago or something, so I don't remember
all that clearly.

> 
> If the order is not important, perhaps this would be cleaner:
> 
> mtk_dsi_poweron()
>   - mtk_dsi_config_vdo_timing()
>     - set VSA_NL, VBP_NL, VFP_NL, VACT_NL, SIZE_CON
>     - mtk_dsi_set_dsc_params()
>     - mtk_dsi_ps_control_{dsc|uncompressed}()
>     - mtk_dsi_config_vdo_timing_per_{frame|line}_lp()
> 
> One problem is that mtk_dsi_config_vdo_timing_per_frame_lp() currently
> doesn't take DSC into account when computing ps_wc, resulting in wrong
> timings.
> 
> Another problem is that the data rate calculation in mtk_dsi_poweron()
> is also unconditionally using the bits-per-pixel value from the color
> format. To get a correct frame rate with DSC, it would need to do
> something similar to dsi_adjust_pclk_for_compression() in
> drivers/gpu/drm/msm/dsi/dsi_host.c.
> 
> Other than that, the DSC support seems to work well so far. Thank you
> for the useful contribution!
> 

Thank you for your review, that was precious.

I will leave this ps_control part as-is, because of the regression that it would
create with the old SoCs otherwise, and because .. well, it works for both me and
you, so for now it's "good enough".

We can always come back to this in the future with a separate patch, and we should
do just that, otherwise series versions will never come to an end :-)


> Best regards,
> Nikolai
> 
> P.S.: I can try to push my changes and workarounds to a git tree if
> needed.

No need for that, I have already addressed your comments and I'll send a v9
tomorrow in the morning after one last test.

Cheers,
Angelo
