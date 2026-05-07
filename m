Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ED6CD37AA
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 21:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA76A10E5B5;
	Thu,  7 May 2026 21:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CsbA6jXk";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86A310E5B5
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 21:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778190593; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RkpU5a0blkHD1o62DEU4Ua9BVAKNmbpdPmcSinkYbmAkkvosOCvs8qGhzWqoRGHWj5ei1UNnhdaOQZHi559x/DZIp8ysP2BU18zJTysIAsxTCJJst1Hr6ZFMUCtvfSBvDfkdN0uWA75is7S/CHadzi43bytpECrWnDSWy1M20Gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778190593;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Yn+lNA4MFHmNERMplaWuzXxuMrhoQvQYCwIda7hIGOQ=; 
 b=K961gvbrswS0JCRv4VJcnPc/Py+Q6b1mPD2J3LeREdvZSFKr+8RRpMJCF6pAMdFfkQZRHoLJViV2TM0xmq9OHra+qsqLBsAC/WLjPryrGtJbc8eEjVL5QIDY/S0uHH8QSqRugO06HOaVdPG/fyqWgHp5ZiP0LWDEwP3YttAVHsE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778190593; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Yn+lNA4MFHmNERMplaWuzXxuMrhoQvQYCwIda7hIGOQ=;
 b=CsbA6jXk1l6yNuHEDJjq5ahkwKtjlOn1QIeWD0MWvMtAbOA7irREbEdxXzFJlh3U
 MowfZVVBNBgGlk/+i6pnNBSustZMZBA15gtmHVv4ry8LptbdBBmKvwY9I+0RoUklsDz
 zqvHx0i3WFRG/CNzhbkFApFmBa+cuFTmcntu3ngo=
Received: by mx.zohomail.com with SMTPS id 1778190593102994.9072727823724;
 Thu, 7 May 2026 14:49:53 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v11 1/6] drm/panthor: Expose GPU page sizes to UM
Date: Thu,  7 May 2026 22:49:02 +0100
Message-ID: <20260507214939.2852489-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507214939.2852489-1-adrian.larumbe@collabora.com>
References: <20260507214939.2852489-1-adrian.larumbe@collabora.com>
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

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c    |  9 ++++++++-
 include/uapi/drm/panthor_drm.h           | 13 +++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 5cba272f9b4d..d856a4fe1d61 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -158,6 +158,9 @@ struct panthor_device {
 	/** @csif_info: Command stream interface information. */
 	struct drm_panthor_csif_info csif_info;
 
+	/** @mmu_info: MMU info */
+	struct drm_panthor_mmu_info mmu_info;
+
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 73fc983dc9b4..beca75b34293 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -175,6 +175,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 	_Generic(_obj_name, \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_mmu_info, page_size_bitmap), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
@@ -954,6 +955,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(priorities_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
+			args->size = sizeof(ptdev->mmu_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -984,6 +989,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		panthor_query_group_priorities_info(file, &priorities_info);
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
 
+	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fc930ee158a5..9b526b61d96d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2768,7 +2768,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	refcount_set(&vm->as.active_cnt, 0);
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= SZ_4K | SZ_2M,
+		.pgsize_bitmap	= ptdev->mmu_info.page_size_bitmap,
 		.ias		= va_bits,
 		.oas		= pa_bits,
 		.coherent_walk	= ptdev->coherent,
@@ -3213,6 +3213,11 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
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
@@ -3225,6 +3230,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	struct panthor_mmu *mmu;
 	int ret, irq;
 
+	panthor_mmu_info_init(ptdev);
+
 	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
 	if (!mmu)
 		return -ENOMEM;
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 0e455d91e77d..b462752c793d 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -253,6 +253,9 @@ enum drm_panthor_dev_query_type {
 	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
 	 */
 	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
+
+	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
+	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
 };
 
 /**
@@ -487,6 +490,16 @@ struct drm_panthor_timestamp_info {
 	__u64 cpu_timestamp_nsec;
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
  * struct drm_panthor_group_priorities_info - Group priorities information
  *
-- 
2.53.0

