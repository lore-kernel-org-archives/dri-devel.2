Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBE1F33806
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35D210E32C;
	Tue, 17 Mar 2026 06:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ejD/aI7f";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8782510E327
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:41:28 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso17395545ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773729688; x=1774334488;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beYKL+KpJYqTN09SlrzQ/IJhFB/kZtPqCQ/2b0LTAW0=;
 b=ejD/aI7fzUlsz8fm4wc/gj6tHetjVZ8ryLT/nqawgSwo95hcOfrwm6xY08Y5j0Wohn
 9A/ji5o8GxNE6tqiNYne0kvIEjmSvTOTPKFK68Mo2utnFYhBihqYN458HEfiG1NYYVAm
 +U0tQuxABc4ipJWn1eZKJVQJyo1KXV4sGepUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773729688; x=1774334488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=beYKL+KpJYqTN09SlrzQ/IJhFB/kZtPqCQ/2b0LTAW0=;
 b=ZvDtB335mlirEeu4qD7mbpxdz47Osca23ui5R6dr8t/tW0Lff0WNSYobH2YsiHIXm/
 P2WZvf7JpXW7EDgybcFvxENmAejjrth0XR+SUEV1mssrk1T2CyfxFVBT6buRoV6M9SCh
 /RGGwveIp0hs8lA7V6Venf/vR/TKcrIitQCocCPPVGRnIyPA9HogZSRdWuCDklz+l7di
 4Q6M/rhHZPcltWUk4cKaGapo75oFyELp8ULOIpnAy17KPZMdUN2aAvWKgYZWFqh4UqOf
 IC2l5KdFPC7pekv3qpIJsuaGlSI7VHTOnsMA+Jrgt949/1UbKSd3k6XU4oFoDRXYz/B2
 9GjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBGp0BWa8GLB4t/r69xRG4hC8WiVbCTZFcSsxYuViQWOpCdF4s2gJ9mxLFxjaEJ4rJecTf+4fS4w4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwD0qR1PBNfz8kq0UeRDLlwkXcjJDVyfmcb/fAmhcGs7yWZLmUC
 zAzJFj/UbGdpLtEMCwCxnjZjzYHVfP1efVTFcCpz290WbPWL25tIVgfShksfVBHnJg==
X-Gm-Gg: ATEYQzzeuFNBuDAf7c/kGAsDpOSlDpGLdf3hLUhmONV7kDEZB05LyJVfdEKsZs/H8bu
 ocJSpXVldz1rBdauSCKqGcub4QMIXj6askzotc/swXo/V+H99821Uz5TL026TmxQIk2t4Akica0
 gBZzvxgRtXFtiap5LFAXu/Hs+kmHo4lgYK6/Gl8z8yONQk5Hm1IYIqd8LL05qgaf+dUSunJobI7
 C2bRKuZTV4bfLFozYgVgnDG0i2bbPdSB7V+uofr8ntoPsOXjp3alZgV8sst/aj50JQ1whaLuQ9d
 i6a0WEqM4xVqmNA85LVuH+JQ53dYF893CUsQZH7AcEyZEX1pAnBrm4dXgMRUWIh/aM0rkxk1OhB
 gt1Nt+dmwZFeg3jrN1Z5j1VifFpsj5mI6d8FxB4Bxl7IXeBUdNO0WygdJuCwVe9JjHbnIs4EN76
 7o9GkuLPlCOKFrDbUn2fVCDszWQhC9+7lRugmI/tOpgPwcBFoqZl0ONC1GVK9RgpUhXFkffvkHe
 iQAQM3/
X-Received: by 2002:a17:903:37d0:b0:2b0:4a57:e498 with SMTP id
 d9443c01a7336-2b04a57e8demr100300115ad.15.1773729688017; 
 Mon, 16 Mar 2026 23:41:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:a064:c65d:a199:5cb6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece605231sm124269425ad.27.2026.03.16.23.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 23:41:27 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 3/4] drm/gem-dma: Use the dma_*_attr API variant
Date: Tue, 17 Mar 2026 14:40:45 +0800
Message-ID: <20260317064049.696795-4-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260317064049.696795-1-wenst@chromium.org>
References: <20260317064049.696795-1-wenst@chromium.org>
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

Also change the dma_free_wc() call in vc4_bo_purge() in the vc4 driver
to use dma_free_attrs() to match. vc4_bo is a sub-class of
drm_gem_dma_object.

Sub-classes of |struct drm_gem_dma_object| can also set additional
DMA_ATTR_* flags if they choose so. For example a sub-class could
set DMA_ATTR_FORCE_CONTIGUOUS in certain cases.

Signed-off-by: Rob Herring <robh@kernel.org>
[wenst@chromium.org: Rebase onto renamed DMA helpers]
[wenst@chromium.org: Make vc4_bo_purge() use matching dma_free_attrs()]
[wenst@chromium.org: Expand commit message to mention that sub-classes
                     can set extra DMA_ATTR_* flags]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

---
Changes since v1:
- Rebased onto renamed DMA helpers
- Made vc4_bo_purge() use matching dma_free_attrs()
- Expanded commit message to mention that sub-classes can set extra
  DMA_ATTR_* flags
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 26 +++++++++++++++-----------
 drivers/gpu/drm/vc4/vc4_bo.c         |  2 +-
 include/drm/drm_gem_dma_helper.h     |  3 +++
 3 files changed, 19 insertions(+), 12 deletions(-)

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
2.53.0.851.ga537e3e6e9-goog

