Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E37606A334
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hAPpXQmx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044AB10E761;
	Sat, 14 Nov 2026 05:01:18 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A48110E660
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632457;
 bh=n2boO7OE5od+BrtQifUyg26oesneiQwaWs7bHfsMIfA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hAPpXQmxEkigGsbt5x8CS9jobkMm3WHwKdirkchD5NOSkW7daqAFw507BRkkySPyZ
 HQ5bk1sVp05IM3c4lipMmZ/2+aOhRj1PKaDHE6hsFp/otGp+tSb3vh109LYVkg80ZQ
 BStyFKXjGSwhXojjgxix4rzJS5PApdZMeRrS6wa7agO9HBd+RS+EqRh2ccpU1f/dAA
 c1oIyudbnQwWLETHNe0cS69B+HTNktuK6J1fou5E+khKbhG7hJ9tbiPrH6oNocYoTx
 yQeS8YuQ50e2+Vn+AUNYVm+xnpkHFtFC7pxaVa5MHWpGotFn5sKUINX4lQgNjcBqkM
 YbRT7KeAlLSRw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2CA6B17E3BFE;
 Sat, 14 Nov 2026 06:00:57 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 2D6A6480069; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:55 +0100
Subject: [PATCH v12 22/23] drm/bridge: synopsys: dw-dp: Add audio support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-22-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12218;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=n2boO7OE5od+BrtQifUyg26oesneiQwaWs7bHfsMIfA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wdaRm7lQVh9vMpfIzA88aX78oHlOo3oS
 +qx6VLvzMH714kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qalkwP/1jhGzqgfDzKvFYNQWbImH2XJoGAejpb7wgWDGROPbaFYugw0M2V8WpyZkhVWW0KEFb
 P3PhrXOLL6yzVeK8AU4vk8pa9xfrRQ2czhH/YJb63yrYEVwUPo47SCGkw0m/jnqDZ7ffTiMJFP5
 hxNMBwETkOUELJo/KTvhkDHt76kZUGvqRIb0wvB0r/j1oPGEJBY/5VVyq+mDjq3oHrOUHFsi8IQ
 r3PWXJi/NzTctapiYJ7mChsxbzo9VobfC7s30iZJfNmcqnY7QRK3XBSHJvzYVJxpB71CBoS/r6j
 LFlrJl6pG8ckO4844M0mxSB7Kr5YP9Ezg7piAulYTXIK50JHV9Hjvcb2G1JRvoJEa5X+l8dgmEf
 WqMHnZfZHObEKC/0Evz10QKhVOQxtVMM45uJjRHKdIw8oiyUW/igAA3UVhkni9KTFkWlpVpLLL+
 +4Y2rU5VQguFmD1p65jSePw2uZJt2IewmFwI5oVyZClOAsb8NDLngEiNNkyz28vTV2BK5/LWBTp
 S1ix6jB57BVUwu/HTxS9zdBrls9u7HtjYucPSbH5yieVeJphkckdo5ZAs9typdepgUwnfYVwISl
 UGnp+GxiptlxpQazjyJdMPguEuexJG18BYhaITswj0fdo5hQ4KVo0rmAIG+9i1igyoZxjmOXPoA
 lN6BQNjD0iaCDhwMNhdwsMA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement audio support for the Synopsys DesignWare DisplayPort
controller.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 316 +++++++++++++++++++++++++++++++-
 1 file changed, 315 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 3c10cdb9ca28..bf3a53463394 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -23,16 +23,20 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/display/drm_dp_helper.h>
+#include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
+#include <sound/hdmi-codec.h>
+
 #define DW_DP_VERSION_NUMBER			0x0000
 #define DW_DP_VERSION_TYPE			0x0004
 #define DW_DP_ID				0x0008
 
 #define DW_DP_CONFIG_REG1			0x0100
+#define AUDIO_SELECT				GENMASK(2, 1)
 #define DW_DP_CONFIG_REG2			0x0104
 #define DW_DP_CONFIG_REG3			0x0108
 
@@ -109,6 +113,10 @@
 #define HBR_MODE_ENABLE				BIT(10)
 #define AUDIO_DATA_WIDTH			GENMASK(9, 5)
 #define AUDIO_DATA_IN_EN			GENMASK(4, 1)
+#define AUDIO_DATA_IN_EN_CHANNEL12		BIT(0)
+#define AUDIO_DATA_IN_EN_CHANNEL34		BIT(1)
+#define AUDIO_DATA_IN_EN_CHANNEL56		BIT(2)
+#define AUDIO_DATA_IN_EN_CHANNEL78		BIT(3)
 #define AUDIO_INF_SELECT			BIT(0)
 
 #define DW_DP_SDP_VERTICAL_CTRL			0x0500
@@ -252,6 +260,8 @@
 
 #define SDP_REG_BANK_SIZE			16
 
+#define DW_DP_SDP_VERSION			0x12
+
 struct dw_dp_link_caps {
 	bool enhanced_framing;
 	bool tps3_supported;
@@ -305,6 +315,19 @@ struct dw_dp_hotplug {
 	bool long_hpd;
 };
 
+enum dw_dp_audio_interface_support {
+	DW_DP_AUDIO_I2S_ONLY = 0,
+	DW_DP_AUDIO_SPDIF_ONLY = 1,
+	DW_DP_AUDIO_I2S_AND_SPDIF = 2,
+	DW_DP_AUDIO_NONE = 3,
+};
+
+enum dw_dp_audio_interface {
+	DW_DP_AUDIO_I2S = 0,
+	DW_DP_AUDIO_SPDIF = 1,
+	DW_DP_AUDIO_UNUSED,
+};
+
 struct dw_dp {
 	struct drm_bridge bridge;
 	struct device *dev;
@@ -320,10 +343,18 @@ struct dw_dp {
 	int irq;
 	struct work_struct hpd_work;
 	struct dw_dp_hotplug hotplug;
+	enum dw_dp_audio_interface audio_interface;
+	int audio_channels;
+	int audio_channel_allocation;
+	int audio_sample_width;
+	bool audio_muted;
+	int audio_sdp_nr;
 	/* Serialize hpd status access */
 	struct mutex irq_lock;
 	/* Serialize sdp_reg_bank access */
 	struct mutex sdp_lock;
+	/* Serialize audio state */
+	struct mutex audio_lock;
 
 	struct drm_dp_aux aux;
 
@@ -1696,6 +1727,261 @@ static int dw_dp_link_enable(struct dw_dp *dp)
 	return ret;
 }
 
+static int dw_dp_audio_infoframe_send(struct dw_dp *dp)
+{
+	struct hdmi_audio_infoframe frame;
+	struct dw_dp_sdp sdp;
+	int ret;
+
+	ret = hdmi_audio_infoframe_init(&frame);
+	if (ret < 0)
+		return ret;
+
+	frame.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
+	frame.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
+	frame.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
+	frame.channels = dp->audio_channels;
+	frame.channel_allocation = dp->audio_channel_allocation;
+
+	ret = hdmi_audio_infoframe_pack_for_dp(&frame, &sdp.base, DW_DP_SDP_VERSION);
+	if (ret < 0)
+		return ret;
+
+	sdp.flags = DW_DP_SDP_VERTICAL_INTERVAL;
+
+	return dw_dp_send_sdp(dp, &sdp);
+}
+
+static void dw_dp_audio_infoframe_clear(struct dw_dp *dp)
+{
+	if (dp->audio_sdp_nr >= 0) {
+		dw_dp_clear_sdp(dp, dp->audio_sdp_nr);
+		dp->audio_sdp_nr = -1;
+	}
+
+	regmap_clear_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
+			  EN_AUDIO_STREAM_SDP | EN_AUDIO_TIMESTAMP_SDP);
+	regmap_clear_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
+			  EN_AUDIO_STREAM_SDP);
+
+	regmap_clear_bits(dp->regmap, DW_DP_AUD_CONFIG1, AUDIO_DATA_IN_EN);
+}
+
+static void __dw_dp_audio_disable(struct dw_dp *dp)
+{
+	dw_dp_audio_infoframe_clear(dp);
+
+	if (dp->audio_interface == DW_DP_AUDIO_SPDIF)
+		clk_disable_unprepare(dp->spdif_clk);
+	else if (dp->audio_interface == DW_DP_AUDIO_I2S)
+		clk_disable_unprepare(dp->i2s_clk);
+
+	dp->audio_interface = DW_DP_AUDIO_UNUSED;
+}
+
+static int __dw_dp_audio_enable(struct dw_dp *dp)
+{
+	u8 audio_data_in_en;
+
+	switch (dp->audio_channels) {
+	case 1:
+	case 2:
+		audio_data_in_en = AUDIO_DATA_IN_EN_CHANNEL12;
+		break;
+	case 8:
+		audio_data_in_en = AUDIO_DATA_IN_EN_CHANNEL12 |
+				   AUDIO_DATA_IN_EN_CHANNEL34 |
+				   AUDIO_DATA_IN_EN_CHANNEL56 |
+				   AUDIO_DATA_IN_EN_CHANNEL78;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(dp->regmap, DW_DP_AUD_CONFIG1,
+			   AUDIO_DATA_IN_EN | NUM_CHANNELS | AUDIO_DATA_WIDTH |
+			   AUDIO_INF_SELECT | HBR_MODE_ENABLE | AUDIO_MUTE,
+			   FIELD_PREP(AUDIO_DATA_IN_EN, audio_data_in_en) |
+			   FIELD_PREP(NUM_CHANNELS, dp->audio_channels - 1) |
+			   FIELD_PREP(AUDIO_DATA_WIDTH, dp->audio_sample_width) |
+			   FIELD_PREP(AUDIO_INF_SELECT, dp->audio_interface) |
+			   FIELD_PREP(HBR_MODE_ENABLE, 0) |
+			   FIELD_PREP(AUDIO_MUTE, dp->audio_muted));
+
+	/* Wait for inf switch */
+	usleep_range(20, 40);
+
+	/*
+	 * Send audio stream during vertical and horizontal blanking periods.
+	 * Send out audio timestamp SDP once per video frame during the vertical
+	 * blanking period
+	 */
+	regmap_update_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
+			   EN_AUDIO_STREAM_SDP | EN_AUDIO_TIMESTAMP_SDP,
+			   FIELD_PREP(EN_AUDIO_STREAM_SDP, 1) |
+			   FIELD_PREP(EN_AUDIO_TIMESTAMP_SDP, 1));
+	regmap_update_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
+			   EN_AUDIO_STREAM_SDP,
+			   FIELD_PREP(EN_AUDIO_STREAM_SDP, 1));
+
+	if (dp->audio_sdp_nr >= 0) {
+		dw_dp_clear_sdp(dp, dp->audio_sdp_nr);
+		dp->audio_sdp_nr = -1;
+	}
+
+	dp->audio_sdp_nr = dw_dp_audio_infoframe_send(dp);
+	if (dp->audio_sdp_nr < 0) {
+		dw_dp_audio_infoframe_clear(dp);
+		return dp->audio_sdp_nr;
+	}
+
+	return 0;
+}
+
+static int dw_dp_audio_startup(struct drm_bridge *bridge,
+			       struct drm_connector *connector)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	dev_dbg(dp->dev, "audio startup\n");
+
+	return pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
+}
+
+static void dw_dp_audio_unprepare(struct drm_bridge *bridge,
+				  struct drm_connector *connector)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	guard(mutex)(&dp->audio_lock);
+
+	__dw_dp_audio_disable(dp);
+}
+
+static int dw_dp_audio_prepare(struct drm_bridge *bridge,
+			       struct drm_connector *connector,
+			       struct hdmi_codec_daifmt *daifmt,
+			       struct hdmi_codec_params *params)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+	u8 supported_audio_interfaces;
+	enum dw_dp_audio_interface audio_interface;
+	u32 cfg1;
+	int ret;
+
+	guard(mutex)(&dp->audio_lock);
+
+	/*
+	 * prepare might be called multiple times, so release the clocks
+	 * from previous calls to keep the calls in balance.
+	 */
+	if (dp->audio_interface != DW_DP_AUDIO_UNUSED)
+		__dw_dp_audio_disable(dp);
+
+	/* The hardware is limited to 1,2 or 8 channels */
+	switch (params->cea.channels) {
+	case 1:
+	case 2:
+	case 8:
+		break;
+	default:
+		dev_err(dp->dev, "invalid audio channels %d\n", params->cea.channels);
+		return -EINVAL;
+	}
+
+	if (params->sample_width < 16 || params->sample_width > 24) {
+		dev_err(dp->dev, "invalid data sample width %d\n", params->sample_width);
+		return -EINVAL;
+	}
+
+	switch (daifmt->fmt) {
+	case HDMI_SPDIF:
+		audio_interface = DW_DP_AUDIO_SPDIF;
+		break;
+	case HDMI_I2S:
+		/*
+		 * It is recommended to use SPDIF instead of I2S, since I2S mode requires
+		 * manually inserting PCUV control bits from userspace and this is done
+		 * automatically in hardware for SPDIF mode.
+		 */
+		audio_interface = DW_DP_AUDIO_I2S;
+		break;
+	default:
+		dev_err(dp->dev, "invalid DAI format %d\n", daifmt->fmt);
+		return -EINVAL;
+	}
+
+	regmap_read(dp->regmap, DW_DP_CONFIG_REG1, &cfg1);
+	supported_audio_interfaces = FIELD_GET(AUDIO_SELECT, cfg1);
+
+	if (supported_audio_interfaces != DW_DP_AUDIO_I2S_AND_SPDIF &&
+	    supported_audio_interfaces != audio_interface) {
+		dev_err(dp->dev, "unsupported DAI %d\n", daifmt->fmt);
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(dp->spdif_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dp->i2s_clk);
+	if (ret) {
+		clk_disable_unprepare(dp->spdif_clk);
+		return ret;
+	}
+
+	if (audio_interface == DW_DP_AUDIO_I2S)
+		clk_disable_unprepare(dp->spdif_clk);
+	else if (audio_interface == DW_DP_AUDIO_SPDIF)
+		clk_disable_unprepare(dp->i2s_clk);
+
+	dp->audio_channels = params->cea.channels;
+	dp->audio_channel_allocation = params->cea.channel_allocation;
+	dp->audio_sample_width = params->sample_width;
+	dp->audio_interface = audio_interface;
+
+	ret = __dw_dp_audio_enable(dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to enable audio\n");
+		__dw_dp_audio_disable(dp);
+		return ret;
+	}
+
+	dev_dbg(dp->dev, "audio prepare with %d channels using DAI=%d\n",
+		dp->audio_channels, dp->audio_interface);
+
+	return 0;
+}
+
+static void dw_dp_audio_shutdown(struct drm_bridge *bridge,
+				 struct drm_connector *connector)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	dev_dbg(dp->dev, "audio shutdown\n");
+
+	dw_dp_audio_unprepare(bridge, connector);
+	pm_runtime_put_autosuspend(dp->dev);
+}
+
+static int dw_dp_audio_mute_stream(struct drm_bridge *bridge,
+				   struct drm_connector *connector,
+				   bool enable, int direction)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	dev_dbg(dp->dev, "audio %smute\n", enable ? "" : "un");
+
+	guard(mutex)(&dp->audio_lock);
+
+	dp->audio_muted = enable;
+
+	regmap_update_bits(dp->regmap, DW_DP_AUD_CONFIG1, AUDIO_MUTE,
+			   FIELD_PREP(AUDIO_MUTE, enable));
+
+	return 0;
+}
+
 static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 				       struct drm_atomic_commit *state)
 {
@@ -1734,12 +2020,22 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 		dev_err(dp->dev, "failed to enable video: %d\n", ret);
 		return;
 	}
+
+	scoped_guard(mutex, &dp->audio_lock) {
+		if (dp->audio_interface != DW_DP_AUDIO_UNUSED) {
+			ret = __dw_dp_audio_enable(dp);
+			if (ret < 0)
+				dev_err(dp->dev, "failed to restore audio: %d\n", ret);
+		}
+	}
 }
 
 static void dw_dp_reset(struct dw_dp *dp)
 {
 	int val;
 
+	guard(mutex)(&dp->audio_lock);
+
 	disable_irq(dp->irq);
 	regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL, CONTROLLER_RESET,
 			   FIELD_PREP(CONTROLLER_RESET, 1));
@@ -2038,6 +2334,11 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.detect = dw_dp_bridge_detect,
 	.edid_read = dw_dp_bridge_edid_read,
 	.oob_notify = dw_dp_bridge_oob_notify,
+
+	.dp_audio_startup = dw_dp_audio_startup,
+	.dp_audio_prepare = dw_dp_audio_prepare,
+	.dp_audio_shutdown = dw_dp_audio_shutdown,
+	.dp_audio_mute_stream = dw_dp_audio_mute_stream,
 };
 
 static int dw_dp_link_retrain(struct dw_dp *dp)
@@ -2252,6 +2553,10 @@ int dw_dp_probe(struct dw_dp *dp)
 	if (ret)
 		return ret;
 
+	ret = devm_mutex_init(dev, &dp->audio_lock);
+	if (ret)
+		return ret;
+
 	res = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(res))
 		return PTR_ERR(res);
@@ -2368,12 +2673,21 @@ int dw_dp_probe(struct dw_dp *dp)
 		return ret;
 
 	dp->vsc_sdp_nr = -1;
+	dp->audio_interface = DW_DP_AUDIO_UNUSED;
+	dp->audio_sdp_nr = -1;
 
 	bridge = &dp->bridge;
 	bridge->of_node = dev->of_node;
-	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
+	bridge->ops = DRM_BRIDGE_OP_DP_AUDIO |
+		      DRM_BRIDGE_OP_DETECT |
+		      DRM_BRIDGE_OP_EDID |
+		      DRM_BRIDGE_OP_HPD;
 	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
 	bridge->ycbcr_420_allowed = true;
+	bridge->hdmi_audio_dev = dev;
+	bridge->hdmi_audio_max_i2s_playback_channels = 8;
+	bridge->hdmi_audio_dai_port = 1;
+	bridge->hdmi_audio_spdif_playback = true;
 
 	return devm_drm_bridge_add(dev, bridge);
 }

-- 
2.53.0

