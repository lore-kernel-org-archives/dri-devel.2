Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349F60A262A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9865E10E6CF;
	Thu, 12 Nov 2026 22:59:18 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5A610E6CF
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:13 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-8b360828905so4667487b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524352; x=1795129152;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4xpeSCzbdtgpV+wabu6FimfaTfSr38PgllCPL0OdJGU=;
 b=GTM6Y/vTh1d7uv5FiuK9JhlT3FobDIcO9qiYCSvGdlUH6Hh4QxTv1fL80CDX3sb9Jt
 6It5BRZiujCm6Qm6Xmx8c008A69b/TvU529XB85IYJ2afjqMnEOaPyfYpGIwJQX/tc0m
 n5IKfiZBlDaBxowtFiqrkdnz71CsbnjwXD0gasPuxCV/yO2lIKO9Q+RDbDvUWa5qx5Jh
 HDpTp+ceDyF160BN1Wj6TYhzFzcsGmpTaMRCYYtC1MwCEJSSJjtSu5jEnj7gr9X+6/W1
 xf4PUBeUrkGsSToNZ/RQDzXFRRXkOu3iRGoHH0QOclNsreqPFs1dKH3wQeKkjMox8QEh
 A8FA==
X-Gm-Message-State: APuU4Z/cR9AiZMzE8uXIV4hUCzFxMTbqH4+tmiyFd46HkVzilnb9uidq
 uj4gleoWz432W1q8hM5bhYPAjPKJ7IPnG6nvB1wYlwczwuV/h+Hm+Ejn
X-Gm-Gg: AYBFou0tR1Op1UbBHjJ05O1WtcvbixTDkbamZ/9S6225i/6AXhI1OQBxjSNgRR9Mxv5
 xgEYv8IBqHxwYmItj3x7Lxs2LIsW7ABVFBo54o2eVhUK31CnBQSY/PJT+dgVY/sW4rFJh5OC06u
 38eesboeDOLtmuNUFxX+itenBFES31GiL1bkKeWZDbYSTmH7QcjECUNMWtwPSeNAeDKs8dLO2+K
 c8kYQHGkb5wI4aLV0xXFL0bEAYHscnwnaILd4mSTaiKeYYgxv21zc3JayCGIgZC77F9om5xTuZR
 ktXbm7pGPJABGGDCQS8+UyQRhWRtaUv0ZGkZn3cH/+8ZiwTQcJqQzyvKosCPhf6V1QGrwRYSpz3
 ZQ1JI2o+zqrlAuz2YIIrVznkZExc/oU1reePfCgIHpsZSmU9Hzg95bRGkfk1qLOBWovXpMu32JV
 SmRkYbnKXVkay32C3F3Tg78ndZMhjvIyvH0+AkyoAqvBZR9gdudtTCnykb2TxdXO5RMx9jSHTGn
 bZ6aAdceLCTbW/o+2jxj8qzWgP6TebwrLxWgWzO0Z8c9BmjVsFbl1k62+0JvcDWeyBnr6e7O+Yh
 MSichx+cI+K4g9wd0CSNyTUFflRYWm2Fu3VRGfyH6SP2xkrlUsFfcjspHji5lXGX6VJjkPlTM53
 pZvRzNLQ3YADWmuxR8NEgr3kGvgVv7zNpyFX6kvZjxTo7DrCUkWW+UpX1Q5bUW9/lkncK5bV8Vt
 CX+TLjnd1Uv2NbOsTlIpe+TzCm
X-Received: by 2002:a05:690c:6987:b0:8b3:361f:5d7a with SMTP id
 00721157ae682-8b4aa25cab2mr5540957b3.41.1794524352554; 
 Thu, 12 Nov 2026 14:59:12 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:11 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:58:53 -0500
Subject: [PATCH RFC 03/13] drm/gma500: Export GEM objects as dma-bufs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-powervr-sgx-v1-3-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A render GPU next to gma500 draws into gma500's scanout buffers: on
Cedarview the SGX545, driven by powervr_sgx through gma500's auxiliary
device, renders while gma500 scans out. Mesa's kmsro allocates the
buffers on the display device and imports them into the render device,
which needs gma500 to export them.

Add the pin, unpin, get_sg_table, vmap and vunmap hooks the PRIME
helpers need. An export pins the object's pages, write-combined as for a
framebuffer, but doesn't insert them into the GTT: the importer maps the
pages itself, and powervr_sgx takes a write-combined kernel mapping of
an import for its cache maintenance. (A CPU mmap through
dma_buf_mmap() still goes through psb_gem_fault(), which pins the object
into the GTT.) A use count shares the pages between GTT pins, exports
and kernel mappings. Objects in stolen memory have no struct pages and
can't be exported.

The PRIME helpers call pin and unpin with the object's reservation lock
held, and psb_gem_pin() and psb_gem_unpin() take that lock themselves.
Split each into a variant that expects the lock held.

The importer's CPU mapping, dma_buf_mmap(), goes through the object's
fake mmap offset, which a dumb buffer only gets from MAP_DUMB, and Mesa's
kmsro never calls that for the buffers it exports. Create the offset at
export.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/gma500/gem.c | 182 ++++++++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/gma500/gem.h |   1 +
 2 files changed, 153 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 4a4ecfb7b..9eff7a739 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -11,11 +11,14 @@
  *		accelerated operations on a GEM object)
  */
 
+#include <linux/iosys-map.h>
 #include <linux/pagemap.h>
+#include <linux/vmalloc.h>
 
 #include <asm/set_memory.h>
 
 #include <drm/drm.h>
+#include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vma_manager.h>
 
@@ -26,71 +29,104 @@
  * PSB GEM object
  */
 
-int psb_gem_pin(struct psb_gem_object *pobj)
+/*
+ * The object's pages, write-combined, for a GART pin or a PRIME export: an
+ * exported object needs them, not a slot in the small GTT aperture.
+ */
+static int psb_gem_get_pages_locked(struct psb_gem_object *pobj)
+{
+	struct drm_gem_object *obj = &pobj->base;
+	struct page **pages;
+
+	dma_resv_assert_held(obj->resv);
+
+	if (pobj->pages_use++)
+		return 0;
+	pages = drm_gem_get_pages(obj);
+	if (IS_ERR(pages)) {
+		pobj->pages_use--;
+		return PTR_ERR(pages);
+	}
+	set_pages_array_wc(pages, obj->size / PAGE_SIZE);
+	pobj->pages = pages;
+	return 0;
+}
+
+static void psb_gem_put_pages_locked(struct psb_gem_object *pobj)
+{
+	struct drm_gem_object *obj = &pobj->base;
+
+	dma_resv_assert_held(obj->resv);
+
+	if (WARN_ON(!pobj->pages_use) || --pobj->pages_use)
+		return;
+	/* Reset caching flags */
+	set_pages_array_wb(pobj->pages, obj->size / PAGE_SIZE);
+	drm_gem_put_pages(obj, pobj->pages, true, false);
+	pobj->pages = NULL;
+}
+
+static int psb_gem_pin_locked(struct psb_gem_object *pobj)
 {
 	struct drm_gem_object *obj = &pobj->base;
 	struct drm_device *dev = obj->dev;
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
 	u32 gpu_base = dev_priv->gtt.gatt_start;
-	struct page **pages;
 	unsigned int npages;
 	int ret;
 
-	ret = dma_resv_lock(obj->resv, NULL);
-	if (drm_WARN_ONCE(dev, ret, "dma_resv_lock() failed, ret=%d\n", ret))
-		return ret;
+	dma_resv_assert_held(obj->resv);
 
 	if (pobj->in_gart || pobj->stolen)
 		goto out; /* already mapped */
 
-	pages = drm_gem_get_pages(obj);
-	if (IS_ERR(pages)) {
-		ret = PTR_ERR(pages);
-		goto err_dma_resv_unlock;
-	}
+	ret = psb_gem_get_pages_locked(pobj);
+	if (ret)
+		return ret;
 
 	npages = obj->size / PAGE_SIZE;
 
-	set_pages_array_wc(pages, npages);
-
-	psb_gtt_insert_pages(dev_priv, &pobj->resource, pages);
+	psb_gtt_insert_pages(dev_priv, &pobj->resource, pobj->pages);
 	if (dev_priv->mmu)
-		psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu), pages,
+		psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu), pobj->pages,
 				     (gpu_base + pobj->offset), npages, 0, 0,
 				     PSB_MMU_CACHED_MEMORY);
 
-	pobj->pages = pages;
-
 out:
 	++pobj->in_gart;
-	dma_resv_unlock(obj->resv);
-
 	return 0;
+}
+
+int psb_gem_pin(struct psb_gem_object *pobj)
+{
+	struct drm_gem_object *obj = &pobj->base;
+	int ret;
 
-err_dma_resv_unlock:
+	ret = dma_resv_lock(obj->resv, NULL);
+	if (drm_WARN_ONCE(obj->dev, ret, "dma_resv_lock() failed, ret=%d\n", ret))
+		return ret;
+	ret = psb_gem_pin_locked(pobj);
 	dma_resv_unlock(obj->resv);
+
 	return ret;
 }
 
-void psb_gem_unpin(struct psb_gem_object *pobj)
+static void psb_gem_unpin_locked(struct psb_gem_object *pobj)
 {
 	struct drm_gem_object *obj = &pobj->base;
 	struct drm_device *dev = obj->dev;
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
 	u32 gpu_base = dev_priv->gtt.gatt_start;
 	unsigned long npages;
-	int ret;
 
-	ret = dma_resv_lock(obj->resv, NULL);
-	if (drm_WARN_ONCE(dev, ret, "dma_resv_lock() failed, ret=%d\n", ret))
-		return;
+	dma_resv_assert_held(obj->resv);
 
 	WARN_ON(!pobj->in_gart);
 
 	--pobj->in_gart;
 
 	if (pobj->in_gart || pobj->stolen)
-		goto out;
+		return;
 
 	npages = obj->size / PAGE_SIZE;
 
@@ -99,13 +135,18 @@ void psb_gem_unpin(struct psb_gem_object *pobj)
 				     (gpu_base + pobj->offset), npages, 0, 0);
 	psb_gtt_remove_pages(dev_priv, &pobj->resource);
 
-	/* Reset caching flags */
-	set_pages_array_wb(pobj->pages, npages);
+	psb_gem_put_pages_locked(pobj);
+}
 
-	drm_gem_put_pages(obj, pobj->pages, true, false);
-	pobj->pages = NULL;
+void psb_gem_unpin(struct psb_gem_object *pobj)
+{
+	struct drm_gem_object *obj = &pobj->base;
+	int ret;
 
-out:
+	ret = dma_resv_lock(obj->resv, NULL);
+	if (drm_WARN_ONCE(obj->dev, ret, "dma_resv_lock() failed, ret=%d\n", ret))
+		return;
+	psb_gem_unpin_locked(pobj);
 	dma_resv_unlock(obj->resv);
 }
 
@@ -133,8 +174,89 @@ static const struct vm_operations_struct psb_gem_vm_ops = {
 	.close = drm_gem_vm_close,
 };
 
+/*
+ * PRIME export, for a render GPU to draw into scanout buffers. Only objects
+ * with pages can be shared: stolen memory has none. An export pins the pages,
+ * write-combined, and doesn't insert them into the GTT. The PRIME helpers
+ * call pin and unpin with the reservation lock held.
+ */
+static int psb_gem_prime_pin(struct drm_gem_object *obj)
+{
+	struct psb_gem_object *pobj = to_psb_gem_object(obj);
+
+	if (pobj->stolen)
+		return -EINVAL;
+	return psb_gem_get_pages_locked(pobj);
+}
+
+static void psb_gem_prime_unpin(struct drm_gem_object *obj)
+{
+	psb_gem_put_pages_locked(to_psb_gem_object(obj));
+}
+
+static struct sg_table *psb_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	struct psb_gem_object *pobj = to_psb_gem_object(obj);
+
+	if (!pobj->pages)
+		return ERR_PTR(-EINVAL);
+	return drm_prime_pages_to_sg(obj->dev, pobj->pages, obj->size >> PAGE_SHIFT);
+}
+
+/*
+ * A kernel mapping for an importer, write-combined like the pages. It holds
+ * the pages as a PRIME pin does. The PRIME helpers call it with the
+ * reservation lock held.
+ */
+static int psb_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
+{
+	struct psb_gem_object *pobj = to_psb_gem_object(obj);
+	void *vaddr;
+	int ret;
+
+	if (pobj->stolen)
+		return -EINVAL;
+	ret = psb_gem_get_pages_locked(pobj);
+	if (ret)
+		return ret;
+	vaddr = vmap(pobj->pages, obj->size >> PAGE_SHIFT, VM_MAP,
+		     pgprot_writecombine(PAGE_KERNEL));
+	if (!vaddr) {
+		psb_gem_put_pages_locked(pobj);
+		return -ENOMEM;
+	}
+	iosys_map_set_vaddr(map, vaddr);
+	return 0;
+}
+
+static void psb_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
+{
+	vunmap(map->vaddr);
+	psb_gem_put_pages_locked(to_psb_gem_object(obj));
+}
+
+/*
+ * dma_buf_mmap() maps through the object's fake offset (drm_gem_prime_mmap()),
+ * which a dumb buffer only gets from MAP_DUMB: make sure it has one.
+ */
+static struct dma_buf *psb_gem_prime_export(struct drm_gem_object *obj, int flags)
+{
+	int ret;
+
+	ret = drm_gem_create_mmap_offset(obj);
+	if (ret)
+		return ERR_PTR(ret);
+	return drm_gem_prime_export(obj, flags);
+}
+
 static const struct drm_gem_object_funcs psb_gem_object_funcs = {
 	.free = psb_gem_free_object,
+	.export = psb_gem_prime_export,
+	.pin = psb_gem_prime_pin,
+	.unpin = psb_gem_prime_unpin,
+	.get_sg_table = psb_gem_prime_get_sg_table,
+	.vmap = psb_gem_prime_vmap,
+	.vunmap = psb_gem_prime_vunmap,
 	.vm_ops = &psb_gem_vm_ops,
 };
 
diff --git a/drivers/gpu/drm/gma500/gem.h b/drivers/gpu/drm/gma500/gem.h
index 27df6ff4e..539f8f20a 100644
--- a/drivers/gpu/drm/gma500/gem.h
+++ b/drivers/gpu/drm/gma500/gem.h
@@ -27,6 +27,7 @@ struct psb_gem_object {
 	bool stolen;			/* Backed from stolen RAM */
 	bool mmapping;			/* Is mmappable */
 	struct page **pages;		/* Backing pages if present */
+	unsigned int pages_use;		/* GART pins and PRIME pins of @pages */
 };
 
 static inline struct psb_gem_object *to_psb_gem_object(struct drm_gem_object *obj)

-- 
2.50.1

