Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89F9CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B090910E1BC;
	Thu,  1 Oct 2026 00:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="i9F8K0Wd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB4A10E1BC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790814420;
 bh=VZ3TAZNBxqqfdza/aL8Ylg5fv5lsNNMVwLTvIMhkWZw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=i9F8K0Wd0t7kK7zrxQtEl0+z0bPu6dwSdr9fodoU+zvYWxSqUGpqi+06QsAS4hc+u
 i0f10LGitEZfeFqZn4/qK/KIdUTn+F2uINo/FPsVl7p9Mgo6CHQYCXeKjBO2mv/YT/
 1XB0DmzdPz1afi0COmjyGpE/N3VHIBBLf0MF1U/II2kUI9IWHuw6r6t1SZVA+xVAN5
 wX14c8V7KVm/KAlAJy2hI9f/LQr5xnW8iRlEivLUZd8zMkY4Xpt5UircODhPFQUFvp
 bBhQOxNyTiLNsXEZNq+h+CxPR3AJ46nuNgTAyhrmKmC+jW9GENdPOCXDCkcA0VON8o
 0qEwwNepqDEcw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4094917E0B0F;
 Thu, 01 Oct 2026 02:27:00 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 01 Oct 2026 03:26:15 +0300
Subject: [PATCH 2/7] drm/vc4: hdmi: Switch to drm_hdmi_mode_needs_scrambling()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-vc4-common-scramb-v1-2-51280460194b@collabora.com>
References: <20261001-vc4-common-scramb-v1-0-51280460194b@collabora.com>
In-Reply-To: <20261001-vc4-common-scramb-v1-0-51280460194b@collabora.com>
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
index 8e4623ccc4f8..26c63ce2dc2f 100644
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
@@ -803,7 +795,7 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
 	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
 		return;
 
-	if (!vc4_hdmi_mode_needs_scrambling(mode,
+	if (!drm_hdmi_mode_needs_scrambling(mode,
 					    vc4_hdmi->output_bpc,
 					    vc4_hdmi->output_format))
 		return;

-- 
2.55.0

