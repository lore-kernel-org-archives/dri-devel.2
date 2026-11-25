Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEA606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=HzeqJfhJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30F710E00F;
	Wed, 25 Nov 2026 08:21:42 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 08:21:34 UTC
Received: from mail-m158219.netease.com (mail-m158219.netease.com
 [47.251.158.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1609910E00F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:21:33 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55f145951;
 Wed, 25 Nov 2026 16:16:26 +0800 (GMT+08:00)
Message-ID: <2b7bc1e2-d881-40fe-be22-544caa1bbc63@rock-chips.com>
Date: Wed, 25 Nov 2026 16:16:20 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/bridge: trilinear: add the DPTX hardware layer
To: Luo Liu <Luo.Liu@cixtech.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
 <20261124120114.3273161-3-Luo.Liu@cixtech.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261124120114.3273161-3-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa211c7077a03a7kunmd89ae1b6dfea52
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUNDVh1CThpLGh0fQhoZSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=HzeqJfhJWLj31pKo7gKMfzBB2s1CnLL2sUWxLsDlrkKIImV2lIvz+RNfOIxIGBL+Zlf9Zx2vklI+oztsobNnD5XjPlsv8NAtHxV0XhwfNdhZCJfjDu9ReqTyJFw9LydzpDl/AEs32oei/8vEANHQXj5y0af1010iFwoWwtaNBFM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=CtgZfboXxz6wBiIi1n5XF0IDOBY8KloGbd+hSVtBnUM=;
 h=date:mime-version:subject:message-id:from;
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

Hi,

On 11/24/2026 8:01 PM, Luo Liu wrote:
> Add the register and PHY programming for the Trilinear DisplayPort
> transmitter: PHY power and reset, host and core enable, AUX transfers
> through the controller's AUX channel, sink capability parsing from the
> DPCD, and link training with rate downshifting when the sink cannot
> lock.
> 
> The transmitter drives up to four lanes at HBR3 and has two SST
> sources. The stream setup programs the main stream attributes, the
> pixel format and the optional VSC SDP per stream. MST is not
> implemented and is left disabled.
> 
> Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
> ---
>  drivers/gpu/drm/bridge/trilinear/dptx_hw.c | 1396 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/trilinear/dptx_hw.h |  109 ++
>  2 files changed, 1505 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_hw.c
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_hw.h
> 
> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_hw.c b/drivers/gpu/drm/bridge/trilinear/dptx_hw.c
> new file mode 100644
> index 000000000000..6f3011ab6541
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_hw.c
> @@ -0,0 +1,1396 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DisplayPort transmitter hardware interface
> + *
> + * Copyright (C) 2026 Trilinear Technologies
> + * Copyright 2026 Cix Technology Group Co., Ltd.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include <drm/display/drm_dp_helper.h>
> +
> +#include "dptx_hw.h"
> +
> +#define DPTX_SDP_DB_MAX 32
> +#define DP_MAX_TRAINING_TRIES 5
> +#define DP_APB_CLK_RATE 200000000UL
> +
> +/* ------------------------------------------------------------------------ */
> +/*  Register offsets */
> +/* ------------------------------------------------------------------------ */
> +/* link configuration */
> +#define DPTX_LINK_BW_SET			0x000ul
> +#define DPTX_LANE_COUNT_SET		0x004ul
> +#define DPTX_ENHANCED_FRAMING_ENABLE	0x008ul
> +#define DPTX_TRAINING_PATTERN_SET	0x00cul
> +#define DPTX_DISABLE_SCRAMBLING		0x014ul
> +#define DPTX_DOWNSPREAD_CONTROL		0x018ul
> +
> +/* core enables */
> +#define DPTX_TRANSMITTER_ENABLE	0x080ul
> +#define DPTX_SOFT_RESET			0x090ul
> +#define DPTX_SOURCE_ENABLE		0x094ul
> +
> +/* misc control */
> +#define DPTX_FORCE_SCRAMBLER_RESET	0x0c0ul
> +
> +/* AUX channel */
> +#define DPTX_AUX_COMMAND			0x100ul
> +#define DPTX_AUX_WRITE_FIFO		0x104ul
> +#define DPTX_AUX_ADDRESS			0x108ul
> +#define DPTX_AUX_CLOCK_DIVIDER	0x10cul
> +#define DPTX_HPD_INPUT_STATE		0x128ul
> +#define DPTX_AUX_REPLY_DATA		0x134ul
> +#define DPTX_AUX_REPLY_CODE		0x138ul
> +#define DPTX_INTERRUPT_CAUSE		0x140ul
> +#define DPTX_INTERRUPT_MASK		0x144ul
> +#define DPTX_AUX_REPLY_DATA_COUNT	0x148ul
> +#define DPTX_AUX_STATUS			0x14cul
> +
> +/* PHY status */
> +#define DPTX_PHY_STATUS			0x280ul
> +
> +/* MST / SST control */
> +#define DPTX_MST_ENABLE			0x500ul
> +#define DPTX_SST_SOURCE_SELECT		0x50cul
> +
> +/* main stream control, virtual source 0 (bases for per-stream helpers) */
> +#define DPTX_SRC0_VIDEO_STREAM_ENABLE	0x800ul
> +#define DPTX_SRC0_SECONDARY_STREAM_ENABLE	0x804ul
> +#define DPTX_SRC0_SECONDARY_DATA_WINDOW	0x808ul
> +#define DPTX_SRC0_DATA_CONTROL		0x810ul
> +#define DPTX_SRC0_MAIN_STREAM_OVERRIDE	0x814ul
> +#define DPTX_SRC0_MAIN_STREAM_HTOTAL	0x820ul
> +#define DPTX_SRC0_MAIN_STREAM_VTOTAL	0x824ul
> +#define DPTX_SRC0_MAIN_STREAM_POLARITY	0x828ul
> +#define DPTX_SRC0_MAIN_STREAM_HSWIDTH	0x82cul
> +#define DPTX_SRC0_MAIN_STREAM_VSWIDTH	0x830ul
> +#define DPTX_SRC0_MAIN_STREAM_HRES	0x834ul
> +#define DPTX_SRC0_MAIN_STREAM_VRES	0x838ul
> +#define DPTX_SRC0_MAIN_STREAM_HSTART	0x83cul
> +#define DPTX_SRC0_MAIN_STREAM_VSTART	0x840ul
> +#define DPTX_SRC0_MAIN_STREAM_MISC0	0x844ul
> +#define DPTX_SRC0_MAIN_STREAM_MISC1	0x848ul
> +#define DPTX_SRC0_TU_CONFIG		0x850ul
> +#define DPTX_SRC0_USER_PIXEL_COUNT	0x858ul
> +#define DPTX_SRC0_USER_DATA_COUNT	0x85cul
> +#define DPTX_SRC0_USER_SYNC_POLARITY	0x864ul
> +
> +/* secondary channel, source 0 */
> +#define DPTX_SEC0_INFOFRAME_ENABLE	0x910ul
> +#define DPTX_SEC0_INFOFRAME_RATE		0x914ul
> +#define DPTX_SEC0_INFOFRAME_SELECT	0x934ul
> +#define DPTX_SEC0_INFOFRAME_DATA		0x938ul
> +
> +/* spacing between consecutive virtual source register blocks */
> +#define DPTX_SOURCE_OFFSET		0x200ul
> +
> +/* per-stream helpers, indexed by source/stream id */
> +#define DPTX_INFOFRAME_ENABLE(stream_id) \
> +	(DPTX_SEC0_INFOFRAME_ENABLE + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_INFOFRAME_SELECT(stream_id) \
> +	(DPTX_SEC0_INFOFRAME_SELECT + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_INFOFRAME_RATE(stream_id) \
> +	(DPTX_SEC0_INFOFRAME_RATE + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_INFOFRAME_DATA(stream_id) \
> +	(DPTX_SEC0_INFOFRAME_DATA + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_VIDEO_STREAM_ENABLE(stream_id) \
> +	(DPTX_SRC0_VIDEO_STREAM_ENABLE + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_SECONDARY_STREAM_ENABLE(stream_id) \
> +	(DPTX_SRC0_SECONDARY_STREAM_ENABLE + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_MISC0(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_MISC0 + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_MISC1(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_MISC1 + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_OVERRIDE(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_OVERRIDE + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_HTOTAL(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_HTOTAL + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_VTOTAL(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_VTOTAL + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_POLARITY(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_POLARITY + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_HSWIDTH(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_HSWIDTH + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_VSWIDTH(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_VSWIDTH + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_HRES(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_HRES + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_VRES(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_VRES + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_HSTART(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_HSTART + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_MAIN_STREAM_VSTART(stream_id) \
> +	(DPTX_SRC0_MAIN_STREAM_VSTART + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_TU_CONFIG(stream_id) \
> +	(DPTX_SRC0_TU_CONFIG + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_USER_DATA_COUNT(stream_id) \
> +	(DPTX_SRC0_USER_DATA_COUNT + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_SECONDARY_DATA_WINDOW(stream_id) \
> +	(DPTX_SRC0_SECONDARY_DATA_WINDOW + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_DATA_CONTROL(stream_id) \
> +	(DPTX_SRC0_DATA_CONTROL + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_USER_PIXEL_COUNT(stream_id) \
> +	(DPTX_SRC0_USER_PIXEL_COUNT + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +#define DPTX_USER_SYNC_POLARITY(stream_id) \
> +	(DPTX_SRC0_USER_SYNC_POLARITY + \
> +	 DPTX_SOURCE_OFFSET * (stream_id))
> +
> +/* ------------------------------------------------------------------------ */
> +/*  Register DPTX_MAIN_STREAM_MISC0 bits */
> +/* ------------------------------------------------------------------------ */
> +#define DPTX_STREAM_MISC0_COMP_FORMAT_RGB (0 << 1)
> +#define DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_422 (5 << 1)
> +#define DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_444 (6 << 1)
> +#define DPTX_STREAM_MISC0_BPC_6 (0 << 5)
> +#define DPTX_STREAM_MISC0_BPC_8 BIT(5)
> +#define DPTX_STREAM_MISC0_BPC_10 (2 << 5)
> +#define DPTX_STREAM_MISC0_BPC_12 (3 << 5)
> +#define DPTX_STREAM_MISC0_BPC_16 (4 << 5)
> +
> +/* ------------------------------------------------------------------------ */
> +/*  Register DPTX_MAIN_STREAM_MISC1 bits */
> +/* ------------------------------------------------------------------------ */
> +#define DPTX_STREAM_MISC1_Y_ONLY_EN BIT(7)
> +
> +/* ------------------------------------------------------------------------ */
> +/*  Register DPTX_MAIN_STREAM_OVERRIDE bits */
> +/* ------------------------------------------------------------------------ */
> +#define DPTX_VSC_COLORIMETRY_EN BIT(6)
> +#define DPTX_STREAM_OVERRIDE_ENABLE BIT(6)
> +/*
> + * Pixel format in bits [5:3]. 0 is RGB. 4:2:2 and 4:4:4 use the same
> + * component-format codes as MISC0 bits [2:1]. 4:2:0 cannot be carried
> + * in MISC0, so it has its own value.
> + */
> +#define DPTX_STREAM_OVERRIDE_YCbCR_422 BIT(3)
> +#define DPTX_STREAM_OVERRIDE_YCbCR_444 (2 << 3)
> +#define DPTX_STREAM_OVERRIDE_YCbCR_420 (4 << 3)
> +#define DPTX_STREAM_OVERRIDE_BPC_6 (0)
> +#define DPTX_STREAM_OVERRIDE_BPC_8 (1)
> +#define DPTX_STREAM_OVERRIDE_BPC_10 (2)
> +#define DPTX_STREAM_OVERRIDE_BPC_12 (3)
> +#define DPTX_STREAM_OVERRIDE_BPC_16 (4)
> +
> +/* ------------------------------------------------------------------------ */
> +/*  Register DPTX_AUX_COMMAND bits */
> +/* ------------------------------------------------------------------------ */
> +#define DPTX_AUX_COMMAND_CMD_SHIFT 8
> +#define DPTX_AUX_COMMAND_ADDRESS_ONLY BIT(12)
> +#define DPTX_AUX_COMMAND_BYTES_SHIFT 0
> +#define DPTX_AUX_STATUS_REPLY_ERROR BIT(3)
> +#define DPTX_AUX_STATUS_REQUEST_IN_PROGRESS BIT(2)
> +#define DPTX_AUX_STATUS_REPLY_IN_PROGRESS BIT(1)
> +#define DPTX_AUX_STATUS_REPLY_RECEIVED BIT(0)
> +
> +#define DPTX_AUX_READ BIT(0)
> +
> +#define DPTX_AUX_REPLY_CODE_AUX_ACK 0
> +#define DPTX_AUX_REPLY_CODE_I2C_ACK 0
> +
> +/* ------------------------------------------------------------------------ */
> +/*  Register DPTX_REPLY_DATA_COUNT bits */
> +/* ------------------------------------------------------------------------ */
> +#define DPTX_REPLY_DATA_COUNT_MASK 0xff
> +
> +#define DPTX_MSA_TRANSFER_UNIT_SIZE_TU_SIZE_DEF 64
> +#define DPTX_MAIN_STREAM_POLARITY_HSYNC_SHIFT 0
> +#define DPTX_MAIN_STREAM_POLARITY_VSYNC_SHIFT 1
> +#define DPTX_MAIN_STREAM_POLARITY_DATAENABLE_HIGH 0xc
> +
> +#define DPTX_DATA_CONTROL_DEFAULT		(BIT(13) | BIT(2))
> +#define DPTX_DATA_CONTROL_2PPC_4LANE_HBR3	BIT(2)
> +
> +#define DPTX_INTERRUPT_GP_TIMER_IRQ BIT(4)
> +#define DPTX_INTERRUPT_REPLY_TIMEOUT BIT(3)
> +#define DPTX_INTERRUPT_REPLY_RECEIVED BIT(2)
> +#define DPTX_INTERRUPT_HPD_IRQ BIT(1)
> +#define DPTX_INTERRUPT_HPD_EVENT BIT(0)
> +
> +#define DPTX_INTERRUPT_MASK_ALL 0x3f
> +#define DPTX_INTERRUPT_CFG 0x1c
> +
> +static const char * const stream_clk_names[] = {
> +	"vid0", "vid1",
> +};
> +
> +static u32 dptx_hw_read(struct dp_hw *hw, int offset)
> +{
> +	return readl(hw->base + offset);
> +}
> +
> +static void dptx_hw_write(struct dp_hw *hw, int offset, u32 val)
> +{
> +	writel(val, hw->base + offset);
> +}
> +
> +static bool dptx_hw_hpd_state(struct dp_hw *hw)
> +{
> +	return dptx_hw_read(hw, DPTX_HPD_INPUT_STATE) & BIT(0);
> +}
> +
> +static bool dptx_hw_sink_present(struct dp_hw *hw)
> +{
> +	u8 dpcd_rev;
> +
> +	return drm_dp_dpcd_readb(&hw->aux, DP_DPCD_REV, &dpcd_rev) >= 0;
> +}
> +
> +static int dptx_hw_phy_reset(struct dp_hw *hw)
> +{
> +	return phy_reset(hw->phy);
> +}
> +
> +static int dptx_hw_phy_init(struct dp_hw *hw)
> +{
> +	return phy_init(hw->phy);
> +}
> +
> +static void dptx_hw_phy_exit(struct dp_hw *hw)
> +{
> +	phy_exit(hw->phy);
> +}
> +
> +static int dptx_hw_phy_power(struct dp_hw *hw, bool enable)
> +{
> +	if (enable)
> +		return phy_power_on(hw->phy);
> +
> +	phy_power_off(hw->phy);
> +	return 0;
> +}

Is it necessary to provide these PHY-related callback functions?
There seem nothing to do with the controller.

> +
> +static int dptx_hw_phy_vs_emph_set(struct dp_hw *hw, u8 lane_cnt,
> +				   const u8 *train_set)
> +{
> +	union phy_configure_opts opts = { 0 };
> +	u8 train;
> +	int i;
> +
> +	opts.dp.lanes = lane_cnt;
> +	for (i = 0; i < lane_cnt; i++) {
> +		train = train_set[i];
> +		opts.dp.voltage[i] = (train & DP_TRAIN_VOLTAGE_SWING_MASK) >>
> +				     DP_TRAIN_VOLTAGE_SWING_SHIFT;
> +		opts.dp.pre[i] = (train & DP_TRAIN_PRE_EMPHASIS_MASK) >>
> +				 DP_TRAIN_PRE_EMPHASIS_SHIFT;
> +	}
> +
> +	opts.dp.set_voltages = 1;
> +	return phy_configure(hw->phy, &opts);
> +}
> +
> +static enum phy_mode dptx_hw_phy_mode(struct dp_hw *hw)
> +{
> +	return phy_get_mode(hw->phy);
> +}
> +
> +static void dptx_hw_aux_clock_divider(struct dp_hw *hw)
> +{
> +	unsigned int rate;
> +
> +	rate = clk_get_rate(hw->apb_clk) / (1000 * 1000);
> +	if (!rate)
> +		rate = 25;
> +
> +	dptx_hw_write(hw, DPTX_AUX_CLOCK_DIVIDER, rate);
> +}
> +
> +static int dptx_hw_apb_clock(struct dp_hw *hw, bool enable)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(hw->apb_clk))
> +		return 0;
> +
> +	if (!enable) {
> +		clk_disable_unprepare(hw->apb_clk);
> +		return 0;
> +	}
> +
> +	if (!clk_get_rate(hw->apb_clk)) {
> +		ret = clk_set_rate(hw->apb_clk, DP_APB_CLK_RATE);
> +		if (ret) {
> +			dev_err(hw->dev, "failed to set apb clock rate: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return clk_prepare_enable(hw->apb_clk);
> +}
> +
> +static void dptx_hw_reset(struct dp_hw *hw, bool assert)
> +{
> +	if (assert)
> +		reset_control_assert(hw->reset);
> +	else
> +		reset_control_deassert(hw->reset);
> +}
> +
> +static void dptx_hw_host_enable(struct dp_hw *hw, bool enable)
> +{
> +	if (enable) {
> +		dptx_hw_write(hw, DPTX_TRANSMITTER_ENABLE, 1);
> +		dptx_hw_write(hw, DPTX_INTERRUPT_MASK,
> +			      DPTX_INTERRUPT_CFG);
> +		dptx_hw_aux_clock_divider(hw);
> +		return;
> +	}
> +
> +	dptx_hw_write(hw, DPTX_TRANSMITTER_ENABLE, 0);
> +	dptx_hw_write(hw, DPTX_INTERRUPT_MASK,
> +		      DPTX_INTERRUPT_MASK_ALL);
> +}
> +
> +static void dptx_hw_core_enable(struct dp_hw *hw, int source_id,
> +				bool enable)
> +{
> +	u32 sources = BIT(source_id);
> +	u32 value;
> +
> +	if (enable) {
> +		dptx_hw_write(hw, DPTX_SOFT_RESET, sources);
> +		dptx_hw_write(hw, DPTX_SOURCE_ENABLE, sources);
> +		dptx_hw_write(hw, DPTX_FORCE_SCRAMBLER_RESET, sources);
> +		dptx_hw_write(hw, DPTX_MST_ENABLE, 0);
> +		dptx_hw_write(hw, DPTX_SST_SOURCE_SELECT, source_id);
> +		return;
> +	}
> +
> +	dptx_hw_write(hw, DPTX_MST_ENABLE, 0);
> +
> +	value = dptx_hw_read(hw, DPTX_SOURCE_ENABLE);
> +	dptx_hw_write(hw, DPTX_SOURCE_ENABLE, value & ~sources);
> +
> +	value = dptx_hw_read(hw, DPTX_SOFT_RESET);
> +	dptx_hw_write(hw, DPTX_SOFT_RESET, value & ~sources);
> +
> +	value = dptx_hw_read(hw, DPTX_FORCE_SCRAMBLER_RESET);
> +	dptx_hw_write(hw, DPTX_FORCE_SCRAMBLER_RESET, value & ~sources);
> +}
> +
> +static void dptx_hw_link_setup(struct dp_hw *hw, u8 lane_cnt,
> +			       bool enhanced, bool downspread)
> +{
> +	dptx_hw_write(hw, DPTX_LANE_COUNT_SET, lane_cnt);
> +
> +	if (enhanced)
> +		dptx_hw_write(hw, DPTX_ENHANCED_FRAMING_ENABLE, 1);
> +
> +	dptx_hw_write(hw, DPTX_DOWNSPREAD_CONTROL, downspread);
> +}
> +
> +static int dptx_hw_link_rate(struct dp_hw *hw, u8 bw_code, u8 lanes)
> +{
> +	union phy_configure_opts opts = { 0 };
> +	u32 ready = (1 << lanes) - 1;
> +	u32 value;
> +	int ret;
> +
> +	dptx_hw_write(hw, DPTX_LINK_BW_SET, bw_code);
> +
> +	opts.dp.link_rate = drm_dp_bw_code_to_link_rate(bw_code) / 100;
> +	opts.dp.set_rate = 1;
> +	ret = phy_configure(hw->phy, &opts);
> +	if (ret)
> +		return ret;
> +
> +	return readl_poll_timeout(hw->base + DPTX_PHY_STATUS, value,
> +				  (value & ready) == ready, 1000, 100 * 1000);
> +}
> +
> +static int dptx_hw_link_configure(struct dp_hw *hw, u8 bw_code,
> +				  u8 lane_cnt, bool enhanced,
> +				  u8 num_lanes)
> +{
> +	bool downspread;
> +	int ret;
> +
> +	downspread = hw->dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5;
> +
> +	dptx_hw_link_setup(hw, lane_cnt, enhanced, downspread);
> +
> +	if (enhanced)
> +		lane_cnt |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
> +
> +	drm_dp_dpcd_writeb(&hw->aux, DP_DOWNSPREAD_CTRL,
> +			   downspread ? DP_SPREAD_AMP_0_5 : 0);
> +
> +	ret = drm_dp_dpcd_writeb(&hw->aux, DP_LANE_COUNT_SET, lane_cnt);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = drm_dp_dpcd_writeb(&hw->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
> +				 DP_SET_ANSI_8B10B);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = drm_dp_dpcd_writeb(&hw->aux, DP_LINK_BW_SET, bw_code);
> +	if (ret < 0)
> +		return ret;
> +
> +	return dptx_hw_link_rate(hw, bw_code, num_lanes);
> +}
> +
> +static int dptx_hw_link_set_pattern(struct dp_hw *hw, u32 pattern)
> +{
> +	if (pattern == DP_TRAINING_PATTERN_4) {
> +		dptx_hw_write(hw, DPTX_TRAINING_PATTERN_SET, 0x4);
> +		dptx_hw_write(hw, DPTX_DISABLE_SCRAMBLING, 0);
> +	} else {
> +		dptx_hw_write(hw, DPTX_TRAINING_PATTERN_SET, pattern);
> +		pattern |= DP_LINK_SCRAMBLING_DISABLE;
> +	}
> +
> +	return drm_dp_dpcd_writeb(&hw->aux, DP_TRAINING_PATTERN_SET, pattern);
> +}
> +
> +static int dptx_hw_link_vs_emph(struct dp_hw *hw, u8 lane_cnt)
> +{
> +	int ret;
> +
> +	ret = drm_dp_dpcd_write(&hw->aux, DP_TRAINING_LANE0_SET, hw->train_setting,
> +				lane_cnt);
> +	if (ret < 0)
> +		return ret;
> +
> +	return dptx_hw_phy_vs_emph_set(hw, lane_cnt, hw->train_setting);
> +}
> +
> +static void dptx_hw_link_adjust_train(struct dp_hw *hw, u8 lane_cnt,
> +				      const u8 *link_status)
> +{
> +	u8 voltage;
> +	u8 preemphasis;
> +	int i;
> +
> +	for (i = 0; i < lane_cnt; i++) {
> +		voltage = drm_dp_get_adjust_request_voltage(link_status, i);
> +		preemphasis =
> +			drm_dp_get_adjust_request_pre_emphasis(link_status, i);
> +
> +		if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
> +			voltage |= DP_TRAIN_MAX_SWING_REACHED;
> +
> +		if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
> +			preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
> +
> +		hw->train_setting[i] = voltage | preemphasis;
> +	}
> +}
> +
> +static int dptx_hw_link_clock_recovery(struct dp_hw *hw, u8 lane_cnt)
> +{
> +	u8 link_status[DP_LINK_STATUS_SIZE];
> +	bool train_done = false;
> +	u8 prev = 0;
> +	int tries = 0;
> +	int i;
> +	int ret;
> +
> +	ret = dptx_hw_link_set_pattern(hw, DP_TRAINING_PATTERN_1);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < 512; i++) {
> +		ret = dptx_hw_link_vs_emph(hw, lane_cnt);
> +		if (ret)
> +			return ret;
> +
> +		drm_dp_link_train_clock_recovery_delay(&hw->aux, hw->dpcd);
> +		ret = drm_dp_dpcd_read_link_status(&hw->aux, link_status);
> +		if (ret < 0)
> +			return ret;
> +
> +		train_done = drm_dp_clock_recovery_ok(link_status, lane_cnt);
> +		if (train_done)
> +			break;
> +
> +		if ((hw->train_setting[0] &
> +		     (DP_TRAIN_VOLTAGE_SWING_MASK |
> +		      DP_TRAIN_PRE_EMPHASIS_MASK)) == prev)
> +			tries++;
> +		else
> +			tries = 0;
> +
> +		if (tries == DP_MAX_TRAINING_TRIES)
> +			break;
> +
> +		prev = hw->train_setting[0] &
> +		       (DP_TRAIN_VOLTAGE_SWING_MASK |
> +			DP_TRAIN_PRE_EMPHASIS_MASK);
> +		dptx_hw_link_adjust_train(hw, lane_cnt, link_status);
> +	}
> +
> +	if (train_done)
> +		return 0;
> +
> +	return -EIO;
> +}
> +
> +static int dptx_hw_link_channel_equalization(struct dp_hw *hw,
> +					     u8 lane_cnt, bool tps3,
> +					     bool tps4)
> +{
> +	u8 link_status[DP_LINK_STATUS_SIZE];
> +	bool train_done = false;
> +	u32 pattern;
> +	int i;
> +	int ret;
> +
> +	if (tps4)
> +		pattern = DP_TRAINING_PATTERN_4;
> +	else if (tps3)
> +		pattern = DP_TRAINING_PATTERN_3;
> +	else
> +		pattern = DP_TRAINING_PATTERN_2;
> +
> +	ret = dptx_hw_link_set_pattern(hw, pattern);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < DP_MAX_TRAINING_TRIES; i++) {
> +		ret = dptx_hw_link_vs_emph(hw, lane_cnt);
> +		if (ret)
> +			return ret;
> +
> +		drm_dp_link_train_channel_eq_delay(&hw->aux, hw->dpcd);
> +		ret = drm_dp_dpcd_read_link_status(&hw->aux, link_status);
> +		if (ret < 0)
> +			return ret;
> +
> +		train_done = drm_dp_channel_eq_ok(link_status, lane_cnt);
> +		if (train_done)
> +			break;
> +
> +		dptx_hw_link_adjust_train(hw, lane_cnt, link_status);
> +	}
> +
> +	if (train_done)
> +		return 0;
> +
> +	return -EIO;
> +}
> +
> +static void dptx_hw_link_train_start(struct dp_hw *hw)
> +{
> +	dptx_hw_write(hw, DPTX_DISABLE_SCRAMBLING, 1);
> +	memset(hw->train_setting, 0, sizeof(hw->train_setting));
> +}
> +
> +static void dptx_hw_link_train_end(struct dp_hw *hw)
> +{
> +	drm_dp_dpcd_writeb(&hw->aux, DP_TRAINING_PATTERN_SET, 0);
> +	dptx_hw_write(hw, DPTX_TRAINING_PATTERN_SET, 0);
> +	dptx_hw_write(hw, DPTX_DISABLE_SCRAMBLING, 0);
> +}
> +
> +static int dptx_hw_link_train(struct dp_hw *hw, u8 bw_code,
> +			      u8 lane_cnt, u8 num_lanes)
> +{
> +	int ret;
> +
> +	ret = dptx_hw_link_configure(hw, bw_code, lane_cnt,
> +				     hw->caps.enhanced_framing, num_lanes);
> +	if (ret < 0)
> +		return ret;
> +
> +	dptx_hw_link_train_start(hw);
> +
> +	ret = dptx_hw_link_clock_recovery(hw, lane_cnt);
> +	if (!ret)
> +		ret = dptx_hw_link_channel_equalization(hw, lane_cnt,
> +							hw->caps.tps3_supported,
> +							hw->caps.tps4_supported);
> +
> +	dptx_hw_link_train_end(hw);
> +
> +	return ret;
> +}
> +
> +static int dptx_hw_link_status(struct dp_hw *hw, u8 lane_cnt)
> +{
> +	u8 status[DP_LINK_STATUS_SIZE + 2];
> +	ssize_t ret;
> +
> +	ret = drm_dp_dpcd_read(&hw->aux, DP_SINK_COUNT, status,
> +			       sizeof(status));
> +	if (ret != (ssize_t)sizeof(status))
> +		return ret < 0 ? ret : -EIO;
> +
> +	if (drm_dp_clock_recovery_ok(&status[2], lane_cnt) &&
> +	    drm_dp_channel_eq_ok(&status[2], lane_cnt))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int dptx_hw_aux_submit(struct dp_hw *hw, u32 cmd, u32 addr,
> +			      const u8 *buf, u32 len)
> +{
> +	bool is_read = cmd & DPTX_AUX_READ;

What's going on here when cmd is DP_AUX_I2C_WRITE_STATUS_UPDATE?

> +	u32 value;
> +	int i;
> +	int ret;
> +
> +	value = dptx_hw_read(hw, DPTX_AUX_STATUS);
> +	if (value & (DPTX_AUX_STATUS_REQUEST_IN_PROGRESS |
> +		     DPTX_AUX_STATUS_REPLY_IN_PROGRESS))
> +		return -EBUSY;
> +
> +	dptx_hw_write(hw, DPTX_AUX_ADDRESS, addr);
> +
> +	if (!is_read)
> +		for (i = 0; i < len; i++)
> +			dptx_hw_write(hw, DPTX_AUX_WRITE_FIFO,
> +				      buf[i]);
> +
> +	value = cmd << DPTX_AUX_COMMAND_CMD_SHIFT;
> +	if (!buf || !len)
> +		value |= DPTX_AUX_COMMAND_ADDRESS_ONLY;
> +	else
> +		value |= (len - 1) << DPTX_AUX_COMMAND_BYTES_SHIFT;
> +
> +	dptx_hw_write(hw, DPTX_AUX_COMMAND, value);
> +
> +	ret = readl_poll_timeout(hw->base + DPTX_AUX_STATUS, value,
> +				 value & (DPTX_AUX_STATUS_REPLY_RECEIVED |
> +					  DPTX_AUX_STATUS_REPLY_ERROR),
> +				 100, 4000);
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	/*
> +	 * REPLY_ERROR is the block's reply timeout. NACK and DEFER come back
> +	 * as a reply with a non-zero reply code, which the caller reads.
> +	 */
> +	if (value & DPTX_AUX_STATUS_REPLY_ERROR)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static void dptx_hw_aux_reply_data(struct dp_hw *hw, u8 *buf, u32 len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		buf[i] = dptx_hw_read(hw, DPTX_AUX_REPLY_DATA);
> +}
> +
> +static int dptx_hw_aux_cmd_submit(struct dp_hw *hw, u32 cmd, u32 addr,
> +				  u8 *buf, u32 bytes, u8 *reply)
> +{
> +	bool is_read = cmd & DPTX_AUX_READ;
> +	u32 reply_code;
> +	int ret;
> +
> +	ret = dptx_hw_aux_submit(hw, cmd, addr, buf, bytes);
> +	if (ret)
> +		return ret;
> +
> +	reply_code = dptx_hw_read(hw, DPTX_AUX_REPLY_CODE);
> +	if (reply)
> +		*reply = reply_code;
> +
> +	if (is_read &&
> +	    (reply_code == DPTX_AUX_REPLY_CODE_AUX_ACK ||
> +	     reply_code == DPTX_AUX_REPLY_CODE_I2C_ACK)) {
> +		if ((dptx_hw_read(hw, DPTX_AUX_REPLY_DATA_COUNT) &
> +		     DPTX_REPLY_DATA_COUNT_MASK) != bytes)
> +			return -EIO;
> +
> +		dptx_hw_aux_reply_data(hw, buf, bytes);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t dptx_hw_aux_transfer(struct drm_dp_aux *aux,
> +				    struct drm_dp_aux_msg *msg)
> +{
> +	struct dp_hw *hw = container_of(aux, struct dp_hw, aux);
> +	size_t to_access = 0;
> +	size_t accessed_bytes = 0;
> +	u32 reply_mask;
> +	u32 reply_ack;
> +	ssize_t ret;
> +
> +	switch (msg->request) {
> +	case DP_AUX_NATIVE_WRITE:
> +	case DP_AUX_NATIVE_READ:
> +		reply_mask = DP_AUX_NATIVE_REPLY_MASK;
> +		reply_ack = DP_AUX_NATIVE_REPLY_ACK;
> +		break;
> +	default:
> +		reply_mask = DP_AUX_NATIVE_REPLY_MASK | DP_AUX_I2C_REPLY_MASK;
> +		reply_ack = DP_AUX_NATIVE_REPLY_ACK | DP_AUX_I2C_REPLY_ACK;
> +		break;
> +	}
> +
> +	do {
> +		to_access = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES,
> +				  msg->size - accessed_bytes);
> +		ret = dptx_hw_aux_cmd_submit(hw, msg->request,
> +					     msg->address + accessed_bytes,
> +					     msg->buffer + accessed_bytes,
> +					     to_access, &msg->reply);
> +		if (ret) {
> +			if (!accessed_bytes)
> +				return ret;
> +			break;
> +		}
> +
> +		if ((msg->reply & reply_mask) != reply_ack)
> +			break;
> +
> +		accessed_bytes += to_access;
> +	} while (accessed_bytes < msg->size);
> +
> +	return accessed_bytes;
> +}
> +
> +static int dptx_hw_stream_clock_enable(struct dp_hw *hw, int stream_id,
> +				       bool enable)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	if (stream_id < 0 || stream_id >= DP_STREAM_MAX)
> +		return -EINVAL;
> +
> +	clk = hw->stream_clk[stream_id];
> +	if (IS_ERR_OR_NULL(clk))
> +		return -EINVAL;
> +
> +	if (enable) {
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			return ret;
> +	} else {
> +		clk_disable_unprepare(clk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int dptx_hw_stream_clock_rate_set(struct dp_hw *hw, int stream_id,
> +					 unsigned long rate)
> +{
> +	struct clk *clk;
> +
> +	if (stream_id < 0 || stream_id >= DP_STREAM_MAX)
> +		return -EINVAL;
> +
> +	clk = hw->stream_clk[stream_id];
> +	if (IS_ERR_OR_NULL(clk) || clk_get_rate(clk) == rate)
> +		return 0;
> +
> +	return clk_set_rate(clk, rate);
> +}
> +
> +static int dptx_hw_dpcd_power_up(struct dp_hw *hw,
> +				 unsigned int delay_ms)
> +{
> +	u8 value;
> +	int ret;
> +
> +	ret = drm_dp_dpcd_readb(&hw->aux, DP_SET_POWER, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	value = (value & ~DP_SET_POWER_MASK) | DP_SET_POWER_D0;
> +
> +	ret = drm_dp_dpcd_writeb(&hw->aux, DP_SET_POWER, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(delay_ms);
> +
> +	return 0;
> +}
> +
> +static int dptx_hw_dpcd_power_down(struct dp_hw *hw, bool hpd)
> +{
> +	u8 value;
> +	int ret;
> +
> +	if (!hpd)
> +		return 0;
> +
> +	ret = drm_dp_dpcd_readb(&hw->aux, DP_SET_POWER, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	value = (value & ~DP_SET_POWER_MASK) | DP_SET_POWER_D3;
> +
> +	ret = drm_dp_dpcd_writeb(&hw->aux, DP_SET_POWER, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(200, 205);
> +
> +	return 0;
> +}
> +
> +static int dptx_hw_dpcd_sink_caps(struct dp_hw *hw)
> +{
> +	u8 value = 0;
> +	int ret;
> +
> +	memset(&hw->caps, 0, sizeof(hw->caps));
> +
> +	ret = drm_dp_read_dpcd_caps(&hw->aux, hw->dpcd);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_dp_read_downstream_info(&hw->aux, hw->dpcd,
> +					  hw->downstream_ports);
> +	if (ret)
> +		return ret;
> +
> +	hw->caps.enhanced_framing = drm_dp_enhanced_frame_cap(hw->dpcd);
> +	hw->caps.tps3_supported = drm_dp_tps3_supported(hw->dpcd);
> +	hw->caps.tps4_supported = drm_dp_tps4_supported(hw->dpcd);
> +
> +	/*
> +	 * DP_DPRX_FEATURE_ENUMERATION_LIST is DP 1.3+. A NACK here just means
> +	 * an older sink, so degrade to "unsupported" instead of failing.
> +	 */
> +	if (hw->dpcd[DP_DPCD_REV] >= DP_DPCD_REV_13 &&
> +	    drm_dp_dpcd_readb(&hw->aux, DP_DPRX_FEATURE_ENUMERATION_LIST,
> +			      &value) == 1)
> +		hw->caps.vsc_supported =
> +			!!(value & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED);
> +
> +	hw->caps.max_lanes = drm_dp_max_lane_count(hw->dpcd);
> +	hw->caps.max_rate = drm_dp_max_link_rate(hw->dpcd);
> +
> +	return 0;
> +}
> +
> +static bool dptx_hw_vsc_supported(struct dp_hw *hw)
> +{
> +	return hw->caps.vsc_supported;
> +}
> +
> +static void dptx_hw_stream_misc(struct dp_hw *hw, int stream_id,
> +				enum dp_pixelformat format, u8 bpc,
> +				bool vsc)
> +{
> +	u8 override_bpc;
> +	u8 override = 0;
> +	u8 misc1 = 0;
> +	u8 misc0;
> +
> +	switch (format) {
> +	case DP_PIXELFORMAT_YUV444:
> +		misc0 = DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_444;
> +		break;
> +	case DP_PIXELFORMAT_YUV422:
> +		misc0 = DPTX_STREAM_MISC0_COMP_FORMAT_YCRCB_422;
> +		break;
> +	default:
> +		misc0 = DPTX_STREAM_MISC0_COMP_FORMAT_RGB;
> +		break;
> +	}
> +
> +	switch (bpc) {
> +	case 6:
> +		misc0 |= DPTX_STREAM_MISC0_BPC_6;
> +		override_bpc = DPTX_STREAM_OVERRIDE_BPC_6;
> +		break;
> +	case 10:
> +		misc0 |= DPTX_STREAM_MISC0_BPC_10;
> +		override_bpc = DPTX_STREAM_OVERRIDE_BPC_10;
> +		break;
> +	case 12:
> +		misc0 |= DPTX_STREAM_MISC0_BPC_12;
> +		override_bpc = DPTX_STREAM_OVERRIDE_BPC_12;
> +		break;
> +	case 16:
> +		misc0 |= DPTX_STREAM_MISC0_BPC_16;
> +		override_bpc = DPTX_STREAM_OVERRIDE_BPC_16;
> +		break;
> +	default:
> +		misc0 |= DPTX_STREAM_MISC0_BPC_8;
> +		override_bpc = DPTX_STREAM_OVERRIDE_BPC_8;
> +		break;
> +	}
> +
> +	if (!vsc && format == DP_PIXELFORMAT_Y_ONLY)
> +		misc1 |= DPTX_STREAM_MISC1_Y_ONLY_EN;
> +
> +	if (vsc) {
> +		misc1 |= DPTX_VSC_COLORIMETRY_EN;
> +		override = override_bpc | DPTX_STREAM_OVERRIDE_ENABLE;
> +
> +		switch (format) {
> +		case DP_PIXELFORMAT_YUV444:
> +			override |= DPTX_STREAM_OVERRIDE_YCbCR_444;
> +			break;
> +		case DP_PIXELFORMAT_YUV422:
> +			override |= DPTX_STREAM_OVERRIDE_YCbCR_422;
> +			break;
> +		case DP_PIXELFORMAT_YUV420:
> +			override |= DPTX_STREAM_OVERRIDE_YCbCR_420;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_MISC0(stream_id), misc0);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_MISC1(stream_id), misc1);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_OVERRIDE(stream_id),
> +		      override);
> +}
> +
> +static void dptx_hw_stream_tu(struct dp_hw *hw, int stream_id,
> +			      u32 video_kbytes, u32 link_rate,
> +			      u8 lane_cnt)
> +{
> +	u32 bytes_per_tu_scaled;
> +	u32 symbols_per_tu;
> +	u32 frac_symbols_per_tu;
> +	u32 tu;
> +
> +	/*
> +	 * Scaled by 1000 (fixed point) so the fraction below can be split
> +	 * into integer symbols + 1/16 fractional symbols without floating
> +	 * point.
> +	 */
> +	bytes_per_tu_scaled = video_kbytes *
> +			      DPTX_MSA_TRANSFER_UNIT_SIZE_TU_SIZE_DEF /
> +			      (lane_cnt * link_rate / 1000);
> +
> +	symbols_per_tu = (bytes_per_tu_scaled / 1000) & 0xff;
> +
> +	/*
> +	 * Fractional number of valid symbols per TU in units of 1/16th. An
> +	 * accumulator is used to increase the number of data per transaction
> +	 * unit by 1 every 1/N TUs.
> +	 */
> +	frac_symbols_per_tu = ((bytes_per_tu_scaled % 1000) * 16 / 1000) & 0x0f;
> +
> +	tu = DPTX_MSA_TRANSFER_UNIT_SIZE_TU_SIZE_DEF;
> +	tu |= FIELD_PREP(GENMASK(23, 16), symbols_per_tu);
> +	tu |= FIELD_PREP(GENMASK(27, 24), frac_symbols_per_tu);
> +
> +	dptx_hw_write(hw, DPTX_TU_CONFIG(stream_id), tu);
> +}
> +
> +static void dptx_hw_stream_timing_set(struct dp_hw *hw, int stream_id,
> +				      const struct drm_display_mode *mode,
> +				      u8 bpp, u8 lane_cnt, u32 link_rate,
> +				      u32 pixel_per_cycle)
> +{
> +	u32 data_control = DPTX_DATA_CONTROL_DEFAULT;
> +	u32 polarity;
> +	u32 user_data_count;
> +
> +	if (pixel_per_cycle == 2 && lane_cnt == 4 &&
> +	    link_rate == drm_dp_bw_code_to_link_rate(DP_LINK_BW_8_1))
> +		data_control = DPTX_DATA_CONTROL_2PPC_4LANE_HBR3;
> +
> +	polarity = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ?
> +		    BIT(DPTX_MAIN_STREAM_POLARITY_VSYNC_SHIFT) : 0) |
> +		   ((mode->flags & DRM_MODE_FLAG_PHSYNC) ?
> +		    BIT(DPTX_MAIN_STREAM_POLARITY_HSYNC_SHIFT) : 0);
> +
> +	user_data_count = ((mode->hdisplay * bpp + 7) / 8 + lane_cnt - 1) /
> +			  lane_cnt;
> +
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_HTOTAL(stream_id),
> +		      mode->htotal);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_VTOTAL(stream_id),
> +		      mode->vtotal);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_POLARITY(stream_id),
> +		      polarity);
> +	dptx_hw_write(hw, DPTX_USER_SYNC_POLARITY(stream_id),
> +		      DPTX_MAIN_STREAM_POLARITY_DATAENABLE_HIGH |
> +		      polarity);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_HSWIDTH(stream_id),
> +		      mode->hsync_end - mode->hsync_start);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_VSWIDTH(stream_id),
> +		      mode->vsync_end - mode->vsync_start);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_HRES(stream_id),
> +		      mode->hdisplay);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_VRES(stream_id),
> +		      mode->vdisplay);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_HSTART(stream_id),
> +		      mode->htotal - mode->hsync_start);
> +	dptx_hw_write(hw, DPTX_MAIN_STREAM_VSTART(stream_id),
> +		      mode->vtotal - mode->vsync_start);
> +	dptx_hw_write(hw, DPTX_USER_DATA_COUNT(stream_id),
> +		      user_data_count);
> +	dptx_hw_write(hw, DPTX_SECONDARY_DATA_WINDOW(stream_id),
> +		      (mode->htotal - mode->hdisplay) * (link_rate / 40) *
> +		      9 / mode->clock);
> +	dptx_hw_write(hw, DPTX_DATA_CONTROL(stream_id), data_control);
> +	dptx_hw_write(hw, DPTX_USER_PIXEL_COUNT(stream_id),
> +		      pixel_per_cycle);
> +}
> +
> +static void dptx_hw_stream_timing(struct dp_hw *hw, int stream_id,
> +				  const struct drm_display_mode *mode,
> +				  u8 bpp, u8 lane_cnt, u32 link_rate,
> +				  u32 pixel_per_cycle)
> +{
> +	dptx_hw_stream_tu(hw, stream_id, mode->clock * bpp / 8, link_rate,
> +			  lane_cnt);
> +	dptx_hw_stream_timing_set(hw, stream_id, mode, bpp, lane_cnt,
> +				  link_rate, pixel_per_cycle);
> +}
> +
> +static void dptx_hw_stream_enable(struct dp_hw *hw, int stream_id,
> +				  bool enable)
> +{
> +	if (enable) {
> +		dptx_hw_write(hw, DPTX_VIDEO_STREAM_ENABLE(stream_id), 1);
> +		dptx_hw_write(hw, DPTX_SECONDARY_STREAM_ENABLE(stream_id), 1);
> +		return;
> +	}
> +
> +	dptx_hw_write(hw, DPTX_INFOFRAME_ENABLE(stream_id), 0);
> +	dptx_hw_write(hw, DPTX_INFOFRAME_SELECT(stream_id), 0);
> +	dptx_hw_write(hw, DPTX_INFOFRAME_RATE(stream_id), 0);
> +	dptx_hw_write(hw, DPTX_SECONDARY_STREAM_ENABLE(stream_id), 0);
> +	dptx_hw_write(hw, DPTX_VIDEO_STREAM_ENABLE(stream_id), 0);
> +}
> +
> +static void dptx_hw_stream_infoframe_write(struct dp_hw *hw,
> +					   int stream_id, u32 select,
> +					   const struct dp_sdp *sdp,
> +					   bool repeat)
> +{
> +	u32 value;
> +	int i;
> +
> +	if (stream_id < 0 || stream_id >= DPTX_MST_SOURCE_NUMBER ||
> +	    select >= DPTX_MAX_SDP)
> +		return;
> +
> +	value = dptx_hw_read(hw, DPTX_INFOFRAME_ENABLE(stream_id));
> +	dptx_hw_write(hw, DPTX_INFOFRAME_ENABLE(stream_id),
> +		      value & ~BIT(select));
> +	dptx_hw_write(hw, DPTX_INFOFRAME_SELECT(stream_id), select);
> +
> +	dptx_hw_write(hw, DPTX_INFOFRAME_DATA(stream_id),
> +		      sdp->sdp_header.HB0);
> +	dptx_hw_write(hw, DPTX_INFOFRAME_DATA(stream_id),
> +		      sdp->sdp_header.HB1);
> +	dptx_hw_write(hw, DPTX_INFOFRAME_DATA(stream_id),
> +		      sdp->sdp_header.HB2);
> +	dptx_hw_write(hw, DPTX_INFOFRAME_DATA(stream_id),
> +		      sdp->sdp_header.HB3);
> +
> +	for (i = 0; i < DPTX_SDP_DB_MAX; i++)
> +		dptx_hw_write(hw, DPTX_INFOFRAME_DATA(stream_id),
> +			      sdp->db[i]);
> +
> +	value = dptx_hw_read(hw, DPTX_INFOFRAME_RATE(stream_id));
> +	if (repeat)
> +		value |= BIT(select);
> +	else
> +		value &= ~BIT(select);
> +	dptx_hw_write(hw, DPTX_INFOFRAME_RATE(stream_id), value);
> +
> +	value = dptx_hw_read(hw, DPTX_INFOFRAME_ENABLE(stream_id));
> +	dptx_hw_write(hw, DPTX_INFOFRAME_ENABLE(stream_id),
> +		      value | BIT(select));
> +}
> +
> +static bool dptx_hw_needs_vsc_sdp(enum dp_pixelformat format,
> +				  u32 colorspace)
> +{
> +	if (format == DP_PIXELFORMAT_YUV420)
> +		return true;
> +
> +	switch (colorspace) {
> +	case DRM_MODE_COLORIMETRY_SYCC_601:
> +	case DRM_MODE_COLORIMETRY_OPYCC_601:
> +	case DRM_MODE_COLORIMETRY_BT2020_YCC:
> +	case DRM_MODE_COLORIMETRY_BT2020_RGB:
> +	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static enum dp_colorimetry
> +dptx_hw_vsc_colorimetry(enum dp_pixelformat format, u32 colorspace)
> +{
> +	switch (colorspace) {
> +	case DRM_MODE_COLORIMETRY_BT709_YCC:
> +		return DP_COLORIMETRY_BT709_YCC;
> +	case DRM_MODE_COLORIMETRY_XVYCC_601:
> +		return DP_COLORIMETRY_XVYCC_601;
> +	case DRM_MODE_COLORIMETRY_XVYCC_709:
> +		return DP_COLORIMETRY_XVYCC_709;
> +	case DRM_MODE_COLORIMETRY_SYCC_601:
> +		return DP_COLORIMETRY_SYCC_601;
> +	case DRM_MODE_COLORIMETRY_OPYCC_601:
> +		return DP_COLORIMETRY_OPYCC_601;
> +	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
> +		return DP_COLORIMETRY_BT2020_CYCC;
> +	case DRM_MODE_COLORIMETRY_BT2020_RGB:
> +		return DP_COLORIMETRY_BT2020_RGB;
> +	case DRM_MODE_COLORIMETRY_BT2020_YCC:
> +		return DP_COLORIMETRY_BT2020_YCC;
> +	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
> +	case DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
> +		return DP_COLORIMETRY_DCI_P3_RGB;
> +	default:
> +		break;
> +	}
> +
> +	/* Unspecified RGB is sRGB. Unspecified YCbCr is BT.709. */
> +	if (format == DP_PIXELFORMAT_RGB)
> +		return DP_COLORIMETRY_DEFAULT;
> +
> +	return DP_COLORIMETRY_BT709_YCC;
> +}
> +
> +static int dptx_hw_stream_format_set(struct dp_hw *hw, int stream_id,
> +				     enum dp_pixelformat format, u32 colorspace,
> +				     u8 bpc, u8 content_type)
> +{
> +	struct drm_dp_vsc_sdp vsc = {};
> +	struct dp_sdp sdp;
> +	bool enable;
> +	ssize_t len;
> +
> +	enable = hw->caps.vsc_supported &&
> +		 dptx_hw_needs_vsc_sdp(format, colorspace);
> +
> +	if (enable) {
> +		vsc.sdp_type = DP_SDP_VSC;
> +		vsc.revision = 0x5;
> +		vsc.length = 0x13;
> +		vsc.pixelformat = format;
> +		vsc.colorimetry = dptx_hw_vsc_colorimetry(format, colorspace);
> +
> +		switch (bpc) {
> +		case 6:
> +		case 8:
> +		case 10:
> +		case 12:
> +		case 16:
> +			vsc.bpc = bpc;
> +			break;
> +		default:
> +			vsc.bpc = 8;
> +			break;
> +		}
> +
> +		vsc.dynamic_range = DP_DYNAMIC_RANGE_CTA;
> +		vsc.content_type = content_type;
> +
> +		len = drm_dp_vsc_sdp_pack(&vsc, &sdp);
> +		if (len < 0)
> +			return len;
> +	}
> +
> +	dptx_hw_stream_misc(hw, stream_id, format, bpc, enable);
> +
> +	if (enable)
> +		dptx_hw_stream_infoframe_write(hw, stream_id, DPTX_VSC_SDP,
> +					       &sdp, true);
> +	return 0;
> +}
> +
> +static irqreturn_t dptx_hw_irq(struct dp_hw *hw)
> +{
> +	u32 value;
> +	u32 mask;
> +
> +	value = dptx_hw_read(hw, DPTX_INTERRUPT_CAUSE);
> +	mask = dptx_hw_read(hw, DPTX_INTERRUPT_MASK);
> +	if (!(value & ~mask))
> +		return IRQ_NONE;
> +

Don't we need to clear the interrupt register, or is it read to clear? 

> +	if (value & DPTX_INTERRUPT_GP_TIMER_IRQ)
> +		dev_dbg_ratelimited(hw->dev, "gp tmr\n");
> +
> +	if (value & DPTX_INTERRUPT_REPLY_TIMEOUT)
> +		dev_dbg_ratelimited(hw->dev, "reply timeout\n");
> +

Use dev_err_ratelimited() for reply timeout?

> +	if (value & DPTX_INTERRUPT_REPLY_RECEIVED)
> +		dev_dbg_ratelimited(hw->dev, "reply received\n");
> +
> +	if (value & DPTX_INTERRUPT_HPD_EVENT)
> +		hw->hpd_event_callback(hw->data);
> +
> +	if (value & DPTX_INTERRUPT_HPD_IRQ)
> +		hw->hpd_irq_callback(hw->data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int dptx_hw_aux_register(struct dp_hw *hw,
> +				struct drm_device *drm)
> +{
> +	int ret;
> +
> +	hw->aux.name = devm_kasprintf(hw->dev, GFP_KERNEL, "%s AUX",
> +				      dev_name(hw->dev));
> +	if (!hw->aux.name)
> +		return -ENOMEM;
> +
> +	hw->aux.dev = hw->dev;
> +	hw->aux.drm_dev = drm;
> +	hw->aux.transfer = dptx_hw_aux_transfer;
> +
> +	ret = drm_dp_aux_register(&hw->aux);
> +	if (ret)
> +		return ret;
> +
> +	hw->aux_registered = true;
> +
> +	return 0;
> +}
> +
> +static void dptx_hw_aux_unregister(struct dp_hw *hw)
> +{
> +	if (!hw->aux_registered)
> +		return;
> +
> +	drm_dp_aux_unregister(&hw->aux);
> +	hw->aux.drm_dev = NULL;
> +	hw->aux_registered = false;
> +}
> +
> +static const struct dptx_hw_ops dptx_hw_ops = {
> +	.hpd_state			= dptx_hw_hpd_state,
> +	.sink_present			= dptx_hw_sink_present,
> +
> +	.phy_reset			= dptx_hw_phy_reset,
> +	.phy_init			= dptx_hw_phy_init,
> +	.phy_exit			= dptx_hw_phy_exit,
> +	.phy_power			= dptx_hw_phy_power,
> +	.phy_mode			= dptx_hw_phy_mode,
> +
> +	.host_enable			= dptx_hw_host_enable,
> +	.core_enable			= dptx_hw_core_enable,
> +
> +	.apb_clock			= dptx_hw_apb_clock,
> +	.reset				= dptx_hw_reset,
> +
> +	.link_train			= dptx_hw_link_train,
> +	.link_status			= dptx_hw_link_status,
> +
> +	.aux_register			= dptx_hw_aux_register,
> +	.aux_unregister			= dptx_hw_aux_unregister,
> +
> +	.dpcd_power_up			= dptx_hw_dpcd_power_up,
> +	.dpcd_power_down		= dptx_hw_dpcd_power_down,
> +	.dpcd_sink_caps			= dptx_hw_dpcd_sink_caps,
> +	.vsc_supported			= dptx_hw_vsc_supported,
> +
> +	.stream_clock_enable		= dptx_hw_stream_clock_enable,
> +	.stream_clock_rate_set		= dptx_hw_stream_clock_rate_set,
> +	.stream_timing			= dptx_hw_stream_timing,
> +	.stream_enable			= dptx_hw_stream_enable,
> +	.stream_format_set		= dptx_hw_stream_format_set,
> +
> +	.irq				= dptx_hw_irq,
> +};
> +
> +static int dptx_hw_parse_dt(struct dp_hw *hw)
> +{
> +	struct platform_device *pdev = to_platform_device(hw->dev);
> +	struct device *dev = hw->dev;
> +	int i;
> +
> +	hw->base = devm_platform_ioremap_resource_byname(pdev, "dp");
> +	if (IS_ERR(hw->base))
> +		return dev_err_probe(dev, PTR_ERR(hw->base),
> +				     "failed to map dp registers\n");
> +
> +	hw->phy = devm_phy_get(dev, NULL);
> +	if (IS_ERR(hw->phy))
> +		return dev_err_probe(dev, PTR_ERR(hw->phy),
> +				     "failed to get dp phy\n");
> +
> +	hw->reset = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(hw->reset))
> +		return dev_err_probe(dev, PTR_ERR(hw->reset),
> +				     "failed to get reset\n");
> +
> +	hw->apb_clk = devm_clk_get(dev, "apb");
> +	if (IS_ERR(hw->apb_clk))
> +		return dev_err_probe(dev, PTR_ERR(hw->apb_clk),
> +				     "failed to get apb clock\n");
> +
> +	for (i = 0; i < DPTX_MST_SOURCE_NUMBER &&
> +	     i < ARRAY_SIZE(stream_clk_names); i++) {
> +		hw->stream_clk[i] = devm_clk_get(dev, stream_clk_names[i]);
> +		if (IS_ERR(hw->stream_clk[i]))
> +			return dev_err_probe(dev, PTR_ERR(hw->stream_clk[i]),
> +					     "failed to get %s\n",
> +					     stream_clk_names[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +struct dp_hw *dptx_hw_init(struct device *dev, void *data,
> +			   void (*hpd_event_callback)(void *data),
> +			   void (*hpd_irq_callback)(void *data))
> +{
> +	struct dp_hw *hw;
> +	int ret;
> +
> +	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
> +	if (!hw)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hw->dev = dev;
> +	hw->data = data;
> +	hw->hpd_event_callback = hpd_event_callback;
> +	hw->hpd_irq_callback = hpd_irq_callback;
> +	hw->ops = &dptx_hw_ops;
> +
> +	ret = dptx_hw_parse_dt(hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return hw;
> +}
> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_hw.h b/drivers/gpu/drm/bridge/trilinear/dptx_hw.h
> new file mode 100644
> index 000000000000..f0e48a9bf60d
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_hw.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * DisplayPort transmitter hardware interface
> + *
> + * Copyright (C) 2026 Trilinear Technologies
> + * Copyright 2026 Cix Technology Group Co., Ltd.
> + */
> +
> +#ifndef DPTX_HW_H
> +#define DPTX_HW_H
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/phy/phy.h>
> +
> +#include <drm/display/drm_dp_helper.h>
> +#include <drm/drm_modes.h>
> +
> +#define DPTX_MST_SOURCE_NUMBER 2
> +#define DP_STREAM_MAX 4
> +#define DPTX_MAX_LANES 4
> +
> +#define DPTX_MAX_SDP 7
> +#define DPTX_VSC_SDP 1
> +
> +struct dptx_hw_ops;
> +struct reset_control;
> +struct drm_device;
> +
> +struct dp_sink_caps {
> +	bool enhanced_framing;
> +	bool tps3_supported;
> +	bool tps4_supported;
> +	bool vsc_supported;
> +	u8 max_lanes;
> +	int max_rate;
> +};
> +
> +struct dp_hw {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct phy *phy;
> +	struct clk *apb_clk;
> +	struct clk *stream_clk[DP_STREAM_MAX];
> +	struct reset_control *reset;
> +	struct drm_dp_aux aux;
> +	bool aux_registered;
> +	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
> +	u8 train_setting[DPTX_MAX_LANES];
> +	struct dp_sink_caps caps;
> +	void (*hpd_event_callback)(void *data);
> +	void (*hpd_irq_callback)(void *data);
> +	const struct dptx_hw_ops *ops;
> +	void *data;
> +};
> +
> +struct dptx_hw_ops {
> +	bool (*hpd_state)(struct dp_hw *hw);
> +	bool (*sink_present)(struct dp_hw *hw);
> +
> +	int (*phy_reset)(struct dp_hw *hw);
> +	int (*phy_init)(struct dp_hw *hw);
> +	void (*phy_exit)(struct dp_hw *hw);
> +	int (*phy_power)(struct dp_hw *hw, bool enable);
> +	enum phy_mode (*phy_mode)(struct dp_hw *hw);
> +
> +	void (*host_enable)(struct dp_hw *hw, bool enable);
> +	void (*reset)(struct dp_hw *hw, bool assert);
> +	void (*core_enable)(struct dp_hw *hw, int source_id, bool enable);
> +
> +	int (*apb_clock)(struct dp_hw *hw, bool enable);
> +
> +	int (*link_train)(struct dp_hw *hw, u8 bw_code, u8 lane_cnt,
> +			  u8 num_lanes);
> +
> +	int (*link_status)(struct dp_hw *hw, u8 lane_cnt);
> +
> +	int (*aux_register)(struct dp_hw *hw, struct drm_device *drm);
> +	void (*aux_unregister)(struct dp_hw *hw);
> +
> +	int (*dpcd_power_up)(struct dp_hw *hw, unsigned int delay_ms);
> +	int (*dpcd_power_down)(struct dp_hw *hw, bool hpd);
> +	int (*dpcd_sink_caps)(struct dp_hw *hw);
> +	bool (*vsc_supported)(struct dp_hw *hw);
> +
> +	int (*stream_clock_enable)(struct dp_hw *hw, int stream_id,
> +				   bool enable);
> +	int (*stream_clock_rate_set)(struct dp_hw *hw, int stream_id,
> +				     unsigned long rate);
> +	void (*stream_timing)(struct dp_hw *hw, int stream_id,
> +			      const struct drm_display_mode *mode, u8 bpp,
> +			      u8 lane_cnt, u32 link_rate,
> +			      u32 pixel_per_cycle);
> +	void (*stream_enable)(struct dp_hw *hw, int stream_id, bool enable);
> +
> +	int (*stream_format_set)(struct dp_hw *hw, int stream_id,
> +				 enum dp_pixelformat format, u32 colorspace,
> +				 u8 bpc, u8 content_type);
> +
> +	irqreturn_t (*irq)(struct dp_hw *hw);
> +};
> +
> +struct dp_hw *dptx_hw_init(struct device *dev, void *data,
> +			   void (*hpd_event_callback)(void *data),
> +			   void (*hpd_irq_callback)(void *data));
> +
> +#endif /* DPTX_HW_H */

-- 
Best, 
Chaoyi
