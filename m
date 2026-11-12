Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DU5NPOfl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=h1TiKEpu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DU5NPOfl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=h1TiKEpu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D4F1120D3;
	Thu, 12 Nov 2026 12:51:05 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D57B1120D3;
 Thu, 12 Nov 2026 12:50:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C807A1F388;
 Thu, 12 Nov 2026 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794487847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=di6aAK1BtRBaMYUj8C1hi651X8uFz2jRN98+jtNkUUQ=;
 b=DU5NPOflpvDEviNHAzyAHOsCDrelKqV4kWFJP31wAo3mcPt6tf2OjyL/CmmZjMvgQxcDsS
 IRBw99dTEZo0dx7zPP6+CQoZowmfaH7VtJcsULg3yrtF9++famQPaFyUTS8yEUsbpQ5Cs9
 ZaXPNsy3Vp1wbOIDS+gHZWh4GtF4q1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794487847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=di6aAK1BtRBaMYUj8C1hi651X8uFz2jRN98+jtNkUUQ=;
 b=h1TiKEpuq+hhh/+LCxBlC1EZTQXVebsx8BGD7RHgGPejK30Cdz6Gna+ZCbO5OxpRrs+yKZ
 TgQMphZYNCKYwJBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794487847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=di6aAK1BtRBaMYUj8C1hi651X8uFz2jRN98+jtNkUUQ=;
 b=DU5NPOflpvDEviNHAzyAHOsCDrelKqV4kWFJP31wAo3mcPt6tf2OjyL/CmmZjMvgQxcDsS
 IRBw99dTEZo0dx7zPP6+CQoZowmfaH7VtJcsULg3yrtF9++famQPaFyUTS8yEUsbpQ5Cs9
 ZaXPNsy3Vp1wbOIDS+gHZWh4GtF4q1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794487847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=di6aAK1BtRBaMYUj8C1hi651X8uFz2jRN98+jtNkUUQ=;
 b=h1TiKEpuq+hhh/+LCxBlC1EZTQXVebsx8BGD7RHgGPejK30Cdz6Gna+ZCbO5OxpRrs+yKZ
 TgQMphZYNCKYwJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C6D2134F4;
 Thu, 12 Nov 2026 12:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +57mLya29WrBWgAAD6G6ig:T2
 (envelope-from <tzimmermann@suse.de>); Thu, 12 Nov 2026 12:50:47 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/2] drm/radeon: Inline drm_crtc_init()
Date: Thu, 12 Nov 2026 13:45:08 +0100
Message-ID: <20261112125039.66082-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112125039.66082-1-tzimmermann@suse.de>
References: <20261112125039.66082-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -11.80
X-Spam-Level: 
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Inline drm_crtc_init() into radeon CRTC initialization. The helper is
only used by drivers for AMD hardware to implement legacy mode setting.

As in drm_crtc_init(), create a primary plane for the CRTC. Use the same
formats as with drm_crtc_init(). Format modifiers are still marked as
unsupported and handled internally by the plane. For the CRTC, call
drm_crtc_init_with_planes() for initialization. Clean up on errors.

Radeon does not support DRM panic helpers. Therefore do not initialize
the primary plane's panic-helper callbacks.

v2:
- add missing formats for primary plane

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 61 ++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aac6733ddd82..1a03c641d72f 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -38,6 +38,7 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
+#include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/radeon_drm.h>
@@ -47,6 +48,31 @@
 #include "radeon.h"
 #include "radeon_kms.h"
 
+static const u32 radeon_primary_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_ARGB2101010,
+	DRM_FORMAT_BGRX1010102,
+	DRM_FORMAT_BGRA1010102,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_BGRX5551,
+	DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_XRGB4444,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_C8,
+};
+
+static const struct drm_plane_funcs radeon_primary_plane_funcs = {
+	.update_plane = drm_plane_helper_update_primary,
+	.disable_plane = drm_plane_helper_disable_primary,
+	.destroy = drm_plane_helper_destroy,
+};
+
 static void avivo_crtc_load_lut(struct drm_crtc *crtc)
 {
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
@@ -680,20 +706,31 @@ static const struct drm_crtc_funcs radeon_crtc_funcs = {
 static void radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
+	struct drm_plane *primary;
 	struct radeon_crtc *radeon_crtc;
+	int ret;
 
-	radeon_crtc = kzalloc_obj(*radeon_crtc);
-	if (radeon_crtc == NULL)
+	primary = __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
+					      &radeon_primary_plane_funcs,
+					      radeon_primary_plane_formats,
+					      ARRAY_SIZE(radeon_primary_plane_formats),
+					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(primary))
 		return;
 
+	radeon_crtc = kzalloc_obj(*radeon_crtc);
+	if (!radeon_crtc)
+		goto err_drm_plane_cleanup;
+
 	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc",
 						  WQ_HIGHPRI | WQ_PERCPU, 0);
-	if (!radeon_crtc->flip_queue) {
-		kfree(radeon_crtc);
-		return;
-	}
+	if (!radeon_crtc->flip_queue)
+		goto err_kfree;
 
-	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
+	ret = drm_crtc_init_with_planes(dev, &radeon_crtc->base, primary, NULL,
+					&radeon_crtc_funcs, NULL);
+	if (ret)
+		goto err_destroy_workqueue;
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
@@ -713,6 +750,16 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
 		radeon_legacy_init_crtc(dev, radeon_crtc);
+
+	return;
+
+err_destroy_workqueue:
+	destroy_workqueue(radeon_crtc->flip_queue);
+err_kfree:
+	kfree(radeon_crtc);
+err_drm_plane_cleanup:
+	drm_plane_cleanup(primary);
+	kfree(primary);
 }
 
 static const char *encoder_names[38] = {
-- 
2.56.0

