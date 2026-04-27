Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B904EFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193BC10E7A5;
	Mon, 27 Apr 2026 15:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="PYJnCjrf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bm1Y1qk5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dTDPJgIR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ecBwDnvT";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FA210E7BE
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:03:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C14805BD28;
 Mon, 27 Apr 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777302175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UQZvEGdAAGF247/aDrP6/yGPr0y0xUEf3MOoLZi22Y=;
 b=PYJnCjrfLfMPbF/RNaCFnChEmBkZsEpxtRMKjG6fJG3EVQwF1z+XBxTn8YSiNlWcxsYKdU
 /k4JgbJ+IU6GWs9Id3Us+Jtsm9mbpYBk72Zt2JAk2blDDYPiqPORkY4NBPvPsujknO9Y8s
 RSP5WTLkjk3eUUhqPNIG2RgfUxaNVp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777302175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UQZvEGdAAGF247/aDrP6/yGPr0y0xUEf3MOoLZi22Y=;
 b=Bm1Y1qk507JbNMDNFbE7OuUswGYQc9CRaI9qS8PNwMcg7yjmt7gvGRw/YIUo4Z9D+Eczbs
 RBg5Jn9qu6ko+KDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777302174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UQZvEGdAAGF247/aDrP6/yGPr0y0xUEf3MOoLZi22Y=;
 b=dTDPJgIRAbvQ/1pWVQtUBUjU0ICcuOfwMTVMd446nW8AOQlI6Z+k/Rdtgvda47/colhKmZ
 wjno209lWMfZErkHdx8iwkToY/gVBq97gB7G7yG2/+YefXRrM0Feg61uVrtbc/EHF20dCW
 +qAmFxZ52FEgo8BVHRioDUuhRKUMm8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777302174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UQZvEGdAAGF247/aDrP6/yGPr0y0xUEf3MOoLZi22Y=;
 b=ecBwDnvTt1Vcbqlu1lxdK4yTqob9Q16e9kHk+R0oSEKRZj+wsn9nHMyMnZceCHHxCNveKG
 +Hzp0NE9zxVWExAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9005A593B0;
 Mon, 27 Apr 2026 15:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qN3GIZ5672k9OQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 15:02:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/3] drm/vmwgfx: Move vblank handling into separate helper
Date: Mon, 27 Apr 2026 17:00:39 +0200
Message-ID: <20260427150250.699768-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427150250.699768-1-tzimmermann@suse.de>
References: <20260427150250.699768-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Decouple vblank handling from the underlying hrtimer. This will be
helpful for replacing vmwgfx's vblank timer with DRM's common
implementation.

The new helper vmw_vkms_handle_vblank_timeout() can later be used as
callback for DRM's handle_vblank call as-is. The helper also keeps the
current semantics for restarting the timer. It returns true to restart
the next vblank timeout even if it could not acquire vmwgfx's vblank
lock.

The remaining code in vmw_vkms_vblank_simulate() will be replaced by
the DRM implementation in a later patch.

v2:
- clarify return-value semantics in commit message (Zack)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 37 +++++++++++++++++++---------
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h |  1 +
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 7862f6972512..15439ddd4f22 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -157,27 +157,19 @@ crc_generate_worker(struct work_struct *work)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
 }
 
-static enum hrtimer_restart
-vmw_vkms_vblank_simulate(struct hrtimer *timer)
+bool
+vmw_vkms_handle_vblank_timeout(struct drm_crtc *crtc)
 {
-	struct vmw_display_unit *du = container_of(timer, struct vmw_display_unit, vkms.timer);
-	struct drm_crtc *crtc = &du->crtc;
+	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 	struct vmw_private *vmw = vmw_priv(crtc->dev);
 	bool has_surface = false;
-	u64 ret_overrun;
 	bool locked, ret;
 
-	ret_overrun = hrtimer_forward_now(&du->vkms.timer,
-					  du->vkms.period_ns);
-	if (ret_overrun != 1)
-		drm_dbg_driver(crtc->dev, "vblank timer missed %lld frames.\n",
-			       ret_overrun - 1);
-
 	locked = vmw_vkms_vblank_trylock(crtc);
 	ret = drm_crtc_handle_vblank(crtc);
 	WARN_ON(!ret);
 	if (!locked)
-		return HRTIMER_RESTART;
+		return true;
 	has_surface = du->vkms.surface != NULL;
 	vmw_vkms_unlock(crtc);
 
@@ -200,6 +192,27 @@ vmw_vkms_vblank_simulate(struct hrtimer *timer)
 			drm_dbg_driver(crtc->dev, "Composer worker already queued\n");
 	}
 
+	return true;
+}
+
+static enum hrtimer_restart
+vmw_vkms_vblank_simulate(struct hrtimer *timer)
+{
+	struct vmw_display_unit *du = container_of(timer, struct vmw_display_unit, vkms.timer);
+	struct drm_crtc *crtc = &du->crtc;
+	u64 ret_overrun;
+	bool success;
+
+	ret_overrun = hrtimer_forward_now(&du->vkms.timer,
+					  du->vkms.period_ns);
+	if (ret_overrun != 1)
+		drm_dbg_driver(crtc->dev, "vblank timer missed %lld frames.\n",
+			       ret_overrun - 1);
+
+	success = vmw_vkms_handle_vblank_timeout(crtc);
+	if (!success)
+		return HRTIMER_NORESTART;
+
 	return HRTIMER_RESTART;
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h
index 69ddd33a8444..0b6bbf7c4487 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h
@@ -45,6 +45,7 @@ bool vmw_vkms_modeset_lock_relaxed(struct drm_crtc *crtc);
 bool vmw_vkms_vblank_trylock(struct drm_crtc *crtc);
 void vmw_vkms_unlock(struct drm_crtc *crtc);
 
+bool vmw_vkms_handle_vblank_timeout(struct drm_crtc *crtc);
 bool vmw_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 				   int *max_error,
 				   ktime_t *vblank_time,
-- 
2.54.0

