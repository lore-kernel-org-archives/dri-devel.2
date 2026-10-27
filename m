Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A07606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e9EALrMf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E5010E4BB;
	Tue, 27 Oct 2026 21:17:52 +0000 (UTC)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20ECE10E4A7
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:17:43 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3ac451e128cso250804a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793135862; x=1793740662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kjKHoXJ1QztHn7LxaBTuy/zVwxBXOh8NpL66zD+sMpw=;
 b=QUkV4wR1KwPBAWkrDFrepp6cCP0sViSaFpX0nnk6Oa37WDzB0ZbAM8qc+UOcL6XMPP
 0N3GPsgic0VYGWoJMeRx169AcIBv023xJFYwKUN9COMuiHcSAfDKGdsBZVos9WjaiTaO
 61+aT/Jrw4SYZ+hmoXmWVf6vQ+3ntofsAhxIlU/2GslM/vSi7g1ZVbwjsZS8hQDjSDXW
 IlkztpV/vgnt6or+KnO2oWCuEL5val/jpSP7KmqUnMVtknQtryVK8U+gzMmqa3BY+5pm
 /n8E9bj19I/4cQs6rz1cnVQ0HWLgfFzhmbLonHBeu/OkEa6N8G7d3FBvgnII+RVxtFkr
 mx/w==
X-Gm-Message-State: AFq9FYIvfi5AAkvcTnuuy+FcIf/cHa/dzQBgjTafhajidnJjjs+FeK5o
 WnQFpxglguuqWmWQ3YJ/hvyPK9C167lqbQmvx6JpOn3yRDigZcpGZkn8i0YuNn251DslzgsCrI7
 7i6xGpI/ckmUutA0L29ahJJ5TeOUSiWhSJNzm1hHYVFjf4O/CUwwsltaxvYVziFeR9IcLtQPkV6
 z6eE4t6S8EYiTA+wM2QN2nE2VnIkXhlBRPL6BDLYUnSPIR3RWGubACzwaMliAtcIQH/FagDHQVK
 dK3H1XWzX1kNRw3kmDR
X-Gm-Gg: AYBFou0s0/jwUymxtGGoeipOgEaL5BC74SOcCljY6XGQN6jOUQk6TlGnMiMBrU1dZL1
 UVwsmqqoWsGFVUibGFR6de7iEkKqYH7cOeG6aQQGnLjiVEBkSYdZ//BOnss3jcKunpkVDajlj7R
 4/jlfDyAw0UNTWbk/inY9iTPVIkm3o45qxfahw74M9yFP8zrc6NXTSx3f1nQ3xYT0Byhb6Uhjub
 IjynkqbJpkSsloSiLHZrMALu7V0kGrneayCbrEUX+8peBQNvk+tuZ68pWpAFGUPdk3aSL6JGSzC
 CQmYPBW8PesBn2Tn83XOg82G3KdYjFqnWtR7/alyxQns8ufadijSZYbp0y2V9AUgAlwssuSE+eM
 byGF8ZpoQkT/8j8FDsNdXQsoj6O6ePvcT4RnVz0P9r6pX+zg2QJvsO6TljHZ8JtrEjcuXmbc2zD
 fof4l4STFoBbwgXpZiDeVB5J/ifM6jXmsS
X-Received: by 2002:a17:90a:e70e:b0:3ac:38dc:6b9e with SMTP id
 98e67ed59e1d1-3ae5810099fmr210018a91.25.1793135862397; 
 Tue, 27 Oct 2026 14:17:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae55a6cfdfsm193827a91.0.2026.10.27.14.17.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 14:17:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so498507eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793135861; x=1793740661;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kjKHoXJ1QztHn7LxaBTuy/zVwxBXOh8NpL66zD+sMpw=;
 b=e9EALrMfhqNs/Nzu+lFkfa+jQ/MLjN4abRUL3M6C8+dhZTUkizIeXXQudzOhJMPoab
 Mr0umH6Ku7OuxejqYoMmdhHJjTHNVmDlhfHSmb8kvM+yH3i+rpAIs8cG25ZhVGRbU1+7
 D/VSOdkpxIDFerQbkin1B2LtMnClURyCB7TFU=
X-Received: by 2002:a05:7301:2e85:b0:36a:1788:3d1c with SMTP id
 5a478bee46e88-36a203dfa05mr1211712eec.34.1793135860412; 
 Tue, 27 Oct 2026 14:17:40 -0700 (PDT)
X-Received: by 2002:a05:7301:2e85:b0:36a:1788:3d1c with SMTP id
 5a478bee46e88-36a203dfa05mr1211660eec.34.1793135859600; 
 Tue, 27 Oct 2026 14:17:39 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:17:38 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 1/6] drm/vmwgfx: keep cursor mappings and pins with each plane
 state
Date: Tue, 27 Oct 2026 17:17:24 -0400
Message-ID: <20261027211729.646988-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cursor plane states duplicate the user object reference without acquiring
its mapping or pin. Preparing the duplicated state nevertheless unmaps
that object, and only pins the new buffer if it is not already pinned.
Cleanup of an older state can therefore remove a mapping or pin still
needed by another cursor commit. Repeated cursor updates from KMS clients
can then access an unmapped or movable buffer.

Give each prepared state its own mapping, buffer reference and pin, and
reset the mapping when duplicating a state. Release only the resources
owned by that state in cleanup_fb(). Map the required image extent for
every state so resizing a cursor on the same buffer cannot reuse a
smaller cached mapping. Unwind the pin and reservation if preparation
fails.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 69 ++++++++++++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h |  4 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          |  1 +
 3 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 5a69606a0593..942d07079ef7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -112,8 +112,7 @@ static void vmw_cursor_update_mob(struct vmw_private *vmw,
 {
 	SVGAGBCursorHeader *header;
 	SVGAGBAlphaCursorHeader *alpha_header;
-	struct vmw_bo *bo = vmw_user_object_buffer(&vps->uo);
-	u32 *image = vmw_bo_map_and_cache(bo);
+	u32 *image = vps->cursor.map.virtual;
 	const u32 image_size = vps->base.crtc_w * vps->base.crtc_h * sizeof(*image);
 
 	header = vmw_bo_map_and_cache(vps->cursor.mob);
@@ -132,7 +131,6 @@ static void vmw_cursor_update_mob(struct vmw_private *vmw,
 	memcpy(header + 1, image, image_size);
 	vmw_write(vmw, SVGA_REG_CURSOR_MOBID, vmw_bo_mobid(vps->cursor.mob));
 
-	vmw_bo_unmap(bo);
 	vmw_bo_unmap(vps->cursor.mob);
 }
 
@@ -490,9 +488,21 @@ vmw_cursor_plane_cleanup_fb(struct drm_plane *plane,
 {
 	struct vmw_cursor_plane *vcp = vmw_plane_to_vcp(plane);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(old_state);
+	struct vmw_bo *bo;
+	int ret;
 
-	if (!vmw_user_object_is_null(&vps->uo))
-		vmw_user_object_unmap(&vps->uo);
+	if (vps->cursor.map.bo) {
+		bo = to_vmw_bo(&vps->cursor.map.bo->base);
+		ret = ttm_bo_reserve(&bo->tbo, false, false, NULL);
+		if (WARN_ON_ONCE(ret))
+			return;
+
+		ttm_bo_kunmap(&vps->cursor.map);
+		vps->cursor.map.bo = NULL;
+		ttm_bo_unpin(&bo->tbo);
+		ttm_bo_unreserve(&bo->tbo);
+		vmw_bo_unreference(&bo);
+	}
 
 	vmw_cursor_mob_unmap(vps);
 	vmw_cursor_mob_put(vcp, vps);
@@ -625,10 +635,12 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	struct vmw_surface *surface;
 	int ret = 0;
 
-	if (!vmw_user_object_is_null(&vps->uo)) {
-		vmw_user_object_unmap(&vps->uo);
+	/*
+	 * A duplicated state only owns the user object reference. Its mappings
+	 * and pins belong to the old state until cleanup_fb().
+	 */
+	if (!vmw_user_object_is_null(&vps->uo))
 		vmw_user_object_unref(&vps->uo);
-	}
 
 	if (fb) {
 		if (vmw_framebuffer_to_vfb(fb)->bo) {
@@ -652,31 +664,34 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 		bo = vmw_user_object_buffer(&vps->uo);
 		if (bo) {
 			struct ttm_operation_ctx ctx = { false, false };
+			size_t size = (size_t)new_state->crtc_w *
+				      new_state->crtc_h * sizeof(u32);
 
 			ret = ttm_bo_reserve(&bo->tbo, true, false, NULL);
 			if (ret != 0)
-				return -ENOMEM;
+				return ret;
 
 			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 			if (ret != 0)
-				return -ENOMEM;
+				goto out_unreserve;
 
 			/*
-			 * vmw_bo_pin_reserved also validates, so to skip
-			 * the extra validation use ttm_bo_pin directly
+			 * vmw_bo_pin_reserved() also validates, so to skip
+			 * the extra validation use ttm_bo_pin directly.
+			 * Every state takes its own pin, the buffer can
+			 * still be in use by an older state whose commit
+			 * hasn't been cleaned up yet.
 			 */
-			if (!bo->tbo.pin_count)
-				ttm_bo_pin(&bo->tbo);
+			ttm_bo_pin(&bo->tbo);
 
-			if (vmw_framebuffer_to_vfb(fb)->bo) {
-				const u32 size = new_state->crtc_w *
-						 new_state->crtc_h *
-						 sizeof(u32);
-
-				(void)vmw_bo_map_and_cache_size(bo, size);
-			} else {
-				vmw_bo_map_and_cache(bo);
+			ret = ttm_bo_kmap(&bo->tbo, 0, PFN_UP(size),
+					  &vps->cursor.map);
+			if (ret) {
+				vps->cursor.map.bo = NULL;
+				ttm_bo_unpin(&bo->tbo);
+				goto out_unreserve;
 			}
+			vmw_bo_reference(bo);
 			ttm_bo_unreserve(&bo->tbo);
 		}
 		if (!vmw_user_object_is_null(&vps->uo)) {
@@ -703,6 +718,10 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	}
 
 	return 0;
+
+out_unreserve:
+	ttm_bo_unreserve(&bo->tbo);
+	return ret;
 }
 
 /**
@@ -796,7 +815,6 @@ void
 vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			       struct drm_atomic_commit *state)
 {
-	struct vmw_bo *bo;
 	struct drm_plane_state *new_state =
 		drm_atomic_get_new_plane_state(state, plane);
 	struct drm_plane_state *old_state =
@@ -823,9 +841,8 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 		vmw_cursor_update_mob(dev_priv, vps);
 		break;
 	case VMW_CURSOR_UPDATE_GB_ONLY:
-		bo = vmw_user_object_buffer(&vps->uo);
-		if (bo)
-			vmw_send_define_cursor_cmd(dev_priv, bo->map.virtual,
+		if (vps->cursor.map.virtual)
+			vmw_send_define_cursor_cmd(dev_priv, vps->cursor.map.virtual,
 						   vps->base.crtc_w,
 						   vps->base.crtc_h,
 						   vps->base.hotspot_x,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
index d32cf17d013b..9b50f80f9635 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
@@ -14,6 +14,8 @@
 #include "drm/drm_fourcc.h"
 #include "drm/drm_plane.h"
 
+#include <drm/ttm/ttm_bo.h>
+
 #include <linux/types.h>
 
 struct SVGA3dCmdHeader;
@@ -41,6 +43,8 @@ struct vmw_cursor_plane_state {
 	enum vmw_cursor_update_type update_type;
 	bool changed;
 	bool surface_changed;
+	/* The mapped buffer is referenced and pinned by this state. */
+	struct ttm_bo_kmap_obj map;
 	struct vmw_bo *mob;
 	struct {
 		s32 hotspot_x;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 31d3ee0825ca..85228eb9c3e6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -283,6 +283,7 @@ vmw_du_plane_duplicate_state(struct drm_plane *plane)
 	vps->cpp = 0;
 
 	vps->cursor.mob = NULL;
+	memset(&vps->cursor.map, 0, sizeof(vps->cursor.map));
 
 	/* Each ref counted resource needs to be acquired again */
 	vmw_user_object_ref(&vps->uo);
-- 
2.53.0

