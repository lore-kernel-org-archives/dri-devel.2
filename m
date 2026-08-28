Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2904CC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835E110F272;
	Fri, 28 Aug 2026 06:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TS7Lq4+c";
	dkim-atps=neutral
Received: from mail-m1602365261.xmail.ntesmail.com
 (mail-m1602365261.xmail.ntesmail.com [160.236.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522AF10F272
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:52:16 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4bab2d5c3;
 Fri, 28 Aug 2026 14:52:11 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v8 5/5] drm/bridge: analogix_dp: Add support for optional
 data-lanes mapping
Date: Fri, 28 Aug 2026 14:51:53 +0800
Message-Id: <20260828065153.590802-6-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828065153.590802-1-damon.ding@rock-chips.com>
References: <20260828065153.590802-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa04723ec2803a8kunm9cc188d518837b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhkaH1YaShlISh4aGk
 JDSk5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSEpKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=TS7Lq4+cqjmu4vyz4wHt52ViZazShlZ9Y19qmzmr2Ff5XJKsGeRI/n59CtNw4xPT6sgghdsIeyQP4RPOr0FoMN2RnW3wOYQF1Ry642hK5U7FQTWX4PG+gNfosiqzKf/swRJO4hHiGrucjESc6fvcDZHIfrQSjafh8mlOgOfOBsE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=07jua1c31UW2L/pF5LvkY8ta4PXpkxHe7lw8I4lCAJA=;
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

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Add lane mapping application scenarios in commit message.

Changes in v5:
- Add Reviewed-by tag.

Changes in v8:
- Fix reg parameter of of_graph_get_endpoint_by_regs() for parsing
  "data-lanes" endpoint from -1 to 0.
- Fix the 'tmp' name in analogix_dp_dt_parse_lanes_map() to
  understandable 'lane_idx'.
- Add comment to explain the lane map fill loop.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 70 +++++++++++++++++++
 .../drm/bridge/analogix/analogix_dp_core.h    |  4 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 15 ++--
 .../gpu/drm/bridge/analogix/analogix_dp_reg.h |  4 ++
 4 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a74c855936b2..18e76d1e78e1 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1244,6 +1244,73 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.detect = analogix_dp_bridge_detect,
 };
 
+static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
+{
+	struct video_info *video_info = &dp->video_info;
+	struct device_node *endpoint;
+	u32 lane_idx[LANE_COUNT4];
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
+	endpoint = of_graph_get_endpoint_by_regs(dp->dev->of_node, 1, 0);
+	if (!endpoint)
+		return -EINVAL;
+
+	ret = of_property_read_u32_array(endpoint, "data-lanes", lane_idx, num_lanes);
+	of_node_put(endpoint);
+	if (ret)
+		return -EINVAL;
+
+	for (i = 0; i < num_lanes; i++) {
+		if (lane_idx[i] >= LANE_COUNT4) {
+			dev_dbg(dp->dev, "data-lanes[%d] = %u is out of range\n", i, lane_idx[i]);
+			return -EINVAL;
+		}
+
+		if (used[lane_idx[i]]) {
+			dev_dbg(dp->dev, "data-lanes[%d] = %u is duplicate\n", i, lane_idx[i]);
+			return -EINVAL;
+		}
+
+		used[lane_idx[i]] = true;
+		map[i] = lane_idx[i];
+	}
+
+	/*
+	 * Fill the map[] entries not described by 'data-lanes' with the
+	 * lane indices not used so far, e.g. for 'data-lanes = <3 1>':
+	 *
+	 *	used[]       = {0, 1, 0, 1}  // only lanes 1 and 3 are used
+	 *	map[] before = {3, 1, x, x}  // x = unassigned
+	 *	map[] after  = {3, 1, 0, 2}
+	 *
+	 * Unused entries have no effect on the current link with fewer
+	 * lanes in use, but filling them with distinct indices keeps the
+	 * LANE_MAP register holding a valid permutation, just like its
+	 * reset value (0xe4), so the mapping remains sane if a sink with
+	 * a different lane count is connected later, e.g. via DP hot-plug.
+	 */
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
@@ -1282,6 +1349,9 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 		break;
 	}
 
+	if (analogix_dp_dt_parse_lanes_map(dp))
+		dev_dbg(dp->dev, "No valid data-lanes found, using default lane map\n");
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index c7997677a286..4560597604ad 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -137,6 +137,8 @@ struct video_info {
 
 	int max_link_rate;
 	enum link_lane_count_type max_lane_count;
+
+	u32 lane_map[LANE_COUNT4];
 };
 
 struct link_train {
@@ -177,7 +179,7 @@ struct analogix_dp_device {
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

