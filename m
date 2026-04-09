Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D17CF364A8
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8510D10E82C;
	Thu,  9 Apr 2026 17:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OcWU6p4E";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF40410E82E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:09:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A90004E429AA;
 Thu,  9 Apr 2026 17:09:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7B402603E4;
 Thu,  9 Apr 2026 17:09:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4A52E104501A3; 
 Thu,  9 Apr 2026 19:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775754545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PUrev3OwtF7+aQkaLQNcxHy9DAd6gNcwgyZHwoDRdgs=;
 b=OcWU6p4Eq4OVCUQGSq0OR24F3SV9U9aoJdhjwYfqGnATABnWmw3hYwQNxsrBWr7LFEN0wY
 +zjRqf2kiNbPo/mU9nW61kDj5CwC7jaSAc5Gy3rkPy5Fj6M7a6/HMc++qZJDBCIVp5SsPv
 dJE7aBu08Dc+AWujlXmml9BdfZqEFleNP2qMh7AKwPjvG6avstJ/DraY1cnCzO32nFb0hm
 MbWiVfy6jfzGcJ3GtebCNIHq3TMe8Qh8ej8R1eIvUEP/2XYnx7UGtypJKwFS4d41ddVztJ
 uP4X8e1sExgc0UDbrUrd84ESpva7V1NRlz9nbV2ut6fF2cmdpdkXxjNkFsekMA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Apr 2026 19:08:20 +0200
Subject: [PATCH RFC 04/12] drm/i915/display: Switch to
 drmm_mode_config_init() and drop manual cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-feat_link_cap-v1-4-7069e8199ce2@bootlin.com>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
In-Reply-To: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3
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

Replace drm_mode_config_init() with drmm_mode_config_init() in
intel_mode_config_init(). The managed variant automatically registers
drm_mode_config_cleanup() with devres, so drivers must no longer call it
directly.

Since intel_mode_config_cleanup() was solely a wrapper combining
intel_atomic_global_obj_cleanup() and drm_mode_config_cleanup(), and the
latter is now handled by DRM core, remove it entirely. Instead, register
intel_atomic_global_obj_cleanup() as a devres action so it still runs just
before drm_mode_config_cleanup() during teardown, preserving the correct
cleanup ordering.

Change intel_mode_config_init() to return int to propagate any error from
drmm_mode_config_init().

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 .../gpu/drm/i915/display/intel_display_driver.c    | 37 ++++++++++++++--------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 23bfecc983e8d..d02393053cef4 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -12,6 +12,7 @@
 #include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_client_event.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_privacy_screen_consumer.h>
 #include <drm/drm_print.h>
@@ -48,6 +49,7 @@
 #include "intel_fbdev.h"
 #include "intel_fdi.h"
 #include "intel_flipq.h"
+#include "intel_global_state.h"
 #include "intel_gmbus.h"
 #include "intel_hdcp.h"
 #include "intel_hotplug.h"
@@ -111,13 +113,28 @@ static const struct drm_mode_config_helper_funcs intel_mode_config_funcs = {
 	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,
 };
 
-static void intel_mode_config_init(struct intel_display *display)
+static void intel_atomic_global_obj_cleanup_action(struct drm_device *drm, void *data)
+{
+	intel_atomic_global_obj_cleanup((struct intel_display *)data);
+}
+
+static int intel_mode_config_init(struct intel_display *display)
 {
 	struct drm_mode_config *mode_config = &display->drm->mode_config;
+	int ret;
+
+	ret = drmm_mode_config_init(display->drm);
+	if (ret)
+		return ret;
 
-	drm_mode_config_init(display->drm);
 	INIT_LIST_HEAD(&display->global.obj_list);
 
+	ret = drmm_add_action_or_reset(display->drm,
+				       intel_atomic_global_obj_cleanup_action,
+				       display);
+	if (ret)
+		return ret;
+
 	mode_config->min_width = 0;
 	mode_config->min_height = 0;
 
@@ -148,12 +165,8 @@ static void intel_mode_config_init(struct intel_display *display)
 	}
 
 	intel_cursor_mode_config_init(display);
-}
 
-static void intel_mode_config_cleanup(struct intel_display *display)
-{
-	intel_atomic_global_obj_cleanup(display);
-	drm_mode_config_cleanup(display->drm);
+	return 0;
 }
 
 static void intel_plane_possible_crtcs_init(struct intel_display *display)
@@ -255,7 +268,9 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 
 	intel_dmc_init(display);
 
-	intel_mode_config_init(display);
+	ret = intel_mode_config_init(display);
+	if (ret)
+		goto cleanup_wq_unordered;
 
 	ret = intel_cdclk_init(display);
 	if (ret)
@@ -456,7 +471,7 @@ int intel_display_driver_probe_nogem(struct intel_display *display)
 
 	ret = intel_crtc_init(display);
 	if (ret)
-		goto err_mode_config;
+		return ret;
 
 	intel_plane_possible_crtcs_init(display);
 	intel_dpll_init(display);
@@ -497,8 +512,6 @@ int intel_display_driver_probe_nogem(struct intel_display *display)
 
 err_hdcp:
 	intel_hdcp_component_fini(display);
-err_mode_config:
-	intel_mode_config_cleanup(display);
 
 	return ret;
 }
@@ -618,8 +631,6 @@ void intel_display_driver_remove_noirq(struct intel_display *display)
 
 	intel_hdcp_component_fini(display);
 
-	intel_mode_config_cleanup(display);
-
 	intel_dp_tunnel_mgr_cleanup(display);
 
 	intel_overlay_cleanup(display);

-- 
2.43.0

