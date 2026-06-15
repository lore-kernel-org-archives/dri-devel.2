Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21667CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BC810E6A3;
	Mon, 15 Jun 2026 20:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="DvQSe4Un";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA8210E68E;
 Mon, 15 Jun 2026 20:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1781554729;
 bh=rFyIJr/5ItYxtHFx9GPLcQKPSSM1zAWX5HycYL8oBWU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DvQSe4UngBVkaI4HZIErFo+CqL+MdGbwYGsLYwZehMs+C7LTq33oxmgYqY2i6PFUL
 D+Y9HE/AmGqTBHa0N6zIxcCyyKx+rPPckNiHpXaLDmyxKDxNJwuuMDqmxYIDkliqx7
 Qd4bN60cDGTv28lGv5l1qMkC6SZkcqnHIaXQfiY8E2hJNvR+iq6ks/3VpHzpnbXTFi
 XckfE/jBrPH6+pFznkX/Eym4Sw2j0Cd/mdYEZloLqwCDbsMMbl1v1km1bhhlsKH6/O
 eWHzIMDg0N2qznT2QpDvQXw8m+G+Ponp7vkVFkSKWpxLCO09ESUPw1bI/DzYEx6AlZ
 KT0wKiY9R0fBg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v8 27/27] drm/xe/display: Prefer not to allocate a
 framebuffers in stolen memory
Date: Mon, 15 Jun 2026 22:18:45 +0200
Message-ID: <20260615201846.307297-28-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615201846.307297-1-dev@lankhorst.se>
References: <20260615201846.307297-1-dev@lankhorst.se>
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

For the same reasons as using stolen memory for DPT, it's also a bad
idea for framebuffers. Allocate new framebuffers always in system memory
when we don't inherit them, and prohibit inheriting stolen framebuffers
when CONFIG_PREEMPT_RT is enabled.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/display/xe_display_bo.c | 35 +++++-----------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/drm/xe/display/xe_display_bo.c
index 7fbac223b0977..5b54d247cb212 100644
--- a/drivers/gpu/drm/xe/display/xe_display_bo.c
+++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
@@ -127,7 +127,7 @@ bool xe_display_bo_fbdev_prefer_stolen(struct xe_device *xe, unsigned int size)
 	if (!stolen)
 		return false;
 
-	if (IS_DGFX(xe))
+	if (IS_DGFX(xe) || IS_ENABLED(CONFIG_PREEMPT_RT))
 		return false;
 
 	if (XE_DEVICE_WA(xe, 22019338487_display))
@@ -146,33 +146,12 @@ static struct drm_gem_object *xe_display_bo_fbdev_create(struct drm_device *drm,
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

