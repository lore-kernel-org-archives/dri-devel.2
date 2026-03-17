Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB5FF33807
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D5E10E33B;
	Tue, 17 Mar 2026 06:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cxBz6+Hs";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07A310E32C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:41:31 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c7393536e53so2081167a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773729691; x=1774334491;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GwlbKCuRkMEJtcMvq6Y2vEjKV9Tt6Itzx4uW6Jnu0w=;
 b=cxBz6+HsUvhgcEPdbI513hgbkmZMMpPaWw+f6avL1gpKMf7CV3PomYcnXui9V5ZBn3
 KFRCSP9+jqCLNiEWEaV8Q3BQIaNRmFC4W8cTSneuU0qdu1R54eG4JRaH33IEg+j8yfRq
 VBqejDBzLY3qU4YN12Api25lt04XqPFCh+Wug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773729691; x=1774334491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GwlbKCuRkMEJtcMvq6Y2vEjKV9Tt6Itzx4uW6Jnu0w=;
 b=PyxGjMeKKbhVRSJV3lGiKY6Vn2k8x/ParWwoUrXvs7liRPRN/NKx9I4cgByea26pLQ
 dOK/Ng5Q/m/oaFU/oEkN+RaEODI117/yOuYH7yboCgrNX7+lfuWit0/2ispeJ4YRNsMQ
 hHknmCeW4p8NTtK5FQbmVD2GKFU8Dphbzyt0BCfZa8/yanWeV5C3rS0KNqJ9ABs9wLKo
 I4+92/AaVSPMFCV6E/m/UV69vMpEsEOFCRmBJQw6Zmo5+rSBqqPKSE+94BUx5HPqkii6
 /BiHsmeab/MXCkOctKRDvDcrxq4MrKNnQpXac0f/rYmGyLE4cKLEMCHI2ibBluddU/7g
 2KEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDGtS1VgUXBnojeFKIuckcPv6VuGbh4vV5UuAYgieRIJMdmoaer5KUTtyVWur4tLDLwm0pmSEuqPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywai+UxSxvxx7+XyKteSFWoLyoam+ix2NYx2rAdWlrUzo6MrqO3
 KoFTGFIOUeC5C5x11CZYX/vD6j70ASqytsuDSnZWeV6cefhjlsImXVzyIfTtIYPtLQ==
X-Gm-Gg: ATEYQzwNLoo56LIgSexJHBQH3Nz1AlkDbCbNm2ask74RW3RruM2myrrngBA+WCIUb9L
 /OSwN3aP4VvwgHCj5CHSWcMHU6G7LTdNLhwxCnnjSLHh2OoqfZkHISYYzrNgKqw44CYQ22Q1/3m
 LPAwMVRuk9jNY2JY10KqIDDRL9oUauVWdanWqKqb3xsoWyPcJITnGcp5ieZeJLfV+SzgMhQd+ee
 q2YTTQ/l7kSloAMrnQitqKna9e64sTUHebPGawfdrMTGqGXdorF56F5XrFlhKKuZB6LAf5IWIhY
 oYdX5YItLZTYOzbAZwzQ+mIJUsYWrqOuDn2XnOHpMm5uGr/FA/Y31bnzSUIlEqDeq5iEtbIoxYi
 UmXEP6nZGBdkngllajh8ZhnULAvKNOU0UayCBEKiNXhgBsnmvsA9a9W9G1dhCBGpS2k0swb2R8t
 4srYnGG5lTNZ9Nmvya+cazNRw2LaVCw9upGsY8ITz7OaxuKo3YMtIDDhiyGAYDNA4ZFMIcQAInR
 iZvwGX3
X-Received: by 2002:a17:902:ecd2:b0:2b0:5a4c:726a with SMTP id
 d9443c01a7336-2b05a5bbfdfmr53881605ad.43.1773729691244; 
 Mon, 16 Mar 2026 23:41:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:a064:c65d:a199:5cb6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece605231sm124269425ad.27.2026.03.16.23.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 23:41:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
 Chen-Yu Tsai <wenst@chromium.org>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>
Subject: [PATCH v2 4/4] drm/gem-dma: Support DRM_MODE_DUMB_KERNEL_MAP flag
Date: Tue, 17 Mar 2026 14:40:46 +0800
Message-ID: <20260317064049.696795-5-wenst@chromium.org>
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

Add support in DMA helpers to handle callers specifying
DRM_MODE_DUMB_KERNEL_MAP flag. Existing behavior is maintained with this
change. drm_gem_dma_dumb_create() always creates a kernel mapping as
before. drm_gem_dma_dumb_create_internal() lets the caller set the flags
as desired.

Most drivers that use drm_gem_dma_dumb_create_internal() are already
using the internal client interface via drm_client_setup*() and
DRM_FBDEV_DMA_DRIVER_OPS, and do not have other direct kernel
accesses to the buffer memory internally. Therefore, there is no need
to add the DRM_MODE_DUMB_KERNEL_MAP flag for them.

The only outlier is the adp driver. The DRM_MODE_DUMB_KERNEL_MAP flag
is added to its dumb_create() function, adp_drm_gem_dumb_create().

Signed-off-by: Rob Herring <robh@kernel.org>
[wenst@chromium.org: Rebase onto renamed GEM DMA helpers]
[wenst@chromium.org: show "vaddr=(no mapping)" in drm_gem_dma_print_info()]
[wenst@chromium.org: Drop DRM_MODE_DUMB_KERNEL_MAP driver changes]
[wenst@chromium.org: Add DRM_MODE_DUMB_KERNEL_MAP to adp_drm_gem_dumb_create()]
[wenst@chromium.org: Add flags field to drm_gem_dma_create_with_handle()
		     kerneldoc]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Rebased onto renamed GEM DMA helpers
- Added check in drm_fb_dma_get_scanout_buffer() and drm_gem_dma_vmap().
- Made drm_gem_dma_print_info() show "vaddr=(no mapping)" for objects
  allocated without kernel mapping
- Dropped existing DRM_MODE_DUMB_KERNEL_MAP flag addition in various
  drivers
- Added DRM_MODE_DUMB_KERNEL_MAP flag to adp_drm_gem_dumb_create()
- Added flags field kerneldoc for drm_gem_dma_create_with_handle()

Cc: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev
---
 drivers/gpu/drm/adp/adp_drv.c        |  1 +
 drivers/gpu/drm/drm_fb_dma_helper.c  |  4 ++
 drivers/gpu/drm/drm_gem_dma_helper.c | 67 +++++++++++++++++-----------
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index 4554cf75565e..c549b44b3814 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -95,6 +95,7 @@ static int adp_drm_gem_dumb_create(struct drm_file *file_priv,
 {
 	args->height = ALIGN(args->height, 64);
 	args->size = args->pitch * args->height;
+	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
 
 	return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
 }
diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index fd71969d2fb1..12a44accc48c 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -187,6 +187,10 @@ int drm_fb_dma_get_scanout_buffer(struct drm_plane *plane,
 	if (!dma_obj->vaddr)
 		return -ENODEV;
 
+	/* Buffer was allocated with NO_KERNEL_MAPPING */
+	if (dma_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return -ENODEV;
+
 	iosys_map_set_vaddr(&sb->map[0], dma_obj->vaddr);
 	sb->format = fb->format;
 	sb->height = fb->height;
diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 9722c9fc86f3..281fb563f061 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -116,26 +116,8 @@ __drm_gem_dma_create(struct drm_device *drm, size_t size, bool private)
 	return ERR_PTR(ret);
 }
 
-/**
- * drm_gem_dma_create - allocate an object with the given size
- * @drm: DRM device
- * @size: size of the object to allocate
- *
- * This function creates a DMA GEM object and allocates memory as backing store.
- * The allocated memory will occupy a contiguous chunk of bus address space.
- *
- * For devices that are directly connected to the memory bus then the allocated
- * memory will be physically contiguous. For devices that access through an
- * IOMMU, then the allocated memory is not expected to be physically contiguous
- * because having contiguous IOVAs is sufficient to meet a devices DMA
- * requirements.
- *
- * Returns:
- * A struct drm_gem_dma_object * on success or an ERR_PTR()-encoded negative
- * error code on failure.
- */
-struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
-					      size_t size)
+static struct drm_gem_dma_object *
+drm_gem_dma_create_flags(struct drm_device *drm, size_t size, u32 flags)
 {
 	struct drm_gem_dma_object *dma_obj;
 	int ret;
@@ -146,6 +128,9 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
 	if (IS_ERR(dma_obj))
 		return dma_obj;
 
+	if (!(flags & DRM_MODE_DUMB_KERNEL_MAP))
+		dma_obj->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
+
 	if (dma_obj->map_noncoherent) {
 		dma_obj->vaddr = dma_alloc_noncoherent(drm_dev_dma_dev(drm),
 						       size,
@@ -171,6 +156,30 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
 	drm_gem_object_put(&dma_obj->base);
 	return ERR_PTR(ret);
 }
+
+/**
+ * drm_gem_dma_create - allocate an object with the given size
+ * @drm: DRM device
+ * @size: size of the object to allocate
+ *
+ * This function creates a DMA GEM object and allocates memory as backing store.
+ * The allocated memory will occupy a contiguous chunk of bus address space.
+ *
+ * For devices that are directly connected to the memory bus then the allocated
+ * memory will be physically contiguous. For devices that access through an
+ * IOMMU, then the allocated memory is not expected to be physically contiguous
+ * because having contiguous IOVAs is sufficient to meet a devices DMA
+ * requirements.
+ *
+ * Returns:
+ * A struct drm_gem_dma_object * on success or an ERR_PTR()-encoded negative
+ * error code on failure.
+ */
+struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
+					      size_t size)
+{
+	return drm_gem_dma_create_flags(drm, size, DRM_MODE_DUMB_KERNEL_MAP);
+}
 EXPORT_SYMBOL_GPL(drm_gem_dma_create);
 
 /**
@@ -179,6 +188,7 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_create);
  * @file_priv: DRM file-private structure to register the handle for
  * @drm: DRM device
  * @size: size of the object to allocate
+ * @flags: DRM_MODE_DUMB_* flags if any
  * @handle: return location for the GEM handle
  *
  * This function creates a DMA GEM object, allocating a chunk of memory as
@@ -194,14 +204,14 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_create);
  */
 static struct drm_gem_dma_object *
 drm_gem_dma_create_with_handle(struct drm_file *file_priv,
-			       struct drm_device *drm, size_t size,
+			       struct drm_device *drm, size_t size, u32 flags,
 			       uint32_t *handle)
 {
 	struct drm_gem_dma_object *dma_obj;
 	struct drm_gem_object *gem_obj;
 	int ret;
 
-	dma_obj = drm_gem_dma_create(drm, size);
+	dma_obj = drm_gem_dma_create_flags(drm, size, DRM_MODE_DUMB_KERNEL_MAP);
 	if (IS_ERR(dma_obj))
 		return dma_obj;
 
@@ -283,7 +293,7 @@ int drm_gem_dma_dumb_create_internal(struct drm_file *file_priv,
 		args->size = args->pitch * args->height;
 
 	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
-						 &args->handle);
+						 args->flags, &args->handle);
 	return PTR_ERR_OR_ZERO(dma_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gem_dma_dumb_create_internal);
@@ -313,12 +323,13 @@ int drm_gem_dma_dumb_create(struct drm_file *file_priv,
 	struct drm_gem_dma_object *dma_obj;
 	int ret;
 
+	args->flags = DRM_MODE_DUMB_KERNEL_MAP;
 	ret = drm_mode_size_dumb(drm, args, 0, 0);
 	if (ret)
 		return ret;
 
 	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
-						 &args->handle);
+						 args->flags, &args->handle);
 	return PTR_ERR_OR_ZERO(dma_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gem_dma_dumb_create);
@@ -412,7 +423,10 @@ void drm_gem_dma_print_info(const struct drm_gem_dma_object *dma_obj,
 			    struct drm_printer *p, unsigned int indent)
 {
 	drm_printf_indent(p, indent, "dma_addr=%pad\n", &dma_obj->dma_addr);
-	drm_printf_indent(p, indent, "vaddr=%p\n", dma_obj->vaddr);
+	if (dma_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		drm_printf_indent(p, indent, "vaddr=(no mapping)\n");
+	else
+		drm_printf_indent(p, indent, "vaddr=%p\n", dma_obj->vaddr);
 }
 EXPORT_SYMBOL(drm_gem_dma_print_info);
 
@@ -511,6 +525,9 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_prime_import_sg_table);
 int drm_gem_dma_vmap(struct drm_gem_dma_object *dma_obj,
 		     struct iosys_map *map)
 {
+	if (dma_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return -ENOMEM;
+
 	iosys_map_set_vaddr(map, dma_obj->vaddr);
 
 	return 0;
-- 
2.53.0.851.ga537e3e6e9-goog

