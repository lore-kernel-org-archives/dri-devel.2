Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0497606A596
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k1c6KJf0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XBBdu16R;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pgvPrly2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NQPMzwH5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E2C10EF32;
	Mon,  2 Nov 2026 14:39:38 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B561310EF32
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:39:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 120911F38F;
 Mon,  2 Nov 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793630365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
 b=k1c6KJf06lLMjANzjsRckqX3a1g93Ie8HyY088UzjjrtT4894T8Lk3meHRPN+FpQrdrDdf
 lHPCUiaq2W2evnfa8OgWPELmf77dNLmbjTDf5L0ozbHgxcsMcRRvWe6iQpuEeHx0CH/cq4
 NaG0GlaV6LnS+poZFVqHEN4RP/JiyJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793630365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
 b=XBBdu16Rfz4pJ5smXefKsiA7G/hsn5pKRl1tSZCquvKXxLd0i0d5jUM0kWPL6ymA2y27U3
 E1yZMn9WVRPw3NBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793630364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
 b=pgvPrly2W0ITJAIbfpbT7pL9CjFjivBu67eQWBZZ7WwBvnhbx40lkTkz0gBVdJ5XzMx0sO
 Vpvnzfn2+ciqv9gEFImpAO338i1zmU8dmH6ZRIn2fxELyLsXtIXHLyGTThUbBF5XHk4/fE
 Aio3PoRwT4qj9X01AwJI7+4zMUuE9fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793630364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Kk/m6s2n0EULcCDaOH1q1j9/CXF2sCn36I0TyIZGQiU=;
 b=NQPMzwH5uWaH5aybTWsxDTZhTH37+xqSEDAYHigOcqwknOaaw3WqVtBe7TwJSSPAYXCWCZ
 GL66YlJGXwHv0jAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97D78134B8;
 Mon,  2 Nov 2026 14:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +68lGJug6GrWRAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 02 Nov 2026 14:39:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, ville.syrjala@linux.intel.com, javierm@redhat.com,
 louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH] drm/vblank: Restart enabling vblank timer on possible deadlock
Date: Mon,  2 Nov 2026 15:38:52 +0100
Message-ID: <20261102143919.1672293-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,bootlin.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,bootlin.com:email,lists.freedesktop.org:email];
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

Return -EDEADLK when trying to cancel a running hrtimer as part of
enable_vblank(). Reacquire vblank_time_lock and try again.

The vblank helper drm_vblank_disable_and_save() and the vblank IRQ
handler hold the spin lock vblank_time_lock at some point. This
can result in a deadlock if vblank timer's disable code in
drm_crtc_vblank_cancel_timer() calls hrtimer_cancel() directly: the
helper wais for the timer function to complete and the timer function
waits for the helper to release vblank.time_lock.

drm_crtc_vblank_cancel_timer() works around this problem by calling
hrtimer_try_to_cancel() instead. For re-enabling the vblank timer,
drm_crtc_vblank_start_timer() must wait for the vblank timer to stop.
It runs into the same deadlock problem while waiting for the timer
function to complete.

The solution to this problem is to release and reacquire the spin
lock vblank_time_lock if hrtimer_try_to_cancel() signals a running
timer function. Releasing the lock allows for the timer function to
make progress.

Signal the possible deadlock with -EDEADLK and perform the necessary
steps. No other driver uses -EDEADLK in their enable_vblank, so the
change should not interfere.

Tested with bochs on qemu.

Closes: https://lore.kernel.org/dri-devel/20260914111129.300691F00898@smtp.kernel.org/
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.19+
---
I also tried to move hrtimer_cancel() out of the critical section. The
result was fairly fragile. So returning an error and re-acquiring the
lock was the easier solution.
---
 drivers/gpu/drm/drm_vblank.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 5162250e8813..135efde86298 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1182,10 +1182,12 @@ static int __enable_vblank(struct drm_device *dev, unsigned int pipe)
 static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
-	int ret = 0;
+	int ret;
 
 	assert_spin_locked(&dev->vbl_lock);
 
+retry:
+	ret = 0;
 	spin_lock(&dev->vblank_time_lock);
 
 	if (!vblank->enabled) {
@@ -1199,7 +1201,11 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 		ret = __enable_vblank(dev, pipe);
 		drm_dbg_core(dev, "enabling vblank on crtc %u, ret: %d\n",
 			     pipe, ret);
-		if (ret) {
+		if (ret == -EDEADLK) {
+			spin_unlock(&dev->vblank_time_lock);
+			cpu_relax();
+			goto retry;
+		} else if (ret) {
 			atomic_dec(&vblank->refcount);
 		} else {
 			drm_update_vblank_count(dev, pipe, 0);
@@ -2232,11 +2238,14 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	} else {
 		/*
-		 * Timer should not be active. If it is, wait for the
-		 * previous cancel operations to finish.
+		 * Timer should not be running. If it is, signal cancellation
+		 * again and restart to release locks.
 		 */
-		while (hrtimer_active(&vtimer->timer))
-			hrtimer_try_to_cancel(&vtimer->timer);
+		if (hrtimer_try_to_cancel(&vtimer->timer) == -1) {
+			scoped_guard(spinlock_irqsave, &vtimer->interval_lock)
+				vtimer->interval = 0;
+			return -EDEADLK;
+		}
 	}
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
-- 
2.56.0

