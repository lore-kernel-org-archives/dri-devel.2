Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADB3C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5857E10EFCB;
	Wed, 23 Sep 2026 11:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="oiRrHK+C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="luhlt1sm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YecCcbCC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4X0Xrs7c";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DB610EFB1;
 Wed, 23 Sep 2026 11:06:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 686FC21D30;
 Wed, 23 Sep 2026 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790161546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1It3FSjuRcVyjIsOIw0Z1T0tf5vC/JVqner4HFLakPY=;
 b=oiRrHK+CbKT0xKCxL5gPLQfHJ+V7qAtEc5TSDqI3Ne+8A/jb2mpPcdczVfnM7H72S8xxbP
 uj1UPe9M3yiJ8PtZ6jW5Tvp48/M/HkAnzXD5yp2Gpzat3gXp1EEjusuIskOC18qNLSOla5
 YI8pXKV7I7O7uQNWMPxibFdPr85Al8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790161546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1It3FSjuRcVyjIsOIw0Z1T0tf5vC/JVqner4HFLakPY=;
 b=luhlt1smwWeQMYvkkb1DqmGGjzmJsVDTfXyn+LqJ9vU7YMeJN3WPVA0w/4Rgl7AfQbtSzF
 HPvDbiDji0CavXDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790161542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1It3FSjuRcVyjIsOIw0Z1T0tf5vC/JVqner4HFLakPY=;
 b=YecCcbCCuvSnVo99i56Z109IC3RhCOMu+5w+HjMHoihI1cwhcl/WSnKi9lZZwIMrOiE9IN
 zR1v7dXxX3RtXRL/5Tg2MaeKlbrp73yGM3dgKWR/pmbXyP7zczXpv6bYUiptkZhfzh9sLP
 n7L9DQ3fL5alSB42vyGMO4QeJraDPz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790161542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1It3FSjuRcVyjIsOIw0Z1T0tf5vC/JVqner4HFLakPY=;
 b=4X0Xrs7cQOT8RfOyanQYnDNMC4oALPHRSSF1N4q1DFSUyC+tw86d5I07+XgFJfnJv6i8tF
 wrVx2fvzTTNizzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF2413A6A;
 Wed, 23 Sep 2026 11:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VCF1C4Wys2qeBAAAD6G6ig:T2
 (envelope-from <tzimmermann@suse.de>); Wed, 23 Sep 2026 11:05:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm/fbdev: Move fbdev module parameters next to module
 init
Date: Wed, 23 Sep 2026 12:59:09 +0200
Message-ID: <20260923110537.451614-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923110537.451614-1-tzimmermann@suse.de>
References: <20260923110537.451614-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Define the parameters for fbdev emulation in the source file with the
module-initialization and exit code of drm_kms_helper.ko. The parameters
control some aspects of DRM's fbdev emulation. Common usage looks like

  drm_kms_helper.drm_fbdev_overalloc=200

on the kernel's command line. This has been possible for many years
and changing it would likely upset users.

The emulation code is supposed to be moved into the module for DRM
clients. Keeping the parameters in drm_kms_helper.ko avoids breaking
systems the use them in the way described above.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_crtc_helper_internal.h |  9 +++++
 drivers/gpu/drm/drm_fb_helper.c            | 32 +-----------------
 drivers/gpu/drm/drm_kms_helper_common.c    | 39 ++++++++++++++++++++++
 3 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper_internal.h b/drivers/gpu/drm/drm_crtc_helper_internal.h
index bae73936acf9..adcc9a2e24ee 100644
--- a/drivers/gpu/drm/drm_crtc_helper_internal.h
+++ b/drivers/gpu/drm/drm_crtc_helper_internal.h
@@ -29,6 +29,8 @@
 #ifndef __DRM_CRTC_HELPER_INTERNAL_H__
 #define __DRM_CRTC_HELPER_INTERNAL_H__
 
+#include <linux/types.h>
+
 enum drm_mode_status;
 struct drm_connector;
 struct drm_crtc;
@@ -36,6 +38,13 @@ struct drm_display_mode;
 struct drm_encoder;
 struct drm_modeset_acquire_ctx;
 
+/* drm_kms_helper_common.c */
+#if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
+extern bool drm_fbdev_emulation;
+extern int drm_fbdev_overalloc;
+extern bool drm_leak_fbdev_smem;
+#endif
+
 /* drm_probe_helper.c */
 enum drm_mode_status drm_crtc_mode_valid(struct drm_crtc *crtc,
 					 const struct drm_display_mode *mode);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d4664ed468b2..76195410db60 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -43,39 +43,9 @@
 #include <drm/drm_vblank.h>
 
 #include "drm_internal.h"
+#include "drm_crtc_helper_internal.h"
 #include "drm_crtc_internal.h"
 
-static bool drm_fbdev_emulation = true;
-module_param_named(fbdev_emulation, drm_fbdev_emulation, bool, 0600);
-MODULE_PARM_DESC(fbdev_emulation,
-		 "Enable legacy fbdev emulation [default=true]");
-
-static int drm_fbdev_overalloc = CONFIG_DRM_FBDEV_OVERALLOC;
-module_param(drm_fbdev_overalloc, int, 0444);
-MODULE_PARM_DESC(drm_fbdev_overalloc,
-		 "Overallocation of the fbdev buffer (%) [default="
-		 __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");
-
-/*
- * In order to keep user-space compatibility, we want in certain use-cases
- * to keep leaking the fbdev physical address to the user-space program
- * handling the fbdev buffer.
- *
- * This is a bad habit, essentially kept to support closed-source OpenGL
- * drivers that should really be moved into open-source upstream projects
- * instead of using legacy physical addresses in user space to communicate
- * with other out-of-tree kernel modules.
- *
- * This module_param *should* be removed as soon as possible and be
- * considered as a broken and legacy behaviour from a modern fbdev device.
- */
-static bool drm_leak_fbdev_smem;
-#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
-module_param_unsafe(drm_leak_fbdev_smem, bool, 0600);
-MODULE_PARM_DESC(drm_leak_fbdev_smem,
-		 "Allow unsafe leaking fbdev physical smem address [default=false]");
-#endif
-
 /**
  * DOC: fbdev helpers
  *
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index b5d5b469b444..1e55ecac4698 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -25,10 +25,49 @@
  *
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 
+#include "drm_crtc_helper_internal.h"
 #include "drm_panic_internal.h"
 
+#if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
+bool drm_fbdev_emulation = true;
+EXPORT_SYMBOL(drm_fbdev_emulation);
+module_param_named(fbdev_emulation, drm_fbdev_emulation, bool, 0600);
+MODULE_PARM_DESC(fbdev_emulation, "Enable legacy fbdev emulation [default=true]");
+
+int drm_fbdev_overalloc = CONFIG_DRM_FBDEV_OVERALLOC;
+EXPORT_SYMBOL(drm_fbdev_overalloc);
+module_param(drm_fbdev_overalloc, int, 0444);
+MODULE_PARM_DESC(drm_fbdev_overalloc,
+		 "Overallocation of the fbdev buffer (%) [default="
+		 __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");
+
+/*
+ * In order to keep user-space compatibility, we want in certain use-cases
+ * to keep leaking the fbdev physical address to the user-space program
+ * handling the fbdev buffer.
+ *
+ * This is a bad habit, essentially kept to support closed-source OpenGL
+ * drivers that should really be moved into open-source upstream projects
+ * instead of using legacy physical addresses in user space to communicate
+ * with other out-of-tree kernel modules.
+ *
+ * This module_param *should* be removed as soon as possible and be
+ * considered as a broken and legacy behaviour from a modern fbdev device.
+ */
+bool drm_leak_fbdev_smem;
+EXPORT_SYMBOL(drm_leak_fbdev_smem);
+#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
+module_param_unsafe(drm_leak_fbdev_smem, bool, 0600);
+MODULE_PARM_DESC(drm_leak_fbdev_smem,
+		 "Allow unsafe leaking fbdev physical smem address [default=false]");
+#endif
+
+#endif
+
 static int __init drm_kms_helper_init(void)
 {
 	return drm_panic_helper_init();
-- 
2.55.0

