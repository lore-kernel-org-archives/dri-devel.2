Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7032606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=rkHWKutd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF591129C7;
	Fri, 30 Oct 2026 20:51:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A375610E34F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=BXC2/8V0ZRDL3Fo5TX3T5Ox6u5P6nv8nWKgT26RS2NY=; b=rkHWKutd3uVPObKey1afTSg0In
 MfzZWmfL2Hp4vamAqjqrYkkNzHGpTsVOKdV8H5lpFO3UHyS+vyKWwvu4PHeaBjBalH5mQI/wqBQ6m
 IUc/ws3i/ST22GTsImEgMu6RwcvXuUUB8Rac07PfRpcO8+B84FNDSHUOFrSqVyEiuWX3+k5q4QWRh
 IUiMTfWhIhBm5+8gBLZ6+U+AYu94+Se43yQOtYqqhL5wnnMehPThro3wNUjnR1WjMNt09aCEqE3mU
 Xc/qBz5xthyVUAc0+K1TzY5cxFAlsEbaLhkTFqiGeD7MJ/pKn+QDH6f6aBETybo2B9D9SNGWmsfwr
 w/fwKJrw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZa-00FLiF-V1; Fri, 30 Oct 2026 21:51:39 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:22 -0300
Subject: [PATCH RFC 04/12] drm/panfrost: Use PRIME helpers with custom
 dma_buf_ops
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-4-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3383; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=l2rLlPb5O3JYbzRb/WnqRJgMtFenlfjPmLVcHVh+gAc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNDT/zPZOo7Mf+thZilWgOR9d7gvmH5Rjd3z
 OwzybV2c8KJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qhxgCADJP05POYGFy+TIo8uNgbbv042ICRtDE9oAWgPzkck11GVZIJwoQnAsfEl5CSFacC14IDg
 8ZYokwZBs0AyPaSaDXQQfIlDOcNqBi0xmvv3j6HMOnDLKQZGvAXchA8G9Lx8fasCLUNes/WcFlP
 OVoHxkC2PsMxKzRZTKKQzdZhIg1UNzTn1zHORTzWMDatuJ2Rcyqih8uQm0wdHRr8vQoSyyRizLn
 nTP+koYTviRi3xsBiBt46yFjV3ar17fYqWD4KR0MjjlgZl9XppA0pmio935eeuV46dbGQoulswD
 FNsip/U1x7CDO16j9fWI3RUymKb2zzSFEpRlyDUSxlE7t2Ow
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

Panfrost duplicates the PRIME export and self-import logic only because
the core helpers hardcoded drm_gem_prime_dmabuf_ops. Use the new
drm_gem_prime_export_with_ops() and gem_prime_is_exporter() functions
instead.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c | 28 ++++------------------------
 drivers/gpu/drm/panfrost/panfrost_gem.h |  5 ++---
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 7c348a0bf1ee..d26f8ca52906 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -824,7 +824,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.minor			= 7,
 
 	.gem_create_object	= panfrost_gem_create_object,
-	.gem_prime_import	= panfrost_gem_prime_import,
+	.gem_prime_is_exporter	= panfrost_gem_prime_is_exporter,
 	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = panfrost_device_debugfs_init,
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 518f24549b9d..207110f33700 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -380,35 +380,15 @@ static const struct dma_buf_ops panfrost_dma_buf_ops = {
 static struct dma_buf *
 panfrost_gem_prime_export(struct drm_gem_object *obj, int flags)
 {
-	struct drm_device *dev = obj->dev;
-	struct dma_buf_export_info exp_info = {
-		.exp_name = KBUILD_MODNAME,
-		.owner = THIS_MODULE,
-		.ops = &panfrost_dma_buf_ops,
-		.size = obj->size,
-		.flags = flags,
-		.priv = obj,
-		.resv = obj->resv,
-	};
-
-	return drm_gem_dmabuf_export(dev, &exp_info);
+	return drm_gem_prime_export_with_ops(obj, &panfrost_dma_buf_ops, flags);
 }
 
-struct drm_gem_object *
-panfrost_gem_prime_import(struct drm_device *dev,
-			  struct dma_buf *dma_buf)
+bool panfrost_gem_prime_is_exporter(struct drm_device *dev,
+				    struct dma_buf *dma_buf)
 {
 	struct drm_gem_object *obj = dma_buf->priv;
 
-	if (dma_buf->ops == &panfrost_dma_buf_ops && obj->dev == dev) {
-		/* Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		drm_gem_object_get(obj);
-		return obj;
-	}
-
-	return drm_gem_prime_import(dev, dma_buf);
+	return dma_buf->ops == &panfrost_dma_buf_ops && obj->dev == dev;
 }
 
 static const struct drm_gem_object_funcs panfrost_gem_funcs = {
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index 3008afcf4bff..9d30c2b768d7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -138,9 +138,8 @@ struct drm_gem_object *
 panfrost_gem_prime_import_sg_table(struct drm_device *dev,
 				   struct dma_buf_attachment *attach,
 				   struct sg_table *sgt);
-struct drm_gem_object *
-panfrost_gem_prime_import(struct drm_device *dev,
-			  struct dma_buf *dma_buf);
+bool panfrost_gem_prime_is_exporter(struct drm_device *dev,
+				    struct dma_buf *dma_buf);
 
 struct panfrost_gem_object *
 panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags);

-- 
2.56.0

