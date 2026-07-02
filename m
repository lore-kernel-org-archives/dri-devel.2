Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B532AC44501
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05BC10F1A3;
	Thu,  2 Jul 2026 07:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="CFYXjPJ6";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56BD10F19D;
 Thu,  2 Jul 2026 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782976887;
 bh=ocXAHjhIgSwKD8HbIDdUs8teuS52aV3hmnhlWYgVFYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CFYXjPJ69OIAV61MYqaT1Y6M6wagOdhMsKaCr1OI57RrhMwNqKYz9n0LKjqWFL9eT
 0dUBkUwPqXG6bsCAna8uLbKjP9DO6kDgANdxcIgPENR3VW05yKp9JkYJiK2hj53uel
 JhoaKInOMPwzUiBZERmKRsgyrhrqPHIdVO0QD2TvAro3hL8JS6lfi2SJGnOZsewxL3
 ZImrOBKIzZS3n0oo1CTzg/0HgSL5b4Z8zfC0hcsHzrPciDe6R6SEty4pvObx+KC4gb
 E5870Mks7FUDrxdRnUhMQ+IH9kT0mMAYDcEJbxnnWDsBsxxhc7lTiWAhk5TwSbaBHu
 IHW2NtBudmFVQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Mike Galbraith <umgwanakikbuti@gmail.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Maarten Lankhorst <dev@lankhorst.se>, Uma Shankar <uma.shankar@intel.com>
Subject: [PATCH 08/10] drm/i915: Use preempt_disable/enable_rt() where
 recommended
Date: Thu,  2 Jul 2026 09:21:51 +0200
Message-ID: <20260702072154.171324-9-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702072154.171324-1-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mike Galbraith <umgwanakikbuti@gmail.com>

Mario Kleiner suggest in commit
  ad3543ede630f ("drm/intel: Push get_scanout_position() timestamping into kms driver.")

a spots where preemption should be disabled on PREEMPT_RT. The
difference is that on PREEMPT_RT the intel_uncore::lock disables neither
preemption nor interrupts and so region remains preemptible.

The area covers only register reads and writes. The part that worries me
is:
- __intel_get_crtc_scanline() the worst case is 100us if no match is
  found.

- intel_crtc_scanlines_since_frame_timestamp() not sure how long this
  may take in the worst case.

It was in the RT queue for a while and nobody complained.
Disable preemption on PREEPMPT_RT during timestamping.

[bigeasy: patch description.]

Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 43 ++++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index 6f1fa952b5391..07dca05332e5b 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -316,6 +316,20 @@ static void intel_vblank_section_exit(struct intel_display *display)
 	struct intel_uncore *uncore = to_intel_uncore(display->drm);
 	spin_unlock(&uncore->lock);
 }
+
+static void intel_vblank_section_enter_irqf(struct intel_display *display, unsigned long *flags)
+	__acquires(i915->uncore.lock)
+{
+	struct intel_uncore *uncore = to_intel_uncore(display->drm);
+	spin_lock_irqsave(&uncore->lock, *flags);
+}
+
+static void intel_vblank_section_exit_irqf(struct intel_display *display, unsigned long flags)
+	__releases(i915->uncore.lock)
+{
+	struct intel_uncore *uncore = to_intel_uncore(display->drm);
+	spin_unlock_irqrestore(&uncore->lock, flags);
+}
 #else
 static void intel_vblank_section_enter(struct intel_display *display)
 {
@@ -324,6 +338,17 @@ static void intel_vblank_section_enter(struct intel_display *display)
 static void intel_vblank_section_exit(struct intel_display *display)
 {
 }
+
+static void intel_vblank_section_enter_irqf(struct intel_display *display, unsigned long *flags)
+{
+	*flags = 0;
+}
+
+static void intel_vblank_section_exit_irqf(struct intel_display *display, unsigned long flags)
+{
+	if (flags)
+		return;
+}
 #endif
 
 static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
@@ -360,10 +385,10 @@ static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
 	 * timing critical raw register reads, potentially with
 	 * preemption disabled, so the following code must not block.
 	 */
-	local_irq_save(irqflags);
-	intel_vblank_section_enter(display);
+	intel_vblank_section_enter_irqf(display, &irqflags);
 
-	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -427,10 +452,10 @@ static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
 	if (etime)
 		*etime = ktime_get();
 
-	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 
-	intel_vblank_section_exit(display);
-	local_irq_restore(irqflags);
+	intel_vblank_section_exit_irqf(display, irqflags);
 
 	/*
 	 * While in vblank, position will be negative
@@ -468,13 +493,11 @@ int intel_get_crtc_scanline(struct intel_crtc *crtc)
 	unsigned long irqflags;
 	int position;
 
-	local_irq_save(irqflags);
-	intel_vblank_section_enter(display);
+	intel_vblank_section_enter_irqf(display, &irqflags);
 
 	position = __intel_get_crtc_scanline(crtc);
 
-	intel_vblank_section_exit(display);
-	local_irq_restore(irqflags);
+	intel_vblank_section_exit_irqf(display, irqflags);
 
 	return position;
 }
-- 
2.53.0

