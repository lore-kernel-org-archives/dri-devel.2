Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5C8CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 11:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5877010E6C2;
	Mon, 11 May 2026 11:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1nB17uTD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RW8CduWy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1nB17uTD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RW8CduWy";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A4310E6C2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 11:55:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9549E61CBC;
 Mon, 11 May 2026 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778500544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I62Gp+N6xbWYqomjf961OL2PVVxznkP0yEcmbDG1cAU=;
 b=1nB17uTDXrfxXbFKzdZO6h3TlFMDLL8GVASr7VHE0GpfeUsftAVcsQgr8pYtX8QG+a2J6A
 EKTRkjuX/o948hdPWtPJ/7aCoEQfRMpg0rDtZFYTIbqDmDlwykLfhmVOJo/P4J+iJ1UV2/
 YiNT3Lfkx4KTZ7IpOmUwpvTKO8zU4dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778500544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I62Gp+N6xbWYqomjf961OL2PVVxznkP0yEcmbDG1cAU=;
 b=RW8CduWy3V6pPLykJsioEsc7Pm+66UOpvVYy4nttoxsU3uFiEOsuHzgWeQyMgrqVJPIHk/
 Zd2YF8syWT3oN1BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778500544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I62Gp+N6xbWYqomjf961OL2PVVxznkP0yEcmbDG1cAU=;
 b=1nB17uTDXrfxXbFKzdZO6h3TlFMDLL8GVASr7VHE0GpfeUsftAVcsQgr8pYtX8QG+a2J6A
 EKTRkjuX/o948hdPWtPJ/7aCoEQfRMpg0rDtZFYTIbqDmDlwykLfhmVOJo/P4J+iJ1UV2/
 YiNT3Lfkx4KTZ7IpOmUwpvTKO8zU4dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778500544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I62Gp+N6xbWYqomjf961OL2PVVxznkP0yEcmbDG1cAU=;
 b=RW8CduWy3V6pPLykJsioEsc7Pm+66UOpvVYy4nttoxsU3uFiEOsuHzgWeQyMgrqVJPIHk/
 Zd2YF8syWT3oN1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51488593A9;
 Mon, 11 May 2026 11:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UASZEsDDAWoERgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 11:55:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 m.szyprowski@samsung.com, wens@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 5/5] drm/exynos: Make exynos_drm_framebuffer_init() an
 internal interface
Date: Mon, 11 May 2026 13:54:35 +0200
Message-ID: <20260511115538.57884-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511115538.57884-1-tzimmermann@suse.de>
References: <20260511115538.57884-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[samsung.com,kernel.org,gmail.com,ffwll.ch];
 RCPT_COUNT_SEVEN(0.00)[10];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
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
index 121c342dd14a..8641c9e84d4c 100644
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

