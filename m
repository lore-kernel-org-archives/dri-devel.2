Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCDAC98307
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369AD10EFE6;
	Wed, 23 Sep 2026 11:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IipGtsLT";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A371210EFE6
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:58:48 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97e97e2c7b3so515766241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790164727; x=1790769527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LP4UJ6rcNxj5vtQd0NWw+zniHfA0ViW+8Yb9WndmdNQ=;
 b=IipGtsLTnpku6aoZMd/acXv1a2aXWAmuAmzL2d7iSTTzKtOcEH1/yvfF22NKidslcW
 zMTk37Qg8OhAJYE5ztt68VpsehaZGOHeu4IXVcjkMExwvVLuJV78QjvTja4ustG+9GuL
 7WjaLu1mX2RnJgr7h8vy+RdjiNSDRl7W+dg6ingFh4E5g43yD9NJa9AiQ0lD4S1vkZOq
 cdG+iIWQJacIiB10KL+7FZqQiXLqogL8GV5WpE0Molz4agjJz1fRwOv6NRR/fGO2+Mur
 EghokxhpuCECkX3SdctxKJAx3KH5AVvtU7fmAbpkfspxpxJm3/4At7Vm2yligvuM9jWH
 n4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790164727; x=1790769527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LP4UJ6rcNxj5vtQd0NWw+zniHfA0ViW+8Yb9WndmdNQ=;
 b=UIg13+XHrSyIrdDs0eWAoe9BZ7/zZrdHERdjQ9D8haXaf+2xBdqUMKQsV8NIJ40/ho
 04PSLjaL+X4QdsIxSy4q6aWW61Gtxld4Nq1hyX+aQLz5W1HN5bOp5WlQYGHlC05kOYof
 S6IXwBTsQBg18qlOOpjYTJNkI13Ls6/G2xkK6Fg3Ftk4zoHrKnYpaVF1aOFuMsYnIKC+
 Qqs2/F8vvGH++TtzMychtpJ9+Rr0culwgS8lc7mF4kqISx28FfJryL1VPPLaFGWTpf20
 z7FTpYJ3hY87h7vOe1qdFKdc0nkUyOb7KT9AWH8KV39repDRa8LeGBZniky2TWUcQYyZ
 hC3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByJxbxS9CgNQV1WhxlZFPyA74nubdamQXTY9u8F4k3XfbpKqunqQzVZBJcgtpWx/b/JEKt36TBKTo4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBSnf9go/oRNcP2aoOxOnJeG//ZiYoM1ppKF5mqQYU+CafPkKR
 GPgU6jYn1BF0iEDDAarmP2Q6Q4zxpCDjjVUNfua+CgfczVblbnuBKsAB
X-Gm-Gg: AYBFou20Yqcr29RnPHqVJXaFNj+9X8u8OEWa9b5oNu93AhsY5zbDUpl0zzKXTK1p5w1
 nG8OY+SXbu8oUi8wpIPqoNulb+zFn5RyCshwrj7mGZL2e3piSs2uvQHSjqNlSxBq0QGdBEhQOCx
 kPb+HPl4I8FNVmUv7o7NiNLeZZt0KlcKoEDOb9dkTkY+nK+4RblcqC9cyfsVA/1YTEHIL24M1lC
 tl3u83+8fC4zb/EyzmNJ38difWFXevvmK9/FoHFfG7ztCqCm/zi1bNv+70KyjYUY6ZjCHBMjGd8
 nsCj+sdFj7H0zKVUV3B8flebkT73C/TDGHb5MA4x7OFz0wZ062GvZcekIaYE8JN0CJZ/c5Q17HW
 aEdW6CkeKs1m1lrkf1JePkTrOP4EClWXkPsWXliGnb54iOXemO7q9aSOM6j/HKP8jNUHhQMyBVU
 OjbLQstgBtfYECwL6ztCswKt8RnEp00TwNio1172ooQHqiyj8LA84s4PY4jS87NB5JY8xbonTKR
 S97FEcAC0/p
X-Received: by 2002:a05:6102:54a5:b0:7a7:19aa:8a85 with SMTP id
 ada2fe7eead31-7ac1d2d4823mr2262310137.32.1790164727264; 
 Wed, 23 Sep 2026 04:58:47 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7abf5674f44sm3099961137.3.2026.09.23.04.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 04:58:46 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 RESEND] drm/vmwgfx: return an error when a shared GB
 surface has no backup buffer
Date: Wed, 23 Sep 2026 08:58:39 -0300
Message-ID: <20260923115839.3363885-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vmw_gb_surface_reference_internal() rejects a surface that has no backup
buffer by logging an error and jumping to out_bad_resource, but it never
sets ret on that path. ret is still 0 from the earlier successful
vmw_surface_handle_reference(), so the ioctl returns success while
leaving the reply structure uninitialised. drm_ioctl() then copies the
72-byte reply back to user space; on a CONFIG_INIT_STACK_NONE build that
is an information leak of stale stack contents, and on every build user
space is handed a "successful" reply that was never produced.
DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALLOW, so an unprivileged local
user can reach it.

Set ret to -EINVAL and, on the error paths, drop the reference that
vmw_surface_handle_reference() took; once the ioctl fails user space no
longer releases it via DRM_VMW_UNREF_SURFACE. The unref is guarded by
ret so the shared success fall-through keeps the reference the caller
still owns, and it also plugs the same leak on the drm_gem_handle_create()
failure path.

Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and reference")
Cc: stable@vger.kernel.org
Suggested-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2:
 - Shortened the commit message (Zack Rusin).
 - Also drop the reference taken by vmw_surface_handle_reference() on the
   error paths; with the ioctl now returning an error, user space no
   longer releases it via DRM_VMW_UNREF_SURFACE (Zack Rusin). This also
   plugs the same pre-existing leak on the drm_gem_handle_create() path.

v1: https://lore.kernel.org/all/20260808231002.67559-1-qwe.aldo@gmail.com/

 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e..164886a3e6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	srf = &user_srf->srf;
 	if (!srf->res.guest_memory_bo) {
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
+		ret = -EINVAL;
 		goto out_bad_resource;
 	}
 	metadata = &srf->metadata;
@@ -1758,6 +1759,9 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->creq.must_be_zero = 0;
 
 out_bad_resource:
+	if (ret)
+		ttm_ref_object_base_unref(vmw_fpriv(file_priv)->tfile,
+					  base->handle);
 	ttm_base_object_unref(&base);
 
 	return ret;
-- 
2.43.0

