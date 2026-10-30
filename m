Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB9606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ckGZiZDQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CA01129BE;
	Fri, 30 Oct 2026 20:52:11 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC3D1129BE
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=heDqTQyloH0LJRpkTlEVFiJgR44mi63KWGSfTxBzrr4=; b=ckGZiZDQfyrEg3WBsdVhuF3Kc1
 Gkqw/XbeKj28eYHSLZD6ZiAH6Hz/d5xXNXceS/oQSWqyuTb0kF0Suv+pJOQPafOlnsJqU3FIugQ5V
 8nHVjI6noQSyBE2tTv2yeVFa6d3b6LucFa5WpmGc0WdbB5ZirbqWmcpbBiS2/6cC5NEiBXcmEfODH
 zKYq/AyHQZfPu1alQO2QIm16BuW/8qt4W2fAuzw6dlBusr+7bx7+8ZgCEsx6pvaTXJjgv0KWa/XU7
 U+ra0i6e2pL/G1nwpSLFI3K/odNTdzr5pjCrwGVGa8FGkimTizP64lrpHzR5AVZLm3+eCcejXjt0r
 rdKBXEfg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZf-00FLiF-ON; Fri, 30 Oct 2026 21:51:43 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:23 -0300
Subject: [PATCH RFC 05/12] drm/panfrost: Use common shmem helpers for
 dma_buf CPU access
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-5-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3414; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=MBFHiqskM1xM+VPf4TiMCcwn3yatLtP7HXZNtn3Aru0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QND52XpnMCXsQ3TFVrP7zY7VBlbYr1iKsg2z
 x0M073tSMCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qj9SCADF4eyyXtx2g5guLQbfvqWKQO0LYbX0o913w17wARew5aOCYvLeIEEPo5fftuE2gbynLSc
 VAqstztAiL4dXlymRWU+AoLnwzlq6fhIM/6qwSJJHPjpWdILkbBcIbFnLkHwDrNM66nfsJdmIOV
 k+yF5fBqj9iaOnRR6mOtIKZzJqLI7ouLfzom2O+EywU68pdHGfE+rnTtHcuUuV72Z5QIJI0VDMs
 TKrgEbVFypRi/YeQ+d027xa5f1dyY5f4wBE9FNsv+wXOzwK/Ikw1/785ySHqI9xsYanpXdgwEKH
 aJtYC0RoYqs+wJa1jG8tzdS/6VD3fmGtWKvyMF1gB4aXjWRw
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

Panfrost's dma_buf map/unmap and CPU access hooks are identical to the
generic shmem implementation. Use the common shmem helpers instead.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 83 ++-------------------------------
 1 file changed, 4 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 207110f33700..5f099c478edd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -289,92 +289,17 @@ static size_t panfrost_gem_rss(struct drm_gem_object *obj)
 	return 0;
 }
 
-static struct sg_table *
-panfrost_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
-			       enum dma_data_direction dir)
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
-panfrost_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
-				 struct sg_table *sgt,
-				 enum dma_data_direction dir)
-{
-	attach->priv = NULL;
-	drm_gem_unmap_dma_buf(attach, sgt, dir);
-}
-
-static int
-panfrost_gem_prime_begin_cpu_access(struct dma_buf *dma_buf,
-				    enum dma_data_direction dir)
-{
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct drm_device *dev = obj->dev;
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
-	struct dma_buf_attachment *attach;
-
-	dma_resv_lock(obj->resv, NULL);
-	if (shmem->sgt)
-		dma_sync_sgtable_for_cpu(dev->dev, shmem->sgt, dir);
-
-	if (shmem->vaddr)
-		invalidate_kernel_vmap_range(shmem->vaddr, shmem->base.size);
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
-panfrost_gem_prime_end_cpu_access(struct dma_buf *dma_buf,
-				  enum dma_data_direction dir)
-{
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct drm_device *dev = obj->dev;
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
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
-	if (shmem->vaddr)
-		flush_kernel_vmap_range(shmem->vaddr, shmem->base.size);
-
-	if (shmem->sgt)
-		dma_sync_sgtable_for_device(dev->dev, shmem->sgt, dir);
-
-	dma_resv_unlock(obj->resv);
-	return 0;
-}
-
 static const struct dma_buf_ops panfrost_dma_buf_ops = {
 	.attach = drm_gem_map_attach,
 	.detach = drm_gem_map_detach,
-	.map_dma_buf = panfrost_gem_prime_map_dma_buf,
-	.unmap_dma_buf = panfrost_gem_prime_unmap_dma_buf,
+	.map_dma_buf = drm_gem_shmem_prime_map_dma_buf,
+	.unmap_dma_buf = drm_gem_shmem_prime_unmap_dma_buf,
 	.release = drm_gem_dmabuf_release,
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
 	.vunmap = drm_gem_dmabuf_vunmap,
-	.begin_cpu_access = panfrost_gem_prime_begin_cpu_access,
-	.end_cpu_access = panfrost_gem_prime_end_cpu_access,
+	.begin_cpu_access = drm_gem_shmem_prime_begin_cpu_access,
+	.end_cpu_access = drm_gem_shmem_prime_end_cpu_access,
 };
 
 static struct dma_buf *

-- 
2.56.0

