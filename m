Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85FCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7705810E9E0;
	Tue, 23 Jun 2026 07:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="X2KzcJwv";
	dkim-atps=neutral
Received: from mail-m83240.xmail.ntesmail.com (mail-m83240.xmail.ntesmail.com
 [156.224.83.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E896E10E9A1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:52:26 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4367cf2ac;
 Tue, 23 Jun 2026 15:52:22 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Vicente Bergas <vicencb@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1] drm/bridge: analogix_dp: Apply standard DP training delay
 helpers
Date: Tue, 23 Jun 2026 15:52:07 +0800
Message-Id: <20260623075207.320603-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ef3774dac03a8kunm0645aabd3edb54
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQx1PVk5OGhpOGh8eQh9KT1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=X2KzcJwvW3fFjMuPTGE4xyKl5PFkg6tQ3P15URyn9oauTuIH0gcVgyL8617gT4NAWWeyYTHhKGGvRcnkTF14KGIszfs2I5KZAzarNNXMgvEs6xw90MnJUuSFAu3LKj4m1Wczjq6u5WvvJOlEqW0lRdeT1EXCwfcEvIAPXROjkEg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=orpaPXG5Jpujh/2+f0fXsHiWrUkO392Qz7s3M/n0pcs=;
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

Replace hardcoded fixed usleep_range() delays during clock recovery and
channel equalization with drm_dp_link_train_clock_recovery_delay()
and drm_dp_link_train_channel_eq_delay() helpers.

The original fixed delays are only valid for the case where bit[6:0] of
DPCD TRAINING_AUX_RD_INTERVAL(0000Eh) is 0x00, while core helpers apply
spec-compliant timings matching actual receiver capability values.

Additionally, add dpcd buffer to struct analogix_dp_device to cache
receiver capabilities. Call drm_dp_read_dpcd_caps() at commit entry to
populate cached DPCD data for subsequent link training steps, and
prepare for further usage of other DP helper APIs.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 10 ++++++++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 1d39a354c3d9..30c0c0b41d5a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -330,7 +330,7 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 	u8 voltage_swing, pre_emphasis, training_lane;
 	u8 link_status[DP_LINK_STATUS_SIZE];
 
-	usleep_range(100, 101);
+	drm_dp_link_train_clock_recovery_delay(&dp->aux, dp->dpcd);
 
 	lane_count = dp->link_train.lane_count;
 
@@ -393,7 +393,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 	u32 reg;
 	u8 link_status[DP_LINK_STATUS_SIZE];
 
-	usleep_range(400, 401);
+	drm_dp_link_train_channel_eq_delay(&dp->aux, dp->dpcd);
 
 	lane_count = dp->link_train.lane_count;
 
@@ -754,6 +754,12 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 {
 	int ret;
 
+	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to read dpcd caps: %d\n", ret);
+		return ret;
+	}
+
 	ret = analogix_dp_train_link(dp);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train, ret=%d\n", ret);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 94348c4e3623..c7997677a286 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -169,6 +169,8 @@ struct analogix_dp_device {
 	bool			fast_train_enable;
 	bool			psr_supported;
 
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+
 	struct analogix_dp_plat_data *plat_data;
 };
 
-- 
2.34.1

