Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BA8C9830C
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E50310E8BB;
	Wed, 23 Sep 2026 13:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O/iuz63b";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1745610E8BB
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:50:22 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-982e8fa91d3so265309241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790171421; x=1790776221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VhOTBKxTDZE3kPAoPytB3fQqVT7gRViOvjJsKRH52ko=;
 b=O/iuz63b4vtC9XBllqzU+N9CseTkLINYZ7jQMLl1ceuc/8IZfDzEtnSOIgiVtTABMs
 YvvL1x1WoacJgjDVAJO1Co0V68nGvajn/Fkt9XjCV22k9v/kCyXht1DdiLvGR9RL5Dgl
 dnLa3eGTEP7RfK9W5c21GF/wyrqCq+XQ51760NcugznxOqS8tqUpoIGiZHZmLOMwblrg
 Y5fC/5oe23sDUXRblMDdcd05l01vWvn4jTT4ljUq+pxQXmt9w26UZV+psm7g3WvoPOKD
 Z1TCQEKmq44FQe+d6wjRd4AQiocKUyobl8kQefT6v66JY6OVEnH5doBFZ4Lej1rQ6fbQ
 MMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790171421; x=1790776221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VhOTBKxTDZE3kPAoPytB3fQqVT7gRViOvjJsKRH52ko=;
 b=j9BvgMUxKJAaYxMVRJLokiJe4Qb1YjFe+aq9/XzriUxH+nSI3w9IORBU2JucnYO1Pv
 Gw3h8vdoW/6HOD0pL3IutNGHuuIVOgx/6brqqU3xZos51UYMdNNqHQKiy3WI+rIcSLCu
 A8FYxmmAOu/tLcFwZB4Z7XoH3WGWuWVftjhALcm0n27+dcu9Sq04VAETUiRk5JwNk2Wj
 AzByeuCd4s6ewqTdBsIIbOOmsE4ZsiXeoEGikNDfhUs3DS1EAjU+wdISsKzy5SDeYEvF
 JU9zmF1CMhEpN4cKJilkTUN8kRLpOSUNpnCjsra4jHlq/CHoALBld6q+IYOt8GHj7Hdn
 VwWw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLZbmemU8X6RYLIGaAAIalvXY844xD4Cj0ZUh9Za+sqyOhIBO/UrHtzcywYluE0Po+7sYNIOOp7rk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m76a8iIz45JVVoA8cZTYwezQ1OiOoHTiOfRZaHn/qyzUUKg0tu
 jdxVizHBJGa47cWLVTJbIC3pY/eFpRlvLKdgFrSns5u/JbgSL0RD739F
X-Gm-Gg: AYBFou1AU3QZXrNv8plcSVrRX5+g773/InUVL35zRv8+D71mZ/en4qghpu9fKVHTcAZ
 fjjNHAqC9vId1kI5vMBLDjj78NV3ZzhpNKb0+H4pBQYbfgQObyqq2P/Ph2WPWvgwlVdug6KiEF6
 qkHIgkf+EqMcdqX6NfYtNEIA1rpaWE28waZCGZGFmSt37/ByHyLJGzZb3hxfg1JCWEF8y/WTaer
 ODb5J1e3ZsLoJ1xgn7681LZ+eAU/vsvJdEIPklqSH52pop+MXZTlVNYa6SEUYgvXj9NePDV43di
 n96ZhsCRCqLR8/iCsKYFHlVBVj8rTR0Cw72gpwVqNh81LAf8GAvonKbUNO5BfDAPqJVPA8HSy6n
 /rK9W5iIlzjhZkq2SGGGvXn+jtZOpJtknb/KBvNOu1dbT6moQpDFSVHEF3UlykNpOkiLJGJhrbV
 c3AyXSmuC0XCxNjyvKsQL59EprBWjMfLoMVXAhF5MeUkbhDaLPySeGP5b35Y26VbmEapXu98wna
 g==
X-Received: by 2002:a05:6102:f12:b0:7a6:accf:72bc with SMTP id
 ada2fe7eead31-7ac0754f89cmr2473350137.0.1790171420881; 
 Wed, 23 Sep 2026 06:50:20 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7abf6087f6dsm4100538137.9.2026.09.23.06.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:50:20 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/vmwgfx: close TOCTOU on guest_memory_bo in surface
 reference ioctl
Date: Wed, 23 Sep 2026 10:50:12 -0300
Message-ID: <20260923135012.1823971-1-qwe.aldo@gmail.com>
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

vmw_gb_surface_reference_internal() checks srf->res.guest_memory_bo for
NULL and reads its buffer_map_handle and buffer_size outside the
cmdbuf_mutex scope that protects the backup pointer.

A concurrent surface eviction can NULL out guest_memory_bo between the
check and the use, causing a NULL pointer dereference in
drm_gem_handle_create(). The post-mutex reads of vma_node and base.size
race with any concurrent backup change.

Move the NULL check inside the mutex, and read buffer_map_handle and
buffer_size while still holding it.

Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and reference")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd05637..fff4402 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1718,15 +1718,21 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 
 	user_srf = container_of(base, struct vmw_user_surface, prime.base);
 	srf = &user_srf->srf;
+	metadata = &srf->metadata;
+
+	mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->guest_memory_bo */
 	if (!srf->res.guest_memory_bo) {
+		mutex_unlock(&dev_priv->cmdbuf_mutex);
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
 		goto out_bad_resource;
 	}
-	metadata = &srf->metadata;
-
-	mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->backup */
 	ret = drm_gem_handle_create(file_priv, &srf->res.guest_memory_bo->tbo.base,
 				    &backup_handle);
+	if (!ret) {
+		rep->crep.buffer_map_handle =
+			drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
+		rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
+	}
 	mutex_unlock(&dev_priv->cmdbuf_mutex);
 	if (ret != 0) {
 		drm_err(dev, "Wasn't able to create a backing handle for surface sid = %u.\n",
@@ -1746,10 +1752,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->crep.handle = user_srf->prime.base.handle;
 	rep->crep.backup_size = srf->res.guest_memory_size;
 	rep->crep.buffer_handle = backup_handle;
-	rep->crep.buffer_map_handle =
-		drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
-	rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
-
+	/* buffer_map_handle and buffer_size set inside the mutex above */
 	rep->creq.version = drm_vmw_gb_surface_v1;
 	rep->creq.svga3d_flags_upper_32_bits =
 		SVGA3D_FLAGS_UPPER_32(metadata->flags);
-- 
2.43.0
