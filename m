Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEB606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=LM7LBd6W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F8010E081;
	Wed, 25 Nov 2026 07:23:28 +0000 (UTC)
Received: from mail-m16023653164.xmail.ntesmail.com
 (mail-m16023653164.xmail.ntesmail.com [160.236.53.164])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BDE10E081
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:23:21 +0000 (UTC)
Received: from [127.0.0.1] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55eee4540;
 Wed, 25 Nov 2026 15:23:17 +0800 (GMT+08:00)
Message-ID: <41f08b77-968f-4d9f-8e89-9f30e189c5fd@rock-chips.com>
Date: Wed, 25 Nov 2026 15:23:11 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/bridge: trilinear: add the DPTX core and build
 glue
To: Luo Liu <Luo.Liu@cixtech.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
 <20261124120114.3273161-5-Luo.Liu@cixtech.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261124120114.3273161-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa211965ed303a7kunm4348aa0cdeff8b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQkwdGFYfTxhNS0wdTU
 gfThlWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=LM7LBd6WjQH9sXTt4SYyQ/OaT9hXWMAsI5mbN5rRUam4joveKcMIv4HEn8K2+aOSg7ME61WJhxAIhrcP6WCn1YV3SUn+BkuFOTlBSPX4Isr3Blw3AVZlZUR26jvnaulqpppK0zf971uxYifmtxKkSCfkQACbAzCF8meMWf1XCLU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Eoo7xrRp437JTo+FCZAFR+pZezBC6VtP8CVOPbEdIGA=;
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
> Add the probe path, system sleep handling, hotplug workers and the
> stream state machine that tie the hardware layer to the DRM bridge, and
> hook the driver into the DRM bridge Kconfig and Makefile.
> 
> Detection is driven by the controller's HPD interrupt. The USB-C
> transmitters do not route HPD to the controller, so a sink that was
> plugged in before the bridge was attached raises no event; replay that
> plug once the common PHY is in DP mode and the AUX channel answers. The
> native DP port wires HPD and is reported by the interrupt.
> 
> Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig               |    2 +
>  drivers/gpu/drm/bridge/Makefile              |    1 +
>  drivers/gpu/drm/bridge/trilinear/Kconfig     |    9 +
>  drivers/gpu/drm/bridge/trilinear/Makefile    |    4 +
>  drivers/gpu/drm/bridge/trilinear/dptx.h      |  106 ++
>  drivers/gpu/drm/bridge/trilinear/dptx_core.c | 1091 ++++++++++++++++++
>  include/drm/bridge/dptx.h                    |   68 ++
>  7 files changed, 1281 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/Kconfig
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/Makefile
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx.h
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_core.c
>  create mode 100644 include/drm/bridge/dptx.h
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index c7da6b02d7b6..d328d5f84dc7 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -510,4 +510,6 @@ source "drivers/gpu/drm/bridge/imx/Kconfig"
>  
>  source "drivers/gpu/drm/bridge/synopsys/Kconfig"
>  
> +source "drivers/gpu/drm/bridge/trilinear/Kconfig"
> +
>  endmenu
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 15cc821d85b7..9fe6bec55c51 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -53,3 +53,4 @@ obj-y += analogix/
>  obj-y += cadence/
>  obj-y += imx/
>  obj-y += synopsys/
> +obj-y += trilinear/
> diff --git a/drivers/gpu/drm/bridge/trilinear/Kconfig b/drivers/gpu/drm/bridge/trilinear/Kconfig
> new file mode 100644
> index 000000000000..7e2bf1f27035
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config DRM_TRILINEAR_DPTX
> +	tristate
> +	depends on COMMON_CLK && DRM && OF
> +	depends on GENERIC_PHY
> +	select DRM_KMS_HELPER
> +	select DRM_DISPLAY_HELPER
> +	select DRM_DISPLAY_DP_HELPER
> diff --git a/drivers/gpu/drm/bridge/trilinear/Makefile b/drivers/gpu/drm/bridge/trilinear/Makefile
> new file mode 100644
> index 000000000000..415842b8465d
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +trilinear-dptx-y := dptx_core.o dptx_drm.o dptx_hw.o
> +obj-$(CONFIG_DRM_TRILINEAR_DPTX) += trilinear-dptx.o
> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx.h b/drivers/gpu/drm/bridge/trilinear/dptx.h
> new file mode 100644
> index 000000000000..d953f7740648
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * DisplayPort transmitter driver
> + *
> + * Copyright (C) 2026 Trilinear Technologies
> + * Copyright 2026 Cix Technology Group Co., Ltd.
> + */
> +
> +#ifndef DPTX_H
> +#define DPTX_H
> +
> +#include <linux/bits.h>
> +#include <linux/mutex.h>
> +
> +#include <drm/bridge/dptx.h>
> +#include <drm/display/drm_dp_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_connector.h>
> +
> +#include "dptx_hw.h"
> +
> +#define DPTX_MAX_RATE(rate, lanes, bpp) ((rate) * (lanes) * 8 / (bpp))
> +
> +#define bridge_to_dp(_bridge) \
> +	container_of(_bridge, struct dptx_dev, bridge)
> +
> +#define DPTX_MAX_FREQ 600000
> +#define DPTX_MAX_LINK_RATE drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4)
> +#define DP_MAX_TRAINING_LOOP 3
> +
> +enum dptx_state {
> +	DPTX_STATE_DISCONNECTED = 0,
> +	DPTX_STATE_CONFIGURED = BIT(0),
> +	DPTX_STATE_INITIALIZED = BIT(1),
> +	DPTX_STATE_READY = BIT(2),
> +	DPTX_STATE_CONNECTED = BIT(3),
> +	DPTX_STATE_ENABLED = BIT(6),
> +	DPTX_STATE_SUSPENDED = BIT(7),
> +	DPTX_STATE_INIT_TRAIN = BIT(8),
> +};
> +
> +struct dptx_mode {
> +	u8 bw_code;
> +	u8 lane_cnt;
> +	int pclock;
> +	int link_rate;
> +};
> +
> +struct dptx_config {
> +	int bpp;
> +	int bpc;
> +	enum dp_pixelformat format;
> +	u32 colorspace;
> +	u8 content_type;
> +};
> +
> +struct dptx_dev;
> +struct dp_hw;
> +
> +struct dptx_ops {
> +	int (*detect)(struct dptx_dev *dp);
> +	enum drm_connector_status (*detect_status)(struct dptx_dev *dp);
> +	int (*prepare)(struct dptx_dev *dp);
> +	int (*unprepare)(struct dptx_dev *dp);
> +	void (*lock)(struct dptx_dev *dp);
> +	void (*unlock)(struct dptx_dev *dp);
> +	int (*encoder_enable)(struct dptx_dev *dp, int stream_id, int enable);
> +	int (*mode_configure)(struct dptx_dev *dp, int pclk, u8 bw, u8 bpp,
> +			      bool downshift);
> +	void (*replay_deferred_hotplug)(struct dptx_dev *dp);
> +	void (*quiesce_hpd)(struct dptx_dev *dp);
> +};
> +
> +struct dptx_dev {
> +	struct drm_bridge bridge;
> +	struct device *dev;
> +	int irq;
> +	bool irq_suspended;
> +	bool hpd_stopped;
> +	bool attached;
> +	/* Link limits of the current sink, clamped to the controller ones. */
> +	int link_max_rate;
> +	int link_max_lanes;
> +
> +	struct delayed_work hpd_event_work;
> +	struct delayed_work hpd_irq_work;
> +	struct delayed_work sw_hpd_irq_work;
> +	enum drm_connector_status status;
> +	enum drm_connector_status force_hpd;
> +	struct dptx_mode mode;
> +	/* Adjusted mode of the enabled stream, cached for the hotplug workers. */
> +	struct drm_display_mode adjusted_mode;
> +	enum dptx_state state;
> +	u32 pixel_per_cycle;
> +	u32 active_stream_cnt;
> +	/* Serializes the DP state against the hotplug workers. */
> +	struct mutex lock;
> +	u32 active_streams;
> +	struct dptx_config config;
> +	const struct dptx_ops *ops;
> +	struct dp_hw *hw;
> +	const struct dptx_plat_data *soc_data;
> +	void *soc_priv;
> +};
> +
> +#endif /* DPTX_H */
> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_core.c b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
> new file mode 100644
> index 000000000000..cf0f6c13df70
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
> @@ -0,0 +1,1091 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Trilinear Technologies
> + * Copyright 2026 Cix Technology Group Co., Ltd.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched.h>
> +#include <linux/workqueue.h>
> +
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include "dptx.h"
> +#include "dptx_drm.h"
> +#include "dptx_hw.h"
> +
> +#define DEFAULT_DP_POWER_ON_DELAY_MS 4
> +#define DP_HPD_MAX_TRIES 100
> +
> +static unsigned int dptx_power_on_delay_ms = DEFAULT_DP_POWER_ON_DELAY_MS;
> +module_param_named(power_on_delay_ms, dptx_power_on_delay_ms, uint, 0444);
> +MODULE_PARM_DESC(power_on_delay_ms,
> +		 "Delay after powering the sink up, in msec (default: 4)");
> +
> +static void dptx_lock(struct dptx_dev *dp)
> +{
> +	mutex_lock(&dp->lock);
> +}
> +
> +static void dptx_unlock(struct dptx_dev *dp)
> +{
> +	mutex_unlock(&dp->lock);
> +}

Please avoid using these helper functions and instead try using
guard/scope_guard(mutex)(&dp->lock) to simplify your process.

> +
> +static bool dptx_regs_accessible(struct dptx_dev *dp)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	return !(dp->state & DPTX_STATE_SUSPENDED) &&
> +	       (dp->state & DPTX_STATE_INITIALIZED);
> +}
> +
> +static bool dptx_get_hpd_state(struct dptx_dev *dp)
> +{
> +	return dp->hw->ops->hpd_state(dp->hw) ||
> +	       (READ_ONCE(dp->force_hpd) == connector_status_connected);
> +}

For dp->force_hpd, why do you use READ_ONCE in some places but not in
others (e.g. dptx_deferred_hotplug_pending)?

Moreover, since you write/read this variable in a locked context, do you
still need to use READ_ONCE? Please consider your concurrency model.

> +
> +static int dptx_get_lanes(struct dptx_dev *dp, int link_rate, int pclk, u8 bpp)
> +{
> +	int max_lanes = dp->link_max_lanes;
> +	int i;
> +
> +	for (i = 1; i <= max_lanes; i <<= 1) {
> +		if (pclk <= DPTX_MAX_RATE(link_rate, i, bpp ? bpp : 24))
> +			return i;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dptx_mode_configure(struct dptx_dev *dp, int pclk, u8 bw, u8 bpp,
> +			       bool downshift)
> +{
> +	int max_rate = dp->link_max_rate;
> +	int lane_cnt;
> +	int bw_code;
> +	int link_rate;
> +
> +	if (!downshift)
> +		bw_code = bw;
> +	else
> +		switch (bw) {
> +		case DP_LINK_BW_8_1:
> +			bw_code = DP_LINK_BW_5_4;
> +			break;
> +		case DP_LINK_BW_5_4:
> +			bw_code = DP_LINK_BW_2_7;
> +			break;
> +		case DP_LINK_BW_2_7:
> +			bw_code = DP_LINK_BW_1_62;
> +			break;
> +		case DP_LINK_BW_1_62:
> +			bw_code = DP_LINK_BW_1_62;
> +			break;
> +		default:
> +			bw_code = drm_dp_link_rate_to_bw_code(max_rate);
> +			break;
> +		}
> +
> +	link_rate = drm_dp_bw_code_to_link_rate(bw_code);
> +	lane_cnt = dptx_get_lanes(dp, link_rate, pclk, bpp);
> +	if (!lane_cnt)
> +		return -EINVAL;
> +
> +	dp->mode.bw_code = bw_code;
> +	dp->mode.link_rate = link_rate;
> +	dp->mode.lane_cnt = lane_cnt;
> +	dp->mode.pclock = pclk;
> +
> +	return 0;
> +}
> +
> +static struct drm_display_mode *dptx_get_mode(struct dptx_dev *dp,
> +					      int stream_id)
> +{

Just use unsigned int for stream_id?

> +	if (stream_id < 0 || stream_id >= DPTX_MST_SOURCE_NUMBER)
> +		return NULL;
> +
> +	if (!(dp->active_streams & BIT(stream_id)))
> +		return NULL;
> +
> +	return &dp->adjusted_mode;
> +}
> +
> +static void dptx_active_streams(struct dptx_dev *dp)
> +{
> +	struct drm_display_mode *mode;
> +	int i;
> +
> +	if (!READ_ONCE(dp->attached))

Again, it looks like the lock is held at this point.

Other variables that use WRITE_ONCE and READ_ONCE have
similar issues as well. Please check again.

> +		return;
> +
> +	for (i = 0; i < DPTX_MST_SOURCE_NUMBER; i++) {
> +		if (!(dp->active_streams & BIT(i)))
> +			continue;
> +
> +		mode = dptx_get_mode(dp, i);
> +		if (!mode)
> +			continue;
> +
> +		dp->hw->ops->stream_timing(dp->hw, i, mode,
> +					   dp->config.bpp,
> +					   dp->mode.lane_cnt, dp->mode.link_rate,
> +					   dp->pixel_per_cycle);
> +	}
> +}
> +
> +static int dptx_stream_hw_cfg(struct dptx_dev *dp, int stream_id)
> +{
> +	const struct dptx_config *config = &dp->config;
> +	struct drm_display_mode *mode = dptx_get_mode(dp, stream_id);
> +	int ret;
> +
> +	if (!mode)
> +		return -EINVAL;
> +
> +	ret = dp->hw->ops->stream_format_set(dp->hw, stream_id, config->format,
> +					     config->colorspace, config->bpc,
> +					     config->content_type);
> +	if (ret)
> +		return ret;
> +
> +	dp->hw->ops->stream_timing(dp->hw, stream_id, mode,
> +				   dp->config.bpp, dp->mode.lane_cnt,
> +				   dp->mode.link_rate, dp->pixel_per_cycle);
> +
> +	dp->soc_data->adapter_config(dp->soc_priv, stream_id,
> +				     config->format, dp->pixel_per_cycle == 2);
> +
> +	return 0;
> +}
> +
> +static int dptx_ctrl_stream_on(struct dptx_dev *dp, int stream_id)
> +{
> +	struct drm_display_mode *mode;
> +	unsigned long pixel_clock;
> +	int ret;
> +
> +	if (stream_id < 0 || stream_id >= DPTX_MST_SOURCE_NUMBER)
> +		return -EINVAL;
> +

Ditto.

> +	mode = dptx_get_mode(dp, stream_id);
> +	if (!mode)
> +		return -EINVAL;
> +
> +	pixel_clock = (unsigned long)mode->clock * 1000;
> +	ret = dp->hw->ops->stream_clock_rate_set(dp->hw, stream_id, pixel_clock);
> +	if (ret)
> +		return ret;
> +
> +	ret = dp->hw->ops->stream_clock_enable(dp->hw, stream_id, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = dptx_stream_hw_cfg(dp, stream_id);
> +	if (ret) {
> +		dp->hw->ops->stream_clock_enable(dp->hw, stream_id, false);
> +		return ret;
> +	}
> +
> +	dp->hw->ops->stream_enable(dp->hw, stream_id, true);
> +
> +	dp->active_stream_cnt++;
> +	return 0;
> +}
> +
> +static void dptx_ctrl_stream_off(struct dptx_dev *dp, int stream_id)
> +{
> +	dp->hw->ops->stream_enable(dp->hw, stream_id, false);
> +	dp->hw->ops->stream_clock_enable(dp->hw, stream_id, false);
> +
> +	dp->active_stream_cnt--;
> +}
> +
> +static void dptx_stop_streams(struct dptx_dev *dp)
> +{
> +	int i;
> +
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED))
> +		return;
> +
> +	for (i = 0; i < DPTX_MST_SOURCE_NUMBER; i++) {
> +		if (!(dp->active_streams & BIT(i)))
> +			continue;
> +
> +		dptx_ctrl_stream_off(dp, i);
> +		dp->active_streams &= ~BIT(i);
> +	}
> +
> +	if (!dp->active_stream_cnt)
> +		dp->state &= ~DPTX_STATE_ENABLED;
> +}
> +
> +static int dptx_enable(struct dptx_dev *dp, int stream_id)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (stream_id < 0 || stream_id >= DPTX_MST_SOURCE_NUMBER)
> +		return -EINVAL;
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED) ||
> +	    !(dp->state & DPTX_STATE_READY)) {
> +		dev_dbg(dp->dev, "enable skipped, state=0x%x\n", dp->state);
> +		return 0;
> +	}
> +
> +	dp->active_streams |= BIT(stream_id);
> +	ret = dptx_ctrl_stream_on(dp, stream_id);
> +	if (ret) {
> +		dp->active_streams &= ~BIT(stream_id);
> +		return ret;
> +	}
> +
> +	dp->state |= DPTX_STATE_ENABLED;
> +
> +	return 0;
> +}
> +
> +static int dptx_disable(struct dptx_dev *dp, int stream_id)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (stream_id < 0 || stream_id >= DPTX_MST_SOURCE_NUMBER)
> +		return -EINVAL;
> +
> +	if (!(dp->state & DPTX_STATE_ENABLED) ||
> +	    !(dp->state & DPTX_STATE_INITIALIZED))
> +		return 0;
> +
> +	if (dp->active_stream_cnt && (dp->active_streams & BIT(stream_id))) {
> +		dptx_ctrl_stream_off(dp, stream_id);
> +		dp->active_streams &= ~BIT(stream_id);
> +	}
> +
> +	return 0;
> +}
> +
> +static int dptx_train_loop(struct dptx_dev *dp)
> +{
> +	struct dptx_mode *mode = &dp->mode;
> +	u8 bpp = dp->config.bpp;
> +	u8 prev_bw = mode->bw_code;
> +	u8 prev_lanes = mode->lane_cnt;
> +	u8 bw_code = mode->bw_code;
> +	int i;
> +	int j;
> +	int ret;
> +
> +	for (i = 0; i < DP_MAX_TRAINING_LOOP; i++) {
> +		for (j = 0; j <= 3; j++) {
> +			if (!(dp->state & DPTX_STATE_READY))
> +				return 0;
> +
> +			ret = dp->hw->ops->link_train(dp->hw, mode->bw_code,
> +					 mode->lane_cnt, DPTX_MAX_LANES);
> +			if (!ret) {
> +				if (dp->active_stream_cnt &&
> +				    (mode->bw_code != prev_bw ||
> +				     mode->lane_cnt != prev_lanes))
> +					dptx_active_streams(dp);
> +				return 0;
> +			}
> +
> +			ret = dptx_mode_configure(dp, mode->pclock, bw_code,
> +						  bpp, true);
> +			if (ret < 0)
> +				break;
> +
> +			bw_code = dp->mode.bw_code;
> +		}
> +
> +		ret = dptx_mode_configure(dp, mode->pclock,
> +					  drm_dp_link_rate_to_bw_code(dp->link_max_rate),
> +					  bpp, false);
> +		if (ret < 0)
> +			return ret;
> +
> +		bw_code = dp->mode.bw_code;
> +	}
> +
> +	return -EIO;
> +}
> +
> +static int dptx_read_sink_caps(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	ret = dp->hw->ops->dpcd_sink_caps(dp->hw);
> +	if (ret)
> +		return ret;
> +
> +	if (dp->hw->caps.max_lanes > 0) {
> +		dp->link_max_lanes = min_t(u8, dp->hw->caps.max_lanes,
> +					   DPTX_MAX_LANES);
> +		dp->link_max_rate = min_t(int, dp->hw->caps.max_rate,
> +					  DPTX_MAX_LINK_RATE);
> +	}
> +
> +	return 0;
> +}
> +
> +static int dptx_core_on(struct dptx_dev *dp)
> +{
> +	int i, ret;
> +
> +	if (dp->state & DPTX_STATE_READY)
> +		return 0;
> +
> +	dp->state |= DPTX_STATE_READY;
> +
> +	for (i = 0; i < DPTX_MST_SOURCE_NUMBER; i++)
> +		dp->hw->ops->stream_enable(dp->hw, i, false);
> +
> +	ret = dp->hw->ops->phy_power(dp->hw, true);
> +	if (ret)
> +		goto err;
> +
> +	ret = dp->hw->ops->dpcd_power_up(dp->hw, dptx_power_on_delay_ms);
> +	if (ret)
> +		goto err_power;
> +
> +	ret = dptx_read_sink_caps(dp);
> +	if (ret)
> +		goto err_power;
> +
> +	ret = dptx_train_loop(dp);
> +	if (ret)
> +		goto err_power;
> +
> +	dp->hw->ops->core_enable(dp->hw, 0, true);
> +
> +	dp->state |= DPTX_STATE_INIT_TRAIN;
> +
> +	return 0;
> +
> +err_power:
> +	dp->hw->ops->dpcd_power_down(dp->hw, dptx_get_hpd_state(dp));
> +	dp->hw->ops->phy_power(dp->hw, false);
> +err:
> +	dp->state &= ~DPTX_STATE_READY;
> +	return ret;
> +}
> +
> +static int dptx_core_off(struct dptx_dev *dp)
> +{
> +	if (!(dp->state & DPTX_STATE_READY))
> +		return 0;
> +
> +	dp->hw->ops->dpcd_power_down(dp->hw, dptx_get_hpd_state(dp));
> +
> +	dp->hw->ops->phy_power(dp->hw, false);
> +	dp->hw->ops->core_enable(dp->hw, 0, false);
> +
> +	dp->state &= ~(DPTX_STATE_READY | DPTX_STATE_INIT_TRAIN);
> +
> +	return 0;
> +}
> +
> +static int dptx_host_reset(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dp->hw->ops->reset(dp->hw, true);
> +	usleep_range(10, 20);
> +	dp->hw->ops->reset(dp->hw, false);
> +
> +	ret = dp->hw->ops->phy_reset(dp->hw);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(100, 200);
> +	dp->hw->ops->host_enable(dp->hw, true);
> +
> +	return dp->hw->ops->phy_init(dp->hw);
> +}
> +
> +static int dptx_host_init(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	if (dp->state & DPTX_STATE_INITIALIZED)
> +		return 0;
> +
> +	ret = dp->hw->ops->apb_clock(dp->hw, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = dptx_host_reset(dp);
> +	if (ret) {
> +		dp->hw->ops->apb_clock(dp->hw, false);
> +		return ret;
> +	}
> +
> +	dp->state |= DPTX_STATE_INITIALIZED;
> +
> +	return 0;
> +}
> +
> +static void dptx_host_deinit(struct dptx_dev *dp)
> +{
> +	if (dp->state & DPTX_STATE_READY)
> +		dptx_core_off(dp);
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED))
> +		return;
> +
> +	dp->hw->ops->host_enable(dp->hw, false);
> +	dp->hw->ops->phy_exit(dp->hw);
> +
> +	dp->hw->ops->apb_clock(dp->hw, false);
> +
> +	dp->state &= ~(DPTX_STATE_INITIALIZED | DPTX_STATE_INIT_TRAIN);
> +}
> +
> +static int dptx_host_resume(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (!(dp->state & DPTX_STATE_SUSPENDED))
> +		return 0;
> +
> +	ret = dptx_host_init(dp);
> +	if (ret)
> +		return ret;
> +
> +	if (READ_ONCE(dp->irq_suspended)) {
> +		enable_irq(dp->irq);
> +		WRITE_ONCE(dp->irq_suspended, false);
> +	}
> +
> +	dp->state &= ~DPTX_STATE_SUSPENDED;
> +	return 0;
> +}
> +
> +static int dptx_handle_connect(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (dp->state & DPTX_STATE_CONNECTED)
> +		return 0;
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED)
> +		return 0;
> +
> +	ret = dptx_read_sink_caps(dp);
> +	if (!ret)
> +		dp->state |= DPTX_STATE_CONNECTED;
> +
> +	return ret;
> +}
> +
> +static int dptx_handle_disconnect(struct dptx_dev *dp)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	dp->state &= ~DPTX_STATE_CONNECTED;
> +
> +	return 0;
> +}
> +
> +static int dptx_detect(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +
> +	if ((dp->state & DPTX_STATE_SUSPENDED) &&
> +	    current_work() == &dp->hpd_event_work.work) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	ret = dptx_host_resume(dp);
> +	if (ret)
> +		goto out;
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		dev_warn_once(dp->dev, "detect with uninitialized host\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (!dptx_get_hpd_state(dp)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = dptx_handle_connect(dp);
> +
> +out:
> +	dptx_unlock(dp);
> +
> +	return ret;
> +}
> +
> +static enum drm_connector_status dptx_detect_status(struct dptx_dev *dp)
> +{
> +	enum drm_connector_status status;
> +	int ret;
> +
> +	ret = dptx_detect(dp);
> +	if (ret == -EBUSY)
> +		status = connector_status_unknown;
> +	else if (ret)
> +		status = connector_status_disconnected;
> +	else
> +		status = connector_status_connected;
> +
> +	dptx_lock(dp);
> +	dp->status = status;
> +	dptx_unlock(dp);
> +
> +	return status;
> +}
> +
> +static void dptx_sw_hpd_irq_work_func(struct work_struct *work)
> +{
> +	struct dptx_dev *dp =
> +		container_of(work, struct dptx_dev, sw_hpd_irq_work.work);
> +
> +	if (READ_ONCE(dp->hpd_stopped) ||
> +	    (READ_ONCE(dp->state) & DPTX_STATE_SUSPENDED))
> +		return;
> +
> +	queue_delayed_work(system_freezable_wq, &dp->hpd_irq_work, 0);
> +}
> +
> +static bool dptx_hpd_work_aborted(struct dptx_dev *dp)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	return READ_ONCE(dp->hpd_stopped) ||
> +	       !READ_ONCE(dp->attached) ||
> +	       !dptx_regs_accessible(dp);
> +}
> +
> +static void dptx_wait_phy_dp_mode(struct dptx_dev *dp)
> +{
> +	enum phy_mode mode;
> +
> +	if (read_poll_timeout(dp->hw->ops->phy_mode, mode, mode == PHY_MODE_DP,
> +			      100 * USEC_PER_MSEC,
> +			      DP_HPD_MAX_TRIES * 100 * USEC_PER_MSEC, false,
> +			      dp->hw))
> +		dev_dbg(dp->dev, "PHY did not enter DP mode\n");
> +}

This looks the same as v2. 

Does the PHY driver support some kind of static mux setting?

- If so, then for standard DP output, you don't need to wait.

- If it is USB-C altmode, please see the comment below.

> +
> +static void dptx_hpd_event_work_func(struct work_struct *work)
> +{
> +	struct dptx_dev *dp = container_of(work, struct dptx_dev,
> +					 hpd_event_work.work);
> +	enum drm_connector_status old_status;
> +	enum drm_connector_status status;
> +	bool hpd;
> +
> +	dptx_lock(dp);
> +	old_status = dp->status;
> +	if (dptx_hpd_work_aborted(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	hpd = dptx_get_hpd_state(dp);
> +	dptx_unlock(dp);
> +
> +	if (hpd && dp->hw->ops->phy_mode(dp->hw) != PHY_MODE_INVALID)
> +		dptx_wait_phy_dp_mode(dp);
> +
> +	dptx_detect_status(dp);
> +
> +	dptx_lock(dp);
> +	status = dp->status;
> +	if (!dptx_hpd_work_aborted(dp)) {
> +		if (status == connector_status_connected)
> +			dptx_handle_connect(dp);
> +		else
> +			dptx_handle_disconnect(dp);
> +	}
> +
> +	dptx_unlock(dp);
> +
> +	if (old_status != status && dp->bridge.dev)
> +		drm_bridge_hpd_notify(&dp->bridge, status);
> +}
> +
> +static void dptx_hpd_irq_work_func(struct work_struct *work)
> +{
> +	struct dptx_dev *dp = container_of(work, struct dptx_dev,
> +					 hpd_irq_work.work);
> +
> +	dptx_lock(dp);
> +
> +	if (READ_ONCE(dp->hpd_stopped) ||
> +	    !dptx_regs_accessible(dp) ||
> +	    !(dp->state & DPTX_STATE_ENABLED) ||
> +	    !dptx_get_hpd_state(dp))
> +		goto end;
> +
> +	if (dp->hw->ops->link_status(dp->hw, dp->mode.lane_cnt) > 0)
> +		dptx_train_loop(dp);
> +
> +end:
> +	dptx_unlock(dp);
> +}
> +
> +static bool dptx_deferred_hotplug_pending(struct dptx_dev *dp)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	return dptx_regs_accessible(dp) &&
> +	       dp->force_hpd == connector_status_unknown;
> +}
> +
> +/*
> + * USB-C combo PHY only. Its HPD pin is not wired to this controller, so a
> + * sink that was plugged in before the connector existed never raises
> + * HPD_EVENT. Replay that plug once the PHY is already in DP mode and AUX
> + * answers.
> + *
> + * A native DP port wires HPD to the controller and leaves the PHY mode at
> + * PHY_MODE_INVALID, so the checks below skip it. That port is reported by
> + * the HPD interrupt instead.
> + */

This looks the same as v2. You only call this during the attach process,
but what about at other times? Obviously, you will lose the HPD state.

Please take another look at aux-hpd-bridge and aux-bridge. Add an aux-bridge
in your PHY driver, and then attach your dptx bridge to this aux-bridge. 
In this way, you establish a bridge chain. Thus, you will not lose any HPD state
changes.

You can refer to how the dw-dp driver does it:
https://lore.kernel.org/all/20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com/

> +static void dptx_replay_deferred_hotplug(struct dptx_dev *dp)
> +{
> +	bool hpd;
> +
> +	dptx_lock(dp);
> +	if (!dptx_deferred_hotplug_pending(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	hpd = dptx_get_hpd_state(dp);
> +	dptx_unlock(dp);
> +
> +	if (hpd) {
> +		schedule_delayed_work(&dp->hpd_event_work, 0);
> +		return;
> +	}
> +
> +	if (dp->hw->ops->phy_mode(dp->hw) != PHY_MODE_DP)
> +		return;
> +
> +	dptx_lock(dp);
> +	if (!dptx_deferred_hotplug_pending(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	dptx_unlock(dp);
> +
> +	if (!dp->hw->ops->sink_present(dp->hw))
> +		return;
> +
> +	dptx_lock(dp);
> +	if (!dptx_regs_accessible(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	dp->force_hpd = connector_status_connected;
> +	dp->status = connector_status_unknown;
> +	dptx_unlock(dp);
> +
> +	schedule_delayed_work(&dp->hpd_event_work, 0);
> +}
> +
> +static irqreturn_t dptx_irq_handler(int irq, void *data)
> +{
> +	struct dptx_dev *dp = data;
> +
> +	return dp->hw->ops->irq(dp->hw);
> +}
> +
> +static void dptx_queue_hpd_event(void *data)
> +{
> +	struct dptx_dev *dp = data;
> +
> +	if (!READ_ONCE(dp->hpd_stopped))
> +		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
> +}
> +
> +static void dptx_queue_hpd_irq(void *data)
> +{
> +	struct dptx_dev *dp = data;
> +
> +	if (!READ_ONCE(dp->hpd_stopped))
> +		queue_delayed_work(system_freezable_wq, &dp->hpd_irq_work, 0);
> +}
> +
> +static void dptx_irq_off(struct dptx_dev *dp)
> +{
> +	if (READ_ONCE(dp->irq_suspended))
> +		return;
> +
> +	disable_irq(dp->irq);
> +	WRITE_ONCE(dp->irq_suspended, true);
> +}
> +
> +static void dptx_cancel_hpd_works(struct dptx_dev *dp)
> +{
> +	cancel_delayed_work_sync(&dp->sw_hpd_irq_work);
> +	cancel_delayed_work_sync(&dp->hpd_irq_work);
> +	cancel_delayed_work_sync(&dp->hpd_event_work);
> +}
> +
> +static void dptx_quiesce_hpd(struct dptx_dev *dp)
> +{
> +	bool irq_off;
> +
> +	dptx_lock(dp);
> +	WRITE_ONCE(dp->hpd_stopped, true);
> +	dptx_unlock(dp);
> +
> +	irq_off = READ_ONCE(dp->irq_suspended);
> +	if (!irq_off)
> +		disable_irq(dp->irq);
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	if (!irq_off)
> +		enable_irq(dp->irq);
> +}
> +
> +static int dptx_pm_prepare(struct dptx_dev *dp)
> +{
> +	if (dp->bridge.dev && dp->bridge.dev->mode_config.poll_enabled)
> +		drm_kms_helper_poll_disable(dp->bridge.dev);
> +
> +	dptx_irq_off(dp);
> +
> +	dptx_lock(dp);
> +	dp->state |= DPTX_STATE_SUSPENDED;
> +	dptx_unlock(dp);
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	dptx_lock(dp);
> +	if (!dp->active_stream_cnt)
> +		dptx_host_deinit(dp);
> +	dp->status = connector_status_unknown;
> +	dp->state &= ~DPTX_STATE_CONNECTED;
> +	dptx_unlock(dp);
> +
> +	return 0;
> +}
> +
> +static int dptx_pm_complete(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +	ret = dptx_host_resume(dp);
> +	dptx_unlock(dp);
> +	if (ret)
> +		return ret;
> +
> +	if (dp->bridge.dev && dp->bridge.dev->mode_config.poll_enabled)
> +		drm_kms_helper_poll_enable(dp->bridge.dev);
> +
> +	if (!READ_ONCE(dp->hpd_stopped) && READ_ONCE(dp->attached))
> +		schedule_delayed_work(&dp->hpd_event_work, 0);
> +
> +	return 0;
> +}
> +
> +static int dptx_prepare(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +
> +	ret = dptx_host_resume(dp);
> +	if (ret)
> +		goto end;
> +
> +	if (dp->state & DPTX_STATE_ENABLED) {
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		ret = dptx_host_init(dp);
> +		if (ret)
> +			goto end;
> +	} else if (dp->state & DPTX_STATE_READY) {
> +		/* core_on() finished, but the stream never became ENABLED. */
> +		dptx_core_off(dp);
> +	}
> +
> +	if (!dptx_get_hpd_state(dp)) {
> +		ret = -ENODEV;
> +		goto end;
> +	}
> +
> +	ret = dptx_handle_connect(dp);
> +
> +end:
> +	dptx_unlock(dp);
> +	return ret;
> +}
> +
> +static int dptx_unprepare(struct dptx_dev *dp)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (dp->active_stream_cnt)
> +		return 0;
> +
> +	if (!(dp->state & (DPTX_STATE_ENABLED | DPTX_STATE_READY)))
> +		return 0;
> +
> +	dptx_core_off(dp);
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED)
> +		dptx_host_deinit(dp);
> +
> +	dp->state &= ~DPTX_STATE_ENABLED;
> +
> +	return 0;
> +}
> +
> +static int dptx_encoder_enable(struct dptx_dev *dp, int stream_id, int enable)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +
> +	if (enable) {
> +		if (!dptx_regs_accessible(dp) ||
> +		    !(dp->state & DPTX_STATE_CONNECTED)) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +
> +		ret = dptx_core_on(dp);
> +		if (ret)
> +			goto out;
> +
> +		ret = dptx_enable(dp, stream_id);
> +		if (ret)
> +			dptx_unprepare(dp);
> +	} else {
> +		if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		ret = dptx_disable(dp, stream_id);
> +		if (ret)
> +			goto out;
> +
> +		ret = dptx_unprepare(dp);
> +	}
> +
> +out:
> +	dptx_unlock(dp);
> +	return ret;
> +}
> +
> +static int dptx_init(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	INIT_DELAYED_WORK(&dp->hpd_event_work, dptx_hpd_event_work_func);
> +	INIT_DELAYED_WORK(&dp->hpd_irq_work, dptx_hpd_irq_work_func);
> +	INIT_DELAYED_WORK(&dp->sw_hpd_irq_work, dptx_sw_hpd_irq_work_func);
> +
> +	mutex_init(&dp->lock);
> +	dp->state |= (DPTX_STATE_CONFIGURED);
> +
> +	ret = dptx_host_init(dp);
> +	if (ret)
> +		goto end1;

Please use meaningful label name like deinit.

> +
> +	irq_set_status_flags(dp->irq, IRQ_DISABLE_UNLAZY);
> +	ret = devm_request_threaded_irq(dp->dev, dp->irq, NULL,
> +					dptx_irq_handler, IRQF_ONESHOT,
> +				       dev_name(dp->dev), dp);
> +	if (ret < 0)
> +		goto end2;
> +
> +	return 0;
> +
> +end2:
> +	dptx_lock(dp);
> +	dptx_host_deinit(dp);
> +	dptx_unlock(dp);

Why is the lock held here?

> +end1:
> +	dp->state &= ~DPTX_STATE_CONFIGURED;
> +	mutex_destroy(&dp->lock);
> +	return ret;
> +}
> +
> +static void dptx_deinit(struct dptx_dev *dp)
> +{
> +	if (!(dp->state & DPTX_STATE_CONFIGURED))
> +		return;
> +
> +	dptx_lock(dp);
> +	WRITE_ONCE(dp->hpd_stopped, true);
> +	dptx_unlock(dp);
> +
> +	dptx_irq_off(dp);
> +	dptx_cancel_hpd_works(dp);
> +
> +	dptx_lock(dp);
> +	dptx_stop_streams(dp);
> +	dptx_host_deinit(dp);
> +	dp->state &= ~(DPTX_STATE_CONFIGURED);
> +	dptx_unlock(dp);
> +
> +	mutex_destroy(&dp->lock);
> +}
> +
> +static void dptx_dev_release(void *res)
> +{
> +	struct dptx_dev *dp = res;
> +
> +	dptx_deinit(dp);
> +}
> +
> +static int dptx_get_irq(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	ret = of_irq_get(dp->dev->of_node, 0);
> +	if (ret < 0)
> +		return dev_err_probe(dp->dev, ret, "failed to get irq\n");
> +

Use if (ret <= 0) ?

> +	dp->irq = ret;
> +
> +	return 0;
> +}
> +
> +static const struct dptx_ops dptx_impl_ops = {
> +	.detect				= dptx_detect,
> +	.detect_status			= dptx_detect_status,
> +	.prepare			= dptx_prepare,
> +	.unprepare			= dptx_unprepare,
> +	.lock				= dptx_lock,
> +	.unlock				= dptx_unlock,
> +	.encoder_enable			= dptx_encoder_enable,
> +	.mode_configure			= dptx_mode_configure,
> +	.replay_deferred_hotplug	= dptx_replay_deferred_hotplug,
> +	.quiesce_hpd			= dptx_quiesce_hpd,
> +};
> +
> +struct dptx_dev *dptx_probe(struct device *dev,
> +			    const struct dptx_plat_data *soc_data,
> +			    void *priv)
> +{
> +	struct dptx_dev *dp;
> +	int ret;
> +
> +	if (!soc_data || !soc_data->adapter_config)
> +		return ERR_PTR(-EINVAL);
> +
> +	dp = dptx_bridge_alloc(dev);
> +	if (IS_ERR(dp))
> +		return dp;
> +
> +	dp->dev = dev;
> +
> +	dp->hw = dptx_hw_init(dev, dp, dptx_queue_hpd_event,
> +			      dptx_queue_hpd_irq);
> +	if (IS_ERR(dp->hw))
> +		return ERR_CAST(dp->hw);
> +
> +	dp->soc_data = soc_data;
> +	dp->soc_priv = priv;
> +	dp->ops = &dptx_impl_ops;
> +	dp->status = connector_status_unknown;
> +	dp->force_hpd = connector_status_unknown;
> +	dp->state = DPTX_STATE_DISCONNECTED;
> +	dp->pixel_per_cycle = 1;
> +
> +	ret = dptx_get_irq(dp);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	dp->link_max_lanes = DPTX_MAX_LANES;
> +	dp->link_max_rate = DPTX_MAX_LINK_RATE;
> +
> +	ret = dptx_init(dp);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_add_action_or_reset(dev, dptx_dev_release, dp);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	dev_set_drvdata(dev, dp);
> +
> +	dp->bridge.of_node = dev->of_node;
> +	dp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_MODES |
> +			 DRM_BRIDGE_OP_HPD;
> +	dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
> +	dp->bridge.ddc = &dp->hw->aux.ddc;
> +	dp->bridge.ycbcr_420_allowed = true;
> +
> +	ret = devm_drm_bridge_add(dev, &dp->bridge);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return dp;
> +}
> +EXPORT_SYMBOL_GPL(dptx_probe);
> +

Use the trilinear prefix, like trilinear_dptx_probe?

> +int dptx_suspend(struct dptx_dev *dp)
> +{
> +	if (!dp)
> +		return 0;
> +
> +	return dptx_pm_prepare(dp);
> +}
> +EXPORT_SYMBOL_GPL(dptx_suspend);
> +
> +int dptx_resume(struct dptx_dev *dp)
> +{
> +	if (!dp)
> +		return 0;
> +
> +	return dptx_pm_complete(dp);
> +}
> +EXPORT_SYMBOL_GPL(dptx_resume);
> +

Ditto.

> +void dptx_shutdown(struct dptx_dev *dp)
> +{
> +	if (!dp)
> +		return;
> +
> +	dptx_lock(dp);
> +	dptx_stop_streams(dp);
> +	dptx_unlock(dp);
> +	dptx_pm_prepare(dp);
> +}
> +EXPORT_SYMBOL_GPL(dptx_shutdown);
> +

Ditto.

> +MODULE_AUTHOR("Luo Liu <Luo.Liu@cixtech.com>");
> +MODULE_AUTHOR("Wuyi Shen <wuyi.shen@cixtech.com>");
> +MODULE_DESCRIPTION("DisplayPort transmitter bridge driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/drm/bridge/dptx.h b/include/drm/bridge/dptx.h
> new file mode 100644
> index 000000000000..fd607e7bcf6d
> --- /dev/null
> +++ b/include/drm/bridge/dptx.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * DisplayPort transmitter bridge driver
> + *
> + * Copyright (C) 2026 Trilinear Technologies
> + * Copyright 2026 Cix Technology Group Co., Ltd.
> + */
> +
> +#ifndef DRM_BRIDGE_DPTX_H
> +#define DRM_BRIDGE_DPTX_H
> +
> +#include <linux/types.h>
> +
> +#include <drm/display/drm_dp.h>
> +
> +struct device;
> +struct dptx_dev;
> +
> +/**
> + * struct dptx_plat_data - platform glue for the DPTX bridge
> + * @adapter_config: programs the SoC side pixel format and pixel-per-clock
> + *                  mode for a stream; @stream_id is the SST stream index,
> + *                  @format the pixel format carried on the link and @ppc2
> + *                  whether the stream runs at two pixels per clock
> + *
> + * The bridge driver owns the DP protocol and the DRM bridge; the platform
> + * integration fills in the parts that are wired differently between SoCs.
> + */
> +struct dptx_plat_data {
> +	void (*adapter_config)(void *priv, int stream_id,
> +			       enum dp_pixelformat format, bool ppc2);
> +};
> +
> +/**
> + * dptx_probe - allocate and register a DPTX bridge
> + * @dev: device backing the transmitter
> + * @soc_data: platform glue for this transmitter
> + * @priv: opaque context passed back to &dptx_plat_data.adapter_config
> + *
> + * Return: the DPTX device on success, or an ERR_PTR() on failure.
> + */
> +struct dptx_dev *dptx_probe(struct device *dev,
> +			    const struct dptx_plat_data *soc_data,
> +			    void *priv);
> +
> +/**
> + * dptx_suspend - prepare a DPTX bridge for system sleep
> + * @dp: DPTX device returned by dptx_probe()
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +int dptx_suspend(struct dptx_dev *dp);
> +
> +/**
> + * dptx_resume - restore a DPTX bridge after system sleep
> + * @dp: DPTX device returned by dptx_probe()
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +int dptx_resume(struct dptx_dev *dp);
> +
> +/**
> + * dptx_shutdown - stop a DPTX bridge on system shutdown
> + * @dp: DPTX device returned by dptx_probe()
> + */
> +void dptx_shutdown(struct dptx_dev *dp);
> +
> +#endif /* DRM_BRIDGE_DPTX_H */

-- 
Best, 
Chaoyi
