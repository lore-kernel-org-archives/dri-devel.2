Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB467CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB8410F365;
	Fri,  8 May 2026 06:49:08 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA8310F365
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:49:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A19915CFB9;
 Fri,  8 May 2026 06:48:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5614A593A7;
 Fri,  8 May 2026 06:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sPqRE1OH/Wm1cgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 06:48:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 m.szyprowski@samsung.com, wens@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 5/5] drm/exynos: Make exynos_drm_framebuffer_init() an
 internal interface
Date: Fri,  8 May 2026 08:46:51 +0200
Message-ID: <20260508064842.22689-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508064842.22689-1-tzimmermann@suse.de>
References: <20260508064842.22689-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A19915CFB9
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

The only caller of exynos_drm_framebuffer_init() is the helper
exynos_user_fb_create() from the same source file. Declare the
former as static. Tidy up the header's include statements.

v2:
- clean up the includes in the header file (Chen-Yu)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fb.c    |  3 ++-
 drivers/gpu/drm/exynos/exynos_drm_fb.h    | 10 +++-------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |  1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index ab0e0c74ec47..c6a33f550ace 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -22,6 +22,7 @@
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fb.h"
 #include "exynos_drm_fbdev.h"
+#include "exynos_drm_gem.h"
 
 static int check_fb_gem_memory_type(struct drm_device *drm_dev,
 				    struct exynos_drm_gem *exynos_gem)
@@ -55,7 +56,7 @@ static const struct drm_framebuffer_funcs exynos_drm_fb_funcs = {
 	.create_handle	= drm_gem_fb_create_handle,
 };
 
-struct drm_framebuffer *
+static struct drm_framebuffer *
 exynos_drm_framebuffer_init(struct drm_device *dev,
 			    const struct drm_format_info *info,
 			    const struct drm_mode_fb_cmd2 *mode_cmd,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.h b/drivers/gpu/drm/exynos/exynos_drm_fb.h
index fdc6cb40cc9c..74300ad9bb51 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.h
@@ -10,14 +10,10 @@
 #ifndef _EXYNOS_DRM_FB_H_
 #define _EXYNOS_DRM_FB_H_
 
-#include "exynos_drm_gem.h"
+#include <linux/types.h>
 
-struct drm_framebuffer *
-exynos_drm_framebuffer_init(struct drm_device *dev,
-			    const struct drm_format_info *info,
-			    const struct drm_mode_fb_cmd2 *mode_cmd,
-			    struct exynos_drm_gem **exynos_gem,
-			    int count);
+struct drm_device;
+struct drm_framebuffer;
 
 dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index f43ce974c952..247b0ec001af 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -22,6 +22,7 @@
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fb.h"
 #include "exynos_drm_fbdev.h"
+#include "exynos_drm_gem.h"
 
 #define MAX_CONNECTOR		4
 
-- 
2.54.0

