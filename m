Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36232C4450A
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C469210F61D;
	Fri, 26 Jun 2026 13:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="Btncb1ix";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E0110F5E5;
 Fri, 26 Jun 2026 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782481336;
 bh=veyMqeP/HHsUinNhNIPK3SHl0Euc6gBrTNuDuscCi+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Btncb1ixxX3rcbBCSTF7ntd9MNkyKUosDbDx/ai9CRzW9jLCfir8ZkUeVv394Dz9n
 KU+e3L9F/yskwDdH6Y2rn7ZsKInrnIbKXAjYSyKd7KpHA1QTrorj7SPeJOwdOyW+9/
 N/YKg1EQEr8w33X6Vw+mvRm9aDcE1shqfowhak/Lpw/R0LueDr52ucFuuNT7qdJ12+
 XJQgKH/Nxz9fBgbmqw8kXRQrzc8kM9qjGJKAkyN7bkgBEIc/ezsgZpKq3zCwPEgxco
 F5DOXNL3rKUeanX6Sz1hHvEP240bm+AgBYtW0ga0nPkYsaqQCY1vJ3Ld0tISNxCT6Z
 wGKabD2VJIAmw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v10.5 28/29] drm/xe/display: Do not allocate into stolen for
 new framebuffers.
Date: Fri, 26 Jun 2026 15:42:19 +0200
Message-ID: <20260626134222.1198252-29-dev@lankhorst.se>
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

Prefer to use system memory for global framebuffers, and reserve
the space for FBC use only.

Now that multiple CRTC's can use FBC's, the simple heuristic
of using less than half of stolen is no longer sufficient.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/display/xe_display_bo.c | 33 ++++------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/drm/xe/display/xe_display_bo.c
index a5080f6540d46..1bde12b509fcb 100644
--- a/drivers/gpu/drm/xe/display/xe_display_bo.c
+++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
@@ -153,33 +153,12 @@ static struct drm_gem_object *xe_display_bo_fbdev_create(struct drm_device *drm,
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

