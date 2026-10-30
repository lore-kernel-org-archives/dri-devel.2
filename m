Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Ho6Vc+zV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C161129CD;
	Fri, 30 Oct 2026 20:52:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C611129CF
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=kzVYhov018Dkn9JJGN04rW5ota4Aq6kf6VdyOVRnGpI=; b=Ho6Vc+zVK9WFEhjg/AFdiWhFo/
 P4Z7n3Mnn+DzL3LQMpTFoUT+IdLsaSxsJ380wFS32YGZDF0N3qn5YHshVkV7mzSMpeWxrGm3JvezR
 prR5jA1JMuzn4g72RMYCO1R/IYjD4vT19LUzEwVWZEdqx2X3P09JCudJBxFPjDHhrrHrM5qhwOe68
 Rju8tJNFZrXntzTEt4W1K+4y7+E3YwxqMU4sp1b8PPQf7YZbpIg2Lg1TbJSMK/nC8pGIsi/eW+7GV
 OUY3sH4nSTL0IM7mcRtOOW+D3z6JlLX/yaAnwzdcQ588VeSM0pO6zeTLMzxO6nGNzDbFwQ/puY2VS
 3z/Qukzw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZk-00FLiF-MY; Fri, 30 Oct 2026 21:51:48 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:24 -0300
Subject: [PATCH RFC 06/12] drm/panfrost: Use drm_gem_shmem_sync()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-6-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=3sDg9hmzoExwNacSApE1iM/VURclXJBahINrmFukq38=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNDJY1p/SnTNA11kSSUuBFULFoxknEhZXeDF
 M89caiu58+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qrAeCACzT/BGa8iaIYOMXufdbsoF9S6b5Koz7xcjs8x9Ic9rB0kqnb3E5XJXmdsnN1R9qi1iI6a
 r8c/GPUoegeMoBq7g8iL2WQaLTR1qOML/XKJcAieh9OFcVyDHY8ZdCMsVN01U+V9y8jqXkpCjt4
 v3jRQ7LQ+UcBHN9WTKn4RxQltiVddQA0OiwWZwfiiDgywp10sW28Ke/fd+451VI8ErCvaVvR4/a
 c21NI4CljxSHinle6ESyJeFGte3wQBG6Am2Ok3jihf8h+u1xyZZqZKVWGeUqvNLjHnCn/Zo7qzd
 9mTnaZpu5xqc4elphfnQyI9TF7UunG8vTf84kjEA7EByDeQ2
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

panfrost_gem_sync() has the same code as the function drm_gem_shmem_sync().
Translate the UAPI sync type to the common shmem type and use the shmem
helper instead.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 74 +++------------------------------
 1 file changed, 5 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 5f099c478edd..80a4a1771ce7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -460,84 +460,20 @@ int
 panfrost_gem_sync(struct drm_gem_object *obj, u32 type, u32 offset, u32 size)
 {
 	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
-	struct drm_gem_shmem_object *shmem = &bo->base;
-	const struct drm_device *dev = shmem->base.dev;
-	struct sg_table *sgt;
-	struct scatterlist *sgl;
-	unsigned int count;
-
-	/* Make sure the range is in bounds. */
-	if (offset + size < offset || offset + size > shmem->base.size)
-		return -EINVAL;
-
-	/* Disallow CPU-cache maintenance on imported buffers. */
-	if (drm_gem_is_imported(&shmem->base))
-		return -EINVAL;
+	enum drm_gem_shmem_sync_type shmem_type;
 
 	switch (type) {
 	case PANFROST_BO_SYNC_CPU_CACHE_FLUSH:
+		shmem_type = DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH;
+		break;
 	case PANFROST_BO_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE:
+		shmem_type = DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE;
 		break;
-
 	default:
 		return -EINVAL;
 	}
 
-	/* Don't bother if it's WC-mapped */
-	if (shmem->map_wc)
-		return 0;
-
-	/* Nothing to do if the size is zero. */
-	if (size == 0)
-		return 0;
-
-	sgt = drm_gem_shmem_get_pages_sgt(shmem);
-	if (IS_ERR(sgt))
-		return PTR_ERR(sgt);
-
-	for_each_sgtable_dma_sg(sgt, sgl, count) {
-		if (size == 0)
-			break;
-
-		dma_addr_t paddr = sg_dma_address(sgl);
-		size_t len = sg_dma_len(sgl);
-
-		if (len <= offset) {
-			offset -= len;
-			continue;
-		}
-
-		paddr += offset;
-		len -= offset;
-		len = min_t(size_t, len, size);
-		size -= len;
-		offset = 0;
-
-		/* It's unclear whether dma_sync_xxx() is the right API to do CPU
-		 * cache maintenance given an IOMMU can register their own
-		 * implementation doing more than just CPU cache flushes/invalidation,
-		 * and what we really care about here is CPU caches only, but that's
-		 * the best we have that is both arch-agnostic and does at least the
-		 * CPU cache maintenance on a <page,offset,size> tuple.
-		 *
-		 * Also, I wish we could do a single
-		 *
-		 *      dma_sync_single_for_device(BIDIR)
-		 *
-		 * and get a flush+invalidate, but that's not how it's implemented
-		 * in practice (at least on arm64), so we have to make it
-		 *
-		 *      dma_sync_single_for_device(TO_DEVICE)
-		 *      dma_sync_single_for_cpu(FROM_DEVICE)
-		 *
-		 * for the flush+invalidate case.
-		 */
-		dma_sync_single_for_device(dev->dev, paddr, len, DMA_TO_DEVICE);
-		if (type == PANFROST_BO_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE)
-			dma_sync_single_for_cpu(dev->dev, paddr, len, DMA_FROM_DEVICE);
-	}
-
-	return 0;
+	return drm_gem_shmem_sync(&bo->base, offset, size, shmem_type);
 }
 
 void

-- 
2.56.0

