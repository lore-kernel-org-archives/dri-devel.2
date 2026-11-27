Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3EA606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=TGdAo/MR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDF310E29F;
	Fri, 27 Nov 2026 16:39:27 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8067112A82
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:39:20 +0000 (UTC)
Received: from abreu.molgen.mpg.de (g44.guest.molgen.mpg.de [141.14.220.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F7DA4C442F95C;
 Fri, 27 Nov 2026 17:38:02 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/i915/backlight: Honor panel backlight quirk for
 minimum brightness
Date: Fri, 27 Nov 2026 17:37:45 +0100
Message-ID: <20261127163752.54806-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127163752.54806-1-pmenzel@molgen.mpg.de>
References: <20261127163752.54806-1-pmenzel@molgen.mpg.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1795797483; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=cpuzMF203iBIm0LK/odzPtCekUJWNzPfkeHY5U9XYwI=; 
 b=TGdAo/MRmMZPqMlaFX9rZrKB44TvbUaMxMAFEIKFQhk33XF8z8f9TDsrNNEabYo9jVl9zrCDt8rT
 6MtGRC0sljTxhUgNr1qy9sNOjfOh5l/rMjcTZ9eDdX+mUDTbH6e8vENsilO4+DR4f0aCunNvwsTW2u
 RSzV17Sa2YOgrcptFNkLuMMAvf5Mhxb/T3Z8l6z3urbxlVlvZFWI0cpNxEaHZspayDRZRN69TR/dpI
 JZj+VEOSg2Vyf5pehVpa39NxImPj+r143ITdUgDitVzgk4DFgxYC+e956v8cPZq41YaRA4qgMAvcjy
 SKZXhyhXS44YHZycTsJyaHqXJVTSEcgQ==
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM panel backlight quirk table (drm_panel_backlight_quirks.c)
overrides the minimum PWM brightness per system and panel, but only
amdgpu consults it. i915 always takes the minimum from the VBT, so a
firmware minimum that is too high cannot be corrected without patching
the driver.

Look up the quirk with the panel’s EDID in get_backlight_min_vbt(), and
if it sets min_brightness, use it instead of the VBT value. Like the
VBT field, the quirk value is on the [0..255] scale, stored plus one so
that 0 means unset; amdgpu reads it the same way. The lookup covers all
PWM backends, as they all get their minimum from get_backlight_min_vbt().

Select DRM_PANEL_BACKLIGHT_QUIRKS for i915 and xe, which builds the
i915 display code as well.

Tested on hardware with GNOME 51 at its lowest brightness
(sysfs 960/96000):

- Dell XPS 13 9310, BIOS 3.17.0 (Sharp LQ134N1, SHP 0x14f9): v7.4-rc1 and
  v7.4-rc4 based kernels; PWM duty 6551 -> 960 (6.8 % -> 1 %).
- Dell XPS 9315, BIOS 1.26.0 (Sharp LQ134N1, SHP 0x1548): v7.4-rc4 + this
  series, Debian 7.3.5 config; duty 6551 -> 960.

     [CONNECTOR:676:eDP-1] Applying panel backlight quirk, min brightness 0/255 (VBT 15/255)".

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    
    Prepared with Claude Code (claude-opus-5-5).

 drivers/gpu/drm/i915/Kconfig                   |  1 +
 drivers/gpu/drm/i915/display/intel_backlight.c | 15 +++++++++++++++
 drivers/gpu/drm/xe/Kconfig                     |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 71426b9c91f00..c2075a4a48b8b 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -18,6 +18,7 @@ config DRM_I915
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
 	select DRM_PANEL
+	select DRM_PANEL_BACKLIGHT_QUIRKS
 	select DRM_MIPI_DSI
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
 	select RELAY
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index b128896cb1c2d..b0c0e7f3d6e24 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -10,6 +10,7 @@
 #include <acpi/video.h>
 
 #include <drm/drm_file.h>
+#include <drm/drm_panel_quirks.h>
 #include <drm/drm_print.h>
 #include <drm/intel/pci_config.h>
 
@@ -1207,10 +1208,24 @@ static u32 get_backlight_min_vbt(struct intel_connector *connector)
 {
 	struct intel_display *display = to_intel_display(connector);
 	struct intel_panel *panel = &connector->panel;
+	const struct drm_panel_backlight_quirk *quirk;
 	int min;
 
 	drm_WARN_ON(display->drm, panel->backlight.pwm_level_max == 0);
 
+	/* Quirk min_brightness is the minimum in [0..255] plus one, 0 = unset. */
+	quirk = drm_get_panel_backlight_quirk(IS_ERR(panel->fixed_edid) ?
+					      NULL : panel->fixed_edid);
+	if (!IS_ERR_OR_NULL(quirk) && quirk->min_brightness) {
+		min = quirk->min_brightness - 1;
+		drm_info(display->drm,
+			 "[CONNECTOR:%d:%s] Applying panel backlight quirk, min brightness %d/255 (VBT %d/255)\n",
+			 connector->base.base.id, connector->base.name,
+			 min, connector->panel.vbt.backlight.min_brightness);
+
+		return scale(min, 0, 255, 0, panel->backlight.pwm_level_max);
+	}
+
 	/*
 	 * XXX: If the vbt value is 255, it makes min equal to max, which leads
 	 * to problems. There are such machines out there. Either our
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 049d2f25d0e60..dab996c7d205d 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -16,6 +16,7 @@ config DRM_XE
 	select DRM_KMS_HELPER
 	select DRM_KUNIT_TEST_HELPERS if DRM_XE_KUNIT_TEST != n
 	select DRM_PANEL
+	select DRM_PANEL_BACKLIGHT_QUIRKS
 	select DRM_SUBALLOC_HELPER
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_DSC_HELPER
-- 
2.54.0

