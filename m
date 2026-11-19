Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11D606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=fe0omJRe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C7A1126EB;
	Thu, 19 Nov 2026 19:39:52 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1321B10F0E2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=ixa+ENI6eAGW02eHz27q61QbODiFBBbeXHlcNb/p1n8=; t=1795117181; x=2110477181; 
 b=fe0omJRehlk6L1LIkZK7VPMX6MhN3hF41mQutAm2E7D43ifnjkbt9M5/jyNQRyE5o9qHk5zG26I
 qoOXRprTb3iE5caC5F28q+Mllm24nKfAyfCRi/rY2276DW8Z6KtzKVfuERZeRy3sTArRuy91/R1B+
 wDGf3SeUJFjo0wGYzfPUuXbIaC0ZcIyvj0++GHbKXpQF7SUK5PZ0o3rn9d6M2emWKHsdvNbnDaIsm
 87m50qEer9/oaPvd2Cn30/2+Q6wSdATgLM5kBQLift/D/sSDpeXLarCmIpTmtQfF+rxDgWlo60W8e
 Q/ZbPIujm+x/CnKL/w3ZVy0Lp0Q/+Obhu5ag==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xU7yu-00000001bU7-0o9b; Thu, 19 Nov 2026 20:39:40 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 19 Nov 2026 16:38:16 -0300
Subject: [PATCH 1/6] drm/shmem: Add a drm_gem_shmem_sync() helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-pan-drop-dma-buf-hooks-v1-1-6c6f1629e7f9@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4927; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=XYXvbIMVlRl9OO7Lt7svHGYxZCClm2wNi5jv7y6SbKk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/1BuizGcJPFyqIKskCq5AuZAa+zRB6M/yBCNO
 dNyvjuB1DqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav9QbgAKCRA/8w6Kdoj6
 qjuwCAC8sFlGNLARHZRY9soNUKWpP75h158QVkT5W2DPnFSrdxdI5z0y8ow3f6xVoU/+v/PSRQZ
 dSi57MNo66izt1fKaYZODi2ynDWdiOIQDAAxUJmjY8cp6Q7+06NHFlVPk9upsmMa0TmI2faFmlb
 FnfHjOGJliuJwGXHQmI2x5Hb7vcmhiCUK0MFHZZCR2jG54gPkRG/1Y6WxHhhFq/suTOtaPOAxD8
 Fez40T40affYvXKtlaPGZlcn7fkLUgh6EBcvqPtRITNbhjaZ8BRDZfp6RQjCm0ErKNLltYMX8ay
 jNxsonREpLrmm0ZHBhPifFEWeBvTRugmWrF3CmOOrSShBoi7
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
index d654a22a30de..72933ed28373 100644
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
index bcbb92f3fe9b..a5def70fae7a 100644
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

