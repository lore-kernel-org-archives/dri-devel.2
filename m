Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2198CD343B
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193CD10EBBC;
	Tue,  5 May 2026 22:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="hk0ewogy";
	dkim-atps=neutral
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8348F10EBBC
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:28:00 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-35fb0bb27e7so3790714a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020080; x=1778624880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i3244wkMCmDcTJccTCigzocf3AM8KFp/Jq6GbvQEdxQ=;
 b=RiQCWhoDsxrFCFhLvPJhPi/MN21TQgPyeazvwCYm6ULBA18irksI37OPeSys0l59jq
 PSTX0xjw0HmJ2LPACrVxcaDS64heryldcM96u4U5tPl1PFAk8LiJ/hfeki7dJHuq88aJ
 C41J7lA4X2kB4kmoVPR8A1tp3i4MD53MEhJszUhSLxSGg6S6SaLDQ7o9eurEHpFu45mF
 5fFPUH4btUf7ZdoTdoq5ZhQU77yoc431v8fipo7WfnLhDebaUBeiQY6zhaPSWh9aa6sF
 /PDOur3Zbc2wdxW5q1ynkfYzKLU4CkfxOF14CmPtxOOD0h1yTXsce0Or8j4rH2VJp8na
 yudA==
X-Gm-Message-State: AOJu0Yw+6jGq1Uj3Ux/yZSFoMZoTEFLn446vkzLxvVSs8AYVh8ig10Sr
 UhYRHXWTUAbbmZWOQK0etiytGGC2d48HtFEFcrypi4CSRpX6ZGD9R406zTZ94hF/bvq/o7uRzOz
 dhMdfpgWRpj61t7MCYoIYSo0QSSfU9wgvbJST0DzUARe8Zca6rvzUCMM26T3pam/7YtulVTF8LQ
 FyAjUjd2tNGbcWS6IWbW66OKLyqoVIsvq0wBpUCoX6YCA7FAO22aird3/KoskpV1I8HEF5q2Rkv
 3I7VIokiBDpEeTOhnsz
X-Gm-Gg: AeBDies0G4RLKL1PAYVfUsuz4HOqQyUA2HTmIYa66fpcJJ0QFWu2qAyedFEa5HxLjUC
 vHsFUB3+yo3zURIiHl3P9l0QXp01E/zBaEdsPxlMVLuvYV7arilgbuZ9j0MuIlqxr1kGkLHhSyI
 eusCL6zKodtkjI06u6dQV7GDRHZ1gjkMrAtsMet5ntsgck4upyy3jnAoIzKlMGdi600UVBFCSZD
 wwWcclypecnM9Yz7xN6k1dqpNALTiKRMRVFcMpVydSnguUvKWwcEG/bcpI9Eo6x6hf+yrbhcwKp
 jAwftNhPjfWBkpmRrluE6UqdD7KG85P5WJTrXV2XTVHa4RrPGa8jU/KNDxd3V7QoDMO2gcJaW3S
 bM+g+GXNmtbU4YnKyepZEuiUV0Z/8eDVDHPJQPpLAhMOrKevM3cjH9fUp8EkyY35RNF0M1G/nq4
 Ymo+0zSgN3n1Z+zg16a/VOprTGjkPBhhq0Sd3YL/dw4tubCS/xAC/eEsJNrDjBEqE0
X-Received: by 2002:a17:90b:2883:b0:365:7e7f:a229 with SMTP id
 98e67ed59e1d1-365ab9b83cfmr692411a91.5.1778020079965; 
 Tue, 05 May 2026 15:27:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-365b0053a20sm14481a91.0.2026.05.05.15.27.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8acaea1ffe7so145031316d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020077; x=1778624877;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3244wkMCmDcTJccTCigzocf3AM8KFp/Jq6GbvQEdxQ=;
 b=hk0ewogy7M6a3u2GzXmIZ1vV45RUwnIto+iuf9vF3A7i+324BA5AcpMflC/UoZF8Cb
 gIyi54ABn5HpJNdymHJ6maBPENex8Bl2yiB1r5/ocsISK2NDanF5Mk6pU16IfOyy92/j
 xN9Y7I4sXnzw5f7m3/FlMEbJD9vJ9lvxuip9s=
X-Received: by 2002:a05:6214:23c9:b0:8ac:a154:e156 with SMTP id
 6a1803df08f44-8bc443d1957mr12241056d6.29.1778020077674; 
 Tue, 05 May 2026 15:27:57 -0700 (PDT)
X-Received: by 2002:a05:6214:23c9:b0:8ac:a154:e156 with SMTP id
 6a1803df08f44-8bc443d1957mr12240386d6.29.1778020077161; 
 Tue, 05 May 2026 15:27:57 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:56 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 09/12] drm/vmwgfx: enforce cursor size limits for MOB cursors
Date: Tue,  5 May 2026 18:22:30 -0400
Message-ID: <20260505222728.519626-10-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
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

vmw_cursor_plane_atomic_check() bounds cursor width and height only
on the legacy update path; the SVGA_CAP2_CURSOR_MOB path -- the
default on modern hosts -- accepts any size.  When the requested size
exceeds SVGA_REG_CURSOR_MAX_DIMENSION or SVGA_REG_MOB_MAX_SIZE,
vmw_cursor_mob_get() returns -EINVAL and leaves vps->cursor.mob NULL.
Its return value is then discarded in vmw_cursor_plane_prepare_fb(),
so the subsequent vmw_cursor_update_mob() calls
vmw_bo_map_and_cache(NULL) and oopses inside
vmw_bo_map_and_cache_size() on the tbo.base.size load.

Reachable from any DRM master via DRM_IOCTL_MODE_CURSOR2 with a
sufficiently large width or height (e.g. cursor_max_dim + 1).

Reject oversized cursors in atomic_check for both MOB-backed cursor
update types.  The MOB byte-size limit only applies to the
SVGA_CAP2_CURSOR_MOB path (vmw_cursor_mob_size() returns 0 for
GB_ONLY); compute the required MOB size in 64-bit to avoid overflow
when very large dimensions are requested.

In prepare_fb only call vmw_cursor_mob_get()/_map() for
VMW_CURSOR_UPDATE_MOB -- the GB_ONLY path uses bo->map.virtual
directly and would otherwise be silently downgraded to NONE on hosts
without SVGA_CAP2_CURSOR_MOB (where vmw_cursor_mob_get() always
returns -EINVAL).  Degrade the update to NONE if vmw_cursor_mob_get()
or vmw_cursor_mob_map() fails so the update path does not run with a
NULL backing MOB.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 49 ++++++++++++++++++--
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index c46f17ba7236..c53bb9376b36 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -432,6 +432,7 @@ vmw_cursor_mob_map(struct vmw_plane_state *vps)
 	u32 size = vmw_cursor_mob_size(vps->cursor.update_type,
 				       vps->base.crtc_w, vps->base.crtc_h);
 	struct vmw_bo *vbo = vps->cursor.mob;
+	void *map;
 
 	if (!vbo)
 		return -EINVAL;
@@ -446,11 +447,15 @@ vmw_cursor_mob_map(struct vmw_plane_state *vps)
 	if (unlikely(ret != 0))
 		return -ENOMEM;
 
-	vmw_bo_map_and_cache(vbo);
+	map = vmw_bo_map_and_cache(vbo);
+	if (!map) {
+		vmw_bo_unmap(vbo);
+		ret = -ENOMEM;
+	}
 
 	ttm_bo_unreserve(&vbo->tbo);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -663,9 +668,15 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 			    !vmw_cursor_buffer_changed(vps, old_vps)) {
 				vps->cursor.update_type =
 					VMW_CURSOR_UPDATE_NONE;
-			} else {
-				vmw_cursor_mob_get(vcp, vps);
-				vmw_cursor_mob_map(vps);
+			} else if (vps->cursor.update_type ==
+				   VMW_CURSOR_UPDATE_MOB &&
+				   (vmw_cursor_mob_get(vcp, vps) ||
+				    vmw_cursor_mob_map(vps))) {
+				/*
+				 * Reset the cursor to avoid crashes later.
+				 */
+				vps->cursor.update_type =
+					VMW_CURSOR_UPDATE_NONE;
 			}
 		}
 	}
@@ -732,6 +743,34 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 				 "surface not suitable for cursor\n");
 			return -EINVAL;
 		}
+	} else if (update_type == VMW_CURSOR_UPDATE_GB_ONLY ||
+		   update_type == VMW_CURSOR_UPDATE_MOB) {
+		u32 cursor_max_dim =
+			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
+
+		if (new_state->crtc_w > cursor_max_dim ||
+		    new_state->crtc_h > cursor_max_dim) {
+			drm_warn(&vmw->drm,
+				 "Cursor dimensions (%d, %d) exceed device max %u\n",
+				 new_state->crtc_w, new_state->crtc_h,
+				 cursor_max_dim);
+			return -EINVAL;
+		}
+
+		if (update_type == VMW_CURSOR_UPDATE_MOB) {
+			u32 mob_max_size =
+				vmw_read(vmw, SVGA_REG_MOB_MAX_SIZE);
+			u64 mob_size = (u64)new_state->crtc_w *
+				       new_state->crtc_h * sizeof(u32) +
+				       sizeof(SVGAGBCursorHeader);
+
+			if (mob_size > mob_max_size) {
+				drm_warn(&vmw->drm,
+					 "Cursor MOB size %llu exceeds device max %u\n",
+					 mob_size, mob_max_size);
+				return -EINVAL;
+			}
+		}
 	}
 
 	return 0;
-- 
2.51.0

