Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D99AF9D0F2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 20:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1A410E667;
	Tue, 14 Apr 2026 20:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="CVWX+vl8";
	dkim-atps=neutral
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com
 [209.85.222.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D337310E667
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 20:08:36 +0000 (UTC)
Received: by mail-ua1-f100.google.com with SMTP id
 a1e0cc1a2514c-95672e8d787so315504241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776197315; x=1776802115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kb9FKU6+Ie50BCspJzCM3YLKPThrt+mcm7gDy0jlGEA=;
 b=Ud8Qb3xirW1/JZytA9RJsLWbdOp5hatuHi80+uqGxrYAeeiFvDxjWfkW51m/YLTAYZ
 iaKF26m9bFOWzkQLc6MRU/X9WHJ/+YP+trmsAT6NN0iRA72TDHDjYoFi46tdY1CmRbwT
 dGkL2XROHG7QE0iX/25qGx2uHcMNcP5rfrdB+ck71jo7TAWTm3UQ6hQ/b0gXW6fAbrG4
 BLTZfge05jN4mo3yZzJ1u6fXC4FKp3pln6rAkWwUVkjFjSgvVmdnf3iOwrSOpeQ3Wrai
 bMiiuvOy1gNfaxpQ+G4pDTCbINobF2arTEcm5aa+BRVpxYTX0svfjH8JsMVjmnb2UpnC
 E22g==
X-Gm-Message-State: AOJu0YwaYNm9sFFtjQFskUky6gtRv/Fo0zmPty2fLz6XCpY5xJqP+qXe
 iAhW35u3uxm13D5zwqqwLEx4BL1AGH2ZlWlfUUMYkjKLz0jnUPJNqavr+XObWKqs5EKD14XESEM
 L328jwrYcRYiss+LGiqBhxIhcf4Xb+nknCN8ltYcdMCEZ+IcT8y4aaHU8HE6w9fsbhqdfEP0rlY
 XZYPdxjQJ669eX66OSyqHMvwz/PYj+ANyBPPB7AWG4AgyLFuVzh8kwudPQJ999I5V9G1IZfzWqu
 cDHm9YtRiVfsTo4JzOr
X-Gm-Gg: AeBDieunEOtNv3sb7QzbjR1ouGkfF7+p604sWHklzppdx0CscBmpS/C8p8VwabCsV1y
 sz4xI5j7mW+taFISoZvp/998YYwHbQTbzBI3rOrpgAQMMpB7cvNK9keGpmrgc6Z4UFzI/8973Xz
 4AA3edLXVvcpaCnfHiY+161N+/iPocXckg8TxkRylKmUN6zZ5BgWpJFJMDDkYadSOLJXmu7PTsX
 +UiQhSr8hPgFl+OD3/ZieqbKghhW0xfkYcDlZIyZh/owVMvUhFe7Wi3m1gKm26Y8xAHMV7i/L4r
 f7BcL12PGbQZ8sqCfDuxhn56REZ1tg3VyVMJtVPMLRX6YFpjfREtCkjj4Z48KU4QkxSPag8i+ug
 uRGNyMWDZSMWWNsFrt/AuW2YrzhrqJAaQNemekvJcaVOXuB+8kAZONAZFmMBKH2xfEsBm8Vqarl
 geF234qVoEf58iopA18QiEqRbO6z0l+B3ORDI89QPMcipUMQ3ZKM8hw9VvMG01FHEM
X-Received: by 2002:a05:6102:5490:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-61221f86dfbmr1418811137.12.1776197315397; 
 Tue, 14 Apr 2026 13:08:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-9569794f300sm332292241.4.2026.04.14.13.08.35
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 13:08:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c21dbc9c1so9551463c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776197314; x=1776802114;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb9FKU6+Ie50BCspJzCM3YLKPThrt+mcm7gDy0jlGEA=;
 b=CVWX+vl8IrxoCHWayxRaklUQsokLqczQ7BdZ0ja0XEM77eVLua0WBYM0I46pre3zwO
 tzAxwwPg8bASkFyYDrKBwCngWGGVFKS+2a5qQgL59ZXMK28GFK9n52ZMaOsQ6b/NQ/uZ
 LzT5q0Qn8zaW31OnJxHoaXhY4fjXc4Bxnl0/I=
X-Received: by 2002:a05:7022:f306:b0:12c:3d30:37d8 with SMTP id
 a92af1059eb24-12c3d3039d0mr5202816c88.19.1776197313927; 
 Tue, 14 Apr 2026 13:08:33 -0700 (PDT)
X-Received: by 2002:a05:7022:f306:b0:12c:3d30:37d8 with SMTP id
 a92af1059eb24-12c3d3039d0mr5202731c88.19.1776197313202; 
 Tue, 14 Apr 2026 13:08:33 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c346fb141sm19408032c88.12.2026.04.14.13.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 13:08:32 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH 3/3] drm/vmwgfx: Cache cursor MOB mappings
Date: Tue, 14 Apr 2026 15:08:19 -0500
Message-ID: <20260414200819.88506-3-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414200819.88506-1-ian.forbes@broadcom.com>
References: <20260414200819.88506-1-ian.forbes@broadcom.com>
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

We map/unmap these for every cursor update. These mappings are small
(64*64*4=16K) and pinned so we can cache them.

Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 74 ++------------------
 1 file changed, 4 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 4f009aa586ac..b8dda6eff3c2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -156,36 +156,11 @@ static void vmw_cursor_mob_destroy(struct vmw_bo **vbo)
 	if (!(*vbo))
 		return;
 
+	vmw_bo_unmap(*vbo);
 	ttm_bo_unpin(&(*vbo)->tbo);
 	vmw_bo_unreference(vbo);
 }
 
-/**
- * vmw_cursor_mob_unmap - Unmaps the cursor mobs.
- *
- * @vps: state of the cursor plane
- *
- * Returns 0 on success
- */
-
-static int
-vmw_cursor_mob_unmap(struct vmw_plane_state *vps)
-{
-	int ret = 0;
-	struct vmw_bo *vbo = vps->cursor.mob;
-
-	if (!vbo || !vbo->map.virtual)
-		return 0;
-
-	ret = ttm_bo_reserve(&vbo->tbo, true, false, NULL);
-	if (likely(ret == 0)) {
-		vmw_bo_unmap(vbo);
-		ttm_bo_unreserve(&vbo->tbo);
-	}
-
-	return ret;
-}
-
 static void vmw_cursor_mob_put(struct vmw_cursor_plane *vcp,
 			       struct vmw_plane_state *vps)
 {
@@ -194,7 +169,6 @@ static void vmw_cursor_mob_put(struct vmw_cursor_plane *vcp,
 	if (!vps->cursor.mob)
 		return;
 
-	vmw_cursor_mob_unmap(vps);
 
 	/* Look for a free slot to return this mob to the cache. */
 	for (i = 0; i < ARRAY_SIZE(vcp->cursor_mobs); i++) {
@@ -257,7 +231,7 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plane *vcp,
 			return 0;
 		}
 	}
-	/* Create a new mob if we can't find an existing one. */
+	/* Create a new pinned mob if we can't find an existing one. */
 	ret = vmw_bo_create_and_populate(dev_priv, size, VMW_BO_DOMAIN_MOB,
 					 &vps->cursor.mob);
 
@@ -274,14 +248,13 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plane *vcp,
 		ttm_bo_unreserve(&vps->cursor.mob->tbo);
 		goto teardown;
 	}
-
+	vmw_bo_map_and_cache(vps->cursor.mob);
 	dma_fence_wait(&fence->base, false);
 	dma_fence_put(&fence->base);
 
 	ttm_bo_unreserve(&vps->cursor.mob->tbo);
 
 	return 0;
-
 teardown:
 	vmw_cursor_mob_destroy(&vps->cursor.mob);
 	return ret;
@@ -418,42 +391,6 @@ void vmw_cursor_plane_destroy(struct drm_plane *plane)
 	drm_plane_cleanup(plane);
 }
 
-/**
- * vmw_cursor_mob_map - Maps the cursor mobs.
- *
- * @vps: plane_state
- *
- * Returns 0 on success
- */
-
-static int
-vmw_cursor_mob_map(struct vmw_plane_state *vps)
-{
-	int ret;
-	u32 size = vmw_cursor_mob_size(vps->cursor.update_type,
-				       vps->base.crtc_w, vps->base.crtc_h);
-	struct vmw_bo *vbo = vps->cursor.mob;
-
-	if (!vbo)
-		return -EINVAL;
-
-	if (vbo->tbo.base.size < size)
-		return -EINVAL;
-
-	if (vbo->map.virtual)
-		return 0;
-
-	ret = ttm_bo_reserve(&vbo->tbo, false, false, NULL);
-	if (unlikely(ret != 0))
-		return -ENOMEM;
-
-	vmw_bo_map_and_cache(vbo);
-
-	ttm_bo_unreserve(&vbo->tbo);
-
-	return 0;
-}
-
 /**
  * vmw_cursor_plane_cleanup_fb - Unpins the plane surface
  *
@@ -481,7 +418,6 @@ vmw_cursor_plane_cleanup_fb(struct drm_plane *plane,
 			ttm_bo_unreserve(bo);
 	}
 
-	vmw_cursor_mob_unmap(vps);
 	vmw_cursor_mob_put(vcp, vps);
 
 	vmw_du_plane_unpin_surf(vps);
@@ -594,10 +530,8 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 				vps->cursor.update_type = VMW_CURSOR_UPDATE_NONE;
 				return 0;
 			}
-			if (vps->cursor.update_type == VMW_CURSOR_UPDATE_MOB) {
+			if (vps->cursor.update_type == VMW_CURSOR_UPDATE_MOB)
 				vmw_cursor_mob_get(vcp, vps);
-				vmw_cursor_mob_map(vps);
-			}
 		}
 		bo = vmw_user_object_buffer(&vps->uo);
 		if (bo) {
-- 
2.53.0

