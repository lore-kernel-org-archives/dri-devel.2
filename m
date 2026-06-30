Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A762C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81A110E4FA;
	Tue, 30 Jun 2026 13:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="Ep7r22/f";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A923A10E031;
 Tue, 30 Jun 2026 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782827696;
 bh=oNkepqcqEIwChWafyJvxfUpZ4AudGhXqsyT2S+wrmsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ep7r22/f5J4YlG0VoYrr1lja/IEIUX8R0WWEeoH2/wLrb8tFGOISCMkd7R1/kuZio
 IiDLRAkzwCklS6muUFxm2Ni43bPWnLIW5NZARGGhW4T4ldP1zqW5GOTn4y0SkxRisC
 cLZUt8gC+wPjTiE1Tlm2Kmxbm1ZLmTn61JNmF0Bhv8qBvymJ2KwvD7+wjUnyfrqRMy
 QgA1dPlA1aWe+hWMd6Yld6xX095FYHLcZgFUTQVpkAbXGNiPhA/HqqCMlj/0c3+s3C
 HmsG+EG1+jj/Kn0LhiUAl0JQqYwS3d3dH64qFWxCTM2pShhTuMzEw8UtChdulGIvFN
 ATh0ufugZo7OA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 3/3] drm/xe/display: Do not allocate into stolen for new
 framebuffers.
Date: Tue, 30 Jun 2026 15:55:22 +0200
Message-ID: <20260630135523.1775379-4-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630135523.1775379-1-dev@lankhorst.se>
References: <20260630135523.1775379-1-dev@lankhorst.se>
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

Prefer to use system memory for global framebuffers, and reserve
the space for FBC use only.

Now that multiple CRTC's can use FBC's, the simple heuristic
of using less than half of stolen is no longer sufficient.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/display/xe_display_bo.c | 33 ++++------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/drm/xe/display/xe_display_bo.c
index 677ae3af9ac0c..04d4204b37a53 100644
--- a/drivers/gpu/drm/xe/display/xe_display_bo.c
+++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
@@ -154,33 +154,12 @@ static struct drm_gem_object *xe_display_bo_fbdev_create(struct drm_device *drm,
 	struct xe_device *xe = to_xe_device(drm);
 	struct xe_bo *obj;
 
-	obj = ERR_PTR(-ENODEV);
-
-	if (xe_display_bo_fbdev_prefer_stolen(xe, size)) {
-		obj = xe_bo_create_pin_map_novm(xe, xe_device_get_root_tile(xe),
-						size,
-						ttm_bo_type_kernel,
-						XE_BO_FLAG_FORCE_WC |
-						XE_BO_FLAG_STOLEN |
-						XE_BO_FLAG_GGTT,
-						false);
-		if (!IS_ERR(obj))
-			drm_info(&xe->drm, "Allocated fbdev into stolen\n");
-		else
-			drm_info(&xe->drm, "Allocated fbdev into stolen failed: %li\n", PTR_ERR(obj));
-	} else {
-		drm_info(&xe->drm, "Allocating fbdev: Stolen memory not preferred.\n");
-	}
-
-	if (IS_ERR(obj)) {
-		obj = xe_bo_create_pin_map_novm(xe, xe_device_get_root_tile(xe), size,
-						ttm_bo_type_kernel,
-						XE_BO_FLAG_FORCE_WC |
-						XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
-						XE_BO_FLAG_GGTT,
-						false);
-	}
-
+	obj = xe_bo_create_pin_map_novm(xe, xe_device_get_root_tile(xe), size,
+					ttm_bo_type_kernel,
+					XE_BO_FLAG_FORCE_WC |
+					XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
+					XE_BO_FLAG_GGTT,
+					false);
 	if (IS_ERR(obj)) {
 		drm_err(&xe->drm, "failed to allocate framebuffer (%pe)\n", obj);
 		return ERR_PTR(-ENOMEM);
-- 
2.53.0

