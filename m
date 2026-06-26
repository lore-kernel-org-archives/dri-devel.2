Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35128C44502
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E8110F5CE;
	Fri, 26 Jun 2026 13:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="QCJhaTt9";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19FC310F5C8;
 Fri, 26 Jun 2026 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782481320;
 bh=cQJ+/My1yGCFFoJg8C+cw2ag6ScIvaGNw4in4m2KFus=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QCJhaTt9y3zPX0TgyVq9wEVuvJIDHEn8KVZdLZXg/ET6ICN7mBctBavTm16onowm6
 1z5UBsFD1X1Qelp2bvshw4UodFkUPiX6vg9LCjkk1BWPK6kuHbe3+Xb8LBStMgar/+
 z0IPZ+1Q8T2JqnsP8wWyihwkDaRCrc5Ll+sCZ8kQtgnUBAtiLET0cjUBnEVIyjopKA
 Ud2QJJ1gxHq2R4j638BzunT55o6g7n4DewGcpPqygU9UcwZI8ER1/t2DA5HEiTxWJr
 RphnyfkS7XKes9/dAkAOORzurpqy86MieMTpg85zKTZcmO4QHywmFANxDZrVgTBe66
 498u3BLdJxoCw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [PATCH v10.5 05/29] drm/i915/display: Move vblank put until after
 critical section
Date: Fri, 26 Jun 2026 15:41:56 +0200
Message-ID: <20260626134222.1198252-6-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626134222.1198252-1-dev@lankhorst.se>
References: <20260626134222.1198252-1-dev@lankhorst.se>
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

drm_crtc_vblank_put may take some locks, this should probably
not be the first thing we do after entering the time sensitive
part.

A better place is after programming is completed. Add a flag
to put the vblank after completion.

In the case of drm_vblank_work_schedule, we may not even need
to disable the vblank interrupt any more if it takes its own
reference.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cursor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 88384dea868b4..68b44a00567e4 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -816,6 +816,7 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 		to_intel_crtc_state(crtc->base.state);
 	struct intel_crtc_state *new_crtc_state;
 	struct intel_vblank_evade_ctx evade;
+	bool has_vblank = false;
 	int ret;
 
 	/*
@@ -913,6 +914,8 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 	intel_psr_lock(crtc_state);
 
 	if (!drm_WARN_ON(display->drm, drm_crtc_vblank_get(&crtc->base))) {
+		has_vblank = true;
+
 		/*
 		 * TODO: maybe check if we're still in PSR
 		 * and skip the vblank evasion entirely?
@@ -922,8 +925,6 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 		local_irq_disable();
 
 		intel_vblank_evade(&evade);
-
-		drm_crtc_vblank_put(&crtc->base);
 	} else {
 		local_irq_disable();
 	}
@@ -939,6 +940,9 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 
 	intel_psr_unlock(crtc_state);
 
+	if (has_vblank)
+		drm_crtc_vblank_put(&crtc->base);
+
 	if (old_plane_state->ggtt_vma != new_plane_state->ggtt_vma) {
 		drm_vblank_work_init(&old_plane_state->unpin_work, &crtc->base,
 				     intel_cursor_unpin_work);
-- 
2.53.0

