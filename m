Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B417C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961E810F42A;
	Thu,  2 Jul 2026 14:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="k98AlkJ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KwA2eahD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k98AlkJ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KwA2eahD";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C04F10F42A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:50:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBFC975A7E;
 Thu,  2 Jul 2026 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783003825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wuWvwrjJDFlMuTbtt7HXIdhoOURhmEZyHA0xpm6e+l4=;
 b=k98AlkJ8ifYQq6btglhE0cy2746Q3h1DDC2pLCWkCmdDAohoMm/XKB4NcoxXzaX41ss1G3
 zpIwwyWwGNZLlLNxpNFBBUsKYVSEux4sz20KpfWrvOR93/hx7iRJ0J3T8Bj0VPzvFFflXV
 iSdjq+tOBgrUifLpcsW2/5O92WTOA7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783003825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wuWvwrjJDFlMuTbtt7HXIdhoOURhmEZyHA0xpm6e+l4=;
 b=KwA2eahD19PvrSQfjvuGLE+QhDwDGWkv4zWU0z6OG2BZXsXc+B4CesqIACSSOM/Xd4Ew6O
 qRELAVUmjwJDo7Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k98AlkJ8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KwA2eahD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783003825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wuWvwrjJDFlMuTbtt7HXIdhoOURhmEZyHA0xpm6e+l4=;
 b=k98AlkJ8ifYQq6btglhE0cy2746Q3h1DDC2pLCWkCmdDAohoMm/XKB4NcoxXzaX41ss1G3
 zpIwwyWwGNZLlLNxpNFBBUsKYVSEux4sz20KpfWrvOR93/hx7iRJ0J3T8Bj0VPzvFFflXV
 iSdjq+tOBgrUifLpcsW2/5O92WTOA7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783003825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wuWvwrjJDFlMuTbtt7HXIdhoOURhmEZyHA0xpm6e+l4=;
 b=KwA2eahD19PvrSQfjvuGLE+QhDwDGWkv4zWU0z6OG2BZXsXc+B4CesqIACSSOM/Xd4Ew6O
 qRELAVUmjwJDo7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B68C779AA;
 Thu,  2 Jul 2026 14:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PzUVFbF6RmogRgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 02 Jul 2026 14:50:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hns@goldelico.com, zhengxingda@iscas.ac.cn, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, akemnade@kernel.org, javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4] drm/fb-helper: Only consider active CRTCs for vblank sync
Date: Thu,  2 Jul 2026 16:50:13 +0200
Message-ID: <20260702145021.226932-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BBFC975A7E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[goldelico.com,iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[15]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Only synchronize fbdev output to the vblank of an active CRTC. Go over
the list of CRTCs and pick the first that matches. Fixes warnings as
the one shown below

[   77.201354] WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x1cc [drm], CPU#1: kworker/1:7/1867
[   77.201354] omapdrm omapdrm.0: [drm] vblank wait timed out on crtc 0

This currently happens if the fbdev output is not on CRTC 0.

Atomic and non-atomic drivers require distinct code paths. As for other
fbdev operations, implement both and select the correct one at runtime.

Not finding an active CRTC is not a bug. Do not wait in this case, but
flush the display update as before.

v4:
- avoid possible deadlocks with locking context (Sashiko)
v3:
- drop excessive state validation (Jani)
- acquire plane and CRTC mutices (Sashiko)
v2:
- move look-up code into separate helper
- support drivers with legacy modesetting
v1:
- see https://lore.kernel.org/dri-devel/1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@suse.de/

Co-authored-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with vblank")
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Closes: https://bugs.debian.org/1138033
---
 drivers/gpu/drm/drm_fb_helper.c | 92 ++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 3316bb00a662..d4664ed468b2 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -225,16 +225,106 @@ static void drm_fb_helper_resume_worker(struct work_struct *work)
 	console_unlock();
 }
 
+static int find_crtc_index_atomic(struct drm_fb_helper *helper)
+{
+	struct drm_device *dev = helper->dev;
+	int crtc_index = -EINVAL;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_plane *plane;
+	int ret = 0;
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry:
+	drm_for_each_plane(plane, dev) {
+		const struct drm_plane_state *plane_state;
+
+		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
+
+		ret = drm_modeset_lock(&plane->mutex, &ctx);
+		if (ret)
+			goto err_drm_modeset_lock;
+		plane_state = plane->state;
+
+		if (plane_state->fb == helper->fb && plane_state->crtc) {
+			struct drm_crtc *crtc = plane_state->crtc;
+
+			ret = drm_modeset_lock(&crtc->mutex, &ctx);
+			if (ret)
+				goto err_drm_modeset_lock;
+			if (crtc->state->active)
+				crtc_index = crtc->index;
+			drm_modeset_unlock(&crtc->mutex);
+		}
+		drm_modeset_unlock(&plane->mutex);
+
+		if (crtc_index >= 0)
+			break;
+	}
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	return crtc_index;
+
+err_drm_modeset_lock:
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry;
+	}
+	return ret;
+}
+
+static int find_crtc_index_legacy(struct drm_fb_helper *helper)
+{
+	struct drm_device *dev = helper->dev;
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dev) {
+		struct drm_plane *plane = crtc->primary;
+
+		if (!crtc->enabled)
+			continue;
+		if (!plane || plane->fb != helper->fb)
+			continue; /* CRTC doesn't display fbdev emulation */
+
+		return crtc->index;
+	}
+
+	return -EINVAL;
+}
+
+static int drm_fb_helper_find_crtc_index(struct drm_fb_helper *helper)
+{
+	struct drm_device *dev = helper->dev;
+	int crtc_index;
+
+	mutex_lock(&dev->mode_config.mutex);
+
+	if (drm_drv_uses_atomic_modeset(dev))
+		crtc_index = find_crtc_index_atomic(helper);
+	else
+		crtc_index = find_crtc_index_legacy(helper);
+
+	mutex_unlock(&dev->mode_config.mutex);
+
+	return crtc_index;
+}
+
 static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
 {
 	struct drm_device *dev = helper->dev;
 	struct drm_clip_rect *clip = &helper->damage_clip;
 	struct drm_clip_rect clip_copy;
+	int crtc_index;
 	unsigned long flags;
 	int ret;
 
 	mutex_lock(&helper->lock);
-	drm_client_modeset_wait_for_vblank(&helper->client, 0);
+	crtc_index = drm_fb_helper_find_crtc_index(helper);
+	if (crtc_index >= 0)
+		drm_client_modeset_wait_for_vblank(&helper->client, crtc_index);
 	mutex_unlock(&helper->lock);
 
 	if (drm_WARN_ON_ONCE(dev, !helper->funcs->fb_dirty))
-- 
2.54.0

