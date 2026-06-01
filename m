Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D505BCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D54810E7E7;
	Mon,  1 Jun 2026 14:19:34 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F5D1133E7
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:19:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 202CE6ACA3;
 Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1232779A7;
 Mon,  1 Jun 2026 14:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eID3LfCUHWpSdwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 14:19:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch, michel.daenzer@mailbox.org, louis.chauvet@bootlin.com,
 ville.syrjala@linux.intel.com, jani.nikula@intel.com, mhklkml@zohomail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/7] drm/vblank: timer: Reorganize get_vblank_timeout
Date: Mon,  1 Jun 2026 16:08:32 +0200
Message-ID: <20260601141922.91498-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141922.91498-1-tzimmermann@suse.de>
References: <20260601141922.91498-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 202CE6ACA3
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

Handle vblank->enabled in a separate branch before handling the
opposite case. Prepares the code for estimating the vblank timeout
while vblanking is disabled. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 03b07e3c2598..cecaef98aa52 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2306,8 +2306,6 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
 	const struct drm_display_mode *mode;
-	u64 cur_count;
-	ktime_t cur_time;
 	s64 framedur_ns;
 	s64 activedur_ns;
 
@@ -2316,24 +2314,28 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 	else
 		mode = &crtc->hwmode;
 
-	if (!READ_ONCE(vblank->enabled))
-		return false;
+	if (READ_ONCE(vblank->enabled)) {
+		ktime_t cur_time;
+		u64 cur_count;
 
-	/*
-	 * A concurrent vblank timeout could update the expires field before
-	 * we compare it with the vblank time. Hence we'd compare the old
-	 * expiry time to the new vblank time; deducing the timer had already
-	 * expired. Reread until we get consistent values from both fields.
-	 */
-	do {
-		cur_count = drm_crtc_vblank_count_and_time(crtc, &cur_time);
-		*vblank_time = READ_ONCE(vtimer->timer.node.expires);
-	} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
+		/*
+		 * A concurrent vblank timeout could update the expires field before
+		 * we compare it with the vblank time. Hence we'd compare the old
+		 * expiry time to the new vblank time; deducing the timer had already
+		 * expired. Reread until we get consistent values from both fields.
+		 */
+		do {
+			cur_count = drm_crtc_vblank_count_and_time(crtc, &cur_time);
+			*vblank_time = READ_ONCE(vtimer->timer.node.expires);
+		} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
 
-	if (drm_WARN_ON(dev, !ktime_compare(*vblank_time, cur_time)))
-		return false; /* Already expired */
+		if (drm_WARN_ON(dev, !ktime_compare(*vblank_time, cur_time)))
+			return false; /* already expired */
 
-	framedur_ns = vblank->framedur_ns;
+		framedur_ns = vblank->framedur_ns;
+	} else {
+		return false;
+	}
 
 	/*
 	 * To prevent races we rolled the hrtimer forward before we did any
-- 
2.54.0

