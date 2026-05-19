Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040C9CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618F910EA6C;
	Tue, 19 May 2026 06:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JVYMBi4e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3170E10EA69
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:15:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 66F20445BF;
 Tue, 19 May 2026 06:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47D4EC2BD01;
 Tue, 19 May 2026 06:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779171356;
 bh=VogAFtpediecZpP5TM2uZbRcL0kuXBfdro2v4LUoJkk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=JVYMBi4e5knehOiV81O7cwQseHAQVHd+8s2BqVc/aix1i3/H+O+BSZoRmk3LdV8ie
 tcMaX8rldTCDyNXRLyaCQ4QPHlQ8ca3n6w/FTZeJdzl2LnHOkT41jHijZ0kpoDI36g
 9lLoZM9Lq2YU4+YzgwhWOFCA9lDb9I0EWtP5I40b/d8ijR/urpQxlQpMG7pJg2+/U3
 AUgQIrK5jGhMvvkVVwz2QgvvIQF76zCn0jyaU65hJ7QVWZgfqAwkSojIa5oIJDhzvi
 9vSRRbbd5HcgIPEkcUh7Ib9cE1f+2GqPbz9VfbFAkyji8pRucSVbXX5dcsbWKAeGJg
 NRjMky5HYjSXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 40B63CD4F54;
 Tue, 19 May 2026 06:15:56 +0000 (UTC)
From: Ekansh Gupta via B4 Relay
 <devnull+ekansh.gupta.oss.qualcomm.com@kernel.org>
Date: Tue, 19 May 2026 11:46:05 +0530
Subject: [PATCH 15/15] accel/qda: Add remote memory unmap from DSP address
 space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qda-series-v1-15-b2d984c297f8@oss.qualcomm.com>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
In-Reply-To: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>, 
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org, 
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org, 
 konradybcio@kernel.org, robin.clark@oss.qualcomm.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171352; l=11684;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=/fQu1UAz3gyMqR3NFZpJX4rpM/wwR7jVltKg2M1B+DU=;
 b=72Y34omiJ0pH6eH3TjgrzGhfH0pIU59j8J/43VANXh+n8/tZffL9Y1uIHokwT5VZoT6IjXqws
 XpdsbbgKvkoDGQjDTS6MiWkzLPEsSABcWvS6//F1VQ4hTleSHoj3T3L
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Endpoint-Received: by B4 Relay for ekansh.gupta@oss.qualcomm.com/20260223
 with auth_id=647
X-Original-From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: ekansh.gupta@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Implement DRM_IOCTL_QDA_REMOTE_MUNMAP (command 0x06), which unmaps
a previously mapped memory region from the DSP's virtual address space.
Two unmap modes mirror the two map modes:

QDA_MUNMAP_REQUEST_LEGACY (FASTRPC_RMID_INIT_MUNMAP)
  Legacy single-argument unmap: sends a fastrpc_munmap_req_msg
  containing the session ID, the DSP virtual address (vaddrout from
  the original map response), and the region size.

QDA_MUNMAP_REQUEST_ATTR (FASTRPC_RMID_INIT_MEM_UNMAP)
  Attribute-based unmap: sends a fastrpc_mem_unmap_req_msg which
  additionally carries the original DMA-BUF fd and virtual address,
  matching the fd-based MEM_MAP path.

DRM_QDA_REMOTE_MUNMAP is assigned command number 0x06, filling the
slot that was previously reserved for this purpose.

Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c     |  1 +
 drivers/accel/qda/qda_fastrpc.c | 84 +++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h | 34 +++++++++++++++++
 drivers/accel/qda/qda_ioctl.c   | 28 ++++++++++++++
 drivers/accel/qda/qda_ioctl.h   |  1 +
 include/uapi/drm/qda_accel.h    | 36 +++++++++++++++++-
 6 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 3640e4a41605..41cc207447b4 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -68,6 +68,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_CREATE, qda_ioctl_init_create, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MAP, qda_ioctl_mmap, 0),
+	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MUNMAP, qda_ioctl_munmap, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_INVOKE, qda_ioctl_invoke, 0),
 };
 
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index cab3a560ceb5..0513beede428 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -887,6 +887,84 @@ static int fastrpc_prepare_args_mem_map_attr(struct fastrpc_invoke_context *ctx,
 	return err;
 }
 
+static int fastrpc_prepare_args_munmap(struct fastrpc_invoke_context *ctx, char __user *argp)
+{
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct fastrpc_munmap_req_msg *req_msg;
+	struct drm_qda_mem_unmap uargs;
+	void *req;
+	int err;
+
+	memcpy(&uargs, argp, sizeof(uargs));
+
+	args = kzalloc_obj(*args);
+	if (!args)
+		return -ENOMEM;
+
+	req = kzalloc_obj(*req_msg);
+	if (!req) {
+		err = -ENOMEM;
+		goto err_free_args;
+	}
+	req_msg = (struct fastrpc_munmap_req_msg *)req;
+
+	req_msg->remote_session_id = ctx->remote_session_id;
+	req_msg->size  = uargs.size;
+	req_msg->vaddr = uargs.vaddrout;
+
+	setup_single_arg(args, req_msg, sizeof(*req_msg));
+	ctx->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
+	ctx->args = args;
+	ctx->req = req;
+	ctx->handle = FASTRPC_INIT_HANDLE;
+
+	return 0;
+
+err_free_args:
+	kfree(args);
+	return err;
+}
+
+static int fastrpc_prepare_args_mem_unmap_attr(struct fastrpc_invoke_context *ctx,
+					       char __user *argp)
+{
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct fastrpc_mem_unmap_req_msg *req_msg;
+	struct drm_qda_mem_unmap uargs;
+	void *req;
+	int err;
+
+	memcpy(&uargs, argp, sizeof(uargs));
+
+	args = kzalloc_obj(*args);
+	if (!args)
+		return -ENOMEM;
+
+	req = kzalloc_obj(*req_msg);
+	if (!req) {
+		err = -ENOMEM;
+		goto err_free_args;
+	}
+	req_msg = (struct fastrpc_mem_unmap_req_msg *)req;
+
+	req_msg->remote_session_id = ctx->remote_session_id;
+	req_msg->fd      = uargs.fd;		/* DMA-BUF fd forwarded to DSP */
+	req_msg->vaddrin = uargs.vaddr;
+	req_msg->len     = uargs.size;
+
+	setup_single_arg(args, req_msg, sizeof(*req_msg));
+	ctx->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
+	ctx->args = args;
+	ctx->req = req;
+	ctx->handle = FASTRPC_INIT_HANDLE;
+
+	return 0;
+
+err_free_args:
+	kfree(args);
+	return err;
+}
+
 static int fastrpc_prepare_args_invoke(struct fastrpc_invoke_context *ctx, char __user *argp)
 {
 	struct drm_qda_invoke_args invoke_args;
@@ -945,6 +1023,12 @@ int qda_fastrpc_prepare_args(struct fastrpc_invoke_context *ctx, char __user *ar
 	case FASTRPC_RMID_INIT_MEM_MAP:
 		err = fastrpc_prepare_args_mem_map_attr(ctx, argp);
 		break;
+	case FASTRPC_RMID_INIT_MUNMAP:
+		err = fastrpc_prepare_args_munmap(ctx, argp);
+		break;
+	case FASTRPC_RMID_INIT_MEM_UNMAP:
+		err = fastrpc_prepare_args_mem_unmap_attr(ctx, argp);
+		break;
 	case FASTRPC_RMID_INVOKE_DYNAMIC:
 		err = fastrpc_prepare_args_invoke(ctx, argp);
 		break;
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 71812eaf9a54..030e9b954f7a 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -275,9 +275,11 @@ struct fastrpc_invoke_context {
 /* Remote Method ID table - identifies initialization and control operations */
 #define FASTRPC_RMID_INIT_RELEASE	1	/* Release DSP process */
 #define FASTRPC_RMID_INIT_MMAP		4	/* Map memory region to DSP */
+#define FASTRPC_RMID_INIT_MUNMAP	5	/* Unmap DSP memory region */
 #define FASTRPC_RMID_INIT_CREATE	6	/* Create DSP process */
 #define FASTRPC_RMID_INIT_CREATE_ATTR	7	/* Create DSP process with attributes */
 #define FASTRPC_RMID_INIT_MEM_MAP	10	/* Map DMA buffer with attributes to DSP */
+#define FASTRPC_RMID_INIT_MEM_UNMAP	11	/* Unmap DMA buffer from DSP */
 #define FASTRPC_RMID_INVOKE_DYNAMIC	0xFFFFFFFF	/* Dynamic method invocation */
 
 /* Common handle for initialization operations */
@@ -345,6 +347,38 @@ struct fastrpc_map_rsp_msg {
 	u64 vaddrout;
 };
 
+/**
+ * struct fastrpc_mem_unmap_req_msg - Memory unmap request message with attributes
+ *
+ * This message structure is sent to the DSP to request unmapping
+ * of a previously mapped memory region (ATTR request).
+ */
+struct fastrpc_mem_unmap_req_msg {
+	/** @remote_session_id: Client identifier for the session */
+	s32 remote_session_id;
+	/** @fd: DMA-BUF file descriptor of the buffer to unmap */
+	s32 fd;
+	/** @vaddrin: DSP virtual address of the mapped region to unmap */
+	u64 vaddrin;
+	/** @len: Size of the region to unmap in bytes */
+	u64 len;
+};
+
+/**
+ * struct fastrpc_munmap_req_msg - Legacy memory unmap request message
+ *
+ * This message structure is sent to the DSP to request unmapping
+ * of a previously mapped memory region.
+ */
+struct fastrpc_munmap_req_msg {
+	/** @remote_session_id: Client identifier for the session */
+	s32 remote_session_id;
+	/** @vaddr: DSP virtual address of the mapped region to unmap */
+	u64 vaddr;
+	/** @size: Size of the region to unmap in bytes */
+	u64 size;
+};
+
 void qda_fastrpc_context_free(struct kref *ref);
 struct fastrpc_invoke_context *qda_fastrpc_context_alloc(void);
 int qda_fastrpc_prepare_args(struct fastrpc_invoke_context *ctx, char __user *argp);
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 283eb7535c45..aeba6190182e 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -254,6 +254,34 @@ int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_pri
 	}
 }
 
+/**
+ * qda_ioctl_munmap() - Unmap memory from DSP address space
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_mem_unmap)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_mem_unmap *unmap_req;
+
+	if (!data)
+		return -EINVAL;
+
+	unmap_req = (struct drm_qda_mem_unmap *)data;
+
+	switch (unmap_req->request) {
+	case QDA_MUNMAP_REQUEST_LEGACY:
+		return fastrpc_invoke(FASTRPC_RMID_INIT_MUNMAP, dev, data, file_priv);
+	case QDA_MUNMAP_REQUEST_ATTR:
+		return fastrpc_invoke(FASTRPC_RMID_INIT_MEM_UNMAP, dev, data, file_priv);
+	default:
+		drm_err(dev, "Invalid munmap request type: %u\n", unmap_req->request);
+		return -EINVAL;
+	}
+}
+
 /**
  * qda_ioctl_invoke() - Perform a dynamic FastRPC method invocation
  * @dev: DRM device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 457ceccede08..e14a39050d09 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -14,5 +14,6 @@ int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *fi
 int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 
 #endif /* __QDA_IOCTL_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 173f59abd361..e3b5c9a963bf 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -21,9 +21,10 @@ extern "C" {
 #define DRM_QDA_QUERY		0x00
 #define DRM_QDA_GEM_CREATE		0x01
 #define DRM_QDA_GEM_MMAP_OFFSET	0x02
-/* Command number 0x03 reserved for INIT_ATTACH; 0x06 reserved for MUNMAP */
+/* Command number 0x03 reserved for INIT_ATTACH */
 #define DRM_QDA_REMOTE_SESSION_CREATE		0x04
 #define DRM_QDA_REMOTE_MAP			0x05
+#define DRM_QDA_REMOTE_MUNMAP			0x06
 #define DRM_QDA_REMOTE_INVOKE			0x07
 
 /*
@@ -44,6 +45,8 @@ extern "C" {
 		 struct drm_qda_init_create)
 #define DRM_IOCTL_QDA_REMOTE_MAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_MAP, \
 					  struct drm_qda_mem_map)
+#define DRM_IOCTL_QDA_REMOTE_MUNMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_MUNMAP, \
+					  struct drm_qda_mem_unmap)
 #define DRM_IOCTL_QDA_REMOTE_INVOKE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_INVOKE, \
 					  struct drm_qda_invoke_args)
 
@@ -51,6 +54,10 @@ extern "C" {
 #define QDA_MAP_REQUEST_LEGACY    1  /* Legacy MMAP operation */
 #define QDA_MAP_REQUEST_ATTR      2  /* Handle-based MEM_MAP operation with attributes */
 
+/* Request type definitions for qda_mem_unmap */
+#define QDA_MUNMAP_REQUEST_LEGACY    1  /* Legacy MUNMAP operation */
+#define QDA_MUNMAP_REQUEST_ATTR      2  /* Handle-based MEM_UNMAP operation */
+
 /**
  * struct drm_qda_query - Device information query structure
  * @dsp_name: Name of DSP (e.g., "adsp", "cdsp", "cdsp1", "gdsp0", "gdsp1")
@@ -188,6 +195,33 @@ struct drm_qda_mem_map {
 	__u64 vaddrout;
 };
 
+/**
+ * struct drm_qda_mem_unmap - Memory unmapping request structure
+ * @request: Request type (QDA_MUNMAP_REQUEST_LEGACY or QDA_MUNMAP_REQUEST_ATTR)
+ * @fd: DMA-BUF file descriptor (used for ATTR request)
+ * @vaddr: Virtual address (used for ATTR request)
+ * @vaddrout: DSP virtual address (used for LEGACY request)
+ * @size: Size of the memory region to unmap in bytes
+ *
+ * This structure is used to request unmapping of a previously mapped
+ * memory region from the DSP's virtual address space.
+ *
+ * For QDA_MUNMAP_REQUEST_LEGACY (value 1):
+ *   - Uses fields: vaddrout, size
+ *   - Legacy MUNMAP operation for backward compatibility
+ *
+ * For QDA_MUNMAP_REQUEST_ATTR (value 2):
+ *   - Uses fields: fd, vaddr, size
+ *   - Handle-based MEM_UNMAP operation
+ */
+struct drm_qda_mem_unmap {
+	__u32 request;
+	__s32 fd;
+	__u64 vaddr;
+	__u64 vaddrout;
+	__u64 size;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1


