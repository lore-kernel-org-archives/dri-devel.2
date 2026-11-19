Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC3606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=C7Radi5h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E8210F0F8;
	Thu, 19 Nov 2026 19:40:23 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C58D10E861
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=RYRHezxiFiN6SonzsgbEp1/rfDoYB4umsJfwajcek78=; t=1795117214; x=2110477214; 
 b=C7Radi5hwBhXe0kEuMr8gZm0kz+qXrkJByouPT+u6YH32X+BX73AOfhdag3udB+qDbYWP69YvbF
 nsEbovUj15+qcjU8WRsXLzII7bBJiRe4I6MygqGQWGjECcbisqpYw+8EG6hhCT7rp6aMJMjNucQ3q
 56O7eUwITJcYdau/GJlkn65MR4CHJsvOEGC5eT//e/hkLbTA0sMHkWJKeJjKQZCE2+KxGnvR1ZJ73
 oLxkXu2g2ZnLSkxRcNstQw9H0ezYnxwVnramV2IyxSudKul79gBN2Y153Jxjv6l6u91um5B+ncz4j
 kT2j/DaXQL0rGQfvV75O8WRs6s7+MbNjlvrw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xU7zQ-00000001bU7-14Dl; Thu, 19 Nov 2026 20:40:12 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 19 Nov 2026 16:38:21 -0300
Subject: [PATCH 6/6] drm/panthor: Drop custom dma_buf_ops
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-pan-drop-dma-buf-hooks-v1-6-6c6f1629e7f9@igalia.com>
References: <20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com>
In-Reply-To: <20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Karunika Choo <karunika.choo@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6134; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=K8OFJTaV9HehQGeZFewc0EAKtvObfCJqG8TsdAA8c0A=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/1BvT/wDi7u6uzJo1EGE+qNCvSlowYHzyag9p
 MEbfgM7xpKJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav9QbwAKCRA/8w6Kdoj6
 qlIhB/9kiBXn38mFpXXBa6+IVRFrCKLI0yfYniyB+jWuiESMmhmXxV5wWOlNp3sXaVBQUT4pOdD
 EU56zw17b3+fFHdIWdCCJ+MmKmqrFrhKXYAJxWTBCEB3ROAJMRBPj5zamgjAyEHcn8bri32LESj
 g/vPPF3NOalHdAZfTALS1gxcBGEIO566+dqt0Yc5hVEgN1sBejm68DXUTLVyjCpwyUDlKxfXBc2
 J4jdQd4hoL6NGUqziRaIgJ/dUfT0etCnrjnW9tAHMXxdLrJndbIHFBXwk+CSmLTr0JT+8wrJOkP
 pPCpE+Ffcx6lxcMBE399iaP8avT+Reoxkk+0rJt5kfqBDce0
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The custom dma_buf_ops were added to provide CPU cache maintenance in
begin/end_cpu_access() for WB_MMAP BOs. As those can no longer be
exported, use the default PRIME ops.

On IO-coherent GPUs, all BOs are CPU-mapped WB, so exported BOs lose
begin/end_cpu_access() cache maintenance for non-coherent importers.
This restores the behavior prior to commit 925ad0c26dd8 ("drm/panthor:
Provide a custom dma_buf implementation").

Suggested-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c |   1 -
 drivers/gpu/drm/panthor/panthor_gem.c | 118 +---------------------------------
 drivers/gpu/drm/panthor/panthor_gem.h |   4 --
 3 files changed, 1 insertion(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..8712587b37d6 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1801,7 +1801,6 @@ static const struct drm_driver panthor_drm_driver = {
 	.minor = 9,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
-	.gem_prime_import = panthor_gem_prime_import,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = panthor_debugfs_init,
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 730567d97f46..af8c94031d14 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -471,108 +471,9 @@ static void panthor_gem_free_object(struct drm_gem_object *obj)
 	drm_gem_object_put(vm_root_gem);
 }
 
-static struct sg_table *
-panthor_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
-			      enum dma_data_direction dir)
-{
-	struct sg_table *sgt = drm_gem_map_dma_buf(attach, dir);
-
-	if (!IS_ERR(sgt))
-		attach->priv = sgt;
-
-	return sgt;
-}
-
-static void
-panthor_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
-				struct sg_table *sgt,
-				enum dma_data_direction dir)
-{
-	attach->priv = NULL;
-	drm_gem_unmap_dma_buf(attach, sgt, dir);
-}
-
-static int
-panthor_gem_prime_begin_cpu_access(struct dma_buf *dma_buf,
-				   enum dma_data_direction dir)
-{
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct drm_device *dev = obj->dev;
-	struct panthor_gem_object *bo = to_panthor_bo(obj);
-	struct dma_buf_attachment *attach;
-
-	dma_resv_lock(obj->resv, NULL);
-	if (bo->dmap.sgt)
-		dma_sync_sgtable_for_cpu(drm_dev_dma_dev(dev), bo->dmap.sgt, dir);
-
-	if (bo->cmap.vaddr)
-		invalidate_kernel_vmap_range(bo->cmap.vaddr, bo->base.size);
-
-	list_for_each_entry(attach, &dma_buf->attachments, node) {
-		struct sg_table *sgt = attach->priv;
-
-		if (sgt)
-			dma_sync_sgtable_for_cpu(attach->dev, sgt, dir);
-	}
-	dma_resv_unlock(obj->resv);
-
-	return 0;
-}
-
-static int
-panthor_gem_prime_end_cpu_access(struct dma_buf *dma_buf,
-				 enum dma_data_direction dir)
-{
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct drm_device *dev = obj->dev;
-	struct panthor_gem_object *bo = to_panthor_bo(obj);
-	struct dma_buf_attachment *attach;
-
-	dma_resv_lock(obj->resv, NULL);
-	list_for_each_entry(attach, &dma_buf->attachments, node) {
-		struct sg_table *sgt = attach->priv;
-
-		if (sgt)
-			dma_sync_sgtable_for_device(attach->dev, sgt, dir);
-	}
-
-	if (bo->cmap.vaddr)
-		flush_kernel_vmap_range(bo->cmap.vaddr, bo->base.size);
-
-	if (bo->dmap.sgt)
-		dma_sync_sgtable_for_device(drm_dev_dma_dev(dev), bo->dmap.sgt, dir);
-
-	dma_resv_unlock(obj->resv);
-	return 0;
-}
-
-static const struct dma_buf_ops panthor_dma_buf_ops = {
-	.attach = drm_gem_map_attach,
-	.detach = drm_gem_map_detach,
-	.map_dma_buf = panthor_gem_prime_map_dma_buf,
-	.unmap_dma_buf = panthor_gem_prime_unmap_dma_buf,
-	.release = drm_gem_dmabuf_release,
-	.mmap = drm_gem_dmabuf_mmap,
-	.vmap = drm_gem_dmabuf_vmap,
-	.vunmap = drm_gem_dmabuf_vunmap,
-	.begin_cpu_access = panthor_gem_prime_begin_cpu_access,
-	.end_cpu_access = panthor_gem_prime_end_cpu_access,
-};
-
 static struct dma_buf *
 panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
 {
-	struct drm_device *dev = obj->dev;
-	struct dma_buf_export_info exp_info = {
-		.exp_name = KBUILD_MODNAME,
-		.owner = THIS_MODULE,
-		.ops = &panthor_dma_buf_ops,
-		.size = obj->size,
-		.flags = flags,
-		.priv = obj,
-		.resv = obj->resv,
-	};
-
 	/* We can't export GEMs that have an exclusive VM. */
 	if (to_panthor_bo(obj)->exclusive_vm_root_gem)
 		return ERR_PTR(-EINVAL);
@@ -581,24 +482,7 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
 	if (to_panthor_bo(obj)->flags & DRM_PANTHOR_BO_WB_MMAP)
 		return ERR_PTR(-EINVAL);
 
-	return drm_gem_dmabuf_export(dev, &exp_info);
-}
-
-struct drm_gem_object *
-panthor_gem_prime_import(struct drm_device *dev,
-			 struct dma_buf *dma_buf)
-{
-	struct drm_gem_object *obj = dma_buf->priv;
-
-	if (dma_buf->ops == &panthor_dma_buf_ops && obj->dev == dev) {
-		/* Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		drm_gem_object_get(obj);
-		return obj;
-	}
-
-	return drm_gem_prime_import(dev, dma_buf);
+	return drm_gem_prime_export(obj, flags);
 }
 
 static void panthor_gem_print_info(struct drm_printer *p, unsigned int indent,
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 5ae37d0d3646..444ef9f66adf 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -274,10 +274,6 @@ void panthor_gem_kernel_bo_set_label(struct panthor_kernel_bo *bo, const char *l
 int panthor_gem_sync(struct drm_gem_object *obj,
 		     u32 type, u64 offset, u64 size);
 
-struct drm_gem_object *
-panthor_gem_prime_import(struct drm_device *dev,
-			 struct dma_buf *dma_buf);
-
 static inline u64
 panthor_kernel_bo_gpuva(struct panthor_kernel_bo *bo)
 {

-- 
2.56.0

