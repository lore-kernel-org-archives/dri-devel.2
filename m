Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0595ACD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02FD113DB9;
	Thu,  4 Jun 2026 08:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ISOkaqn3";
	dkim-atps=neutral
Received: from mail-m9326.xmail.ntesmail.com (mail-m9326.xmail.ntesmail.com
 [103.126.93.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6005F113DB9
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 08:53:20 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 410f6c9da;
 Thu, 4 Jun 2026 16:53:16 +0800 (GMT+08:00)
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
Subject: [PATCH v5 2/4] drm/dp: Add helper to validate DP lane counts
Date: Thu,  4 Jun 2026 16:52:18 +0800
Message-Id: <20260604085220.2862986-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604085220.2862986-1-damon.ding@rock-chips.com>
References: <20260604085220.2862986-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e91d63bbd03a8kunm52a01cd0409908
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTktCVhkdGh1DGE4YQkoaTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=ISOkaqn33xDGR1+G5j0ZVei2/HBuEVAzaVlXIYZNFH8pjcu3U5DesmPqPNH3xI8kRkuc9lksYWo2zhgHIGxFzozvq2/jyGOz45rHazQTFzXJs0heJ4v4QmH9QEv9GZMb08zLj5fMOMQkzCO4W6QdTmohhmv5cMekmME4J1EyPEI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=9dIv0NNIoT30XW+12t9f4ox/v0SxbNDGY/P6QADqWYk=;
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

Add a generic helper function drm_dp_lane_count_is_valid() to check
if a DisplayPort lane count is valid. According to the DP specification,
only 1, 2, or 4 lanes are supported.

This helper avoids duplicating DP lane count validation logic across
individual DisplayPort drivers.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 include/drm/display/drm_dp_helper.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 8c2d77a032f0..c904cb480d84 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -138,6 +138,12 @@ bool drm_dp_as_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_C
 
 int drm_dp_psr_setup_time(const u8 psr_cap[EDP_PSR_RECEIVER_CAP_SIZE]);
 
+static inline bool
+drm_dp_lane_count_is_valid(int lane_count)
+{
+	return lane_count == 1 || lane_count == 2 || lane_count == 4;
+}
+
 static inline int
 drm_dp_max_link_rate(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
-- 
2.34.1

