Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B3606A330
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eebLj8cv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aJuaYI/2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eebLj8cv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aJuaYI/2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2FC10EEA4;
	Tue, 10 Nov 2026 08:47:44 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F1110EEA4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:47:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E14621FC4;
 Tue, 10 Nov 2026 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794300435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cUVptpHv3XOVaNUbbyHyVf6R5LgqLqMQhFeVA4GL+o=;
 b=eebLj8cvEvvdbsO2UC7dRmP34GDW8HhmzWuYQtUTofcSM4VN3PiKBs+BzfjdQ/1EC4exfG
 fIbo92NKKFSs2CqFj+CLCr91Y6mq9NUi7W8Sm1ne6ylYB16ARgd+kzZM6noPFLtURIObiQ
 atHFYvWaRDyMTt5epeu+op4ma7CoNwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794300435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cUVptpHv3XOVaNUbbyHyVf6R5LgqLqMQhFeVA4GL+o=;
 b=aJuaYI/2/crlSnjQDkqTdUcrYBVduEgQAUlLft2Qo6y/+EH31gPgtYTfOJ0OAOxnoCw8z4
 UH3y06vFzBpZCIBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794300435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cUVptpHv3XOVaNUbbyHyVf6R5LgqLqMQhFeVA4GL+o=;
 b=eebLj8cvEvvdbsO2UC7dRmP34GDW8HhmzWuYQtUTofcSM4VN3PiKBs+BzfjdQ/1EC4exfG
 fIbo92NKKFSs2CqFj+CLCr91Y6mq9NUi7W8Sm1ne6ylYB16ARgd+kzZM6noPFLtURIObiQ
 atHFYvWaRDyMTt5epeu+op4ma7CoNwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794300435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cUVptpHv3XOVaNUbbyHyVf6R5LgqLqMQhFeVA4GL+o=;
 b=aJuaYI/2/crlSnjQDkqTdUcrYBVduEgQAUlLft2Qo6y/+EH31gPgtYTfOJ0OAOxnoCw8z4
 UH3y06vFzBpZCIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E613313479;
 Tue, 10 Nov 2026 08:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GTbNGhLa8mojQwAAD6G6ig:T2
 (envelope-from <tzimmermann@suse.de>); Tue, 10 Nov 2026 08:47:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ville.syrjala@linux.intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com,
 zack.rusin@broadcom.com, louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/vblank: timer: Do not block within critical section
Date: Tue, 10 Nov 2026 09:45:19 +0100
Message-ID: <20261110084710.503870-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110084710.503870-1-tzimmermann@suse.de>
References: <20261110084710.503870-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-16.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,broadcom.com,bootlin.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, bootlin.com:email,
 lists.freedesktop.org:email, intel.com:email, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -16.30
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

Remove try-to-cancel loop from drm_crtc_vblank_start_timer() to avoid
a possible livelock while spinning within the loop. Hold interval_lock
when starting and forwarding the vblank timer's hrtimer to avoid
forwarding an already queued timer.

The vblank helper drm_vblank_disable_and_save() and the vblank IRQ
handler hold the spin lock vblank_time_lock at some point. This can
result in a deadlock if the vblank timer's disable code in
drm_crtc_vblank_cancel_timer() calls hrtimer_cancel() directly: the
helper waits for the timer function to complete and the timer function
waits for the helper to release vblank_time_lock.

drm_crtc_vblank_cancel_timer() works around this problem by calling
hrtimer_try_to_cancel() instead. For re-enabling the vblank timer,
drm_crtc_vblank_start_timer() currently waits for the vblank timer
to stop. It runs into the same locking problem while waiting for the
timer function to complete.

Resolve the locking problem by removing hrtimer_try_to_cancel() from
drm_crtc_vblank_start_timer(). Hold interval_lock while starting or
forwarding the hrtimer. Without holding interval_lock,
drm_crtc_vblank_start_timer() could set an interval and start the
hrtimer; while a concurrent timer function forwards the timer with the
old interval. This can corrupt the ordering of the hrtimer's internal
queue. Holding the lock prevents this from happening.

When starting the vblank timer, it is still possible that an already
running timer sends out a vblank event at the previous vblank interval.
This is merely an inconsistency and not critical.

Closes: https://lore.kernel.org/dri-devel/20260914111129.300691F00898@smtp.kernel.org/
Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.19+
---
 drivers/gpu/drm/drm_vblank.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..8cc8d018d353 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2179,19 +2179,18 @@ static enum hrtimer_restart drm_vblank_timer_function(struct hrtimer *timer)
 	struct drm_crtc *crtc = vtimer->crtc;
 	const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
 	struct drm_device *dev = crtc->dev;
-	unsigned long flags;
-	ktime_t interval;
-	u64 ret_overrun;
+	u64 ret_overrun = 1;
 	bool succ;
 
-	spin_lock_irqsave(&vtimer->interval_lock, flags);
-	interval = vtimer->interval;
-	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
+	scoped_guard(spinlock_irqsave, &vtimer->interval_lock) {
+		ktime_t interval = vtimer->interval;
 
-	if (!interval)
-		return HRTIMER_NORESTART;
+		if (!interval || hrtimer_is_queued(timer))
+			return HRTIMER_NORESTART;
+
+		ret_overrun = hrtimer_forward_now(timer, interval);
+	}
 
-	ret_overrun = hrtimer_forward_now(&vtimer->timer, interval);
 	if (ret_overrun != 1)
 		drm_dbg_vbl(dev, "vblank timer overrun\n");
 
@@ -2220,7 +2219,6 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 {
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
-	unsigned long flags;
 
 	if (!vtimer->crtc) {
 		/*
@@ -2230,22 +2228,14 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 		spin_lock_init(&vtimer->interval_lock);
 		hrtimer_setup(&vtimer->timer, drm_vblank_timer_function,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	} else {
-		/*
-		 * Timer should not be active. If it is, wait for the
-		 * previous cancel operations to finish.
-		 */
-		while (hrtimer_active(&vtimer->timer))
-			hrtimer_try_to_cancel(&vtimer->timer);
 	}
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
-	spin_lock_irqsave(&vtimer->interval_lock, flags);
-	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
-	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
-
-	hrtimer_start(&vtimer->timer, vtimer->interval, HRTIMER_MODE_REL);
+	scoped_guard(spinlock_irqsave, &vtimer->interval_lock) {
+		vtimer->interval = ns_to_ktime(vblank->framedur_ns);
+		hrtimer_start(&vtimer->timer, vtimer->interval, HRTIMER_MODE_REL);
+	}
 
 	return 0;
 }
-- 
2.56.0

