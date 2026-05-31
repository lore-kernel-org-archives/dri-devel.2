Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B7CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A110112AEE;
	Sun, 31 May 2026 11:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QePbd8ux";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06942112AEC;
 Sun, 31 May 2026 11:49:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E460D43BA6;
 Sun, 31 May 2026 11:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2951F00899;
 Sun, 31 May 2026 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228160;
 bh=CcLw2xrA7d/rhgSuQdOu3mO9lNkWZtB/cXxj8gAKDVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QePbd8uxdPB87nFmPiqImv6C9ianuvp3aqFBoec4LkiglHg6f+7TZn5sUDdWxmg0e
 JcZRHzmN8hfnj+AHjiVeDvsS5rxFoBDDQDglTNE0EShwhFJK32IQVTjmVhaIuHf0mg
 9fIwWqccY1rNS6179YcA6vUzhObMFiEB2D183WkkdeC1QXgFcJNNocMK5YLw/w/OVO
 thKemPEAEYK6icAxx8r/TIoK9Pd9lmQYKux3eidTambK4zMbcE378H+Huu0zJt0Ts0
 8zvINM55yHUa1FH0W90IIKzU249V98qgjwKVqQDdznTO+XuH0GlchbkSXK/vupEFvu
 ctoh+vQxrGPNw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 08/11] drm/amd/display: use drm backlight
Date: Sun, 31 May 2026 06:49:05 -0500
Message-ID: <20260531114908.1693426-9-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531114908.1693426-1-superm1@kernel.org>
References: <20260531114908.1693426-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Convert AMD display driver to use the new DRM backlight infrastructure.
This allows brightness control via DRM connector properties.

Includes fixes for backlight resource lifecycle management.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f6610902eee4..55c3838f7ec8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -86,6 +86,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_fourcc.h>
@@ -5549,6 +5550,15 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		dm->actual_brightness[aconnector->bl_idx] = real_brightness;
 		dm->brightness[aconnector->bl_idx] = real_brightness;
 	}
+
+	/* Link the registered backlight device to the DRM connector. If
+	 * drm_backlight_alloc() failed earlier in init_helper,
+	 * aconnector->base.backlight is NULL and drm_backlight_link() is a
+	 * no-op.
+	 */
+	drm_backlight_link(aconnector->base.backlight,
+			   dm->backlight_dev[aconnector->bl_idx]);
+
 	drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
 
 	return 0;
@@ -7993,6 +8003,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	}
 
 	if (aconnector->bl_idx != -1) {
+		drm_backlight_link(aconnector->base.backlight, NULL);
 		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	}
@@ -8005,6 +8016,10 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	aconnector->dc_sink = NULL;
 
 	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
+	/* DRM core will handle drm_backlight cleanup via:
+	 * drm_connector_unregister() -> drm_backlight_unregister()
+	 * drm_connector_cleanup() -> drm_backlight_free()
+	 */
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 	kfree(aconnector->dm_dp_aux.aux.name);
@@ -9254,6 +9269,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->base.state->max_bpc = 16;
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
 
+	if (connector_type == DRM_MODE_CONNECTOR_eDP) {
+		int r = drm_backlight_alloc(&aconnector->base);
+
+		if (r)
+			drm_err(dm->ddev, "Failed to allocate backlight: %d\n", r);
+	}
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		/* Content Type is currently only implemented for HDMI. */
 		drm_connector_attach_content_type_property(&aconnector->base);
-- 
2.54.0

