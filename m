Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59615F8FA6D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA6D10EC8D;
	Tue, 21 Apr 2026 12:57:48 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F2010EC86
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 12:57:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42E645BCEE;
 Tue, 21 Apr 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E54B4593B0;
 Tue, 21 Apr 2026 12:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8K3LNkN052labwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 12:57:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/6] drm/msm: Do not declare msm_framebuffer_init() as static
Date: Tue, 21 Apr 2026 14:51:14 +0200
Message-ID: <20260421125733.209568-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421125733.209568-1-tzimmermann@suse.de>
References: <20260421125733.209568-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 42E645BCEE
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Declare msm_framebuffer_init() in msm_drv.h and remove the static
qualifier. The function will be required in msm_fbdev.c after inlining
msm_alloc_stolen_fb().

Also move msm_framebuffer_init() before msm_framebuffer_create(), so
that it can later be made static again. Prepares msm's fbdev emulation
for using client buffers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/msm/msm_drv.h |  4 ++
 drivers/gpu/drm/msm/msm_fb.c  | 72 +++++++++++++++++------------------
 2 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 6d847d593f1a..efc901c9d8c2 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -259,6 +259,10 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb);
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane);
 struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane);
 const struct msm_format *msm_framebuffer_format(struct drm_framebuffer *fb);
+struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
+					     const struct drm_format_info *info,
+					     const struct drm_mode_fb_cmd2 *mode_cmd,
+					     struct drm_gem_object **bos);
 struct drm_framebuffer *msm_framebuffer_create(struct drm_device *dev,
 		struct drm_file *file, const struct drm_format_info *info,
 		const struct drm_mode_fb_cmd2 *mode_cmd);
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 9b681e144c07..d7523a0a866a 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -29,10 +29,6 @@ struct msm_framebuffer {
 };
 #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, base)
 
-static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
-		const struct drm_format_info *info,
-		const struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos);
-
 static int msm_framebuffer_dirtyfb(struct drm_framebuffer *fb,
 				   struct drm_file *file_priv, unsigned int flags,
 				   unsigned int color, struct drm_clip_rect *clips,
@@ -139,39 +135,10 @@ const struct msm_format *msm_framebuffer_format(struct drm_framebuffer *fb)
 	return msm_fb->format;
 }
 
-struct drm_framebuffer *msm_framebuffer_create(struct drm_device *dev,
-		struct drm_file *file, const struct drm_format_info *info,
-		const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	struct drm_gem_object *bos[4] = {0};
-	struct drm_framebuffer *fb;
-	int ret, i, n = info->num_planes;
-
-	for (i = 0; i < n; i++) {
-		bos[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
-		if (!bos[i]) {
-			ret = -ENXIO;
-			goto out_unref;
-		}
-	}
-
-	fb = msm_framebuffer_init(dev, info, mode_cmd, bos);
-	if (IS_ERR(fb)) {
-		ret = PTR_ERR(fb);
-		goto out_unref;
-	}
-
-	return fb;
-
-out_unref:
-	for (i = 0; i < n; i++)
-		drm_gem_object_put(bos[i]);
-	return ERR_PTR(ret);
-}
-
-static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
-		const struct drm_format_info *info,
-		const struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos)
+struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
+					     const struct drm_format_info *info,
+					     const struct drm_mode_fb_cmd2 *mode_cmd,
+					     struct drm_gem_object **bos)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
@@ -251,6 +218,37 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 	return ERR_PTR(ret);
 }
 
+struct drm_framebuffer *msm_framebuffer_create(struct drm_device *dev,
+					       struct drm_file *file,
+					       const struct drm_format_info *info,
+					       const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct drm_gem_object *bos[4] = {0};
+	struct drm_framebuffer *fb;
+	int ret, i, n = info->num_planes;
+
+	for (i = 0; i < n; i++) {
+		bos[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
+		if (!bos[i]) {
+			ret = -ENXIO;
+			goto out_unref;
+		}
+	}
+
+	fb = msm_framebuffer_init(dev, info, mode_cmd, bos);
+	if (IS_ERR(fb)) {
+		ret = PTR_ERR(fb);
+		goto out_unref;
+	}
+
+	return fb;
+
+out_unref:
+	for (i = 0; i < n; i++)
+		drm_gem_object_put(bos[i]);
+	return ERR_PTR(ret);
+}
+
 struct drm_framebuffer *
 msm_alloc_stolen_fb(struct drm_device *dev, int w, int h, int p, uint32_t format)
 {
-- 
2.53.0

