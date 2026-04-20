Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1984F588C2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7CF10E597;
	Mon, 20 Apr 2026 12:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="eAKpRKNB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UihuWR5v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eAKpRKNB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UihuWR5v";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938D810E597
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:52:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3EF3F5BCD2;
 Mon, 20 Apr 2026 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776689547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DaVPvgyfDTCuL2vL0og8o+J1SC3wf6QM2Ry7EZHNGkY=;
 b=eAKpRKNBXi99BnJ1A2+3lNHmFiQe93MEv20pQAyvBZ/E54PrDGZCOx6SrKA3j4+b6Jen6q
 LCtfP+2GwnmGX4Vs650m6lZH4HP9Ylozzo8iI/E7Hyp1UK1WHa7/3s+NU2jNasvjUS7gPh
 FXhl1qfN48SVALhyF2/0wTOrS3Evbfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776689547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DaVPvgyfDTCuL2vL0og8o+J1SC3wf6QM2Ry7EZHNGkY=;
 b=UihuWR5vC8MTFSU9Fadm3SqsmuDkMr/DqrBArHJkui8I3Ox6uZlr8mn9UXfKbKYr68qK5s
 cNfJ/qS1XmXe1BDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eAKpRKNB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UihuWR5v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776689547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DaVPvgyfDTCuL2vL0og8o+J1SC3wf6QM2Ry7EZHNGkY=;
 b=eAKpRKNBXi99BnJ1A2+3lNHmFiQe93MEv20pQAyvBZ/E54PrDGZCOx6SrKA3j4+b6Jen6q
 LCtfP+2GwnmGX4Vs650m6lZH4HP9Ylozzo8iI/E7Hyp1UK1WHa7/3s+NU2jNasvjUS7gPh
 FXhl1qfN48SVALhyF2/0wTOrS3Evbfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776689547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DaVPvgyfDTCuL2vL0og8o+J1SC3wf6QM2Ry7EZHNGkY=;
 b=UihuWR5vC8MTFSU9Fadm3SqsmuDkMr/DqrBArHJkui8I3Ox6uZlr8mn9UXfKbKYr68qK5s
 cNfJ/qS1XmXe1BDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09FD4593AE;
 Mon, 20 Apr 2026 12:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Y4EAYsh5mmZDQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 12:52:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/amdgpu: Replace VKMS vblank timer with common
 implementation
Date: Mon, 20 Apr 2026 14:51:53 +0200
Message-ID: <20260420125223.234974-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3EF3F5BCD2
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

Replace amdgpu's custom vblank timers with the shared implementation
in DRM's vblank code. Both are built upon hrtimers. The vblank logic
is identical.

The shared helpers contain all initialization internally. They also
handle a number of deadlocks and race conditions that are present in
amdgpu.

Also remove the set-but-unused field vsync_timer_enabled from struct
amdgpu_crtc.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 123 +----------------------
 2 files changed, 3 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 51ab1a332615..8069fc41cc7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -38,7 +38,6 @@
 #include <drm/drm_probe_helper.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
-#include <linux/hrtimer.h>
 #include "amdgpu_irq.h"
 
 #include <drm/display/drm_dp_mst_helper.h>
@@ -505,9 +504,6 @@ struct amdgpu_crtc {
 	u32 line_time;
 	u32 lb_vblank_lead_lines;
 	struct drm_display_mode hw_mode;
-	/* for virtual dce */
-	struct hrtimer vblank_timer;
-	enum amdgpu_interrupt_state vsync_timer_enabled;
 
 	int otg_inst;
 	struct drm_pending_vblank_event *event;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index e54295b56282..9f497e9c65b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -5,6 +5,7 @@
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_vblank_helper.h>
 
 #include "amdgpu.h"
 #ifdef CONFIG_DRM_AMDGPU_SI
@@ -42,81 +43,6 @@ static const u32 amdgpu_vkms_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
-static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
-{
-	struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct amdgpu_crtc, vblank_timer);
-	struct drm_crtc *crtc = &amdgpu_crtc->base;
-	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
-	u64 ret_overrun;
-	bool ret;
-
-	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
-					  output->period_ns);
-	if (ret_overrun != 1)
-		drm_warn(amdgpu_crtc->base.dev,
-			 "%s: vblank timer overrun count: %llu\n",
-			 __func__, ret_overrun);
-
-	ret = drm_crtc_handle_vblank(crtc);
-	/* Don't queue timer again when vblank is disabled. */
-	if (!ret)
-		return HRTIMER_NORESTART;
-
-	return HRTIMER_RESTART;
-}
-
-static int amdgpu_vkms_enable_vblank(struct drm_crtc *crtc)
-{
-	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-	drm_calc_timestamping_constants(crtc, &crtc->mode);
-
-	out->period_ns = ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns, HRTIMER_MODE_REL);
-
-	return 0;
-}
-
-static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
-{
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
-}
-
-static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-					     int *max_error,
-					     ktime_t *vblank_time,
-					     bool in_vblank_irq)
-{
-	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
-	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-	if (!READ_ONCE(vblank->enabled)) {
-		*vblank_time = ktime_get();
-		return true;
-	}
-
-	*vblank_time = READ_ONCE(amdgpu_crtc->vblank_timer.node.expires);
-
-	if (WARN_ON(*vblank_time == vblank->time))
-		return true;
-
-	/*
-	 * To prevent races we roll the hrtimer forward before we do any
-	 * interrupt processing - this is how real hw works (the interrupt is
-	 * only generated after all the vblank registers are updated) and what
-	 * the vblank core expects. Therefore we need to always correct the
-	 * timestampe by one frame.
-	 */
-	*vblank_time -= output->period_ns;
-
-	return true;
-}
-
 static const struct drm_crtc_funcs amdgpu_vkms_crtc_funcs = {
 	.set_config             = drm_atomic_helper_set_config,
 	.destroy                = drm_crtc_cleanup,
@@ -124,45 +50,11 @@ static const struct drm_crtc_funcs amdgpu_vkms_crtc_funcs = {
 	.reset                  = drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
-	.enable_vblank		= amdgpu_vkms_enable_vblank,
-	.disable_vblank		= amdgpu_vkms_disable_vblank,
-	.get_vblank_timestamp	= amdgpu_vkms_get_vblank_timestamp,
+	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 
-static void amdgpu_vkms_crtc_atomic_enable(struct drm_crtc *crtc,
-					   struct drm_atomic_state *state)
-{
-	drm_crtc_vblank_on(crtc);
-}
-
-static void amdgpu_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
-					    struct drm_atomic_state *state)
-{
-	drm_crtc_vblank_off(crtc);
-}
-
-static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
-					  struct drm_atomic_state *state)
-{
-	unsigned long flags;
-	if (crtc->state->event) {
-		spin_lock_irqsave(&crtc->dev->event_lock, flags);
-
-		if (drm_crtc_vblank_get(crtc) != 0)
-			drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		else
-			drm_crtc_arm_vblank_event(crtc, crtc->state->event);
-
-		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
-
-		crtc->state->event = NULL;
-	}
-}
-
 static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs = {
-	.atomic_flush	= amdgpu_vkms_crtc_atomic_flush,
-	.atomic_enable	= amdgpu_vkms_crtc_atomic_enable,
-	.atomic_disable	= amdgpu_vkms_crtc_atomic_disable,
+	DRM_CRTC_HELPER_VBLANK_FUNCS,
 };
 
 static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
@@ -187,10 +79,6 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
-	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
-
-	hrtimer_setup(&amdgpu_crtc->vblank_timer, &amdgpu_vkms_vblank_simulate, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
 
 	return ret;
 }
@@ -538,11 +426,6 @@ static int amdgpu_vkms_sw_init(struct amdgpu_ip_block *ip_block)
 static int amdgpu_vkms_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i = 0;
-
-	for (i = 0; i < adev->mode_info.num_crtc; i++)
-		if (adev->mode_info.crtcs[i])
-			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 	drm_mode_config_cleanup(adev_to_drm(adev));
-- 
2.53.0

