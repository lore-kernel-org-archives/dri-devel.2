Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D957606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=fzrev7c2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EA91129CF;
	Fri, 30 Oct 2026 20:52:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAAD1129BE
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=4jEy73cHOh5B3v+eJ9I3vK0RsnhB9SChCnIEk6bmna8=; b=fzrev7c2Uo5cOx5POh0f3YNmJn
 hRyMm8oUeYmm0nCnK2l4u52LcKIV31hhr1/n/TXIoKToZoBtjffJRdLhOI/Xr2iZ2Pr0iH371GLGg
 0DoyDkzG+HDRjcnqeX+BtFpNcM8KVwl0PzsF++5AUN+Rhh4+b5tyo3HjsJ5WM9LKbuuKfEov0SQqC
 753Hz64kQVCWzVviIk8s25M4Dqf3YKaAaofEa4q7V2NF2+koZAtVDwssPEMhgXZJUXm347WlO/MA6
 /znW4DZVnFxS/OYjF8uv9vjrMBnIbeKYBldjyeXGXtm9vv/DPSlutUHSASHCKIVMo3j1Y0hiu+UFO
 fzcRfy3w==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZp-00FLiF-Gx; Fri, 30 Oct 2026 21:51:53 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:25 -0300
Subject: [PATCH RFC 07/12] drm/panthor: Use PRIME helpers with custom
 dma_buf_ops
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-7-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3427; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=lwGvsgKVg2ZAKletiELSrLO1kIitLO0hNxcRNHqKbfo=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNDHNrZvLl3MJ/xuyy/9lPd1UxBR+CEZKqJi
 sJKnsq8qPaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qq6RB/4n/yjsmEwR0epGbKDiK4GXgNO9urDbQkm8792Il6W5+JpF9qnX6C9TmPxpQZfEe0wgo/q
 CYYizJbMBbfzcgF/M67DegXrowFTm2W8sAWYXi1sYJ8HPZIra3TnavWF1MNtH1sgZLEeeUyAf9V
 +aR3Slt76DU8NpErmy0gRKcp0PAlv9TVObNEFCW3p4b8WVoO++tKQgf8Vj+reQX8W1Q+0PfwopB
 zsbLR8/2BZL6eDe92y4BCIvYjEWuz/byKfZ8ZE35Cgxz8u0XgtqeJsY50PUklPLy6L3GNB4ACCH
 UCKJTgDVRmPIDS7jh0DNChrIUalXZ5972uU+NRSg04cDhiT2
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

Panthor duplicates the PRIME export and self-import logic only because
the core helpers hardcoded drm_gem_prime_dmabuf_ops. Use the new
drm_gem_prime_export_with_ops() and gem_prime_is_exporter() functions
instead.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c |  2 +-
 drivers/gpu/drm/panthor/panthor_gem.c | 28 ++++------------------------
 drivers/gpu/drm/panthor/panthor_gem.h |  5 ++---
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..37048030afcb 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1801,7 +1801,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.minor = 9,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
-	.gem_prime_import = panthor_gem_prime_import,
+	.gem_prime_is_exporter = panthor_gem_prime_is_exporter,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = panthor_debugfs_init,
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 22b57ab6f929..2b7e4d5f5f5c 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -562,39 +562,19 @@ static const struct dma_buf_ops panthor_dma_buf_ops = {
 static struct dma_buf *
 panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
 {
-	struct drm_device *dev = obj->dev;
-	struct dma_buf_export_info exp_info = {
-		.exp_name = KBUILD_MODNAME,
-		.owner = THIS_MODULE,
-		.ops = &panthor_dma_buf_ops,
-		.size = obj->size,
-		.flags = flags,
-		.priv = obj,
-		.resv = obj->resv,
-	};
-
 	/* We can't export GEMs that have an exclusive VM. */
 	if (to_panthor_bo(obj)->exclusive_vm_root_gem)
 		return ERR_PTR(-EINVAL);
 
-	return drm_gem_dmabuf_export(dev, &exp_info);
+	return drm_gem_prime_export_with_ops(obj, &panthor_dma_buf_ops, flags);
 }
 
-struct drm_gem_object *
-panthor_gem_prime_import(struct drm_device *dev,
-			 struct dma_buf *dma_buf)
+bool panthor_gem_prime_is_exporter(struct drm_device *dev,
+				   struct dma_buf *dma_buf)
 {
 	struct drm_gem_object *obj = dma_buf->priv;
 
-	if (dma_buf->ops == &panthor_dma_buf_ops && obj->dev == dev) {
-		/* Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		drm_gem_object_get(obj);
-		return obj;
-	}
-
-	return drm_gem_prime_import(dev, dma_buf);
+	return dma_buf->ops == &panthor_dma_buf_ops && obj->dev == dev;
 }
 
 static void panthor_gem_print_info(struct drm_printer *p, unsigned int indent,
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 5ae37d0d3646..a68cd3c280ed 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -274,9 +274,8 @@ void panthor_gem_kernel_bo_set_label(struct panthor_kernel_bo *bo, const char *l
 int panthor_gem_sync(struct drm_gem_object *obj,
 		     u32 type, u64 offset, u64 size);
 
-struct drm_gem_object *
-panthor_gem_prime_import(struct drm_device *dev,
-			 struct dma_buf *dma_buf);
+bool panthor_gem_prime_is_exporter(struct drm_device *dev,
+				   struct dma_buf *dma_buf);
 
 static inline u64
 panthor_kernel_bo_gpuva(struct panthor_kernel_bo *bo)

-- 
2.56.0

