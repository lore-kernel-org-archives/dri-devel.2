Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B4AC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446E910ED52;
	Mon, 14 Sep 2026 11:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="085m7F6v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h8LkQDnX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hUVlpVnE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MKQX36/0";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F165510ED52
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:00:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1CD8A211CA;
 Mon, 14 Sep 2026 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789383612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7WuirKrxCxKEKqt/9W+tCHalBkxSlirtta4lU9w4TY=;
 b=085m7F6vjN1nwBBnXwJYAfdlNdYy8PaRBO/4jJEI7fPOgFeZk2RCqQXQFGCVh1hkWwUDqB
 K023FsbgarTa+E2CKknJc5ZPo4tjDPSDvPNc/TXprEq32HS9Y5kiC/w0QBSXNczyRXvl1S
 kQiiwkmfDapNTpzFfKhgY0RpMvHREf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789383612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7WuirKrxCxKEKqt/9W+tCHalBkxSlirtta4lU9w4TY=;
 b=h8LkQDnXdz2pFnC9paPPVLArTSh8ZdaO6cCyUPutzbCunPoXC3kbL9QxrwNDDLuqmNmSD/
 ipw74xfP/XsI2ZCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789383608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7WuirKrxCxKEKqt/9W+tCHalBkxSlirtta4lU9w4TY=;
 b=hUVlpVnEdTxfsmZSH1loTyvfQr/Q2cyM5US8Cb3a8h6nabCrm4okj/UggU888T1HzMyEHk
 z8bQzzOOu2c5buWa03bkA7jGdHzhroJyCi/JxTQL+TYy8zYklOOPrWYClRnC1VsDBAwfrQ
 exUE/VFtPGU5owv1Cvkc/2ooYEcSx0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789383608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h7WuirKrxCxKEKqt/9W+tCHalBkxSlirtta4lU9w4TY=;
 b=MKQX36/0O0IS5zIpN2esIY4uX5+cL5xtJNBLHNVUciVuPaIqZzbSgNs6wuGYwZnMt5esNh
 BZxTIgxUr/oZHBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EEB71368C;
 Mon, 14 Sep 2026 11:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9xzaFLfTp2oJPAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 14 Sep 2026 11:00:07 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: me@romanilin.is, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, javierm@redhat.com, dmitry.osipenko@collabora.com,
 ville.syrjala@linux.intel.com, regressions@leemhuis.info,
 peter.m.arnesen@gmail.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid frame
 duration
Date: Mon, 14 Sep 2026 12:57:26 +0200
Message-ID: <20260914110004.211027-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[romanilin.is,bootlin.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,collabora.com,leemhuis.info];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
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

From: Roman Ilin <me@romanilin.is>

When a CRTC's display mode carries a too small pixel clock,
drm_calc_timestamping_constants() computes a frame duration that
exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
interval, after which vblank events are no longer delivered. Pending
page flips never complete and the display appears frozen.

This could be triggered on virtio-gpu guests that have dynamic resolution
enabled: when the SPICE agent or the X server resizes the output, it
submits a mode whose pixel clock is off by a factor of 1000, e.g.:

    clock = 406 kHz, htotal = 3152, vtotal = 2148

    framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)

16675852216 does not fit into an int and wraps to roughly -504000000.
ns_to_ktime() then yields a negative interval and the timer stops working.

Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
Use vblank timer"). That commit merely made virtio-gpu use the vblank
timer and thereby exposed the pre-existing problem in the timer setup
added by commit 74afeb812850 ("drm/vblank: Add vblank timer").

To fix this, modify drm_calc_timestamping_constants() to use u64 for
calculations, check for INT_MAX overflows, and return an error code.
drm_crtc_vblank_start_timer() will then propagate the error, enabling
the driver to fall back to immediate vblank events. Valid modes are
unaffected, and the timer self-heals on the next mode with a sane clock.

v4:
- avoid log spamming with drm_warn_once()

Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Roman Ilin <me@romanilin.is>
---
I took Roman's patch from [1] and replaced the error messages with
warn_once, as suggestde in my review.

[1] https://lore.kernel.org/dri-devel/20260702181027.98526-1-me@romanilin.is/
---
 drivers/gpu/drm/drm_vblank.c | 73 +++++++++++++++++++++++-------------
 include/drm/drm_vblank.h     |  4 +-
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..72b543bca9e3 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -631,45 +631,54 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
  * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
  * CRTC's true scanout timing, so they take things like panel scaling or
  * other adjustments into account.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
  */
-void drm_calc_timestamping_constants(struct drm_crtc *crtc,
-				     const struct drm_display_mode *mode)
+int drm_calc_timestamping_constants(struct drm_crtc *crtc,
+				    const struct drm_display_mode *mode)
 {
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	int linedur_ns = 0, framedur_ns = 0;
+	u64 linedur_ns, framedur_ns;
 	int dotclock = mode->crtc_clock;
+	unsigned int frame_size;
 
 	if (!drm_dev_has_vblank(dev))
-		return;
+		return 0;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
-		return;
+		return -EINVAL;
 
-	/* Valid dotclock? */
-	if (dotclock > 0) {
-		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
+	if (dotclock <= 0) {
+		drm_err_once(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
+			     crtc->base.id, dotclock);
+		goto error;
+	}
 
-		/*
-		 * Convert scanline length in pixels and video
-		 * dot clock to line duration and frame duration
-		 * in nanoseconds:
-		 */
-		linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
-		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
+	frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode->crtc_vtotal;
 
-		/*
-		 * Fields of interlaced scanout modes are only half a frame duration.
-		 */
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-			framedur_ns /= 2;
-	} else {
-		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
-			crtc->base.id);
+	/*
+	 * Convert scanline length in pixels and video dot clock to line duration
+	 * and frame duration in nanoseconds.
+	 */
+	linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
+	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
+
+	/*
+	 * Fields of interlaced scanout modes are only half a frame duration.
+	 */
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		framedur_ns /= 2;
+
+	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
+		drm_err_once(dev, "crtc %u: Can't calculate constants, mode clock too small!\n",
+			     crtc->base.id);
+		goto error;
 	}
 
-	vblank->linedur_ns  = linedur_ns;
+	vblank->linedur_ns = linedur_ns;
 	vblank->framedur_ns = framedur_ns;
 	drm_mode_copy(&vblank->hwmode, mode);
 
@@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
 		     crtc->base.id, mode->crtc_htotal,
 		     mode->crtc_vtotal, mode->crtc_vdisplay);
 	drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
-		     crtc->base.id, dotclock, framedur_ns, linedur_ns);
+		     crtc->base.id, dotclock,
+		     vblank->framedur_ns, vblank->linedur_ns);
+
+	return 0;
+
+error:
+	vblank->linedur_ns = 0;
+	vblank->framedur_ns = 0;
+	drm_mode_copy(&vblank->hwmode, mode);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(drm_calc_timestamping_constants);
 
@@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
 	unsigned long flags;
+	int ret;
 
 	if (!vtimer->crtc) {
 		/*
@@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 			hrtimer_try_to_cancel(&vtimer->timer);
 	}
 
-	drm_calc_timestamping_constants(crtc, &crtc->mode);
+	ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&vtimer->interval_lock, flags);
 	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f5b1..d99772dfa034 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
 u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
 void drm_crtc_vblank_restore(struct drm_crtc *crtc);
 
-void drm_calc_timestamping_constants(struct drm_crtc *crtc,
-				     const struct drm_display_mode *mode);
+int drm_calc_timestamping_constants(struct drm_crtc *crtc,
+				    const struct drm_display_mode *mode);
 wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
 void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
 				   u32 max_vblank_count);

base-commit: 06576c2b43750d990297b8ff1989b94ac72e855f
prerequisite-patch-id: 6729bb10d5e338678e78ccda2dd24f232a13cd22
prerequisite-patch-id: 9d94d20bd45967493b4dc339b58082e1c8da0f4f
prerequisite-patch-id: 6ac8d22df34db9e7d467b1ab95ad30f94841d5db
prerequisite-patch-id: f548dbde3f944ca3415c808be628719acebe898a
prerequisite-patch-id: 2ae91ee8e2bbcd33b8325be046e7214185aba6aa
prerequisite-patch-id: f97bbde08a9996d7c62ca3e3ebfcd387e50bc5c3
prerequisite-patch-id: ecc3c825277bc9978c6979455517249a074c0cb1
prerequisite-patch-id: 0449925cca36664b566f614bfb7d573a11f0575f
prerequisite-patch-id: 9fb2c2787244e9621847af09bea03e575e6276c7
prerequisite-patch-id: eb4384d581805e1178d22e7df45f134223c38305
prerequisite-patch-id: 1a7a529e4b2864abe8071aa44598d28ce72483f4
prerequisite-patch-id: 844a85f4c2fe2f72209b82d46614004c3cfe4123
prerequisite-patch-id: 13f7cb22114c648d35f8c9fa74e9165656ce31eb
prerequisite-patch-id: 20ee46bd6fdd91e39f71d22f52ef6682a4e41512
prerequisite-patch-id: 1d26c0ff91796ff1e62d3831d00bee18723788ef
prerequisite-patch-id: 007f6ea0d09bef54b689bae0eb5abeb497bdfaad
prerequisite-patch-id: 2d89c1507c909520adf9bfb1a137d458a819ae8f
prerequisite-patch-id: d90dc4134468870ab8ccbd71547c9552dff74fbd
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
-- 
2.55.0

