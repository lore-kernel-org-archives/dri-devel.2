Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC80CD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0519E10E1E7;
	Mon, 25 May 2026 09:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SwnWaMCW";
	dkim-atps=neutral
Received: from mail-m12832.netease.com (mail-m12832.netease.com
 [103.209.128.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4FC10E1B5
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:47:39 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3fb5f003e;
 Mon, 25 May 2026 17:47:36 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v3 2/2] drm/bridge: analogix_dp: Add support for optional
 data-lanes mapping
Date: Mon, 25 May 2026 17:47:31 +0800
Message-Id: <20260525094731.121380-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525094731.121380-1-damon.ding@rock-chips.com>
References: <20260525094731.121380-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e5e88608d03a3kunm84eb206f10f6ef
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBkYVhhOGEpIHkhKHx8YSlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=SwnWaMCWjBLEY9nKSNBIz17WNyQl3/WLyAr/pLx5YTQwhiRjh6ZQnLn6oAI6Iqs/7NNrszMwz5keqkc5VnCtZoSncH1PkgVdrLw8GU859XU30U80MLn2h5OaEzhOShS6a3j147K5XoJ29wwpsRa3jmXHxvKrw45mCGYx690GYHg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=MGZJIkp+bxuC8sN+1d1VBd1BwHThYFGRrqxTQBMfj8w=;
 h=date:mime-version:subject:message-id:from;
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

Parse the optional 'data-lanes' device tree property to support
custom physical lane mapping configuration.

If no valid configuration is found, fall back to the default
lane map (0, 1, 2, 3) automatically and keep the driver running.

Lane mapping is mainly used for below scenarios:
1. Correct PCB lane swap and differential line routing crossover
   without hardware changes;
2. Adapt mismatched lane pin definitions between SoC and eDP panel;
3. Support multiple panel hardware variants on the same board
   by configuring data-lanes in device tree only.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Add lane mapping application scenarios in commit message.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 56 +++++++++++++++++++
 .../drm/bridge/analogix/analogix_dp_core.h    |  4 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 15 +++--
 .../gpu/drm/bridge/analogix/analogix_dp_reg.h |  4 ++
 4 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5dc07ff84cd3..d1c6365118de 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1234,6 +1234,59 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.detect = analogix_dp_bridge_detect,
 };
 
+static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
+{
+	struct video_info *video_info = &dp->video_info;
+	struct device_node *endpoint;
+	u32 tmp[LANE_COUNT4];
+	u32 map[LANE_COUNT4] = {0, 1, 2, 3};
+	bool used[LANE_COUNT4] = {false};
+	int num_lanes;
+	int ret, i;
+
+	memcpy(video_info->lane_map, map, sizeof(map));
+
+	num_lanes = drm_of_get_data_lanes_count_ep(dp->dev->of_node, 1, 0, 1,
+						   video_info->max_lane_count);
+	if (num_lanes < 0)
+		return -EINVAL;
+
+	endpoint = of_graph_get_endpoint_by_regs(dp->dev->of_node, 1, -1);
+	if (!endpoint)
+		return -EINVAL;
+
+	ret = of_property_read_u32_array(endpoint, "data-lanes", tmp, num_lanes);
+	of_node_put(endpoint);
+	if (ret)
+		return -EINVAL;
+
+	for (i = 0; i < num_lanes; i++) {
+		if (tmp[i] >= LANE_COUNT4) {
+			dev_dbg(dp->dev, "data-lanes[%d] = %u is out of range\n", i, tmp[i]);
+			return -EINVAL;
+		}
+
+		if (used[tmp[i]]) {
+			dev_dbg(dp->dev, "data-lanes[%d] = %u is duplicate\n", i, tmp[i]);
+			return -EINVAL;
+		}
+
+		used[tmp[i]] = true;
+		map[i] = tmp[i];
+	}
+
+	for (i = 0; i < LANE_COUNT4 && num_lanes < LANE_COUNT4; i++) {
+		if (!used[i])
+			map[num_lanes++] = i;
+	}
+
+	dev_dbg(dp->dev, "Using parsed lane map: <%u %u %u %u>\n", map[0], map[1], map[2], map[3]);
+
+	memcpy(video_info->lane_map, map, sizeof(map));
+
+	return 0;
+}
+
 static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 {
 	struct device_node *dp_node = dp->dev->of_node;
@@ -1266,6 +1319,9 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 		break;
 	}
 
+	if (analogix_dp_dt_parse_lanes_map(dp))
+		dev_dbg(dp->dev, "No valid data-lanes found, using default lane map\n");
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 94348c4e3623..a75d0fb8f980 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -137,6 +137,8 @@ struct video_info {
 
 	int max_link_rate;
 	enum link_lane_count_type max_lane_count;
+
+	u32 lane_map[LANE_COUNT4];
 };
 
 struct link_train {
@@ -175,7 +177,7 @@ struct analogix_dp_device {
 /* analogix_dp_reg.c */
 void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool enable);
 void analogix_dp_stop_video(struct analogix_dp_device *dp);
-void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable);
+void analogix_dp_lane_mapping(struct analogix_dp_device *dp);
 void analogix_dp_init_analog_param(struct analogix_dp_device *dp);
 void analogix_dp_init_interrupt(struct analogix_dp_device *dp);
 void analogix_dp_reset(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index ea8401293a23..c1344a3f013a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -48,16 +48,15 @@ void analogix_dp_stop_video(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 }
 
-void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
+void analogix_dp_lane_mapping(struct analogix_dp_device *dp)
 {
+	u32 *lane_map = dp->video_info.lane_map;
 	u32 reg;
 
-	if (enable)
-		reg = LANE3_MAP_LOGIC_LANE_0 | LANE2_MAP_LOGIC_LANE_1 |
-		      LANE1_MAP_LOGIC_LANE_2 | LANE0_MAP_LOGIC_LANE_3;
-	else
-		reg = LANE3_MAP_LOGIC_LANE_3 | LANE2_MAP_LOGIC_LANE_2 |
-		      LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;
+	reg = lane_map[0] << LANE0_MAP_SHIFT;
+	reg |= lane_map[1] << LANE1_MAP_SHIFT;
+	reg |= lane_map[2] << LANE2_MAP_SHIFT;
+	reg |= lane_map[3] << LANE3_MAP_SHIFT;
 
 	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_MAP);
 }
@@ -140,7 +139,7 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
 
 	usleep_range(20, 30);
 
-	analogix_dp_lane_swap(dp, 0);
+	analogix_dp_lane_mapping(dp);
 
 	writel(0x0, dp->reg_base + ANALOGIX_DP_SYS_CTL_1);
 	writel(0x40, dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
index 12735139046c..ac914e37089b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
@@ -209,6 +209,10 @@
 #define LANE0_MAP_LOGIC_LANE_1			(0x1 << 0)
 #define LANE0_MAP_LOGIC_LANE_2			(0x2 << 0)
 #define LANE0_MAP_LOGIC_LANE_3			(0x3 << 0)
+#define LANE3_MAP_SHIFT				(6)
+#define LANE2_MAP_SHIFT				(4)
+#define LANE1_MAP_SHIFT				(2)
+#define LANE0_MAP_SHIFT				(0)
 
 /* ANALOGIX_DP_ANALOG_CTL_1 */
 #define TX_TERMINAL_CTRL_50_OHM			(0x1 << 4)
-- 
2.34.1

