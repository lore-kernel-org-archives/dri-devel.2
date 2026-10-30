Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B6606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=e3HGYE64
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBEB10E8D8;
	Fri, 30 Oct 2026 20:52:16 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1AD10E8D8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=5hSYJysLvz0z7Y1pbUi5BhzqoTLlTdu/EAYyLr1gaVU=; b=e3HGYE64Gfyk7iimAEsJAq2BPA
 ZuR5zdzCERGZ0QMGf850cr8NtPw6GyWI05BRJWpiJ1Udl5Qv1YDqmNohCdeIRDRxz1bWTSRXtteZR
 squet0VVjVlM0LPBWjoqAv0jUnE1FHmKKHbSm4MlC2X6fOoJw13pa6CFDIwh2c0vXEWsnaKhI9XXi
 J0D9SxfnWTI3kPHF44osh04XZvb05muxX0H5wBAyqlNFXkhKoLqEaWItV5pR8WBdvZk3dJ/Wh/Ccc
 wfSGW2j8Ahk2VbQba+PFgCY+cTdgDZ5jCnQTapjYEnqdGgQjXlnSjE+meaCwTtGSb3EzR+Nk4Dpyu
 JJb8QHcA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZy-00FLiF-2h; Fri, 30 Oct 2026 21:52:02 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:27 -0300
Subject: [PATCH RFC 09/12] drm/v3d: Provide a custom dma_buf implementation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-9-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=uciWqvfkp96Hg/3trAcUr+amMQN65j+2lD1S1oIX5DU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNDVsD+qc1NjzvLQI1mKTfBHHRmk0MTBE0y0
 Rw11kdbF6mJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qifnB/wM8WIQ2jnLIdb5WVc3REPJseS6CUIYKKOtzeoVEvmrYmXv/akXGcPB7oP9KYY51FqRw+w
 XF25ctaayYo7vZsJ3Q/gyckG+4bwW6M8wrWPM+2ZZao33YGOsrPb+yb4DsvQmWCqHh+hH7hcFOQ
 yhu19m4dDCFES48BC1QupbG9WAO76kbOw+mlod7iq50CUIJBH3a65D1OX+IJVXiS7Kd4osG5/Xn
 q1iwl2vlOAiofGW9oTnmJYb16rMFL677c5OBj/1X6g4L4KwPptpLwAFAL1G8I0+GEz5D6KzjZ8r
 sX9CyLhn7YHenmaqUsqV8k5rKXdwRnxuslHhTEuQcjWGhZqp
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

Before introducing cached CPU mappings, V3D needs a dma_buf implementation
that satisfies synchronization requests around CPU accesses coming from
a DMA-BUF exported by the driver. Use the generic shmem PRIME helpers
for that.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c  | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_drv.c |  1 +
 drivers/gpu/drm/v3d/v3d_drv.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index db95a2fac5d0..803f3bbb7144 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -63,12 +63,38 @@ void v3d_free_object(struct drm_gem_object *obj)
 	drm_gem_shmem_free(&bo->base);
 }
 
+static const struct dma_buf_ops v3d_dma_buf_ops = {
+	.attach = drm_gem_map_attach,
+	.detach = drm_gem_map_detach,
+	.map_dma_buf = drm_gem_shmem_prime_map_dma_buf,
+	.unmap_dma_buf = drm_gem_shmem_prime_unmap_dma_buf,
+	.release = drm_gem_dmabuf_release,
+	.mmap = drm_gem_dmabuf_mmap,
+	.vmap = drm_gem_dmabuf_vmap,
+	.vunmap = drm_gem_dmabuf_vunmap,
+	.begin_cpu_access = drm_gem_shmem_prime_begin_cpu_access,
+	.end_cpu_access = drm_gem_shmem_prime_end_cpu_access,
+};
+
+static struct dma_buf *v3d_prime_export(struct drm_gem_object *obj, int flags)
+{
+	return drm_gem_prime_export_with_ops(obj, &v3d_dma_buf_ops, flags);
+}
+
+bool v3d_prime_is_exporter(struct drm_device *dev, struct dma_buf *dma_buf)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+
+	return dma_buf->ops == &v3d_dma_buf_ops && obj->dev == dev;
+}
+
 static const struct drm_gem_object_funcs v3d_gem_funcs = {
 	.free = v3d_free_object,
 	.print_info = drm_gem_shmem_object_print_info,
 	.pin = drm_gem_shmem_object_pin,
 	.unpin = drm_gem_shmem_object_unpin,
 	.get_sg_table = drm_gem_shmem_object_get_sg_table,
+	.export = v3d_prime_export,
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index b790be8a7fac..7d91c528c1e9 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -283,6 +283,7 @@ static const struct drm_driver v3d_drm_driver = {
 
 	.gem_create_object = v3d_create_object,
 	.gem_prime_import_sg_table = v3d_prime_import_sg_table,
+	.gem_prime_is_exporter = v3d_prime_is_exporter,
 
 	.ioctls = v3d_drm_ioctls,
 	.num_ioctls = ARRAY_SIZE(v3d_drm_ioctls),
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 7c7bdf6e51a5..e0eed4cfef61 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -606,6 +606,7 @@ int v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
 struct drm_gem_object *v3d_prime_import_sg_table(struct drm_device *dev,
 						 struct dma_buf_attachment *attach,
 						 struct sg_table *sgt);
+bool v3d_prime_is_exporter(struct drm_device *dev, struct dma_buf *dma_buf);
 
 /* v3d_debugfs.c */
 void v3d_debugfs_init(struct drm_minor *minor);

-- 
2.56.0

