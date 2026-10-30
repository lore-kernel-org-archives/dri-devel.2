Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA22606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UPTaS63o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8730510E34F;
	Fri, 30 Oct 2026 20:51:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA741129BE
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=v2Q7mQlIsmnr8w1YmmTKsK+J1bfL0KvHD/ciQ+bKbo4=; b=UPTaS63o72wOOHjYKooma0nu3L
 F+yziFIBWhIbTuIhfVAW8SUhTDbo6TK4FmCa6Cja05nXKMxx8C9TL7zlmqcl2ok1Cmb7bAe2UmOKG
 Gv572LOEEgXZz+BjcJ7Y8+TZTm6A7PVVQC8IGetaPUDY/9ZlwRo9rui3ttMRSyG0LZET6NPOPupRT
 JE6bf6o+t9/gKtB6/TkjSzkWP964eR17OL7m0wlXHMJwDqGlI6ALRd5O3KXan466ohIqsSN3zKKxt
 hNAYFoKxn0LxxAHyPwKkFxa7bW00tNut8uCY+b0jDf0o5QVf2oKyESD9wz3onNNJT8jlTB4R4huxF
 kV5vdP/w==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZM-00FLiF-Ve; Fri, 30 Oct 2026 21:51:25 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:19 -0300
Subject: [PATCH RFC 01/12] drm/prime: Allow custom dma_buf_ops in PRIME helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-1-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5803; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=dztp4NILszPTCzaYDzXraf1RMVC3SI5/4xfUm+vPSDc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNCrv6XkqRggA7epl5sgTgFUeefDGwlgyIDe
 nEGkK7vfNmJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQgAKCRA/8w6Kdoj6
 qnNRCACpTcijKcDZaiib0iraCye7ujg0YlheDoSSOoB4sF3RDcEYwSt2LlVrgn/9Ud+MEJ1HRG0
 tFsxmoo1YjRfH+nSjS5b5xliv6M43IhE65b7MG+560ZI/xVcntWgtwiv5Qn77lH1m0JCEQGHmgR
 bmQf2TpFssn0oECvqZZkm9lly3ScVY4IINSpIjTUmDuMWyOPiw6lfS592vSqnt7JL+AoCfgM8Ks
 /ElZd301TRjsq0RWXPww+fZzw3zNcc1zJv62TK3q+EaZP2oWP3eBN/EYCUkEmhYiSPMQlGaR9El
 j2adfvne+/ZB1Gw9qIl5Rh8HZ8Ddwu8cWLsmrsndOGVf5ler
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

drm_gem_prime_export() and drm_gem_is_prime_exported_dma_buf() hardcode
drm_gem_prime_dmabuf_ops. Drivers with custom dma_buf_ops can't use them
and end up duplicating the export and self-import logic instead.

Add drm_gem_prime_export_with_ops() to export with driver-provided ops,
and an optional drm_driver.gem_prime_is_exporter() callback to let drivers
identify their own DMA-BUFs. Note that the callback must receive DMA-BUF,
so that the driver can check its ops before dereferencing dma_buf->priv.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_prime.c | 47 +++++++++++++++++++++++++++++++++++----------
 include/drm/drm_drv.h       | 11 +++++++++++
 include/drm/drm_prime.h     |  4 ++++
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index fe3436d1235d..4183def83cdd 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -905,22 +905,26 @@ unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt)
 EXPORT_SYMBOL(drm_prime_get_contiguous_size);
 
 /**
- * drm_gem_prime_export - helper library implementation of the export callback
+ * drm_gem_prime_export_with_ops - export a GEM object with custom dma_buf_ops
  * @obj: GEM object to export
+ * @dma_buf_ops: &dma_buf_ops of the exported DMA-BUF
  * @flags: flags like DRM_CLOEXEC and DRM_RDWR
  *
- * This is the implementation of the &drm_gem_object_funcs.export functions for GEM drivers
- * using the PRIME helpers. It is used as the default in
- * drm_gem_prime_handle_to_fd().
+ * Same as drm_gem_prime_export(), but with driver-provided &dma_buf_ops.
+ * Drivers using this can implement &drm_driver.gem_prime_is_exporter for
+ * the PRIME import helpers to recognize their own buffers.
+ *
+ * Return: the exported DMA-BUF on success, or an ERR_PTR() on failure.
  */
-struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
-				     int flags)
+struct dma_buf *drm_gem_prime_export_with_ops(struct drm_gem_object *obj,
+					      const struct dma_buf_ops *dma_buf_ops,
+					      int flags)
 {
 	struct drm_device *dev = obj->dev;
 	struct dma_buf_export_info exp_info = {
 		.exp_name = KBUILD_MODNAME, /* white lie for debug */
 		.owner = dev->driver->fops->owner,
-		.ops = &drm_gem_prime_dmabuf_ops,
+		.ops = dma_buf_ops,
 		.size = obj->size,
 		.flags = flags,
 		.priv = obj,
@@ -929,24 +933,47 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 
 	return drm_gem_dmabuf_export(dev, &exp_info);
 }
+EXPORT_SYMBOL(drm_gem_prime_export_with_ops);
+
+/**
+ * drm_gem_prime_export - helper library implementation of the export callback
+ * @obj: GEM object to export
+ * @flags: flags like DRM_CLOEXEC and DRM_RDWR
+ *
+ * This is the implementation of the &drm_gem_object_funcs.export function for
+ * GEM drivers using the PRIME helpers. It is used as the default in
+ * drm_gem_prime_handle_to_fd().
+ *
+ * Return: the exported DMA-BUF on success, or an ERR_PTR() on failure.
+ */
+struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
+				     int flags)
+{
+	return drm_gem_prime_export_with_ops(obj, &drm_gem_prime_dmabuf_ops, flags);
+}
 EXPORT_SYMBOL(drm_gem_prime_export);
 
 
 /**
- * drm_gem_is_prime_exported_dma_buf -
- * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
+ * drm_gem_is_prime_exported_dma_buf - check if a DMA-BUF was exported by @dev
  * @dev: drm_device to check against
  * @dma_buf: dma-buf object to import
  *
+ * DMA-BUFs exported with custom &dma_buf_ops are recognized through
+ * &drm_driver.gem_prime_is_exporter.
+ *
  * Return: true if the DMA-BUF was exported from a GEM object belonging
  * to @dev, false otherwise.
  */
-
 bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
 				       struct dma_buf *dma_buf)
 {
 	struct drm_gem_object *obj = dma_buf->priv;
 
+	if (dev->driver->gem_prime_is_exporter &&
+	    dev->driver->gem_prime_is_exporter(dev, dma_buf))
+		return true;
+
 	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
 }
 EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b23830494ed4..d613740a06d4 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -310,6 +310,17 @@ struct drm_driver {
 	 */
 	struct drm_gem_object * (*gem_prime_import)(struct drm_device *dev,
 				struct dma_buf *dma_buf);
+	/**
+	 * @gem_prime_is_exporter:
+	 *
+	 * Returns true if @dma_buf was exported from a GEM object of @dev.
+	 * Drivers exporting with a custom &dma_buf_ops can implement this
+	 * hook to let the PRIME import helpers recognize their own buffers.
+	 *
+	 * This callback is optional.
+	 */
+	bool (*gem_prime_is_exporter)(struct drm_device *dev,
+				      struct dma_buf *dma_buf);
 	/**
 	 * @gem_prime_import_sg_table:
 	 *
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index f50f862f0d8b..9b704e3ca919 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -53,6 +53,7 @@ struct device;
 
 struct dma_buf_export_info;
 struct dma_buf;
+struct dma_buf_ops;
 struct dma_buf_attachment;
 struct iosys_map;
 
@@ -96,6 +97,9 @@ struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
 				       struct page **pages, unsigned int nr_pages);
 struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 				     int flags);
+struct dma_buf *drm_gem_prime_export_with_ops(struct drm_gem_object *obj,
+					      const struct dma_buf_ops *dma_buf_ops,
+					      int flags);
 
 unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
 

-- 
2.56.0

