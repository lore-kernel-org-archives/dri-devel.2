Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F40F9D0F2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 20:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FD110E0E9;
	Tue, 14 Apr 2026 20:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="QDsh1zIP";
	dkim-atps=neutral
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3759D10E0E9
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 20:08:30 +0000 (UTC)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7dbd801138eso2783082a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776197309; x=1776802109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9j7f/4mioeVjvt1pTXWziJkwL8qV79excVcLWtLqKHM=;
 b=OArr9miYYIDvn67xtDDDOAoBo5Ohl2jQS+o07+CzKrOxGH3PK9hG8iOSjK9vEkhVcY
 02s7PfpZxGzM+aBJj9zhz8EgQH+DJSTSewYfg/po+gOylAly86FEJoXhHiTFarRkL4/v
 eK0l9gUbr650t4Crs3MABgAQyv5ctgWdXLXnhWKAh3v2pvrssBBdYX4Mza9EbGoiG8dv
 P5nuXTwLfgXWU+6jydcM3/npU0YV+L0V/qIF2DIcOs8Kpo+rrl6USNhi1bRDN9HZ11S1
 9H+fiNlq0q9ZYBeHn8al6oM3D6i/ptBc7U1vG7LIU+wgvDXE20+/IPkVbgNUf6v1uA/S
 y6Mw==
X-Gm-Message-State: AOJu0YwIJbhKUAoWcLjsgUsSxVsaGxgInB57o1+UO9OujDmTggH9ihLp
 WdmG8O1tG16gPUsxuGB/c+vuoh96tsZWR6vdN8FSyAIhWSte8vhR+fX16kgMXKYLI/oy/NlGTTU
 aEDNXX7fBPI9gx4MN40d49viDgNc1S8vanmIqpKz58agAtMCzEhSKdrF/FMv+49ZG5ZFHECFXQT
 ouB6AU6WbOAJUKBykuhDbeTf27qChyGnYSPeQFrlUXrLZLlskq5/ZlM3lIxPugO847lWbc5bItw
 wsuQhNLnKSfrazYL27C
X-Gm-Gg: AeBDieu1A/T6PAKTOMZ6yimuPBikTYLnf12VzNn6bioWGXHUI7zZi54YpsruIyN1nRU
 363+p+AkSkB29S6Jxe5zPy5kGDlTBizfYINq0h5BkKrTVTodYmUnvyaK5z9fYI0Rl26u5MPD2o7
 Q66zsCvM4H3vCjjBze0yR1qpyUrxbWRyhtvE4BOYdO59aBl+mWc0qeXu57aR7wzmWckH4xMw9Bp
 r4w1bZuYiEUP9z6vPG1jitfLyv6rMF2Za1S2MX0gh9zaH+u3gdB0TR7sSMq66f3POlUdXZPpv0+
 7npWQPrZqZmqcIjgDX+KChmDDmkcrYyw3qEJe9B6cCzrLXBRtgsyzbtg6rA6BSwI2wfpFW9U2PC
 PMTYrAomHr6/Zb6obRfYPxr7NO+O1bM5dyz3z/vm+bUEy9lJnQB/fwwqndbNAIX94wYiAEtvEfH
 ixQnll4Z2/ngaZfr0VB2whzWuUswknVAHw8HluzLQygi0sneEOcSzXqSvw4aXD99dp
X-Received: by 2002:a05:6820:1505:b0:683:310:77c0 with SMTP id
 006d021491bc7-68bf83c8996mr8049049eaf.23.1776197309055; 
 Tue, 14 Apr 2026 13:08:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-68bca5f87dbsm1051474eaf.16.2026.04.14.13.08.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 13:08:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d8c521be48so1742783eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776197307; x=1776802107;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9j7f/4mioeVjvt1pTXWziJkwL8qV79excVcLWtLqKHM=;
 b=QDsh1zIPkdM0eU/vczqE5f9rHhB9CGgqWFMYRTncH8eZD21QXxg06ytINAWZL21TeW
 04vStu4vDj+ivJFf9K8zGDl4fzUM6YPk+Hl0tsbo03fjOc/p3MMRiXQWNy04T4NvamAi
 Ieo/igRxwYR9tWuScYm4kA2gXDqjBgp7pXl4I=
X-Received: by 2002:a05:7022:384:b0:123:2f12:60b4 with SMTP id
 a92af1059eb24-12c28c315aemr11036443c88.20.1776197307197; 
 Tue, 14 Apr 2026 13:08:27 -0700 (PDT)
X-Received: by 2002:a05:7022:384:b0:123:2f12:60b4 with SMTP id
 a92af1059eb24-12c28c315aemr11036406c88.20.1776197306420; 
 Tue, 14 Apr 2026 13:08:26 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c346fb141sm19408032c88.12.2026.04.14.13.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 13:08:25 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH 1/3] drm/vmwgfx: Store cursor source mappings in plane_state
Date: Tue, 14 Apr 2026 15:08:17 -0500
Message-ID: <20260414200819.88506-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

We aren't tracking the map/unmap sequences correctly for the cursor
plane's source buffer mapping during atomic commits. Instead relying
on ref counting in vmw_bo_map_and_cache to paper over these mistakes.

map_and_cache is not thread safe and requires the BO to be reserved but we
shouldn't reserve, or map, in atomic_update where we incorrectly assume the
mapping is always cached.

Under stress test like IGT's kms_cursor_legacy the unmap at the start of
prepare_fb can unmap the mapping and the map_and_cache in atomic_update
will either need to redo the mapping or will crash because the mapping
was removed while in use.

The best solution is simply to move the mapping to the plane_state and
not duplicate it ensuring the each mapping is local to each atomic commit.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 84 +++++---------------
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          |  1 +
 3 files changed, 25 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index c46f17ba7236..125080c2a018 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -112,10 +112,12 @@ static void vmw_cursor_update_mob(struct vmw_private *vmw,
 {
 	SVGAGBCursorHeader *header;
 	SVGAGBAlphaCursorHeader *alpha_header;
-	struct vmw_bo *bo = vmw_user_object_buffer(&vps->uo);
-	u32 *image = vmw_bo_map_and_cache(bo);
+	bool is_iomem;
+	u32 *image = ttm_kmap_obj_virtual(&vps->cursor.src_map, &is_iomem);
 	const u32 image_size = vps->base.crtc_w * vps->base.crtc_h * sizeof(*image);
 
+	WARN_ON(is_iomem || !image);
+
 	header = vmw_bo_map_and_cache(vps->cursor.mob);
 	alpha_header = &header->header.alphaHeader;
 
@@ -132,7 +134,6 @@ static void vmw_cursor_update_mob(struct vmw_private *vmw,
 	memcpy(header + 1, image, image_size);
 	vmw_write(vmw, SVGA_REG_CURSOR_MOBID, vmw_bo_mobid(vps->cursor.mob));
 
-	vmw_bo_unmap(bo);
 	vmw_bo_unmap(vps->cursor.mob);
 }
 
@@ -469,9 +470,16 @@ vmw_cursor_plane_cleanup_fb(struct drm_plane *plane,
 {
 	struct vmw_cursor_plane *vcp = vmw_plane_to_vcp(plane);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(old_state);
+	struct ttm_buffer_object *bo = vps->cursor.src_map.bo;
+	int ret;
 
-	if (!vmw_user_object_is_null(&vps->uo))
-		vmw_user_object_unmap(&vps->uo);
+	if (bo) {
+		ret = ttm_bo_reserve(bo, false, false, NULL);
+		ttm_bo_kunmap(&vps->cursor.src_map);
+		ttm_bo_unpin(bo);
+		if (ret == 0)
+			ttm_bo_unreserve(bo);
+	}
 
 	vmw_cursor_mob_unmap(vps);
 	vmw_cursor_mob_put(vcp, vps);
@@ -488,7 +496,6 @@ vmw_cursor_buffer_changed(struct vmw_plane_state *new_vps,
 	struct vmw_bo *old_bo = vmw_user_object_buffer(&old_vps->uo);
 	struct vmw_surface *surf;
 	bool dirty = false;
-	int ret;
 
 	if (new_bo != old_bo)
 		return true;
@@ -507,52 +514,6 @@ vmw_cursor_buffer_changed(struct vmw_plane_state *new_vps,
 					vmw_bo_dirty_clear(new_bo);
 			}
 			return dirty;
-		} else if (new_bo != old_bo) {
-			/*
-			 * Currently unused because the top exits right away.
-			 * In most cases buffer being different will mean
-			 * that the contents is different. For the few percent
-			 * of cases where that's not true the cost of doing
-			 * the memcmp on all other seems to outweight the
-			 * benefits. Leave the conditional to be able to
-			 * trivially validate it by removing the initial
-			 * if (new_bo != old_bo) at the start.
-			 */
-			void *old_image;
-			void *new_image;
-			bool changed = false;
-			struct ww_acquire_ctx ctx;
-			const u32 size = new_vps->base.crtc_w *
-					 new_vps->base.crtc_h * sizeof(u32);
-
-			ww_acquire_init(&ctx, &reservation_ww_class);
-
-			ret = ttm_bo_reserve(&old_bo->tbo, false, false, &ctx);
-			if (ret != 0) {
-				ww_acquire_fini(&ctx);
-				return true;
-			}
-
-			ret = ttm_bo_reserve(&new_bo->tbo, false, false, &ctx);
-			if (ret != 0) {
-				ttm_bo_unreserve(&old_bo->tbo);
-				ww_acquire_fini(&ctx);
-				return true;
-			}
-
-			old_image = vmw_bo_map_and_cache(old_bo);
-			new_image = vmw_bo_map_and_cache(new_bo);
-
-			if (old_image && new_image && old_image != new_image)
-				changed = memcmp(old_image, new_image, size) !=
-					  0;
-
-			ttm_bo_unreserve(&new_bo->tbo);
-			ttm_bo_unreserve(&old_bo->tbo);
-
-			ww_acquire_fini(&ctx);
-
-			return changed;
 		}
 		return false;
 	}
@@ -605,7 +566,6 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	int ret = 0;
 
 	if (!vmw_user_object_is_null(&vps->uo)) {
-		vmw_user_object_unmap(&vps->uo);
 		vmw_user_object_unref(&vps->uo);
 	}
 
@@ -630,6 +590,7 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	case VMW_CURSOR_UPDATE_MOB: {
 		bo = vmw_user_object_buffer(&vps->uo);
 		if (bo) {
+			u32 size;
 			struct ttm_operation_ctx ctx = { false, false };
 
 			ret = ttm_bo_reserve(&bo->tbo, true, false, NULL);
@@ -644,18 +605,16 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 			 * vmw_bo_pin_reserved also validates, so to skip
 			 * the extra validation use ttm_bo_pin directly
 			 */
-			if (!bo->tbo.pin_count)
-				ttm_bo_pin(&bo->tbo);
+			ttm_bo_pin(&bo->tbo);
 
 			if (vmw_framebuffer_to_vfb(fb)->bo) {
-				const u32 size = new_state->crtc_w *
-						 new_state->crtc_h *
-						 sizeof(u32);
-
-				(void)vmw_bo_map_and_cache_size(bo, size);
+				size = new_state->crtc_w *
+					new_state->crtc_h *
+					sizeof(u32);
 			} else {
-				vmw_bo_map_and_cache(bo);
+				size = bo->tbo.base.size;
 			}
+			ttm_bo_kmap(&bo->tbo, 0, PFN_UP(size), &vps->cursor.src_map);
 			ttm_bo_unreserve(&bo->tbo);
 		}
 		if (!vmw_user_object_is_null(&vps->uo)) {
@@ -770,7 +729,8 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 	case VMW_CURSOR_UPDATE_GB_ONLY:
 		bo = vmw_user_object_buffer(&vps->uo);
 		if (bo)
-			vmw_send_define_cursor_cmd(dev_priv, bo->map.virtual,
+			vmw_send_define_cursor_cmd(dev_priv,
+						   vps->cursor.src_map.virtual,
 						   vps->base.crtc_w,
 						   vps->base.crtc_h,
 						   vps->base.hotspot_x,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
index 0c2cc0699b0d..c82d6bf50248 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
@@ -13,6 +13,7 @@
 #include "drm/drm_file.h"
 #include "drm/drm_fourcc.h"
 #include "drm/drm_plane.h"
+#include <drm/ttm/ttm_bo.h>
 
 #include <linux/types.h>
 
@@ -39,8 +40,7 @@ enum vmw_cursor_update_type {
 
 struct vmw_cursor_plane_state {
 	enum vmw_cursor_update_type update_type;
-	bool changed;
-	bool surface_changed;
+	struct ttm_bo_kmap_obj src_map;
 	struct vmw_bo *mob;
 	struct {
 		s32 hotspot_x;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index e7bddf840a79..3c90e53a2bad 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -274,6 +274,7 @@ vmw_du_plane_duplicate_state(struct drm_plane *plane)
 	vps->pinned = 0;
 	vps->cpp = 0;
 
+	memset(&vps->cursor.src_map, 0, sizeof(vps->cursor.src_map));
 	vps->cursor.mob = NULL;
 
 	/* Each ref counted resource needs to be acquired again */
-- 
2.53.0

