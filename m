Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61115CDE003
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0990310EDDA;
	Wed, 24 Jun 2026 07:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jxjyygah";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E244B10EC5B
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:38:58 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so158306f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782243537; x=1782848337; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xi3F77gv3Dog6TTeJPtSgdEIuLjDDaKZJ2VGU5mi4ts=;
 b=jxjyygah2YqXHYxsed0I1gUAMDr2mTk8Efm27mH8tZBdFJHXxU6uGIh2WdRCzNzrJz
 TXgJCu/s21kYTuJrJFMkuK+21/x0OerXSFqaIPm6I0iAvduLAzYyNpZGNoLN5XLeNJBC
 95EQTssRttmMSMQy2f3lRp9PlPhmfnTPge5iVhMN1X2oD1USvLzuydNk3X692gVxr4Ry
 oYapLoxd4odkmxsWuoFgqEpk8Xmktngc1Dp2PjqsqVj0dGnbyauFidxK446iReJK4uSl
 0SwsYgiOZ8pC/RQzWOPAVtij9KScsm49w9dVzb8aQf1RnVgDMgBvKx4zge8+B8nTUtdy
 hZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782243537; x=1782848337;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xi3F77gv3Dog6TTeJPtSgdEIuLjDDaKZJ2VGU5mi4ts=;
 b=guALqO2BgT1A/qoQD/B9URuvtQeKFuc8RdAQfYZUNf9qRuOcANMHUCpGDcdR0JV1lx
 Jb/8ifInB7bYNW/+vgDaL83SH2GDgqFxHzRYbbLYKC6Yi0+Hjf+eLnTP7lDPAHxF4ARC
 BOqzT3tGTOubsZweC+HiEB/B+8RSlKsOigg1dYCpUsh5M0fNjR9YUmpC11EOwcjojdgA
 XRmrila0j/qOFoXjvziC9/bZuM01w+3t8Xgta5mXx7+PAszAAe05fntRaYCMO1lvFQFv
 hPcCpJqkf2QyhAF1GedhAzxczOJXy/yNVM1z0JfF5NlP/cNNbUKZ/ZiSEuDCuv6IcbNx
 RpAA==
X-Gm-Message-State: AOJu0Yyd+xk7AYnz715ZZO3v7pU+ZvZobl4czlaWLRdBua3pFik6oD07
 0yPWhxNO3t6ZywKSQ0kQ97WHJwz2qON0MZw620rpr/vNlIygRg0ZMPYX
X-Gm-Gg: AfdE7clLoQ4EZ5niWvMcqvc+8d9W9Z032tUEzfvJeSyHyMME84WFSO+kLHj7pS5cVmV
 bDlrkqj/IswM7hdyGWuytvKY61jQBxDrjUvEv2sV+wHHi0jjN7w0rPcz9ejoGTawkRAt/CymcWB
 IB7OtfsveuNimfE1yI7fAj58gDrnmtuXw4xGHB28xJ32kVEMmP7kKaCqNTB4y4GDVF4MxiXkvNI
 IEjZQhKAUZK7PelNJACi8LD0iFiRIMzr/PmTw/y4QeX1/bYpV2Wy8G0qjaCUBmh7pO4A0LSRIut
 /1iCvAc42YVU9Q73TryA+7Re7UOyNXWJKx2umS4ZsdHUXxmVNmS41ODqpnJXLC+Ra0gpNRZl39b
 Y7yovUSfugbCxgDitEAJ6UKeVAe4HTXLTyA5Xjov5uU8vvk2aZqkLwS4xwH4Oe4O/aVW4cC9zOr
 8nwezbAJcET0rSlw1Jfe7/APH1yrecCDw=
X-Received: by 2002:a05:6000:41c6:b0:45e:945b:276 with SMTP id
 ffacd0b85a97d-46c0bd7cb49mr317363f8f.20.1782243536803; 
 Tue, 23 Jun 2026 12:38:56 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579d4sm39418017f8f.28.2026.06.23.12.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:38:56 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 23 Jun 2026 21:38:33 +0200
Subject: [PATCH] drm/gma500: Remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-gma-drm-simple-v1-1-c404a5e62aab@gmail.com>
X-B4-Tracking: v=1; b=H4sIALjgOmoC/x3MQQqAIBBA0avErBswLYOuEi0sRxvICoUIxLsnL
 d/i/wyJIlOCqckQ6eHE11nRtQ1suzk9IdtqkEJqoaVCHwzaGDBxuA/CbSCt3NivnRZQozuS4/c
 fzkspHwm8NDxgAAAA
X-Change-ID: 20260623-gma-drm-simple-c5e63f74b160
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the dependency on drm simple helpers from gma500
DRM drivers.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_crt.c  |  9 +++++++--
 drivers/gpu/drm/gma500/cdv_intel_dp.c   |  9 +++++++--
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c | 10 +++++++---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c |  9 +++++++--
 drivers/gpu/drm/gma500/oaktrail_hdmi.c  |  9 +++++++--
 drivers/gpu/drm/gma500/oaktrail_lvds.c  |  9 +++++++--
 drivers/gpu/drm/gma500/psb_intel_lvds.c |  9 +++++++--
 7 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index 342a57c82846..e51a965ddeb8 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -29,8 +29,8 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "cdv_device.h"
 #include "intel_bios.h"
@@ -217,6 +217,10 @@ static int cdv_intel_crt_set_property(struct drm_connector *connector,
  * Routines for controlling stuff on the analog port
  */
 
+static const struct drm_encoder_funcs cdv_intel_crt_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs cdv_intel_crt_helper_funcs = {
 	.dpms = cdv_intel_crt_dpms,
 	.prepare = gma_encoder_prepare,
@@ -275,7 +279,8 @@ void cdv_intel_crt_init(struct drm_device *dev,
 		goto err_ddc_destroy;
 
 	encoder = &gma_encoder->base;
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
+	ret = drm_encoder_init(dev, encoder, &cdv_intel_crt_funcs,
+			       DRM_MODE_ENCODER_DAC, NULL);
 	if (ret)
 		goto err_connector_cleanup;
 
diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index fbed35cf7603..5bcbb2d2b837 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -33,9 +33,9 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "gma_display.h"
 #include "psb_drv.h"
@@ -1872,6 +1872,10 @@ cdv_intel_dp_destroy(struct drm_connector *connector)
 	kfree(gma_connector);
 }
 
+static const struct drm_encoder_funcs cdv_intel_dp_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs cdv_intel_dp_helper_funcs = {
 	.dpms = cdv_intel_dp_dpms,
 	.mode_fixup = cdv_intel_dp_mode_fixup,
@@ -1970,7 +1974,8 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 	encoder = &gma_encoder->base;
 
 	drm_connector_init(dev, connector, &cdv_intel_dp_connector_funcs, type);
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(dev, encoder, &cdv_intel_dp_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 
diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
index ce7850647778..757ff9408250 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
@@ -30,9 +30,9 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "cdv_device.h"
 #include "psb_drv.h"
@@ -251,6 +251,10 @@ static void cdv_hdmi_destroy(struct drm_connector *connector)
 	kfree(gma_connector);
 }
 
+static const struct drm_encoder_funcs cdv_hdmi_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs cdv_hdmi_helper_funcs = {
 	.dpms = cdv_hdmi_dpms,
 	.prepare = gma_encoder_prepare,
@@ -329,8 +333,8 @@ void cdv_hdmi_init(struct drm_device *dev,
 	if (ret)
 		goto err_ddc_destroy;
 
-	ret = drm_simple_encoder_init(dev, &gma_encoder->base,
-				      DRM_MODE_ENCODER_TMDS);
+	ret = drm_encoder_init(dev, &gma_encoder->base, &cdv_hdmi_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret)
 		goto err_connector_cleanup;
 
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index d7fd9a783cde..336ab411d699 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -13,9 +13,9 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "cdv_device.h"
 #include "intel_bios.h"
@@ -394,6 +394,10 @@ static int cdv_intel_lvds_set_property(struct drm_connector *connector,
 	return 0;
 }
 
+static const struct drm_encoder_funcs cdv_intel_lvds_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs
 					cdv_intel_lvds_helper_funcs = {
 	.dpms = cdv_intel_lvds_encoder_dpms,
@@ -535,7 +539,8 @@ void cdv_intel_lvds_init(struct drm_device *dev,
 	if (ret)
 		goto err_destroy_ddc;
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(dev, encoder, &cdv_intel_lvds_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret)
 		goto err_connector_cleanup;
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 403d21cbb3a2..5a6132176086 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -29,9 +29,9 @@
 #include <drm/drm.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "psb_drv.h"
 #include "psb_intel_drv.h"
@@ -605,6 +605,10 @@ static void oaktrail_hdmi_destroy(struct drm_connector *connector)
 	return;
 }
 
+static const struct drm_encoder_funcs oaktrail_hdmi_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs oaktrail_hdmi_helper_funcs = {
 	.dpms = oaktrail_hdmi_dpms,
 	.prepare = gma_encoder_prepare,
@@ -648,7 +652,8 @@ void oaktrail_hdmi_init(struct drm_device *dev,
 			   &oaktrail_hdmi_connector_funcs,
 			   DRM_MODE_CONNECTOR_DVID);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(dev, encoder, &oaktrail_hdmi_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index e194d0cce067..425796d8d6c3 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -12,9 +12,9 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "intel_bios.h"
 #include "power.h"
@@ -202,6 +202,10 @@ static void oaktrail_lvds_commit(struct drm_encoder *encoder)
 	oaktrail_lvds_set_power(dev, gma_encoder, true);
 }
 
+static const struct drm_encoder_funcs oaktrail_lvds_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs oaktrail_lvds_helper_funcs = {
 	.dpms = oaktrail_lvds_dpms,
 	.mode_fixup = psb_intel_lvds_mode_fixup,
@@ -319,7 +323,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
 	if (ret)
 		goto err_free_connector;
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(dev, encoder, &oaktrail_lvds_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret)
 		goto err_connector_cleanup;
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index 2ca164b21293..cd882786d946 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -12,9 +12,9 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "intel_bios.h"
 #include "power.h"
@@ -593,6 +593,10 @@ int psb_intel_lvds_set_property(struct drm_connector *connector,
 	return -1;
 }
 
+static const struct drm_encoder_funcs psb_intel_lvds_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs psb_intel_lvds_helper_funcs = {
 	.dpms = psb_intel_lvds_encoder_dpms,
 	.mode_fixup = psb_intel_lvds_mode_fixup,
@@ -679,7 +683,8 @@ void psb_intel_lvds_init(struct drm_device *dev,
 	if (ret)
 		goto err_ddc_destroy;
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(dev, encoder, &psb_intel_lvds_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret)
 		goto err_connector_cleanup;
 

---
base-commit: 60326b17f877e12846167bf8ef83680b9875218a
change-id: 20260623-gma-drm-simple-c5e63f74b160

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

