Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D9E105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D41110E0B8;
	Fri, 13 Mar 2026 15:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="UC+F7jcZ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A85510E12D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414652; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N8GDxeLdozI8r7o6tSrlvtLncL8WK2yBdaWcuNz2vE5G8Xq62vyokYJ9SNtRoVcs//MIrMlJOvMtWHN266XQhecEuFKIdFVf1lYrODCMp/3z+PG5VFAXDigcg+rdAW/5s45A1snAQT4Q27rbwyj0L/RuuVGgqtZFq42G0NecU88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414652;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RjYJ3DizTjJtzRhYbQxll0gdIM44uF70YvnjwEwWoNQ=; 
 b=mu96UbKcztdIgle9aAl2f4196DLgLTi+Y7TNUyWaN6gXYWmvss7Blb7V6XVud3h1P8VmJpnvzy735x+L/3UpmqmymB8ayNs1tKvNRC4VJ4RXigRuWVB4xu4fPwNReJiTqR29sOYJFYDft/XKo2fE8J8j0T7IeW9MMlqKSetO5kM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414652; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=RjYJ3DizTjJtzRhYbQxll0gdIM44uF70YvnjwEwWoNQ=;
 b=UC+F7jcZ1VHRPjwq7uUW5j7oUXDL7jSx9PJQd8PjpHmeXvN1Vn9jn7IxNiCbC2FV
 hF4Epv4+7Gg+Z5cZtiBY74bYCV6FB5nMCLUlBtpT+XtoJqphcUaXWmq/Ycu524lEjmj
 +PeUIdolJZgrmmsnM5/a3E4AwAApz1X0oWl/kxgQ=
Received: by mx.zohomail.com with SMTPS id 1773414649676281.58412724129994;
 Fri, 13 Mar 2026 08:10:49 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v5 01/11] drm/panthor: Expose GPU page sizes to UM
Date: Fri, 13 Mar 2026 15:09:38 +0000
Message-ID: <20260313150956.1618635-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

In future commits that will implement repeated mappings, only repeat
values multiple of GPU page sizes will be tolerated. That means these
values must be made known to UM. Do it through a queriable GPU info
value.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c    |  9 ++++++++-
 include/uapi/drm/panthor_drm.h           | 13 +++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b6696f73a536..91bfba9018cf 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -157,6 +157,9 @@ struct panthor_device {
 	/** @csif_info: Command stream interface information. */
 	struct drm_panthor_csif_info csif_info;
 
+	/** @mmu_info: MMU info */
+	struct drm_panthor_mmu_info mmu_info;
+
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 165dddfde6ca..8a901e06a9c9 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -172,6 +172,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 	_Generic(_obj_name, \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_mmu_info, page_size_bitmap), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
@@ -830,6 +831,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(ptdev->csif_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
+			args->size = sizeof(ptdev->mmu_info);
+			return 0;
+
 		case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
 			args->size = sizeof(timestamp_info);
 			return 0;
@@ -850,6 +855,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	case DRM_PANTHOR_DEV_QUERY_CSIF_INFO:
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
 
+	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
+
 	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
 		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index ba3b7c93303c..07c520475f14 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2463,7 +2463,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	refcount_set(&vm->as.active_cnt, 0);
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= SZ_4K | SZ_2M,
+		.pgsize_bitmap	= ptdev->mmu_info.page_size_bitmap,
 		.ias		= va_bits,
 		.oas		= pa_bits,
 		.coherent_walk	= ptdev->coherent,
@@ -2837,6 +2837,11 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
 	destroy_workqueue(res);
 }
 
+static void panthor_mmu_info_init(struct panthor_device *ptdev)
+{
+	ptdev->mmu_info.page_size_bitmap = SZ_4K | SZ_2M;
+}
+
 /**
  * panthor_mmu_init() - Initialize the MMU logic.
  * @ptdev: Device.
@@ -2849,6 +2854,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	struct panthor_mmu *mmu;
 	int ret, irq;
 
+	panthor_mmu_info_init(ptdev);
+
 	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
 	if (!mmu)
 		return -ENOMEM;
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index b401ac585d6a..4089271f3d36 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -246,6 +246,9 @@ enum drm_panthor_dev_query_type {
 	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
 	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
 
+	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
+	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
+
 	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information. */
 	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
 
@@ -409,6 +412,16 @@ struct drm_panthor_csif_info {
 	__u32 pad;
 };
 
+/**
+ * struct drm_panthor_mmu_info - MMU information
+ *
+ * Structure grouping all queryable information relating to the MMU.
+ */
+struct drm_panthor_mmu_info {
+	/** @page_size_bitmap: Allowed page sizes */
+	__u64 page_size_bitmap;
+};
+
 /**
  * struct drm_panthor_timestamp_info - Timestamp information
  *
-- 
2.53.0

