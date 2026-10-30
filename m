Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VkPBLO3h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B541129CA;
	Fri, 30 Oct 2026 20:52:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636541129CA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=03G3x+uvAwP6+7mtotLf5DP/A6uExP9wIHtxQlf5KmU=; b=VkPBLO3hhNLhsQfjHCo+7+M208
 Sx+Hcq/OoikM46CPnIYVFWYTGpTw9eEwAjoDCp9Im9quLvh4BfhTtdNv3xXjodJrbBC5rNCkPa4ef
 Nb4S7imDZW8dPZ3uWob+ylJnL7YKmAsVIpeQ5xmm5yVfkq42c9Po75A+hMWyJtp18AeivrnZh6vVt
 UTsPKo3JoUM5dbPO0LU50+Nt1X811mDz+f8azTuTMIcg94P501g7PXvam3PBbdOPyNx6UX6qrfQlo
 IOmv5sLRNSGUXbk7zCGEGyHYjq+fe09m+cW2wgI6LaJocnAB9Yu1Cieah9+STt0U7hxf9+nP7Wjma
 TF8RX7kQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMta2-00FLiF-FM; Fri, 30 Oct 2026 21:52:06 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:28 -0300
Subject: [PATCH RFC 10/12] drm/v3d: Add flag to map BOs write-back
 cacheable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-10-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=nptzUJcHzyUw3XUcFetUIOlLfPXaOqorCsudaP+6Tys=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNDV5o4S3OMWOnOmQoZJ/nua058GzlDD3hIp
 /OCW7SUb1uJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qnbHCADEjSyUiwF+pKsvljEjLCfyxvsTMo4wPBjrWH/DUwPitBiMhpqGSpbPA/xuMRAlr5Tn9MJ
 d+R5S8hOwc8ldSAfb6rEic8H7V16RQJUqKZvJyoVAUJomSMvNOp1ba8yjzWMd0vToAdO5/rHOe1
 HXFIMUcw9kTmQZ62IEIiQYtS4u3AJ2GDH2mUqWHoO0yeKAMjqWOwrPwlmQinsxcPkC/kNy/H40l
 8ZHGsd4IRCYO0Kddgs1xLoU3gP36TFje3BCB7hSCSdJDte3DOJMXFMw3QsdxomF9PZNhCGjoVx6
 +viHr8XEyuUUptr9BfOSjUPu/kyeQPFbwjJfXaQaVfN0yy0e
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

All V3D BOs are mapped write-combined, which makes CPU reads slow.
Buffers frequently read by the CPU, or with access patterns that make
non-cacheable mappings inefficient, can benefit from cached mappings.

Add DRM_V3D_BO_WB_MMAP to let userspace request a cached mapping. As
V3D is not I/O coherent, userspace becomes responsible for CPU cache
maintenance around the job execution. Note that this also includes CPU
jobs, as the kernel accesses the BOs through write-combined mappings.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c  | 11 ++++++-----
 drivers/gpu/drm/v3d/v3d_drv.h |  3 +--
 drivers/gpu/drm/v3d/v3d_irq.c |  2 +-
 include/uapi/drm/v3d_drm.h    |  9 +++++++--
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 803f3bbb7144..0a5a056d4b26 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -173,18 +173,19 @@ v3d_bo_create_finish(struct drm_gem_object *obj)
 	return 0;
 }
 
-struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
-			     size_t unaligned_size)
+struct v3d_bo *v3d_bo_create(struct drm_device *dev, size_t size, u32 flags)
 {
 	struct drm_gem_shmem_object *shmem_obj;
 	struct v3d_bo *bo;
 	int ret;
 
-	shmem_obj = drm_gem_shmem_create(dev, unaligned_size);
+	shmem_obj = drm_gem_shmem_create(dev, size);
 	if (IS_ERR(shmem_obj))
 		return ERR_CAST(shmem_obj);
+
 	bo = to_v3d_bo(&shmem_obj->base);
 	bo->vaddr = NULL;
+	bo->base.map_wc = !(flags & DRM_V3D_BO_WB_MMAP);
 
 	ret = v3d_bo_create_finish(&shmem_obj->base);
 	if (ret)
@@ -239,12 +240,12 @@ int v3d_create_bo_ioctl(struct drm_device *dev, void *data,
 	struct v3d_bo *bo = NULL;
 	int ret;
 
-	if (args->flags != 0) {
+	if (args->flags & ~DRM_V3D_BO_WB_MMAP) {
 		drm_dbg(dev, "unknown create_bo flags: %d\n", args->flags);
 		return -EINVAL;
 	}
 
-	bo = v3d_bo_create(dev, file_priv, PAGE_ALIGN(args->size));
+	bo = v3d_bo_create(dev, PAGE_ALIGN(args->size), args->flags);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index e0eed4cfef61..4f32fc3ab1de 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -591,8 +591,7 @@ struct v3d_submit_ext {
 /* v3d_bo.c */
 struct drm_gem_object *v3d_create_object(struct drm_device *dev, size_t size);
 void v3d_free_object(struct drm_gem_object *gem_obj);
-struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
-			     size_t size);
+struct v3d_bo *v3d_bo_create(struct drm_device *dev, size_t size, u32 flags);
 void v3d_get_bo_vaddr(struct v3d_bo *bo);
 void v3d_put_bo_vaddr(struct v3d_bo *bo);
 int v3d_create_bo_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 963d711dc16b..19315acf567a 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -43,7 +43,7 @@ v3d_overflow_mem_work(struct work_struct *work)
 	struct v3d_dev *v3d =
 		container_of(work, struct v3d_dev, overflow_mem_work);
 	struct drm_device *dev = &v3d->drm;
-	struct v3d_bo *bo = v3d_bo_create(dev, NULL /* XXX: GMP */, 256 * 1024);
+	struct v3d_bo *bo = v3d_bo_create(dev, SZ_256K, 0);
 	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
 	struct v3d_bin_job *bin_job;
 	struct drm_gem_object *obj;
diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 2750a6fbb6b8..4221c7544d08 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -237,11 +237,16 @@ struct drm_v3d_wait_bo {
 	__u64 timeout_ns;
 };
 
+/*
+ * Map the BO CPU-cached instead of write-combined. Userspace is responsible
+ * for CPU cache maintenance.
+ */
+#define DRM_V3D_BO_WB_MMAP			  0x01
+
 /**
  * struct drm_v3d_create_bo - ioctl argument for creating V3D BOs.
  *
- * There are currently no values for the flags argument, but it may be
- * used in a future extension.
+ * @flags is a mask of DRM_V3D_BO_* flags.
  */
 struct drm_v3d_create_bo {
 	__u32 size;

-- 
2.56.0

