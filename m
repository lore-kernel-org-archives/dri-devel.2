Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4CF606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JMooBPN0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68ECC1129D3;
	Fri, 30 Oct 2026 20:52:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1131129CA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=L62gGkXMAWJrZGPw1k1pLLbN/lTLX7n+hDy39+FDLF8=; b=JMooBPN0e3NdyjGl+gN1opFUtQ
 nlWEbjV3N+tACtqLPpt4B9PkbpYZt0cZ4fgQ9Pk/2CV7ZL+PCfgLrR3AQQA4m2n+WYooerSnwFoI5
 XJ9Q+4lFotUhnNlHFV4xli7gSNeGrl6cyDlyC2ojws41d9TDOvxIQoVb9WcUUkYav9e+7rClXSqLq
 ppghZ5Ti3W/qEBS9NpOiV65lC9kWPFQ8QOk0xVGYJsNwqr68j2rYncH7qB3EvefwU6PtKmXqjZaLt
 678sPchgrxL8kLZ1+ujEEH7G/49x4Lpe2j0oUbZY/NhuiUqi3PVXNfCDXNsEG8JWqiN3HDPJudYU9
 jB0Imiqg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMta6-00FLiF-RC; Fri, 30 Oct 2026 21:52:11 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:29 -0300
Subject: [PATCH RFC 11/12] drm/v3d: Add a DRM_IOCTL_V3D_SYNC_BO ioctl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-11-0a6a6b363382@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6545; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ypSopMNr1FHNpuBUjqXnuefaemdRBkUhlptqmySJXFw=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNEFPLsCfF7DT1T1CD8Ak9GxVoDPNJppD2E3
 C7tkRNV202JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDRAAKCRA/8w6Kdoj6
 qsNdCACJalmFqW3OjD7kRpuuEQIlMWZjLuhsztnK1hcGvTqvvjQAF0wuSgzC6zAOtjpDBO9lsQT
 goS+TTFL0Q4SmTquy+99BF2x68LJFaVK8qV8hgsq+q37uqkqzMJgkBWl3vFMujYHfShbw35uAC1
 i1WTr72foAsipi6CP8mhj2ddTexDAakfT+yFtSKzjhic6+zQDxoheQvc33ZnkCT4nEu9zqBOHPl
 5afhi94vBZWRhtAvtcCAeUX60hP8kAkLenAofR1HgCR5EfUEDA42Ma/EvEyR303PnCAPx5iCDX7
 DikghXGyfhNSU5vidfYo8aF8xex1jpWAhPajyUXJACmDE7z+
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

BOs mapped with DRM_V3D_BO_WB_MMAP require CPU cache maintenance around
job execution. ARM64 userspace can do it through userspace cache
operations, but AArch32 cache maintenance is privileged, even on an ARM64
kernel, which means that 32-bit userspace can't do cache mainteinance.
Without a kernel interface, a 32-bit userspace wouldn't be able to use
cached BOs.

Add an ioctl taking an array of sync operations, so userspace can flush or
invalidate multiple BO ranges in a single call.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c  | 64 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_drv.c |  1 +
 drivers/gpu/drm/v3d/v3d_drv.h |  2 ++
 include/uapi/drm/v3d_drm.h    | 48 ++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 0a5a056d4b26..78eb3a1cc794 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -280,6 +280,70 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
+static int v3d_bo_sync(struct drm_gem_object *obj,
+		       const struct drm_v3d_bo_sync_op *op)
+{
+	struct v3d_bo *bo = to_v3d_bo(obj);
+	enum drm_gem_shmem_sync_type type;
+
+	switch (op->type) {
+	case DRM_V3D_BO_SYNC_CPU_CACHE_FLUSH:
+		type = DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH;
+		break;
+	case DRM_V3D_BO_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE:
+		type = DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return drm_gem_shmem_sync(&bo->base, op->offset, op->size, type);
+}
+
+int v3d_sync_bo_ioctl(struct drm_device *dev, void *data,
+		      struct drm_file *file_priv)
+{
+	struct drm_v3d_sync_bo *args = data;
+	struct drm_v3d_bo_sync_op *ops;
+	struct drm_gem_object *obj;
+	int ret = 0;
+
+	if (args->pad)
+		return -EINVAL;
+
+	if (!args->op_count)
+		return 0;
+
+	/* Limits the number of sync operations requested by userspace. */
+	if (args->op_count > SZ_64K) {
+		drm_dbg(dev, "Too many sync ops: %u\n", args->op_count);
+		return -EINVAL;
+	}
+
+	ops = vmemdup_array_user(u64_to_user_ptr(args->ops), args->op_count,
+				 sizeof(*ops));
+	if (IS_ERR(ops))
+		return PTR_ERR(ops);
+
+	for (u32 i = 0; i < args->op_count; i++) {
+		obj = drm_gem_object_lookup(file_priv, ops[i].handle);
+		if (!obj) {
+			drm_dbg(dev, "Failed to look up GEM BO %d\n",
+				ops[i].handle);
+			ret = -ENOENT;
+			break;
+		}
+
+		ret = v3d_bo_sync(obj, &ops[i]);
+		drm_gem_object_put(obj);
+		if (ret)
+			break;
+	}
+
+	kvfree(ops);
+	return ret;
+}
+
 int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_priv)
 {
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 7d91c528c1e9..9e6e4f832eee 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -267,6 +267,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CPU, v3d_submit_cpu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
 	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_COUNTER, v3d_perfmon_get_counter_ioctl, DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(V3D_PERFMON_SET_GLOBAL, v3d_perfmon_set_global_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(V3D_SYNC_BO, v3d_sync_bo_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver v3d_drm_driver = {
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 4f32fc3ab1de..e5fb3a7b8d96 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -602,6 +602,8 @@ int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_priv);
 int v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *file_priv);
+int v3d_sync_bo_ioctl(struct drm_device *dev, void *data,
+		      struct drm_file *file_priv);
 struct drm_gem_object *v3d_prime_import_sg_table(struct drm_device *dev,
 						 struct dma_buf_attachment *attach,
 						 struct sg_table *sgt);
diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 4221c7544d08..c2f7f1409ae4 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -44,6 +44,7 @@ extern "C" {
 #define DRM_V3D_SUBMIT_CPU                        0x0b
 #define DRM_V3D_PERFMON_GET_COUNTER               0x0c
 #define DRM_V3D_PERFMON_SET_GLOBAL                0x0d
+#define DRM_V3D_SYNC_BO                           0x0e
 
 #define DRM_IOCTL_V3D_SUBMIT_CL           DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_CL, struct drm_v3d_submit_cl)
 #define DRM_IOCTL_V3D_WAIT_BO             DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_WAIT_BO, struct drm_v3d_wait_bo)
@@ -64,6 +65,7 @@ extern "C" {
 						   struct drm_v3d_perfmon_get_counter)
 #define DRM_IOCTL_V3D_PERFMON_SET_GLOBAL  DRM_IOW(DRM_COMMAND_BASE + DRM_V3D_PERFMON_SET_GLOBAL, \
 						   struct drm_v3d_perfmon_set_global)
+#define DRM_IOCTL_V3D_SYNC_BO             DRM_IOW(DRM_COMMAND_BASE + DRM_V3D_SYNC_BO, struct drm_v3d_sync_bo)
 
 #define DRM_V3D_SUBMIT_CL_FLUSH_CACHE             0x01
 #define DRM_V3D_SUBMIT_EXTENSION		  0x02
@@ -796,6 +798,52 @@ struct drm_v3d_perfmon_set_global {
 	__u32 id;
 };
 
+/* Valid types to pass to drm_v3d_bo_sync_op */
+#define DRM_V3D_BO_SYNC_CPU_CACHE_FLUSH                0
+#define DRM_V3D_BO_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE 1
+
+/**
+ * struct drm_v3d_bo_sync_op - BO synchronization operation
+ */
+struct drm_v3d_bo_sync_op {
+	/** @handle: Handle of the buffer object to sync. */
+	__u32 handle;
+
+	/** @type: Type of sync operation, DRM_V3D_BO_SYNC_*. */
+	__u32 type;
+
+	/**
+	 * @offset: Offset into the BO at which the sync range starts.
+	 *
+	 * This will be rounded down to the nearest cache line as needed.
+	 */
+	__u32 offset;
+
+	/**
+	 * @size: Size of the range to sync.
+	 *
+	 * @size + @offset will be rounded up to the nearest cache line as
+	 * needed.
+	 */
+	__u32 size;
+};
+
+/**
+ * struct drm_v3d_sync_bo - ioctl argument for CPU cache maintenance on BOs
+ *
+ * Operations on write-combined BOs are no-ops, and imported BOs are rejected.
+ */
+struct drm_v3d_sync_bo {
+	/** @ops: Pointer to an array of struct drm_v3d_bo_sync_op. */
+	__u64 ops;
+
+	/** @op_count: Number of elements in @ops. */
+	__u32 op_count;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.56.0

