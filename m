Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F757CDB466
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DE310E694;
	Tue, 23 Jun 2026 02:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PTUTEg4W";
	dkim-atps=neutral
Received: from mail-m933.xmail.ntesmail.com (mail-m933.xmail.ntesmail.com
 [103.126.93.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C058F10E694
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 02:35:11 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 435bb4864;
 Tue, 23 Jun 2026 10:35:08 +0800 (GMT+08:00)
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
Subject: [PATCH v2] drm/bridge: analogix_dp: Fix PE/VS value shift mismatch
 during link training
Date: Tue, 23 Jun 2026 10:35:06 +0800
Message-Id: <20260623023506.309858-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ef254dce103a8kunme3595de73c2926
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHU0aVkNDTk1PHh9DSE1KGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=PTUTEg4Wag7+Rl/ucbOFVTDhjSjOwaZnVrUpPQOT8dFyNzvshwH0/DAl1J8mfvesCuefJEd4TXzhTzurBSM9R4ZQDyj0IfMXnC7XPf/Z3aoyHpN4QgHUe6M/NhUNpiYb9iArK68PyGCruX+r8+MfJotTZFGsyCVaal/hXrBomRE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=yzjgFgwzGUQuXS/L+ntcc2zWKIM+5JsR921qg53e0Lk=;
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

VS/PE values returned by drm_dp_get_adjust_request_voltage() and
drm_dp_get_adjust_request_pre_emphasis() are already encoded to their
native DPCD register bit positions. However, DPCD_VOLTAGE_SWING_SET /
DPCD_PRE_EMPHASIS_SET macros perform an extra internal shift. Feeding
the raw offset-bearing values directly leads to overlapping bitfields
and invalid lane training configuration, causing link training failures
and black screen.

Add right shift using DP_TRAIN_*_SHIFT constants to strip the DPCD bit
offsets before passing values to the SET macros and subsequent checks.
Apply this fix for both clock recovery and adjust training code paths.

Reported-by: Vicente Bergas <vicencb@gmail.com>
Closes: https://lore.kernel.org/all/CAAMcf8D-d+5n=H44KeKBSqWY42m+o32W+mO-r15VqWNyYhJL7Q@mail.gmail.com/
Fixes: d84b087c7662 ("drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted voltages and pre-emphasises")
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Fix the ambiguous descriptions in commit msg.
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 7a85774aaac1..1d39a354c3d9 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -309,7 +309,9 @@ static void analogix_dp_get_adjust_training_lane(struct analogix_dp_device *dp,
 	lane_count = dp->link_train.lane_count;
 	for (lane = 0; lane < lane_count; lane++) {
 		voltage_swing = drm_dp_get_adjust_request_voltage(link_status, lane);
+		voltage_swing >>= DP_TRAIN_VOLTAGE_SWING_SHIFT;
 		pre_emphasis = drm_dp_get_adjust_request_pre_emphasis(link_status, lane);
+		pre_emphasis >>= DP_TRAIN_PRE_EMPHASIS_SHIFT;
 		training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
 				DPCD_PRE_EMPHASIS_SET(pre_emphasis);
 
@@ -355,7 +357,9 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 	for (lane = 0; lane < lane_count; lane++) {
 		training_lane = analogix_dp_get_lane_link_training(dp, lane);
 		voltage_swing = drm_dp_get_adjust_request_voltage(link_status, lane);
+		voltage_swing >>= DP_TRAIN_VOLTAGE_SWING_SHIFT;
 		pre_emphasis = drm_dp_get_adjust_request_pre_emphasis(link_status, lane);
+		pre_emphasis >>= DP_TRAIN_PRE_EMPHASIS_SHIFT;
 
 		if (DPCD_VOLTAGE_SWING_GET(training_lane) == voltage_swing &&
 		    DPCD_PRE_EMPHASIS_GET(training_lane) == pre_emphasis)
-- 
2.34.1

