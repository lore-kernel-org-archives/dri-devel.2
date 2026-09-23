Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A02AC9830C
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B2B10E891;
	Wed, 23 Sep 2026 12:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+OOAePR";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C8A10E891
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:26:13 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c67e53002bso576055e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166373; x=1790771173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3lfa5GPOn19zRKVJ4YVgkdAOFskUQn9deVo/jHnP1F0=;
 b=c+OOAePRzHMeL5rx2flTGmZS6VmRBqqOkb9GudLA/Hd2ZUFgvrlSqK7LD8OmL0oooH
 U/JSfWH1euJmYP1XlAUnOJunM+gBCL8O1nEkbDzXhq8d7nP4t1hycLVfPJgiFNk3o+Lo
 QtbLq76nblEvETv2nnSoX4l5wCGAUqE5W1N9MdeF9+Mf/GtuVJ/AWaKgS2V14qAUNHBD
 KhBmie83zR/JRZDdKTSA71Re63LXegLZ6KzaHMIVdeBTjONZQqa7aGGsOpvyOm1RvRI2
 51LWnHJ7UczLDyGCcim5LmxLEg1p24y3spODiK/xgpxyI0B0hhAWpRFnwxqWaiQE16t/
 C5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166373; x=1790771173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3lfa5GPOn19zRKVJ4YVgkdAOFskUQn9deVo/jHnP1F0=;
 b=hlJITm/czYSx9xPq0uvaouF1A4qCxEImAXf3mYmlxIRXWb5FpyAYO6riunnZKJS40r
 tIbVAzktcVIqkq/q9tvXJSTXTEY62eu+7G6SMVKmOwjSYoYmk4xhw4FaPqOqY8ziIjwa
 iCbwwRNWXmrkXpLDO0eZa6QfmO5EnnpjyraHtYcFM9wV+vVO7FIkUMuAclAJ4pWkmo+0
 sqjSunWXLqn7lamX9O/iMQy7/MoMfupf2QUt/lTQy8lub8qd3DMP+fOqTsi7o9ZaaE6z
 GlTwucZlWHcpZ40wg5EPdOPTIPDu9IW7t6Xfk3JrlbIGm2ZdgIh0H55swRBTZU9EIxZg
 kBog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxio81nKX4pT85JXGHltk6DiS6bo9j+VoigrtKiujNOwDflIvu2o9YwplFdKy+vNUqn2ezRDVJoQtc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0vaazQZznX6LiNHnBptg+TXxmqcm2Ytig+xWEoNfHUegUjWPy
 pCfDeIlZsoME1r4lGsEGBJZ0AG0eXPnmfr9T62JN7rhWsJzCgRroHa9+
X-Gm-Gg: AYBFou0F+4GLowXAxNe7ASAnyb9Bn+A/YTt4Hi90qZrNT8LghGHed3dZWEpGinWdhRn
 fEavudSgdZRz5sfwYMRJme5/4DU9HJLDDvfDhVeWCnGSxslvQSrmCR+WXbax3SsaJ5uew/lWj/L
 FQ27xVYm5yw72NiJGRWeVuV4Oo7ZynA5elZFcGh3PATl2SFTtzm2bcOc1n3CZodxQbOE08sef1s
 cwb0J60jNOQxPAuMBhlbbuAaMVaYsH2hELAVTd9v594ZgejxMULEjCEzsO7qKqMwvUFBZkbMme5
 oe9rtGkGUWrvQXHo3AjPPyylQRC2vaaCtJnO7xinxSf6Oogc9rAkSVa5gH2XOI8bnWedqdQnAy2
 ATp34NA7W71y5KVBUEL87Z0ApRgaylVRTzlLvUNXvhCJx36uw3Dgh6HQtQDZe3RmpXTMFtSPWBm
 D8OxvftdXAMssIwcUp2OLypi+hnQcWaxpOt+0LozutbHI9VLgJEJl3Yef3o0/wRyA=
X-Received: by 2002:a05:6122:f93:b0:5c8:228:5ea6 with SMTP id
 71dfb90a1353d-5c9f159ab1bmr3134360e0c.5.1790166372720; 
 Wed, 23 Sep 2026 05:26:12 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9f04f5b93sm3002417e0c.8.2026.09.23.05.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:26:12 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the PRIME
 core
Date: Wed, 23 Sep 2026 09:26:01 -0300
Message-ID: <20260923122601.438892-1-qwe.aldo@gmail.com>
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

vmw_gem_object_get_sg_table() returns vmw_tt->vsgt.sgt when the buffer
object has already been DMA mapped.  vmw_ttm_map_dma() sets that field
to &vmw_tt->sgt, which is a member embedded inside the struct
vmw_ttm_tt allocation and not a table of its own.

The core owns whatever .get_sg_table returns.  drm_gem_map_dma_buf()
takes the table and drm_gem_unmap_dma_buf() destroys it in full:

	dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
	sg_free_table(sgt);
	kfree(sgt);

Both are ops of drm_gem_prime_dmabuf_ops, so the core ends up calling
kfree() on &vmw_tt->sgt, which is not the start of an allocation.  The
preceding sg_free_table() also destroys a scatterlist that vmwgfx still
considers its own and frees again from vmw_ttm_unmap_dma().

drm_gem_unmap_dma_buf() runs from dma_buf_detach(), including the
importer's error path, so a failed import is enough to reach it:
exporting a bound buffer with DRM_IOCTL_PRIME_HANDLE_TO_FD and
importing it on a second DRM device with DRM_IOCTL_PRIME_FD_TO_HANDLE
is sufficient.  Both ioctls are DRM_RENDER_ALLOW.

Observed on 6.12.101 with KASAN, as uid 65534:

  BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf+0xb3/0xf0
  Free of addr ffff888008290450 by task poc_mm04_sgtabl/321
  CPU: 1 UID: 65534 PID: 321 Comm: poc_mm04_sgtabl Not tainted 6.12.101 #4
   kasan_report_invalid_free+0x94/0xc0
   check_slab_allocation+0x116/0x120
   kfree+0x103/0x360
   drm_gem_unmap_dma_buf+0xb3/0xf0
   dma_buf_detach+0x165/0x510
   drm_gem_prime_import_dev+0x33e/0x430
  which belongs to the cache kmalloc-192 of size 192
  The buggy address is located 80 bytes inside of
   144-byte region [ffff888008290400, ffff888008290490)

80 is offsetof(struct vmw_ttm_tt, sgt) and 144 is sizeof(struct
vmw_ttm_tt), which identifies the freed pointer as the embedded member.

Always return a table the core can own, as the other drivers do.
Reusing the cached representation would require copying it into a
freshly allocated sg_table, never returning the alias.

Fixes: 8afa13a0583f ("drm/vmwgfx: Implement DRIVER_GEM")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index 39f8c4655..a0233729b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -73,10 +73,13 @@ static struct sg_table *vmw_gem_object_get_sg_table(struct drm_gem_object *obj)
 	struct vmw_ttm_tt *vmw_tt =
 		container_of(bo->ttm, struct vmw_ttm_tt, dma_ttm);
 
-	if (vmw_tt->vsgt.sgt)
-		return vmw_tt->vsgt.sgt;
-
-	return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages, vmw_tt->dma_ttm.num_pages);
+	/*
+	 * Do not return &vmw_tt->sgt: the core owns what this returns and
+	 * drm_gem_unmap_dma_buf() sg_free_table()s and kfree()s it, but that
+	 * sg_table is embedded in the vmw_ttm_tt allocation.
+	 */
+	return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages,
+				     vmw_tt->dma_ttm.num_pages);
 }
 
 static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
-- 
2.43.0

