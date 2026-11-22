Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C607606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=IICAapmQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645E710EAD0;
	Sun, 22 Nov 2026 22:15:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C461910E6C1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 22:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=NrK9/r4SJF3jAwZM8JqYqYC1DRFMvOtMUQh9jZZynaM=; t=1795385714; x=2110745714; 
 b=IICAapmQM5722m7Ny/FUgI22ocFJ7aSW6UCmj6zMSpPVPk7WNPmCs51Go+wrH1ijGssV1gbwb1+
 e81+ioQEJ/WVGEBWV2aCChrFjXiZkVb9pVmHvteCil/1r7Z6/dE7IyrNLrggW8AsIre2DwuMncYnX
 JNbEeZ9agXzhRert6SwMcIbavJ6UPkYKeSXgTeNeDmze+vJUbhl8YnGKNdQTBZ1Wa186p2DMJ8TXW
 R9aoKdGLogEQAr0MFZLYMcnjdErv3hFvhQMYhXAtMcgkXLRyfPkIQJoAcMaH/ZGhEH6zKSrC906AX
 2lbdQv7/uDOSX7SKirTmgC/LOdQ1W4M+lgfQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVFq4-00000002j1Q-3s6a; Sun, 22 Nov 2026 23:15:13 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 22 Nov 2026 19:14:50 -0300
Subject: [PATCH v2 2/4] drm/panfrost: Use drm_gem_shmem_sync()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-pan-drop-dma-buf-hooks-v2-2-2ed42dce9db6@igalia.com>
References: <20261122-pan-drop-dma-buf-hooks-v2-0-2ed42dce9db6@igalia.com>
In-Reply-To: <20261122-pan-drop-dma-buf-hooks-v2-0-2ed42dce9db6@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ry5WZonfag3R2iYp6kbiStBXwZxqNwSRvxUM5zYxctA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBrA2leWB2k31mdfCb7Rqs6hOZ6szq/sXqkQQzXv
 PXz/+4kPkyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCawNpXgAKCRA/8w6Kdoj6
 qqB6B/9gzdu8RXkVh34Hxhc/mlUDuoApgnZGKgUUiDMpJh+xnGWirSpak/cWfYRa+UD1qcT1a/9
 vZX200KIQDnrhzPN7JaFbzFH73sH8ViKBgRunirq3UuoDyPDWWEyZ84usB1AtPWuU48TKDAOBvy
 7sdj/Y+AfK5nJWmcuOimIuKM1sgLWZRA7ndvJw8vbRC6CHjQwnoHh3qt9SwB1NMFDkPifh7+suy
 OXOPlN4J7/Y0j0/0H7i6wDBaH2L8LbK7brDJBo3yhU/HqEg++dw7pBmDENZRe5JwN7DFJXyM27h
 NZp9mEhH236PXoxfBTLAAWZBHLLP1GwFZpHniYK0oO0dbqxz
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

panfrost_gem_sync() walks the shmem sgt without holding the resv lock,
so the shrinker can purge a BO and free the sgt during the walk. It also
repopulates purged BOs, allocating memory the shrinker can no longer
reclaim.

The common helper drm_gem_shmem_sync() has the same functionality as
panfrost_gem_sync(), but it also handles the mentioned cases. Translate
the Panfrost UAPI sync type to the common shmem type and use the helper
instead.

Fixes: 7be45f548976 ("drm/panfrost: Add a PANFROST_SYNC_BO ioctl")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 74 +++------------------------------
 1 file changed, 5 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 518f24549b9d..8c0facd498d7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -555,84 +555,20 @@ int
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

