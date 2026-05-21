Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0C2CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 10:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C0C10E18A;
	Thu, 21 May 2026 10:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="f5SUmz2W";
	dkim-atps=neutral
Received: from mail-m60195.netease.com (mail-m60195.netease.com
 [210.79.60.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FDA10E18A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 10:27:23 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3f4e1cf0d;
 Thu, 21 May 2026 18:27:19 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1] drm/bridge: analogix_dp: Convert status check functions to
 bool
Date: Thu, 21 May 2026 18:27:16 +0800
Message-Id: <20260521102716.1373519-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e4a134eda03a3kunm9bb0eb6d711e8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQhlMVkNKGUtOTRgZTEgaSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=f5SUmz2W5gYAVStKjo7qAkjdW4p08Dc9Cb9ZzK4N6kDaFniMCjFuRD7aRIkVaq9sY2fkiaEP6xy9TpXJpY1Bkq5G3vEY5WdbIS/XXUgBos7LODxVvXQGD1ZECHlsfeq71P42v334bretDbteKgMLbL7MJuYdCldp4lib53MgKS0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=XtwCByr+wKG5Y+gmLOm1LXw98pacruXWBpNBN0qDn4c=;
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

Convert analogix_dp_is_slave_video_stream_clock_on() and
analogix_dp_is_video_stream_on() from int to bool return type.

This makes the code more readable and aligns with kernel best
practices for boolean status checks, while simplifying the
callers by removing unnecessary "== 0" comparisons.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 ++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  4 ++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8cf6b73bceac..573900c2cefc 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -619,7 +619,7 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 
 	for (;;) {
 		timeout_loop++;
-		if (analogix_dp_is_slave_video_stream_clock_on(dp) == 0)
+		if (analogix_dp_is_slave_video_stream_clock_on(dp))
 			break;
 		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
 			dev_err(dp->dev, "Timeout of slave video streamclk ok\n");
@@ -647,7 +647,7 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
 
 	for (;;) {
 		timeout_loop++;
-		if (analogix_dp_is_video_stream_on(dp) == 0) {
+		if (analogix_dp_is_video_stream_on(dp)) {
 			done_count++;
 			if (done_count > 10)
 				break;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 17347448c6b0..94348c4e3623 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -211,7 +211,7 @@ void analogix_dp_reset_macro(struct analogix_dp_device *dp);
 void analogix_dp_init_video(struct analogix_dp_device *dp);
 
 void analogix_dp_set_video_color_format(struct analogix_dp_device *dp);
-int analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp);
+bool analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp);
 void analogix_dp_set_video_cr_mn(struct analogix_dp_device *dp,
 				 enum clock_recovery_m_value_type type,
 				 u32 m_value,
@@ -220,7 +220,7 @@ void analogix_dp_set_video_timing_mode(struct analogix_dp_device *dp, u32 type);
 void analogix_dp_enable_video_master(struct analogix_dp_device *dp,
 				     bool enable);
 void analogix_dp_start_video(struct analogix_dp_device *dp);
-int analogix_dp_is_video_stream_on(struct analogix_dp_device *dp);
+bool analogix_dp_is_video_stream_on(struct analogix_dp_device *dp);
 void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp);
 void analogix_dp_enable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_disable_scrambling(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 38fd8d5014d2..f84c1d48d671 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -713,7 +713,7 @@ void analogix_dp_set_video_color_format(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_3);
 }
 
-int analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp)
+bool analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
@@ -724,7 +724,7 @@ int analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp)
 
 	if (!(reg & DET_STA)) {
 		dev_dbg(dp->dev, "Input stream clock not detected.\n");
-		return -EINVAL;
+		return false;
 	}
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
@@ -735,10 +735,10 @@ int analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp)
 
 	if (reg & CHA_STA) {
 		dev_dbg(dp->dev, "Input stream clk is changing\n");
-		return -EINVAL;
+		return false;
 	}
 
-	return 0;
+	return true;
 }
 
 void analogix_dp_set_video_cr_mn(struct analogix_dp_device *dp,
@@ -816,7 +816,7 @@ void analogix_dp_start_video(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 }
 
-int analogix_dp_is_video_stream_on(struct analogix_dp_device *dp)
+bool analogix_dp_is_video_stream_on(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
@@ -826,10 +826,10 @@ int analogix_dp_is_video_stream_on(struct analogix_dp_device *dp)
 	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 	if (!(reg & STRM_VALID)) {
 		dev_dbg(dp->dev, "Input video stream is not detected.\n");
-		return -EINVAL;
+		return false;
 	}
 
-	return 0;
+	return true;
 }
 
 void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp)
-- 
2.34.1

