Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94098CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9AB510F3CE;
	Mon, 12 Oct 2026 22:38:40 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2988F10F3D4
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791844704;
 bh=LAIR5aBqKu1Zb2wOdOKDE+JwgF+ffZH9cyeFXr6LID8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fLOsIsdsBC8d/av+U4z3gw1jtMG/Ul9s7Y9+hCVPNYVN55YYfuuuhyST0NOAZOiYl
 TSZDwFubX/wapGHW5fRma7kogvGPWyig38BkmdIztNOfel5rYwqityY7dW/pG06xnB
 PDNvuXQN/KiHUj/m67ooxZX4drAwGpbNAHSc8E9bL0UxG8fNRMla2S34jf1QxvQwma
 DusV6UE0ySg26phPksVJbArRm4sxngpzmsbkaiZ8UiQJ3OzpipB0BQIGn+PhpKLjcn
 sNi1xPWqOBF6LsKgbuEqAejx43cZyw5lG+S2sZ648NHvDoFQYg033uNc2H53gH9DUX
 D8jP8NRJq70yw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B09317E0D7E;
 Tue, 13 Oct 2026 00:38:24 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 13 Oct 2026 01:37:48 +0300
Subject: [PATCH v2 8/8] drm/vc4: hdmi: Defer pixel clock validation to HDMI
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-vc4-common-scramb-v2-8-a41d15e131ad@collabora.com>
References: <20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com>
In-Reply-To: <20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

drmm_connector_hdmi_init() now derives the maximum TMDS character rate
from the supported HDMI version, and
drm_atomic_helper_connector_hdmi_check() rejects modes exceeding it
before invoking the driver's .tmds_char_rate_valid() hook.

Since each of the chip variants reports a supported HDMI version
matching its hardware limit, the max_pixel_clock check in
vc4_hdmi_connector_clock_valid() is redundant.  Drop it together with
the max_pixel_clock field of struct vc4_hdmi_variant.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 ---------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 11414025fe7b..ca8712b49ffb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1529,12 +1529,8 @@ vc4_hdmi_connector_clock_valid(const struct drm_connector *connector,
 			       const struct drm_display_mode *mode,
 			       unsigned long long clock)
 {
-	const struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
 	struct vc4_dev *vc4 = to_vc4_dev(connector->dev);
 
-	if (clock > vc4_hdmi->variant->max_pixel_clock)
-		return MODE_CLOCK_HIGH;
-
 	if (!vc4->hvs->vc5_hdmi_enable_hdmi_20 && clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
 		return MODE_CLOCK_HIGH;
 
@@ -3185,7 +3181,6 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi_regs",
 	.card_name		= "vc4-hdmi",
-	.max_pixel_clock	= HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
@@ -3205,7 +3200,6 @@ static const struct vc4_hdmi_variant bcm2711_hdmi0_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi0_regs",
 	.card_name		= "vc4-hdmi-0",
-	.max_pixel_clock	= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc5_hdmi_hdmi0_fields,
 	.num_registers		= ARRAY_SIZE(vc5_hdmi_hdmi0_fields),
 	.phy_lane_mapping	= {
@@ -3234,7 +3228,6 @@ static const struct vc4_hdmi_variant bcm2711_hdmi1_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI1,
 	.debugfs_name		= "hdmi1_regs",
 	.card_name		= "vc4-hdmi-1",
-	.max_pixel_clock	= HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc5_hdmi_hdmi1_fields,
 	.num_registers		= ARRAY_SIZE(vc5_hdmi_hdmi1_fields),
 	.phy_lane_mapping	= {
@@ -3263,7 +3256,6 @@ static const struct vc4_hdmi_variant bcm2712_hdmi0_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi0_regs",
 	.card_name		= "vc4-hdmi-0",
-	.max_pixel_clock	= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc6_hdmi_hdmi0_fields,
 	.num_registers		= ARRAY_SIZE(vc6_hdmi_hdmi0_fields),
 	.phy_lane_mapping	= {
@@ -3290,7 +3282,6 @@ static const struct vc4_hdmi_variant bcm2712_hdmi1_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI1,
 	.debugfs_name		= "hdmi1_regs",
 	.card_name		= "vc4-hdmi-1",
-	.max_pixel_clock	= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc6_hdmi_hdmi1_fields,
 	.num_registers		= ARRAY_SIZE(vc6_hdmi_hdmi1_fields),
 	.phy_lane_mapping	= {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index f6159c9e6144..61486e7b4ba2 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -29,9 +29,6 @@ struct vc4_hdmi_variant {
 	/* Filename to expose the registers in debugfs */
 	const char *debugfs_name;
 
-	/* Maximum pixel clock supported by the controller (in Hz) */
-	unsigned long long max_pixel_clock;
-
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 

-- 
2.55.0

