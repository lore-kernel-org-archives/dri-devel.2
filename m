Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04BBF589DA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D69910F146;
	Thu, 23 Apr 2026 14:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CfUOSLL9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ag/n9Ygt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CfUOSLL9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ag/n9Ygt";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC5D10F146
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:00:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A27506A86D;
 Thu, 23 Apr 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776952835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8iGzXDdAsWe4Dlk10v8oKLR2EPxuue9+GaWVQqU9Tt8=;
 b=CfUOSLL9+s8z3AdZ20RQS8eUYxz7Tqa2SYdpBWznv82vLJtS1yeYizbL49FuvPZMfpM63v
 WBh65zeVG7m+QRFLy5GGTkzb5TuMxxN3FJEg2JwLRdBScqB18ibk1yroX8nJ49e9e39X3o
 90wGBAv7UaEPVYIgIku8E5EJKrlIqf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776952835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8iGzXDdAsWe4Dlk10v8oKLR2EPxuue9+GaWVQqU9Tt8=;
 b=ag/n9YgtpxjwVl+onFAMu7oOzwdLD/bi5aqM5hmD8yh60u03tKmgbO3r3Exj2KGsvPtOgG
 Nk4R9iJY30+tdzAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776952835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8iGzXDdAsWe4Dlk10v8oKLR2EPxuue9+GaWVQqU9Tt8=;
 b=CfUOSLL9+s8z3AdZ20RQS8eUYxz7Tqa2SYdpBWznv82vLJtS1yeYizbL49FuvPZMfpM63v
 WBh65zeVG7m+QRFLy5GGTkzb5TuMxxN3FJEg2JwLRdBScqB18ibk1yroX8nJ49e9e39X3o
 90wGBAv7UaEPVYIgIku8E5EJKrlIqf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776952835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8iGzXDdAsWe4Dlk10v8oKLR2EPxuue9+GaWVQqU9Tt8=;
 b=ag/n9YgtpxjwVl+onFAMu7oOzwdLD/bi5aqM5hmD8yh60u03tKmgbO3r3Exj2KGsvPtOgG
 Nk4R9iJY30+tdzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70DD4593A3;
 Thu, 23 Apr 2026 14:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wGlcGgMm6mlCTwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 14:00:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/3] drm/omapdrm: Make omap_framebuffer_init() an internal
 interface
Date: Thu, 23 Apr 2026 15:58:09 +0200
Message-ID: <20260423140031.126072-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423140031.126072-1-tzimmermann@suse.de>
References: <20260423140031.126072-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[ideasonboard.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

The only caller of omap_framebuffer_init() is omap_framebuffer_create()
from the same source file. Declare the former as static. Reorder the
functions to avoid forward declarations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 68 ++++++++++++++++---------------
 drivers/gpu/drm/omapdrm/omap_fb.h |  3 --
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 1df232232a64..74cd0e4271c2 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -335,39 +335,10 @@ void omap_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
 }
 #endif
 
-struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
-		struct drm_file *file, const struct drm_format_info *info,
-		const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	unsigned int num_planes = info->num_planes;
-	struct drm_gem_object *bos[4];
-	struct drm_framebuffer *fb;
-	int i;
-
-	for (i = 0; i < num_planes; i++) {
-		bos[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
-		if (!bos[i]) {
-			fb = ERR_PTR(-ENOENT);
-			goto error;
-		}
-	}
-
-	fb = omap_framebuffer_init(dev, info, mode_cmd, bos);
-	if (IS_ERR(fb))
-		goto error;
-
-	return fb;
-
-error:
-	while (--i >= 0)
-		drm_gem_object_put(bos[i]);
-
-	return fb;
-}
-
-struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
-		const struct drm_format_info *info,
-		const struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos)
+static struct drm_framebuffer *
+omap_framebuffer_init(struct drm_device *dev,
+		      const struct drm_format_info *info,
+		      const struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos)
 {
 	struct omap_framebuffer *omap_fb = NULL;
 	struct drm_framebuffer *fb = NULL;
@@ -455,3 +426,34 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 
 	return ERR_PTR(ret);
 }
+
+struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
+						struct drm_file *file,
+						const struct drm_format_info *info,
+						const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	unsigned int num_planes = info->num_planes;
+	struct drm_gem_object *bos[4];
+	struct drm_framebuffer *fb;
+	int i;
+
+	for (i = 0; i < num_planes; i++) {
+		bos[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
+		if (!bos[i]) {
+			fb = ERR_PTR(-ENOENT);
+			goto error;
+		}
+	}
+
+	fb = omap_framebuffer_init(dev, info, mode_cmd, bos);
+	if (IS_ERR(fb))
+		goto error;
+
+	return fb;
+
+error:
+	while (--i >= 0)
+		drm_gem_object_put(bos[i]);
+
+	return fb;
+}
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.h b/drivers/gpu/drm/omapdrm/omap_fb.h
index e6010302a22b..595d4d695ac4 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.h
+++ b/drivers/gpu/drm/omapdrm/omap_fb.h
@@ -23,9 +23,6 @@ struct seq_file;
 struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
 		struct drm_file *file, const struct drm_format_info *info,
 		const struct drm_mode_fb_cmd2 *mode_cmd);
-struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
-		const struct drm_format_info *info,
-		const struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos);
 int omap_framebuffer_pin(struct drm_framebuffer *fb);
 void omap_framebuffer_unpin(struct drm_framebuffer *fb);
 void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
-- 
2.53.0

