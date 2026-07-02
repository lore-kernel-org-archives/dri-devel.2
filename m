Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A7AC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8007210F1A2;
	Thu,  2 Jul 2026 07:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="gYoiypEL";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB62F10F1A1;
 Thu,  2 Jul 2026 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782976888;
 bh=ALbia/61W347pafx6roK8tZ0v9st1/H0ivVM62ph0GU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gYoiypEL31qxiomEe5WRTCpwJpTkdc6F0qfPvg/nUKX6Pjf1aJlmw9FCsc4fbuljl
 wNLEnXx4dVhImuzD7oqNhiRBqgFSlOgsIxTBuboLHXEXVwpeiQ1z2iqfrRrf7ED6Zx
 E4VAa8l9B8CiB/RuT9eAwoHjR+3Ufa2nOiKsd1fqmysohufLBCeNG0T+D7cBYbJaUw
 jFY1zOmphqMZ9c6t6z3Ci2vbWLyZTqObFsBBfo/DeYAYuKhsvATEMtPN+4RtO2L9tj
 dfsPIc17YS04yYwNVDibQtcV0qaAnstQHxXCZvMCqaZ18MDn/IeH1b/4sPheC9UOZ9
 pZekcEfKb+0UA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 10/10] drm/i915/display: Do not take uncore lock in
 i915_get_vblank_counter
Date: Thu,  2 Jul 2026 09:21:53 +0200
Message-ID: <20260702072154.171324-11-dev@lankhorst.se>
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

This fixes a lockdep splat that occurs in the code that should be run
with interrupts disabled. The uncore and DMC locks should not be taken
and released repeatedly in a timing sensitive path.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_de.h       |  8 ++++++
 drivers/gpu/drm/i915/display/intel_vblank.c   |  4 +--
 drivers/gpu/drm/i915/intel_uncore.h           | 26 +++++++++++++------
 .../drm/xe/compat-i915-headers/intel_uncore.h |  7 +++++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_de.h b/drivers/gpu/drm/i915/display/intel_de.h
index 1029790194296..497a308322847 100644
--- a/drivers/gpu/drm/i915/display/intel_de.h
+++ b/drivers/gpu/drm/i915/display/intel_de.h
@@ -65,6 +65,14 @@ intel_de_read64_2x32(struct intel_display *display, intel_reg_t reg)
 	return (u64)upper << 32 | lower;
 }
 
+static inline u64
+intel_de_read64_2x32_fw(struct intel_display *display,
+			i915_reg_t lower_reg, i915_reg_t upper_reg)
+{
+	return intel_uncore_read64_2x32_fw(__to_uncore(display),
+					   lower_reg, upper_reg);
+}
+
 static inline void
 intel_de_posting_read(struct intel_display *display, intel_reg_t reg)
 {
diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index c0cc0a4c25dbe..5ca22899055d7 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -109,8 +109,8 @@ u32 i915_get_vblank_counter(struct drm_crtc *crtc)
 	 * we get a low value that's stable across two reads of the high
 	 * register.
 	 */
-	frame = intel_de_read64_2x32_volatile(display, PIPEFRAMEPIXEL(display, pipe),
-					      PIPEFRAME(display, pipe));
+	frame = intel_de_read64_2x32_fw(display, PIPEFRAMEPIXEL(display, pipe),
+				        PIPEFRAME(display, pipe));
 
 	pixel = frame & PIPE_PIXEL_MASK;
 	frame = (frame >> PIPE_FRAME_LOW_SHIFT) & 0xffffff;
diff --git a/drivers/gpu/drm/i915/intel_uncore.h b/drivers/gpu/drm/i915/intel_uncore.h
index fafc2ca9a2376..507398a562649 100644
--- a/drivers/gpu/drm/i915/intel_uncore.h
+++ b/drivers/gpu/drm/i915/intel_uncore.h
@@ -449,13 +449,28 @@ static inline void intel_uncore_rmw_fw(struct intel_uncore *uncore,
 		intel_uncore_write_fw(uncore, reg, val);
 }
 
+static inline u64
+intel_uncore_read64_2x32_fw(struct intel_uncore *uncore,
+			    i915_reg_t lower_reg, i915_reg_t upper_reg)
+{
+	u32 upper, lower, old_upper, loop = 0;
+	upper = intel_uncore_read_fw(uncore, upper_reg);
+	do {
+		old_upper = upper;
+		lower = intel_uncore_read_fw(uncore, lower_reg);
+		upper = intel_uncore_read_fw(uncore, upper_reg);
+	} while (upper != old_upper && loop++ < 2);
+
+	return (u64)upper << 32 | lower;
+}
+
 static inline u64
 intel_uncore_read64_2x32(struct intel_uncore *uncore,
 			 i915_reg_t lower_reg, i915_reg_t upper_reg)
 {
-	u32 upper, lower, old_upper, loop = 0;
 	enum forcewake_domains fw_domains;
 	unsigned long flags;
+	u64 ret;
 
 	fw_domains = intel_uncore_forcewake_for_reg(uncore, lower_reg,
 						    FW_REG_READ);
@@ -466,17 +481,12 @@ intel_uncore_read64_2x32(struct intel_uncore *uncore,
 	spin_lock_irqsave(&uncore->lock, flags);
 	intel_uncore_forcewake_get__locked(uncore, fw_domains);
 
-	upper = intel_uncore_read_fw(uncore, upper_reg);
-	do {
-		old_upper = upper;
-		lower = intel_uncore_read_fw(uncore, lower_reg);
-		upper = intel_uncore_read_fw(uncore, upper_reg);
-	} while (upper != old_upper && loop++ < 2);
+	ret = intel_uncore_read64_2x32_fw(uncore, lower_reg, upper_reg);
 
 	intel_uncore_forcewake_put__locked(uncore, fw_domains);
 	spin_unlock_irqrestore(&uncore->lock, flags);
 
-	return (u64)upper << 32 | lower;
+	return ret;
 }
 
 static inline int intel_uncore_write_and_verify(struct intel_uncore *uncore,
diff --git a/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h b/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h
index 08d7ab9336725..764bc94044537 100644
--- a/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h
@@ -74,6 +74,13 @@ intel_uncore_read64_2x32(struct intel_uncore *uncore,
 	return (u64)upper << 32 | lower;
 }
 
+static inline u64
+intel_uncore_read64_2x32_fw(struct intel_uncore *uncore,
+			    i915_reg_t i915_lower_reg, i915_reg_t i915_upper_reg)
+{
+	return intel_uncore_read64_2x32(uncore, i915_lower_reg, i915_upper_reg);
+}
+
 static inline void intel_uncore_posting_read(struct intel_uncore *uncore,
 					     i915_reg_t i915_reg)
 {
-- 
2.53.0

