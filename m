Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAE4C55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F03110F32C;
	Fri, 31 Jul 2026 16:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LP7UoA9X";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69CC10F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514784;
 bh=T57B2HIpxjOg2246T5ktjF/JgTCd4d9jWzrI7OnBqP0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LP7UoA9Xj4+0SCmFFy4slUzG9qksnmPdmhrc+bzX4b1fl+siK8bEPBcvSxVMlzahA
 xy/mcQ5TIqSvGUIVbnxnsbCAduq94oxpZPqv5LYQH9iVljwwGyA0Ig55Qi6uc0wj+P
 Pm9cD5dtEQJfQgG7nS82WFbX5VkqI+4ds+3xbr4OUMo9Eb7ZSgW1X6sojH7zog1xpa
 VNH/aktvWtNwhpP4JtWxa5AXyWFkbhOqjrbIe5hAXks/fjyRyn8+i445yrZwL5ZIxm
 7OvWCfQleS8eMUN1wPKcvlyjuUqe+zci5NN7iq/tt5upQJzj585ESM3B80lEgHYQq6
 7gLHueC2ZBlmQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B4A017E0936;
 Fri, 31 Jul 2026 18:19:44 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:48 +0300
Subject: [PATCH v10 41/69] drm/vc4: hdmi: Switch to
 drm_hdmi_mode_needs_scrambling()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-41-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
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

The VC4 HDMI driver has a local helper to check whether a mode requires
scrambling.  It is equivalent to drm_hdmi_mode_needs_scrambling(), so
use the common helper instead.

No functional change intended.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9ce56eca775c..4f7fc6689869 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -130,15 +130,6 @@ static bool vc4_hdmi_supports_scrambling(struct vc4_hdmi *vc4_hdmi)
 	return true;
 }
 
-static bool vc4_hdmi_mode_needs_scrambling(const struct drm_display_mode *mode,
-					   unsigned int bpc,
-					   enum drm_output_color_format fmt)
-{
-	unsigned long long clock = drm_hdmi_compute_mode_clock(mode, bpc, fmt);
-
-	return clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
-}
-
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_debugfs_entry *entry = m->private;
@@ -313,7 +304,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 		return 0;
 	}
 
-	scrambling_needed = vc4_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_adjusted_mode,
+	scrambling_needed = drm_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_adjusted_mode,
 							   vc4_hdmi->output_bpc,
 							   vc4_hdmi->output_format);
 	if (!scrambling_needed) {
@@ -443,7 +434,8 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 		const struct drm_display_mode *mode;
 
 		list_for_each_entry(mode, &connector->probed_modes, head) {
-			if (vc4_hdmi_mode_needs_scrambling(mode, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444)) {
+			if (drm_hdmi_mode_needs_scrambling(mode, 8,
+							   DRM_OUTPUT_COLOR_FORMAT_RGB444)) {
 				drm_warn_once(drm, "The core clock cannot reach frequencies high enough to support 4k @ 60Hz.");
 				drm_warn_once(drm, "Please change your config.txt file to add hdmi_enable_4kp60.");
 			}
@@ -802,7 +794,7 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
 	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
 		return;
 
-	if (!vc4_hdmi_mode_needs_scrambling(mode,
+	if (!drm_hdmi_mode_needs_scrambling(mode,
 					    vc4_hdmi->output_bpc,
 					    vc4_hdmi->output_format))
 		return;

-- 
2.55.0

