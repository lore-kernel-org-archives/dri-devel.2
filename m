Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7AECD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1928110EA72;
	Tue, 19 May 2026 06:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HdtvzWU3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DAF10EA64
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:15:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AF84445ED;
 Tue, 19 May 2026 06:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE6AFC2BCB3;
 Tue, 19 May 2026 06:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779171355;
 bh=TNokpRpTG+3gI2q+POIo3ibcCSAOFF+PoAZfYfV7jE8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HdtvzWU3Sbe5rbTYSBe32vPDbAA0mFajoPFwMugI++gHIU38ZxixCxd/UWXbX9j50
 /vtD/f6t2/OkJqcAWwG7eBnzA3QkVGuuB4OCJX3pkXFu7AFFhbifMkV+v99C8xFcKn
 1w5baN/tSupz2UtdSLPDWVam84tTq1GkZCfxXHrbdF/EupNYErvHzH7kUDP1VZJzuo
 XxlgyjE7rNo3Mk27tuLuyt/udc5gj4dJaeAKJnqyodmLtOqSLZ3ZAoELhFDzfm4LIY
 MTBHJ41+D1TzkmW5PSiolrq53PeijIoASKM5sHBbgKV5hZ6x60g6u68NkL/VpiVmfm
 dhBPaJT0rlXwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D70CFCD4F5B;
 Tue, 19 May 2026 06:15:55 +0000 (UTC)
From: Ekansh Gupta via B4 Relay
 <devnull+ekansh.gupta.oss.qualcomm.com@kernel.org>
Date: Tue, 19 May 2026 11:46:00 +0530
Subject: [PATCH 10/15] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET IOCTLs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qda-series-v1-10-b2d984c297f8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171352; l=6304;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=pBfyH+kW8lztOnF6gzWzKMphw0VyvnLIiifmSXvlor4=;
 b=DTRjUkRF9MFrez4Yl2sKiZLIErX/Qcl75LFFQwkSWSfMjxV6yGe97d089iHoKI14WFFG0oOV9
 qzOmjQcQ4GmBC4IELwIX14y8ZrVfapzoAMb+ywogpA9nxSRxup6TBg8
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

Expose two new DRM IOCTLs that allow user-space to allocate DMA-backed
GEM buffer objects and retrieve their mmap offsets.

DRM_IOCTL_QDA_GEM_CREATE (drm_qda_gem_create)
  Allocates a DMA-coherent GEM buffer of the requested size. The
  memory manager assigns an IOMMU context bank to the calling process
  on first use and performs the DMA allocation against that bank.
  Returns a GEM handle that identifies the buffer for subsequent
  operations.

DRM_IOCTL_QDA_GEM_MMAP_OFFSET (drm_qda_gem_mmap_offset)
  Returns the mmap offset for an existing GEM handle. The offset can
  be passed directly to mmap() to map the buffer into user-space.
  Imported DMA-BUF objects are rejected by drm_gem_dumb_map_offset().

DRIVER_GEM is added to driver_features now that GEM IOCTLs are
present.

Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c   |  4 +++-
 drivers/accel/qda/qda_ioctl.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h |  2 ++
 include/uapi/drm/qda_accel.h  | 36 +++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 1b534fea50c8..c9b9e56dcb28 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -53,10 +53,12 @@ DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
 static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
+	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
+	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
 };
 
 static const struct drm_driver qda_drm_driver = {
-	.driver_features = DRIVER_COMPUTE_ACCEL,
+	.driver_features = DRIVER_GEM | DRIVER_COMPUTE_ACCEL,
 	.fops = &qda_accel_fops,
 	.open = qda_open,
 	.postclose = qda_postclose,
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 761d3567c33f..1769c85a3e98 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -3,6 +3,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/qda_accel.h>
 #include "qda_drv.h"
+#include "qda_gem.h"
 #include "qda_ioctl.h"
 
 /**
@@ -24,3 +25,52 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
 
 	return 0;
 }
+
+/**
+ * qda_ioctl_gem_create() - Create a GEM buffer object
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_gem_create)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_gem_create *args = data;
+	struct drm_gem_object *gem_obj;
+	struct qda_dev *qdev;
+
+	if (args->pad)
+		return -EINVAL;
+
+	qdev = qda_dev_from_drm(dev);
+	if (!qdev->iommu_mgr)
+		return -ENODEV;
+
+	gem_obj = qda_gem_create_object(dev, qdev->iommu_mgr, args->size, file_priv);
+	if (IS_ERR(gem_obj))
+		return PTR_ERR(gem_obj);
+
+	return qda_gem_create_handle(file_priv, gem_obj, &args->handle);
+}
+
+/**
+ * qda_ioctl_gem_mmap_offset() - Get the mmap offset for a GEM object
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_gem_mmap_offset)
+ * @file_priv: DRM file private data
+ *
+ * Uses drm_gem_dumb_map_offset() which rejects imported dma-buf objects
+ * (mmap of imported objects is not allowed).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_gem_mmap_offset *args = data;
+
+	if (args->pad)
+		return -EINVAL;
+
+	return drm_gem_dumb_map_offset(file_priv, dev, args->handle, &args->offset);
+}
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index b8fd536a111f..d1cbbfb6d965 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -9,5 +9,7 @@
 #include "qda_drv.h"
 
 int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
 
 #endif /* __QDA_IOCTL_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 1971a4263065..319e21aae0d6 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -19,6 +19,8 @@ extern "C" {
  * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
  */
 #define DRM_QDA_QUERY		0x00
+#define DRM_QDA_GEM_CREATE		0x01
+#define DRM_QDA_GEM_MMAP_OFFSET	0x02
 
 /*
  * QDA IOCTL definitions
@@ -29,6 +31,10 @@ extern "C" {
  */
 #define DRM_IOCTL_QDA_QUERY		DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
 					 struct drm_qda_query)
+#define DRM_IOCTL_QDA_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_CREATE, \
+					  struct drm_qda_gem_create)
+#define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
+					  struct drm_qda_gem_mmap_offset)
 
 /**
  * struct drm_qda_query - Device information query structure
@@ -42,6 +48,36 @@ struct drm_qda_query {
 	__u8 dsp_name[16];
 };
 
+/**
+ * struct drm_qda_gem_create - GEM buffer object creation parameters
+ * @size: Size of the GEM object to create in bytes (input)
+ * @handle: Allocated GEM handle (output)
+ *
+ * This structure is used with DRM_IOCTL_QDA_GEM_CREATE to allocate
+ * a new GEM buffer object.
+ */
+struct drm_qda_gem_create {
+	__u64 size;
+	__u32 handle;
+	__u32 pad;
+};
+
+/**
+ * struct drm_qda_gem_mmap_offset - GEM object mmap offset query
+ * @offset: mmap offset for the GEM object (output)
+ * @handle: GEM handle (input)
+ * @pad: Padding for 64-bit alignment
+ *
+ * This structure is used with DRM_IOCTL_QDA_GEM_MMAP_OFFSET to retrieve
+ * the mmap offset that can be used with mmap() to map the GEM object into
+ * user space.
+ */
+struct drm_qda_gem_mmap_offset {
+	__u64 offset;
+	__u32 handle;
+	__u32 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1


