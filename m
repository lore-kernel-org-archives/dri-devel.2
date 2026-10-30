Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B3606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=je8cSqzN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767D510E097;
	Fri, 30 Oct 2026 20:51:48 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14D81129C7
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=8JPSJwmXTSDqxrNj6yVd1AQck+tLNps7C5TUSbEoN/A=; b=je8cSqzNbpvDouCYOUBkdDCu1D
 EBQ0bx57kb2AOlSRbrxy2+mzjM93owd5APxY9q4NP3LmVYrfgTQNy6vH+ZOL/nVtbki3vujuJPUh5
 nnPJNsDM0/7ee44VJ2s/ykFs3rEREdKz5eu0ZEOfXCLbS6GPscymoq7QzMX6veHqw/twaXHGoyu5q
 5EKQa93AINYZqH6Myav5aaZQYkb5kkdkNQUOyL59G7nOK7elvwM599I6qgfHABSANdiHOvw3byYMO
 PsHT7ftxod9zmLI1tZx39GH63RE7ZRppOPpJfwY1/mygGN4aNxg0O8ZfTSrfTq+BunRTzG29oTPOs
 A42tbT8g==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZR-00FLiF-F2; Fri, 30 Oct 2026 21:51:29 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:20 -0300
Subject: [PATCH RFC 02/12] drm/shmem: Provide a generic {begin,
 end}_cpu_access() implementation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-2-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5990; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=IvNgE/SpIhKezIPhBdH4RRwZ/TIe11953K9VaiN248Q=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNCd9EWDLHPIbhLP+CwCtadeOnvXOWIKfg4G
 E5/3BTNYx6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQgAKCRA/8w6Kdoj6
 qkMfB/43l+CBqCY2o3nr2sWfZSlOX/Fsua3rJdrLbGH1z3jvQSXhACn/O5PfO0Py6WDVCVzOGs+
 Llm+dKRHbHHpndOHmeDMNYGuXzN9BXqSi5Wt2lS3AYvlN262WCEFb789qgW7A0cQK1KFrdG/U4o
 nUMVcu4dDU9lnTaYgsO8BTGncUXNRKnJi2ZkUrHzk/1SdPOuF/wKwlUu/zDtPSUlIcZ7y3Near8
 bB0Nnh3yVdFjsWHW/xe/qau/GIl75nwFpEX5DyilWi6uLRpxcB0UGle6Ad75EOSn5KaQy5024WD
 PlaAdMW70WJ2JLfxUhIErGVzbF2jdDY1DmTMww6cBzRyxnLe
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

From: Boris Brezillon <boris.brezillon@collabora.com>

The default implementation simply takes care of invalidating/flushing
caches around CPU accesses. It takes care of both the exporter and
the importers, which forces us to overload the default
::[un]map_dma_buf() implementation provided by drm_gem.c to store the
sgt.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
[mcanal: rebased on top of drm-misc-next and fixed kernel-doc typo]
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 115 +++++++++++++++++++++++++++++++++
 include/drm/drm_gem_shmem_helper.h     |  10 +++
 2 files changed, 125 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d654a22a30de..13c4a68fdde0 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -993,6 +993,121 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_no_map);
 
+/**
+ * drm_gem_shmem_prime_map_dma_buf - Default map_dma_buf() for exported buffers
+ * @attach: attachment
+ * @dir: type of access done by this attachment
+ *
+ * Default implementation for dma_buf_ops::map_dma_buf(). This is just a wrapper
+ * around drm_gem_map_dma_buf() that lets us set the dma_buf_attachment::priv
+ * to the sgt so that drm_gem_shmem_prime_{begin,end}_cpu_access() can sync
+ * around CPU accesses.
+ *
+ * Return: the mapped SG table on success, or an ERR_PTR() on failure.
+ */
+struct sg_table *
+drm_gem_shmem_prime_map_dma_buf(struct dma_buf_attachment *attach,
+				enum dma_data_direction dir)
+{
+	struct sg_table *sgt = drm_gem_map_dma_buf(attach, dir);
+
+	if (!IS_ERR(sgt))
+		attach->priv = sgt;
+
+	return sgt;
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_map_dma_buf);
+
+/**
+ * drm_gem_shmem_prime_unmap_dma_buf - Default unmap_dma_buf() for exported buffers
+ * @attach: attachment
+ * @sgt: SG table to unmap
+ * @dir: type of access done by this attachment
+ *
+ * Default implementation for dma_buf_ops::unmap_dma_buf(). This is just a wrapper
+ * around drm_gem_unmap_dma_buf() that lets us reset the dma_buf_attachment::priv
+ * field so that drm_gem_shmem_prime_{begin,end}_cpu_access() don't consider it
+ * as a mapped attachment to sync against.
+ */
+void drm_gem_shmem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
+				       struct sg_table *sgt,
+				       enum dma_data_direction dir)
+{
+	attach->priv = NULL;
+	drm_gem_unmap_dma_buf(attach, sgt, dir);
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_unmap_dma_buf);
+
+/**
+ * drm_gem_shmem_prime_begin_cpu_access - Default begin_cpu_access() for exported buffers
+ * @dma_buf: The exported DMA buffer this acts on
+ * @dir: direction of the access
+ *
+ * Default implementation for dma_buf_ops::begin_cpu_access(). This only takes care of
+ * cache maintenance.
+ */
+int drm_gem_shmem_prime_begin_cpu_access(struct dma_buf *dma_buf,
+					 enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_device *dev = obj->dev;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+	struct dma_buf_attachment *attach;
+
+	dma_resv_lock(obj->resv, NULL);
+	if (shmem->sgt)
+		dma_sync_sgtable_for_cpu(dev->dev, shmem->sgt, dir);
+
+	if (shmem->vaddr)
+		invalidate_kernel_vmap_range(shmem->vaddr, shmem->base.size);
+
+	list_for_each_entry(attach, &dma_buf->attachments, node) {
+		struct sg_table *sgt = attach->priv;
+
+		if (sgt)
+			dma_sync_sgtable_for_cpu(attach->dev, sgt, dir);
+	}
+	dma_resv_unlock(obj->resv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_begin_cpu_access);
+
+/**
+ * drm_gem_shmem_prime_end_cpu_access - Default end_cpu_access() for exported buffers
+ * @dma_buf: The exported DMA buffer this acts on
+ * @dir: direction of the access
+ *
+ * Default implementation for dma_buf_ops::end_cpu_access(). This only takes care of
+ * cache maintenance.
+ */
+int drm_gem_shmem_prime_end_cpu_access(struct dma_buf *dma_buf,
+				       enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_device *dev = obj->dev;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+	struct dma_buf_attachment *attach;
+
+	dma_resv_lock(obj->resv, NULL);
+	list_for_each_entry(attach, &dma_buf->attachments, node) {
+		struct sg_table *sgt = attach->priv;
+
+		if (sgt)
+			dma_sync_sgtable_for_device(attach->dev, sgt, dir);
+	}
+
+	if (shmem->vaddr)
+		flush_kernel_vmap_range(shmem->vaddr, shmem->base.size);
+
+	if (shmem->sgt)
+		dma_sync_sgtable_for_device(dev->dev, shmem->sgt, dir);
+
+	dma_resv_unlock(obj->resv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_end_cpu_access);
+
 /*
  * Kunit helpers
  */
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index bcbb92f3fe9b..358cd247f803 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -293,6 +293,16 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
 struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 							 struct dma_buf *buf);
+struct sg_table *
+drm_gem_shmem_prime_map_dma_buf(struct dma_buf_attachment *attach,
+				enum dma_data_direction dir);
+void drm_gem_shmem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
+				       struct sg_table *sgt,
+				       enum dma_data_direction dir);
+int drm_gem_shmem_prime_begin_cpu_access(struct dma_buf *dma_buf,
+					 enum dma_data_direction dir);
+int drm_gem_shmem_prime_end_cpu_access(struct dma_buf *dma_buf,
+				       enum dma_data_direction dir);
 
 /**
  * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations

-- 
2.56.0

