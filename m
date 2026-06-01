Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F85ACD6E57
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD0810E81A;
	Mon,  1 Jun 2026 14:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ZEzNXtUg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7K4ONuKt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZEzNXtUg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7K4ONuKt";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F031133E1
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00CC166ECE;
 Mon,  1 Jun 2026 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780323568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fk07Lco7EbMpsPzUHkxPB2V56LtwKNzzCcNnTsfYvJE=;
 b=ZEzNXtUgNsRWrSVj/15t5k3zbQejl7j7n84v0eq2xvw3Mh+OfBQojtfPbbdaaXTF+f7QLg
 /cNu66SLPBsGo/Q849QMDwOCeL/k3T7b9E5YFDWMFXAHFoQfQQVfeioP2CgHBHlJk7yzxS
 vkQl8yjZMEAaBk+fZuMIQckKhkYtKUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780323568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fk07Lco7EbMpsPzUHkxPB2V56LtwKNzzCcNnTsfYvJE=;
 b=7K4ONuKtfSRz00c+Iyp51FcW3g323EvfFS6/oK323sLaeM/wp22uZb/7Sz1PPsniSSEVPy
 VsSEt3qHveqPLKCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780323568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fk07Lco7EbMpsPzUHkxPB2V56LtwKNzzCcNnTsfYvJE=;
 b=ZEzNXtUgNsRWrSVj/15t5k3zbQejl7j7n84v0eq2xvw3Mh+OfBQojtfPbbdaaXTF+f7QLg
 /cNu66SLPBsGo/Q849QMDwOCeL/k3T7b9E5YFDWMFXAHFoQfQQVfeioP2CgHBHlJk7yzxS
 vkQl8yjZMEAaBk+fZuMIQckKhkYtKUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780323568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fk07Lco7EbMpsPzUHkxPB2V56LtwKNzzCcNnTsfYvJE=;
 b=7K4ONuKtfSRz00c+Iyp51FcW3g323EvfFS6/oK323sLaeM/wp22uZb/7Sz1PPsniSSEVPy
 VsSEt3qHveqPLKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EEB0779A8;
 Mon,  1 Jun 2026 14:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WP2dJe+UHWpSdwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 14:19:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch, michel.daenzer@mailbox.org, louis.chauvet@bootlin.com,
 ville.syrjala@linux.intel.com, jani.nikula@intel.com, mhklkml@zohomail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/7] drm/vblank: timer: Return success status from
 get_vblank_timeout
Date: Mon,  1 Jun 2026 16:08:29 +0200
Message-ID: <20260601141922.91498-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141922.91498-1-tzimmermann@suse.de>
References: <20260601141922.91498-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[ffwll.ch,mailbox.org,bootlin.com,linux.intel.com,intel.com,zohomail.com,kernel.org,gmail.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLgb6padn6wcu17bxtda1k7h6p)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Return true/false from drm_crtc_vblank_get_vblank_timeout(), depending
on the success of the calculation. Let caller handle failure by itself.

Until now the helper tried to return a vblank time even in the case of
an error. Letting the caller handle the failure is the preferred behavior.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c        | 15 +++++++++------
 drivers/gpu/drm/drm_vblank_helper.c |  4 +---
 include/drm/drm_vblank.h            |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..96d70c3d4522 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2287,18 +2287,19 @@ EXPORT_SYMBOL(drm_crtc_vblank_cancel_timer);
  * The helper drm_crtc_vblank_get_vblank_timeout() returns the next vblank
  * timestamp of the CRTC's vblank timer according to the timer's expiry
  * time.
+ *
+ * Returns:
+ * True on success, or false otherwise.
  */
-void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_time)
+bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_time)
 {
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
 	u64 cur_count;
 	ktime_t cur_time;
 
-	if (!READ_ONCE(vblank->enabled)) {
-		*vblank_time = ktime_get();
-		return;
-	}
+	if (!READ_ONCE(vblank->enabled))
+		return false;
 
 	/*
 	 * A concurrent vblank timeout could update the expires field before
@@ -2312,7 +2313,7 @@ void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 	} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
 
 	if (drm_WARN_ON(crtc->dev, !ktime_compare(*vblank_time, cur_time)))
-		return; /* Already expired */
+		return false; /* Already expired */
 
 	/*
 	 * To prevent races we roll the hrtimer forward before we do any
@@ -2322,5 +2323,7 @@ void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 	 * correct the timestamp by one frame.
 	 */
 	*vblank_time = ktime_sub(*vblank_time, vtimer->interval);
+
+	return true;
 }
 EXPORT_SYMBOL(drm_crtc_vblank_get_vblank_timeout);
diff --git a/drivers/gpu/drm/drm_vblank_helper.c b/drivers/gpu/drm/drm_vblank_helper.c
index d3f8147ecdc1..aa8df047b2aa 100644
--- a/drivers/gpu/drm/drm_vblank_helper.c
+++ b/drivers/gpu/drm/drm_vblank_helper.c
@@ -169,8 +169,6 @@ bool drm_crtc_vblank_helper_get_vblank_timestamp_from_timer(struct drm_crtc *crt
 							    ktime_t *vblank_time,
 							    bool in_vblank_irq)
 {
-	drm_crtc_vblank_get_vblank_timeout(crtc, vblank_time);
-
-	return true;
+	return drm_crtc_vblank_get_vblank_timeout(crtc, vblank_time);
 }
 EXPORT_SYMBOL(drm_crtc_vblank_helper_get_vblank_timestamp_from_timer);
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f5b1..1c06e4499dae 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -319,7 +319,7 @@ void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
 
 int drm_crtc_vblank_start_timer(struct drm_crtc *crtc);
 void drm_crtc_vblank_cancel_timer(struct drm_crtc *crtc);
-void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_time);
+bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_time);
 
 /*
  * Helpers for struct drm_crtc_funcs
-- 
2.54.0

