Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC56DC5AD46
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C645910F24B;
	Thu,  6 Aug 2026 17:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lcW9nXzl";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FF510F248
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035746;
 bh=rUTz7CK3p/p2jbkH5eKhbQMALWCMFHw5vsivpEJ3pwQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lcW9nXzlKeKucAMDXDRybejHCaRVN9fawy6j+qBitfB1l+cFI348QCuueOOPOiONy
 25xQVdBxNeTrWuxc6lF6Rv4+QsKVJkXAQOhu8OcxDCs3bWvBdikVfXTdBFD/A5CVqJ
 O0BVSvrHnU1TXxeyIwQeBAbus2NSCQl018jwX75jxNhEnyJZ6IO+7WVRLwnRQiQOCg
 wCp9mHbzWBv10pfczuqEX25JKKRePl+DihOFpBAsZyKZKH63wLdQe/Frpcld9jUoMH
 pCQBDlpgKoQvxyOw/LIH4ovNaHWnRj/3LY8tpNxjrkoAZ9dHqeXhRiXGCItamkGBh9
 FRJg4LMjW7YCg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1189017E12AE;
 Thu, 06 Aug 2026 19:02:26 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 16E65480067; Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:27 +0200
Subject: [PATCH v11 21/21] drm/bridge: synopsys: dw-dp: Add audio support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-21-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12060;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=rUTz7CK3p/p2jbkH5eKhbQMALWCMFHw5vsivpEJ3pwQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viCmTmD+Df9ExnIlzRsALD/ImSzw/8caf
 KMHYlneHVOnbIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qapQEQAIVoNi5dICimyRYUXb6uAlfXDWEZdB28aPjUBH4KjqYuYJrdhVDzFwAq8snEaMMInl2
 yGs7kKdlUxzTktQGbNmA3ZoTALo18Dumue7GUeiz4GEl4tQPPhzFK9JKaQLK+Q8uNaGNXOA/J79
 xHxFCHSZvHLnl2Df44iO5mP5wamwAp84m3801jtX5lEeHc13fyMRwDxfzQVdCdnN+C7p7hsJSw7
 X9TRCY3gO8xv7tfunsmnYR5JiVVaPX8j1YqJM3IUUzExUjuMdJqH45EOVdYMrX/MVISoR7afskG
 C6OKXwtoHyK/HIb+mZQqUx/ToiDVq++vPKhGwP6C8UEZDoi2P4BCB9qLl0PVL5MuxoHFuTiB3Lz
 H3SLgZooNHV8AKseIdeRZg8kCunfhAAIb32hwlXENRfrRr8rc4KUpE1Bn+N9T1V90B1MOPIqfIC
 rqupjSH81B597gpJQJAP00yIG3i0Td97qkf0Pj4n8puoGcbYrpBFq1g3aLGxh5zE6hUjW8wwVYX
 PL2c5BOPlywY9cJpUab/nsuZaMuNxky8HUrZdCPSOq77knmSSltTDr8rBkaIxttFqia7Un9xFxu
 RbJJwQIXZ8Wcfee0s9oQ1rMpYpvpdyUPaXsql6C3YM8vEmyOx6LzsNf3qvkEvrDoDpR3BN+d5va
 Knjg+uzqKLsI+lTaRfUMqGA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Implement audio support for the Synopsys DesignWare DisplayPort
controller.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 314 +++++++++++++++++++++++++++++++-
 1 file changed, 313 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index b610abf76ef7..df149c52fce0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -23,17 +23,21 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/display/drm_dp_helper.h>
+#include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include <sound/hdmi-codec.h>
+
 #define DW_DP_VERSION_NUMBER			0x0000
 #define DW_DP_VERSION_TYPE			0x0004
 #define DW_DP_ID				0x0008
 
 #define DW_DP_CONFIG_REG1			0x0100
+#define AUDIO_SELECT				GENMASK(2, 1)
 #define DW_DP_CONFIG_REG2			0x0104
 #define DW_DP_CONFIG_REG3			0x0108
 
@@ -110,6 +114,10 @@
 #define HBR_MODE_ENABLE				BIT(10)
 #define AUDIO_DATA_WIDTH			GENMASK(9, 5)
 #define AUDIO_DATA_IN_EN			GENMASK(4, 1)
+#define AUDIO_DATA_IN_EN_CHANNEL12		BIT(0)
+#define AUDIO_DATA_IN_EN_CHANNEL34		BIT(1)
+#define AUDIO_DATA_IN_EN_CHANNEL56		BIT(2)
+#define AUDIO_DATA_IN_EN_CHANNEL78		BIT(3)
 #define AUDIO_INF_SELECT			BIT(0)
 
 #define DW_DP_SDP_VERTICAL_CTRL			0x0500
@@ -253,6 +261,8 @@
 
 #define SDP_REG_BANK_SIZE			16
 
+#define DW_DP_SDP_VERSION			0x12
+
 struct dw_dp_link_caps {
 	bool enhanced_framing;
 	bool tps3_supported;
@@ -306,6 +316,19 @@ struct dw_dp_hotplug {
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
@@ -321,10 +344,18 @@ struct dw_dp {
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
 
@@ -1697,6 +1728,261 @@ static int dw_dp_link_enable(struct dw_dp *dp)
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
@@ -1735,6 +2021,14 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
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
@@ -2035,6 +2329,11 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
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
@@ -2249,6 +2548,10 @@ int dw_dp_probe(struct dw_dp *dp)
 	if (ret)
 		return ret;
 
+	ret = devm_mutex_init(dev, &dp->audio_lock);
+	if (ret)
+		return ret;
+
 	res = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(res))
 		return PTR_ERR(res);
@@ -2365,12 +2668,21 @@ int dw_dp_probe(struct dw_dp *dp)
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

