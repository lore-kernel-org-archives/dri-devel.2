Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4078CA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB7B10F7D5;
	Wed,  7 Oct 2026 21:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z24Iugdw";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE00510F7D5
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 21:21:21 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5dedc4e5cf4so3510985e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791408080; x=1792012880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e14mQQiltcvPeO/AMh2B9KgoOUXPqFLUs2pJsfGY66Q=;
 b=Z24IugdwqzxhfguEdJOWHNB5LwzpEIDpfjIAT7MSDO+cqdwYuavgld9GXKbd8Pqo13
 S1/1t9wDcipEjTibAC//71VyY4P9HcPE367ePJd3RsRcQ8aUeAWW0So/A9BN+jIerqW6
 JuqUMoxr3bMLPIE+Q+WJiWSWUey5+iNzRMZho1z0/+qqBGMvaV3g6R1x0tk57C86pmeb
 Yf+CWaKr6ddGzLvODWCBSW53030dfIxaIFg5UQAay+HmibenSz7J/kye8nNFMJwVCbc9
 KGqbl4dsGVuCg+Y92jL05BsN4rSg9Ew6PZu9yOfeIjEqOxXPRMi94SodFnYJq9sMFm+B
 yzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791408080; x=1792012880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e14mQQiltcvPeO/AMh2B9KgoOUXPqFLUs2pJsfGY66Q=;
 b=XovygSX1s5nhqacGWaJN8IPEiMtFQFCioVTmio06C9SPE13JrViUfpclt/En9+XGGy
 qqQClCX0PXnqf/O0h1X6PaHEQWgqN2OjjUCOa/3/dyqG7tndkWsj+agx3wGiwlHsVgrJ
 HTD7Uezb1RDLRIhYPwqXYC2xBpjAbJVYJp66/DNEbTFHlVZxLOkBx8vqkKpEmncoNPzG
 CtC3qrWjqUF2/8kidDemKbFsonBRkLY24im0RQjW+0tqdzufZXvrrzQzEt6D9Lpd7IQ5
 W/RIYzqhPBgPna7UcxeQyuNpJqv0LL7+tH4l+oPlOp+Fg+924pkGaUkOoBN9YG0KdWGw
 9feg==
X-Gm-Message-State: AFq9FYILgaTvtUFWzoQM2C7kcIOexSG4QqyQcLb/ab/zvnLdCVughuU2
 ACxRvMsgfTL7ARAgXlTtSK0q2Upkc70K/q20Lsw6YppSom5kQcWkYEu2
X-Gm-Gg: AYBFou2MrvTgC1JHKjejbh+XfYiTM9EA0C1gDA3h6WUIJe1U935FqPNlBUkUsKEzYEE
 riq7qhJnXCUkWRnBz+Tq0eJQ775e4wBNdJSdxMft8LwC7+GwuhTbiCQOoRVjkOa5kUJPqtVU0PF
 qUnpf6bnOb0KqilJP7tt0H0OHizQZmLyXGVnjJ49ih0/vpSedrXNcZuyWXTLuhiL7lRLv46BmDb
 TEgRPgEYB89HDa42DeWyeGV29h/BopPmKY5b3IqmJyfApf2kFpsZF8lLsGbyj3F/etkJjFYqNjg
 OKjTUbmZ21aQQe2dqX9D4W9mID/p5ZIIq8DRy9bksWvCPrzPO2zMMxJDTIVbPnJ9i5/fesGYt2d
 X3rtWfH5yc7E70IkBFV+zdCsgsEu+AJyDyDe+GeqSsgkj5OjUKBAEXWxItR2eyv4700lWLSsPhp
 zX3VqBTmyTTHmN2Bs9R2v8ZSFeqqhvnped9MuDNybpRkKxh4SC3AXQ14fmR95tpXE=
X-Received: by 2002:a05:6122:390f:b0:5c9:c60e:5cf6 with SMTP id
 71dfb90a1353d-5e6d3701681mr1419054e0c.20.1791408080617; 
 Wed, 07 Oct 2026 14:21:20 -0700 (PDT)
Received: from beelink.. ([187.13.30.250]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e6c4d62704sm3115891e0c.10.2026.10.07.14.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:21:20 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, maaz.mombasawala@broadcom.com,
 stable@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/2] drm/vmwgfx: close TOCTOU on guest_memory_bo in surface
 reference ioctl
Date: Wed,  7 Oct 2026 18:20:49 -0300
Message-ID: <20261007212051.2574235-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007212051.2574235-1-qwe.aldo@gmail.com>
References: <20261007212051.2574235-1-qwe.aldo@gmail.com>
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

vmw_gb_surface_reference_internal() checks srf->res.guest_memory_bo
for NULL and reads its vma_node offset and base.size outside the
cmdbuf_mutex scope that protects the backup pointer.

A concurrent backup switch, e.g. from SVGA_3D_CMD_BIND_GB_SURFACE
via vmw_resource_unreserve(), drops its reference to the old buffer
and installs a new one under cmdbuf_mutex. The unlocked check in
the surface reference ioctl can see a transient NULL. The reads
after the unlock can return another buffer's offset and size; a
further switch can drop that buffer's last reference and free it
while the ioctl reads from it.

Move the NULL check inside the mutex, and read buffer_map_handle
and buffer_size while still holding it.

Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 97966d849583..291e3efad9ad 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1718,23 +1718,32 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 
 	user_srf = container_of(base, struct vmw_user_surface, prime.base);
 	srf = &user_srf->srf;
+	metadata = &srf->metadata;
+
+	mutex_lock(&dev_priv->cmdbuf_mutex);
+
 	if (!srf->res.guest_memory_bo) {
+		mutex_unlock(&dev_priv->cmdbuf_mutex);
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
 		ret = -EINVAL;
 		goto out_bad_resource;
 	}
-	metadata = &srf->metadata;
 
-	mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->backup */
 	ret = drm_gem_handle_create(file_priv, &srf->res.guest_memory_bo->tbo.base,
 				    &backup_handle);
-	mutex_unlock(&dev_priv->cmdbuf_mutex);
 	if (ret != 0) {
+		mutex_unlock(&dev_priv->cmdbuf_mutex);
 		drm_err(dev, "Wasn't able to create a backing handle for surface sid = %u.\n",
 			req->sid);
 		goto out_bad_resource;
 	}
 
+	rep->crep.buffer_map_handle =
+		drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
+	rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
+
+	mutex_unlock(&dev_priv->cmdbuf_mutex);
+
 	rep->creq.base.svga3d_flags = SVGA3D_FLAGS_LOWER_32(metadata->flags);
 	rep->creq.base.format = metadata->format;
 	rep->creq.base.mip_levels = metadata->mip_levels[0];
@@ -1747,9 +1756,6 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->crep.handle = user_srf->prime.base.handle;
 	rep->crep.backup_size = srf->res.guest_memory_size;
 	rep->crep.buffer_handle = backup_handle;
-	rep->crep.buffer_map_handle =
-		drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
-	rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
 
 	rep->creq.version = drm_vmw_gb_surface_v1;
 	rep->creq.svga3d_flags_upper_32_bits =
-- 
2.43.0

