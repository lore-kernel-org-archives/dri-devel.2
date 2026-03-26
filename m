Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123CE106F30F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF7210EAAB;
	Thu, 26 Mar 2026 10:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eq/x810W";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883DE10EAA6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:03:08 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c74f0c3fc16so295950a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774519388; x=1775124188;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9KkAzXq0JR8TGkENovBJsntvxWB2injAP7fSinZoPY=;
 b=eq/x810WnScTgjAnDATpJZ47opymQV6wYPIr4/9O7VwkPdHe0N7HCmDj8d9h7Yyq/y
 +1CNw30/rIIcJNuiE0A9d3yGBGrPD5UVBrBUPSFlFl18q7DSHjNrftX/EZri0Eblg3zW
 kP2x81EVq3YoyvGzCb1WeCma4pzrQ3j9otzcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774519388; x=1775124188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9KkAzXq0JR8TGkENovBJsntvxWB2injAP7fSinZoPY=;
 b=Y7p0HBEJvgzM6NajDwJ+IQ2rlRGh3DdTP9GqGsNQNghBPuQ0Px7QRejONSY1L73nR9
 lFM2jVtD3T7YNDKR4V4bUYCAKIshg9qVivjnEKp1D/ogOuMyy2flcNRWFoCN4X1sTQEI
 UdMRaCo12lS0kVMyhLyVFFVGNMuQaUcg4WYIbhrX1PvPYHL+mkVLg2Rd6aetISI6P1S8
 17jPR5fGalvKfeuazbuJiARqVclvUVTqAVU7SBMRX8iU9ZyLXHpbMyd20MMSq49HIKBi
 NS5O1rVDvCQhYWY2E0X/A/miPgfKCapL8HtMqOTtG5LbzPQiM2DEwyGmQAm9nJPrdte5
 E1vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsXd6UP+qsVbMsWrcLOQdj6duZw2RbWymNOCshW1fk2sgM9jLnbnYba7IOmqJ73Qd6+vSlX3gBK9Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlyO3p/bzql2Nt7VkI7agNbdQ+MVazl+6yy20IZqa70ynxpvDD
 /rDgRr2tvV3mILTVJRl6IvAJ9T3FPvANgfjesgnkY8TMsOjiz4xmMBjD5cYDO2vD/A==
X-Gm-Gg: ATEYQzzK7SYk8MSVDKCB3DdywSAyqsy5c7ZsOOUJDEmDUeGYk+V9UxHilLEzk6o6wj1
 5NSEsI+MBWtLN7hSc1XCw8fIbConpsuj6ounL1rY5MqQ1+5cmLutfMBUUUh5mW4V5rrS+RKxomi
 zL6oQ73Cw46FDSWna+wae5I50gwhM2jsK2M9ameNzF2SW8aoIBu+qI/JI2SPITm1K9kNmtLQ+WS
 DSfV0HNpSGjqUMyWFBkaa898qvREvIdEIDouKyeKoVykK1GvgdIzdHuHIBpzokDFTjFPY6kcqiN
 tAO+VzyFtfB2ZvtP8wSYTGtEA5Fsjm7DCxa+7PTMQMbU/i+RUcdOGiYiwy+iLQucarN9nvpJSmj
 ONyKUJZLuDex0om9y0QKIDUTNp/cq9Wi4TexVRtUIks2wYQh8BsP09d00yyK55ahGZ9aCrDa615
 4/lm+vt0urkUw0yz0Fes9M/msL7UV8xWhlX5KW1mExnNjfowk0FU0NeOhIcjJt8Rf85BERLvumN
 U2HnrKP
X-Received: by 2002:a17:902:cec1:b0:2b0:b290:f2f4 with SMTP id
 d9443c01a7336-2b0b2910099mr70615975ad.32.1774519387930; 
 Thu, 26 Mar 2026 03:03:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7c2942sm23339435ad.36.2026.03.26.03.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:03:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v3 2/3] drm/gem-dma: Use the dma_*_attr API variant
Date: Thu, 26 Mar 2026 18:01:44 +0800
Message-ID: <20260326100248.1171828-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326100248.1171828-1-wenst@chromium.org>
References: <20260326100248.1171828-1-wenst@chromium.org>
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

From: Rob Herring <robh@kernel.org>

In preparation to allow DRM DMA users to adjust the DMA_ATTR_* flags,
convert the DMA helper code to use the dma_*_attr APIs instead of the
dma_*_wc variants.

Only the DMA_ATTR_WRITE_COMBINE and DMA_ATTR_NO_WARN attributes are set
in this commit, so there's no functional change.

Update rcar_du_vsp_map_fb() to use dma_get_sgtable_attrs() instead of
dma_get_sgtable().

Also change the dma_free_wc() call in vc4_bo_purge() in the vc4 driver
to use dma_free_attrs() to match. vc4_bo is a sub-class of
drm_gem_dma_object.

Sub-classes of |struct drm_gem_dma_object| can also set additional
DMA_ATTR_* flags if they choose so. For example a sub-class could
set DMA_ATTR_FORCE_CONTIGUOUS in certain cases.

Signed-off-by: Rob Herring <robh@kernel.org>
[wenst@chromium.org: Rebase onto renamed DMA helpers]
[wenst@chromium.org: Make vc4_bo_purge() use matching dma_free_attrs()]
[wenst@chromium.org: Make rcar_du_vsp_map_fb() use dma_get_sgtable_attrs()]
[wenst@chromium.org: Expand commit message to mention that sub-classes
                     can set extra DMA_ATTR_* flags]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

---
Changes since v2:
- rcar-du: Change dma_get_sgtable() to dma_get_sgtable_attrs()

Changes since v1:
- Rebased onto renamed DMA helpers
- Made vc4_bo_purge() use matching dma_free_attrs()
- Expanded commit message to mention that sub-classes can set extra
  DMA_ATTR_* flags
---
 drivers/gpu/drm/drm_gem_dma_helper.c          | 26 +++++++++++--------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c |  5 ++--
 drivers/gpu/drm/vc4/vc4_bo.c                  |  2 +-
 include/drm/drm_gem_dma_helper.h              |  3 +++
 4 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 1c00a71ab3c9..9722c9fc86f3 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -108,6 +108,7 @@ __drm_gem_dma_create(struct drm_device *drm, size_t size, bool private)
 		goto error;
 	}
 
+	dma_obj->dma_attrs |= DMA_ATTR_NO_WARN | DMA_ATTR_WRITE_COMBINE;
 	return dma_obj;
 
 error:
@@ -152,9 +153,10 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
 						       DMA_TO_DEVICE,
 						       GFP_KERNEL | __GFP_NOWARN);
 	} else {
-		dma_obj->vaddr = dma_alloc_wc(drm_dev_dma_dev(drm), size,
-					      &dma_obj->dma_addr,
-					      GFP_KERNEL | __GFP_NOWARN);
+		dma_obj->vaddr = dma_alloc_attrs(drm_dev_dma_dev(drm), size,
+						 &dma_obj->dma_addr,
+						 GFP_KERNEL | __GFP_NOWARN,
+						 dma_obj->dma_attrs);
 	}
 	if (!dma_obj->vaddr) {
 		drm_dbg(drm, "failed to allocate buffer with size %zu\n",
@@ -242,9 +244,9 @@ void drm_gem_dma_free(struct drm_gem_dma_object *dma_obj)
 					     dma_obj->vaddr, dma_obj->dma_addr,
 					     DMA_TO_DEVICE);
 		else
-			dma_free_wc(drm_dev_dma_dev(gem_obj->dev),
-				    dma_obj->base.size, dma_obj->vaddr,
-				    dma_obj->dma_addr);
+			dma_free_attrs(drm_dev_dma_dev(gem_obj->dev),
+				       dma_obj->base.size, dma_obj->vaddr,
+				       dma_obj->dma_addr, dma_obj->dma_attrs);
 	}
 
 	drm_gem_object_release(gem_obj);
@@ -435,8 +437,9 @@ struct sg_table *drm_gem_dma_get_sg_table(struct drm_gem_dma_object *dma_obj)
 	if (!sgt)
 		return ERR_PTR(-ENOMEM);
 
-	ret = dma_get_sgtable(drm_dev_dma_dev(obj->dev), sgt, dma_obj->vaddr,
-			      dma_obj->dma_addr, obj->size);
+	ret = dma_get_sgtable_attrs(drm_dev_dma_dev(obj->dev), sgt,
+				    dma_obj->vaddr, dma_obj->dma_addr,
+				    obj->size, dma_obj->dma_attrs);
 	if (ret < 0)
 		goto out;
 
@@ -546,9 +549,10 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 				     vma, vma->vm_end - vma->vm_start,
 				     virt_to_page(dma_obj->vaddr));
 	} else {
-		ret = dma_mmap_wc(drm_dev_dma_dev(dma_obj->base.dev), vma,
-				  dma_obj->vaddr, dma_obj->dma_addr,
-				  vma->vm_end - vma->vm_start);
+		ret = dma_mmap_attrs(drm_dev_dma_dev(dma_obj->base.dev), vma,
+				     dma_obj->vaddr, dma_obj->dma_addr,
+				     vma->vm_end - vma->vm_start,
+				     dma_obj->dma_attrs);
 	}
 	if (ret)
 		drm_gem_vm_close(vma);
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
index 94c22d2db197..a4896096e3bc 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
@@ -291,8 +291,9 @@ int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, struct drm_framebuffer *fb,
 				dst = sg_next(dst);
 			}
 		} else {
-			ret = dma_get_sgtable(rcdu->dev, sgt, gem->vaddr,
-					      gem->dma_addr, gem->base.size);
+			ret = dma_get_sgtable_attrs(rcdu->dev, sgt, gem->vaddr,
+						    gem->dma_addr, gem->base.size
+						    gem->dma_attrs);
 			if (ret)
 				goto fail;
 		}
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index f45ba47b4ba8..981593739a0f 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -304,7 +304,7 @@ static void vc4_bo_purge(struct drm_gem_object *obj)
 
 	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
 
-	dma_free_wc(dev->dev, obj->size, bo->base.vaddr, bo->base.dma_addr);
+	dma_free_attrs(dev->dev, obj->size, bo->base.vaddr, bo->base.dma_addr, bo->base.dma_attrs);
 	bo->base.vaddr = NULL;
 	bo->madv = __VC4_MADV_PURGED;
 }
diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_helper.h
index f2678e7ecb98..e815ff121e23 100644
--- a/include/drm/drm_gem_dma_helper.h
+++ b/include/drm/drm_gem_dma_helper.h
@@ -16,6 +16,8 @@ struct drm_mode_create_dumb;
  *       more than one entry but they are guaranteed to have contiguous
  *       DMA addresses.
  * @vaddr: kernel virtual address of the backing memory
+ * @dma_attrs: DMA attributes used when allocating backing memory.
+ *             Only applies to coherent memory.
  * @map_noncoherent: if true, the GEM object is backed by non-coherent memory
  */
 struct drm_gem_dma_object {
@@ -25,6 +27,7 @@ struct drm_gem_dma_object {
 
 	/* For objects with DMA memory allocated by GEM DMA */
 	void *vaddr;
+	unsigned long dma_attrs;
 
 	bool map_noncoherent;
 };
-- 
2.53.0.1018.g2bb0e51243-goog

