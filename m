Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70AFFB3CE5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2721410E57E;
	Mon, 30 Mar 2026 09:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Sx7l6psS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4ED10E5AC
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774864145;
 bh=vJ9VxiSezaHmUT4R1gM2vBrOcIXoOjygXM32L+tr6kY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sx7l6psSi64c0+QbHSdp8hr2GMbkQJ6Zzu13V+KlVD0HeRxGbs4FV7CUqQwZckOSq
 JSQaJ4SYFLPtOJtJ7cVJ3e8O39HTytmnhhU3LPOjSHU/E0FOwI77gECku/JwO4eSPE
 Iv6kCSP0K2joKs6B5GlMZmiysT1KNPU7Pr4IAH8wYViFL6H+TW+yY0VYYArjwTH5qe
 aYeu7efcOFm700zg2OgLFivHUjue77Kv3IQ/A96jhg1fXGP5VLxKZlyNaV+mW4eG3R
 6cgf7TS4H9Ah8BUuosagiFbDYOgzuSeLchIjFke78M7c6iWt+v27mbp98q9UaCzeBi
 k/5SXE+mOL9Sg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BC58D17E41C5;
 Mon, 30 Mar 2026 11:49:04 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
Subject: [PATCH v6 8/9] drm/panthor: Track the number of mmap on a BO
Date: Mon, 30 Mar 2026 11:48:47 +0200
Message-ID: <20260330094848.2169422-9-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330094848.2169422-1-boris.brezillon@collabora.com>
References: <20260330094848.2169422-1-boris.brezillon@collabora.com>
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

This will be used to order things by reclaimability.

v2:
- Fix refcounting

v3:
- Fix refcounting (again)

v4:
- Collect R-b

v5:
- Collect R-b

v6:
- Warn on is_imported() (not supposed to happen since mmap is
  redirected to the dmabuf layer) instead of adding a conditional
  in panthor_gem_vm_open()

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 42 +++++++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_gem.h |  3 ++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index d9c3a71da29b..eb139759beda 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -488,6 +488,7 @@ static void panthor_gem_print_info(struct drm_printer *p, unsigned int indent,
 	drm_printf_indent(p, indent, "vmap_use_count=%u\n",
 			  refcount_read(&bo->cmap.vaddr_use_count));
 	drm_printf_indent(p, indent, "vaddr=%p\n", bo->cmap.vaddr);
+	drm_printf_indent(p, indent, "mmap_count=%u\n", refcount_read(&bo->cmap.mmap_count));
 }
 
 static int panthor_gem_pin_locked(struct drm_gem_object *obj)
@@ -604,6 +605,13 @@ static int panthor_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *v
 	if (is_cow_mapping(vma->vm_flags))
 		return -EINVAL;
 
+	if (!refcount_inc_not_zero(&bo->cmap.mmap_count)) {
+		dma_resv_lock(obj->resv, NULL);
+		if (!refcount_inc_not_zero(&bo->cmap.mmap_count))
+			refcount_set(&bo->cmap.mmap_count, 1);
+		dma_resv_unlock(obj->resv);
+	}
+
 	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	if (should_map_wc(bo))
@@ -740,13 +748,43 @@ static vm_fault_t panthor_gem_fault(struct vm_fault *vmf)
 	return panthor_gem_any_fault(vmf, 0);
 }
 
+static void panthor_gem_vm_open(struct vm_area_struct *vma)
+{
+	struct panthor_gem_object *bo = to_panthor_bo(vma->vm_private_data);
+
+	drm_WARN_ON(bo->base.dev, drm_gem_is_imported(&bo->base));
+	drm_WARN_ON(bo->base.dev, !refcount_inc_not_zero(&bo->cmap.mmap_count));
+
+	drm_gem_vm_open(vma);
+}
+
+static void panthor_gem_vm_close(struct vm_area_struct *vma)
+{
+	struct panthor_gem_object *bo = to_panthor_bo(vma->vm_private_data);
+
+	if (drm_gem_is_imported(&bo->base))
+		goto out;
+
+	if (refcount_dec_not_one(&bo->cmap.mmap_count))
+		goto out;
+
+	dma_resv_lock(bo->base.resv, NULL);
+	if (refcount_dec_and_test(&bo->cmap.mmap_count)) {
+		/* Nothing to do, pages are reclaimed lazily. */
+	}
+	dma_resv_unlock(bo->base.resv);
+
+out:
+	drm_gem_object_put(&bo->base);
+}
+
 static const struct vm_operations_struct panthor_gem_vm_ops = {
 	.fault = panthor_gem_fault,
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	.huge_fault = panthor_gem_any_fault,
 #endif
-	.open = drm_gem_vm_open,
-	.close = drm_gem_vm_close,
+	.open = panthor_gem_vm_open,
+	.close = panthor_gem_vm_close,
 };
 
 static const struct drm_gem_object_funcs panthor_gem_funcs = {
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index b66478c9590c..c0a18dca732c 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -80,6 +80,9 @@ struct panthor_gem_cpu_map {
 
 	/** @vaddr_use_count: Number of active vmap() requests on this GEM */
 	refcount_t vaddr_use_count;
+
+	/** @mmap_count: Number of active mmap() requests on this GEM */
+	refcount_t mmap_count;
 };
 
 /**
-- 
2.53.0

