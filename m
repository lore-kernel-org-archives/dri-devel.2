Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C3606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=csRSsK8J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6111129C8;
	Fri, 30 Oct 2026 20:52:05 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB9F1129BE
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=YoC3LHJrNBgHbTfYvRMmCEXVSLWcnYqP/83kag65iPQ=; b=csRSsK8JfoQ+t++0VF/xVs+1fe
 RUFx33/cN7/wqe4IwuYK9gH2YAYqhdLHZv9JVs0FArq3slcKUxDaY9vfMIoVHZUVh/c3PBLwdoIY2
 1fLbAAI1hSkZevtYjBBSQ1Qr2xMKsuJRHAofzkLC1I9sdREoe8EZYMmJGsOf0sfMpWjSG3wBwSpsw
 0A/Euzd8JO8ZEBp6UhAbGyYfNcZhx70fLUCNuaz8GDrIj4bTAkKNKIwI8nFh+4Br3SwbWSSdoKKS6
 oRJtTPGLZciETHWR+0r8GAi34NPhXbzl9HEClq+a9Tsahc5WaEykv0p9VM7lKQm6o8VO3dlfhLeIt
 IWXMqAlw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZV-00FLiF-VH; Fri, 30 Oct 2026 21:51:34 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:21 -0300
Subject: [PATCH RFC 03/12] drm/shmem: Add a drm_gem_shmem_sync() helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-3-0a6a6b363382@igalia.com>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
In-Reply-To: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 JaeHoon Lee <dlwognsdc610@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4927; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=sM+xbTTgE3YKaUjTeF79+q3eBowQXaAbKz46J3OYGM0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNDTPH+dFpcw0P63hD/va/vQSBAHwaBq+lkN
 wpvBp7Krh+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qpx1B/4iJ8w3l6BRKEBmD7kF+KobJzID69fkGB1aQa5FO0/u/VlzgBJoeTgYENYOeMfGIII01L/
 4zoXrTpLHoxswxb87AzPARkOC3ao9RuWLLrzRfNWW74paRGaxhERWYq3hstRTFS2O7N4tC3KIg0
 aLA1eU7hP4oIYQ7jiAmFOPL1T9an1RO7YhWetCr0KwpYveAHvqurWf57amXlqtvlXC8C3Skmk6S
 nG8SCoQpRABkG+vjJ9oe368rlw8RAXMu8Cm/j/NoaVr/j61/BKtrBofdMroppfJCV7Lys2QlZwz
 BMV4ulT3qE2B7/3J23IgB/J67lXkXW3TasmGT61Wn1IziswQ
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Faith Ekstrand <faith.ekstrand@collabora.com>

This enables syncing mapped GEM objects between the CPU and GPU via calls
to dma_sync_*().  It's a bit annoying as it requires walking the sg_table
so it's best if every driver doesn't hand-roll it.

Signed-off-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
[mcanal: rebased on top of drm-misc-next and fixed a kernel-doc nit]
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 93 ++++++++++++++++++++++++++++++++++
 include/drm/drm_gem_shmem_helper.h     | 17 +++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 13c4a68fdde0..9bf727fc1c19 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -790,6 +790,99 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_mmap);
 
+/**
+ * drm_gem_shmem_sync - Sync CPU-mapped data
+ * @shmem: shmem GEM object
+ * @offset: Offset into the GEM object
+ * @size: Size of the area to sync
+ * @type: Type of synchronization
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_shmem_sync(struct drm_gem_shmem_object *shmem, size_t offset,
+		       size_t size, enum drm_gem_shmem_sync_type type)
+{
+	const struct drm_device *dev = shmem->base.dev;
+	struct sg_table *sgt;
+	struct scatterlist *sgl;
+	unsigned int count;
+
+	/* Make sure the range is in bounds. */
+	if (offset + size < offset || offset + size > shmem->base.size)
+		return -EINVAL;
+
+	/* Disallow CPU-cache maintenance on imported buffers. */
+	if (drm_gem_is_imported(&shmem->base))
+		return -EINVAL;
+
+	switch (type) {
+	case DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH:
+	case DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Don't bother if it's WC-mapped */
+	if (shmem->map_wc)
+		return 0;
+
+	/* Nothing to do if the size is zero. */
+	if (size == 0)
+		return 0;
+
+	sgt = drm_gem_shmem_get_pages_sgt(shmem);
+	if (IS_ERR(sgt))
+		return PTR_ERR(sgt);
+
+	for_each_sgtable_dma_sg(sgt, sgl, count) {
+		if (size == 0)
+			break;
+
+		dma_addr_t paddr = sg_dma_address(sgl);
+		size_t len = sg_dma_len(sgl);
+
+		if (len <= offset) {
+			offset -= len;
+			continue;
+		}
+
+		paddr += offset;
+		len -= offset;
+		len = min_t(size_t, len, size);
+		size -= len;
+		offset = 0;
+
+		/* It's unclear whether dma_sync_xxx() is the right API to do CPU
+		 * cache maintenance given an IOMMU can register their own
+		 * implementation doing more than just CPU cache flushes/invalidation,
+		 * and what we really care about here is CPU caches only, but that's
+		 * the best we have that is both arch-agnostic and does at least the
+		 * CPU cache maintenance on a <page,offset,size> tuple.
+		 *
+		 * Also, I wish we could do a single
+		 *
+		 *	dma_sync_single_for_device(BIDIR)
+		 *
+		 * and get a flush+invalidate, but that's not how it's implemented
+		 * in practice (at least on arm64), so we have to make it
+		 *
+		 *	dma_sync_single_for_device(TO_DEVICE)
+		 *	dma_sync_single_for_cpu(FROM_DEVICE)
+		 *
+		 * for the flush+invalidate case.
+		 */
+		dma_sync_single_for_device(dev->dev, paddr, len, DMA_TO_DEVICE);
+		if (type == DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE)
+			dma_sync_single_for_cpu(dev->dev, paddr, len, DMA_FROM_DEVICE);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_sync);
+
 /**
  * drm_gem_shmem_print_info() - Print &drm_gem_shmem_object info for debugfs
  * @shmem: shmem GEM object
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 358cd247f803..3c6ed3a5f0ac 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -122,6 +122,23 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 				 struct iosys_map *map);
 int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma);
 
+/**
+ * enum drm_gem_shmem_sync_type - Type of synchronization
+ */
+enum drm_gem_shmem_sync_type {
+	/** @DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH: Flush CPU caches */
+	DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH = 0,
+
+	/**
+	 * @DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE: Flush and
+	 * invalidate CPU caches
+	 */
+	DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE,
+};
+
+int drm_gem_shmem_sync(struct drm_gem_shmem_object *shmem, size_t offset,
+		       size_t size, enum drm_gem_shmem_sync_type type);
+
 int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem);
 

-- 
2.56.0

