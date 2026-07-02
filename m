Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E8DC44502
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D540D10F191;
	Thu,  2 Jul 2026 07:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="PI9jR5aF";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499B010E097;
 Thu,  2 Jul 2026 07:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782976884;
 bh=SmCb7iPHg2+9A/ixj9TBOSkQYHIyXxixNZ3hoWoXINI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PI9jR5aFXOoUYnaJnzk59u92l7X2xXIZEBwdESRdWrHq5HITAz3QU2v1BSP5lDuVx
 ZSb3tIcCAgEm6afdJ4B9qFhTF4uaiyi4LXpbB12e54gIKcoW2ZZTJBj29wRY6FoZWP
 AbgWXn7tTPF8k4zezQc5S8yi/UXP0FVNiJBu/Wj57C2UwlQTKL2LOfN+YYOyqAS0jN
 9obFYm/I0HlNcetiuxxJJy6hNbJ9QvyNo0xLskOUHgzAyRZlvLpnxbtKmVhQF+YBFe
 UdsH3YYGabRRFEeb9SBAlJIQSn2xtPB8yzqcC63yYT6RNHvnQVyG4lSLv47Y0fQWvl
 9LAPbkFgFVHcQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 03/10] drm/intel/display: Make intel_crtc_arm_vblank_event
 static
Date: Thu,  2 Jul 2026 09:21:46 +0200
Message-ID: <20260702072154.171324-4-dev@lankhorst.se>
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

Only used inside intel_crtc.c now, so no need to export it any more.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_crtc.c | 2 +-
 drivers/gpu/drm/i915/display/intel_crtc.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 10ed9bdfee763..805645318747f 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -684,7 +684,7 @@ static void dbg_vblank_evade(struct intel_crtc *crtc, ktime_t end)
 static void dbg_vblank_evade(struct intel_crtc *crtc, ktime_t end) {}
 #endif
 
-void intel_crtc_arm_vblank_event(struct intel_crtc_state *crtc_state)
+static void intel_crtc_arm_vblank_event(struct intel_crtc_state *crtc_state)
 {
 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
 	unsigned long irqflags;
diff --git a/drivers/gpu/drm/i915/display/intel_crtc.h b/drivers/gpu/drm/i915/display/intel_crtc.h
index 12507b51ee77e..f65cbafe2b42a 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.h
+++ b/drivers/gpu/drm/i915/display/intel_crtc.h
@@ -33,7 +33,6 @@ int intel_usecs_to_scanlines(const struct drm_display_mode *adjusted_mode,
 			     int usecs);
 int intel_scanlines_to_usecs(const struct drm_display_mode *adjusted_mode,
 			     int scanlines);
-void intel_crtc_arm_vblank_event(struct intel_crtc_state *crtc_state);
 void intel_crtc_prepare_vblank_event(struct intel_crtc_state *crtc_state,
 				     struct drm_pending_vblank_event **event);
 u32 intel_crtc_max_vblank_count(const struct intel_crtc_state *crtc_state);
-- 
2.53.0

