Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAB2CD5BD1
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D9D112AFD;
	Sun, 31 May 2026 11:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S0sIwwim";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8774E112AED;
 Sun, 31 May 2026 11:49:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B84A60123;
 Sun, 31 May 2026 11:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC581F00893;
 Sun, 31 May 2026 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228162;
 bh=s/yReg27q7GRpv9v5w8P9RnJc9ups0mYVC6jBC5ZC6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S0sIwwimF8pFh2usvlucQ/LJDBneh6T1HhCPEGU82bUIq3ozw1JyS86Mua63/z8j3
 8/eOI8coHcWGabj8XKmSo7C1xdD9tGGAElPHxh0JP31F5AwtSxcT1d5jOn+wCFfY7R
 3OmkLiSEgM5aKICOQm3t9oc/PQi9BgEZHRJSUKIa1XBynaKHIqZOgkdABttVP9UuL4
 ur5l/7R/khNz+AISaD5JqgQaAy1KGsxTbzqbvlIcpI3cOPCSWwTFA3nchJsCESoqmt
 1exe0coQAk8jrHHgZMdp04AwtIh2JaW0+SNrIrWUZGD3SNOlFk0+kFVpzVBebwDtBH
 xDqBa1jux88tA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 11/11] drm/i915/display: use drm backlight
Date: Sun, 31 May 2026 06:49:08 -0500
Message-ID: <20260531114908.1693426-12-superm1@kernel.org>
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

Convert Intel display drivers (i915 and xe) to use the new DRM backlight
infrastructure. This allows brightness control via DRM connector
properties.

Allocate DRM backlight for eDP connectors during initialization, link the
backlight device to the connector during registration, and unlink during
unregistration.

Assisted-by: Sonnet:4
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * New patch
---
 drivers/gpu/drm/i915/display/intel_backlight.c | 4 ++++
 drivers/gpu/drm/i915/display/intel_dp.c        | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 34e95f05936e..99ae39dfb7bb 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/string_helpers.h>
 #include <acpi/video.h>
 
+#include <drm/drm_backlight.h>
 #include <drm/drm_file.h>
 #include <drm/drm_print.h>
 
@@ -1004,6 +1005,8 @@ int intel_backlight_device_register(struct intel_connector *connector)
 		    "[CONNECTOR:%d:%s] backlight device %s registered\n",
 		    connector->base.base.id, connector->base.name, name);
 
+	drm_backlight_link(connector->base.backlight, bd);
+
 out:
 	kfree(name);
 
@@ -1015,6 +1018,7 @@ void intel_backlight_device_unregister(struct intel_connector *connector)
 	struct intel_panel *panel = &connector->panel;
 
 	if (panel->backlight.device) {
+		drm_backlight_link(connector->base.backlight, NULL);
 		backlight_device_unregister(panel->backlight.device);
 		panel->backlight.device = NULL;
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6ef2a0043cda..109f85dc6b89 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -44,6 +44,7 @@
 #include <drm/display/drm_dsc_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
@@ -7222,6 +7223,13 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 				    type, &intel_dp->aux.ddc);
 	drm_connector_helper_add(&connector->base, &intel_dp_connector_helper_funcs);
 
+	if (type == DRM_MODE_CONNECTOR_eDP) {
+		int r = drm_backlight_alloc(&connector->base);
+
+		if (r)
+			drm_err(display->drm, "Failed to allocate backlight: %d\n", r);
+	}
+
 	if (!HAS_GMCH(display) && DISPLAY_VER(display) < 12)
 		connector->base.interlace_allowed = true;
 
-- 
2.54.0

