Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C2EC44501
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3C210F424;
	Thu,  2 Jul 2026 14:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AUWvfFo9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B2210F418
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003613;
 bh=GZD6Fe+CXbV2SuqMa7njjRBNK1q0BccBT9KRXSuTGM4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AUWvfFo9YocastN+22NZydCLZ/QCu3FDglpatsnKPWFmIUTm1VO+kVjNgbj/7prp/
 7KGLPvycg71RY6b/+p1mSivg+mvvMSX+h5UvutBpwAugqIrZC9QxB9eerg6i2Jsio3
 peUSwt60C69sU0B4xi9pWeKFRQZFDJuFEnYBrnHbEp8bq2tXBXQV6WK/g0cRgT1uWm
 kMO9KFBUVbizgnkRZ0upJUbHnqYjZ9w+qRpnKNjOA1j2myzPvAe1veScCVx40fVNK8
 9e6CXhTn6ioQDUtFogkz/2MNpxQyxins6wl3TPrhvwcRbMfhazRgRhNhZhmPka6uDe
 wGPX0cjRszneQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 20C7E17E3666;
 Thu,  2 Jul 2026 16:46:53 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:42 +0300
Subject: [PATCH v8 29/39] drm/vc4: hdmi: Use common TMDS char rate
 constants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-29-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
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

Replace HDMI_14_MAX_TMDS_CLK defined locally with
HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ provided by linux/hdmi.h.  Note this
incorrectly referenced HDMI 1.4, as the 340 MHz maximum TMDS character
rate was actually introduced in HDMI 1.3.

Similarly, use HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ instead of the 600000000
magic number.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index e165f604939b..fbdb0448aa2b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -45,6 +45,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hdmi.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -113,8 +114,6 @@
 #define HSM_MIN_CLOCK_FREQ	120000000
 #define CEC_CLOCK_FREQ 40000
 
-#define HDMI_14_MAX_TMDS_CLK   (340 * 1000 * 1000)
-
 static bool vc4_hdmi_supports_scrambling(struct vc4_hdmi *vc4_hdmi)
 {
 	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
@@ -137,7 +136,7 @@ static bool vc4_hdmi_mode_needs_scrambling(const struct drm_display_mode *mode,
 {
 	unsigned long long clock = drm_hdmi_compute_mode_clock(mode, bpc, fmt);
 
-	return clock > HDMI_14_MAX_TMDS_CLK;
+	return clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
 }
 
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
@@ -1727,7 +1726,7 @@ vc4_hdmi_connector_clock_valid(const struct drm_connector *connector,
 	if (clock > vc4_hdmi->variant->max_pixel_clock)
 		return MODE_CLOCK_HIGH;
 
-	if (!vc4->hvs->vc5_hdmi_enable_hdmi_20 && clock > HDMI_14_MAX_TMDS_CLK)
+	if (!vc4->hvs->vc5_hdmi_enable_hdmi_20 && clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
 		return MODE_CLOCK_HIGH;
 
 	/* 4096x2160@60 is not reliable without overclocking core */
@@ -3253,7 +3252,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	 * vc4_hdmi_disable_scrambling() will thus run at boot, make
 	 * sure it's disabled, and avoid any inconsistency.
 	 */
-	if (variant->max_pixel_clock > HDMI_14_MAX_TMDS_CLK)
+	if (variant->max_pixel_clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
 		vc4_hdmi->scdc_enabled = true;
 
 	ret = variant->init_resources(drm, vc4_hdmi);
@@ -3383,7 +3382,7 @@ static const struct vc4_hdmi_variant bcm2711_hdmi0_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi0_regs",
 	.card_name		= "vc4-hdmi-0",
-	.max_pixel_clock	= 600000000,
+	.max_pixel_clock	= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc5_hdmi_hdmi0_fields,
 	.num_registers		= ARRAY_SIZE(vc5_hdmi_hdmi0_fields),
 	.phy_lane_mapping	= {
@@ -3412,7 +3411,7 @@ static const struct vc4_hdmi_variant bcm2711_hdmi1_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI1,
 	.debugfs_name		= "hdmi1_regs",
 	.card_name		= "vc4-hdmi-1",
-	.max_pixel_clock	= HDMI_14_MAX_TMDS_CLK,
+	.max_pixel_clock	= HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc5_hdmi_hdmi1_fields,
 	.num_registers		= ARRAY_SIZE(vc5_hdmi_hdmi1_fields),
 	.phy_lane_mapping	= {
@@ -3441,7 +3440,7 @@ static const struct vc4_hdmi_variant bcm2712_hdmi0_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi0_regs",
 	.card_name		= "vc4-hdmi-0",
-	.max_pixel_clock	= 600000000,
+	.max_pixel_clock	= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc6_hdmi_hdmi0_fields,
 	.num_registers		= ARRAY_SIZE(vc6_hdmi_hdmi0_fields),
 	.phy_lane_mapping	= {
@@ -3468,7 +3467,7 @@ static const struct vc4_hdmi_variant bcm2712_hdmi1_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI1,
 	.debugfs_name		= "hdmi1_regs",
 	.card_name		= "vc4-hdmi-1",
-	.max_pixel_clock	= 600000000,
+	.max_pixel_clock	= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc6_hdmi_hdmi1_fields,
 	.num_registers		= ARRAY_SIZE(vc6_hdmi_hdmi1_fields),
 	.phy_lane_mapping	= {

-- 
2.54.0

